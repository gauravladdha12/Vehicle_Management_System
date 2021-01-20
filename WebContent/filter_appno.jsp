<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>RSWM VEHICLE MANAGEMENT SYSTEM</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <link rel="shortcut icon" type="image/x-icon" href="resources/img/banner/rswm-logo.svg">
<%@ include file = "resources.jsp" %>
<%@ include file = "application_resources.jsp" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
        <script type="text/javascript" src="jspdf.plugin.autotable.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.22/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script><title>Insert title here</title>
 <style>
       .sticky-col {
  position:sticky; left: 0px; background-color: #feceab;
}
body
{
overflow: auto; 
    counter-reset: Serial;           /* Set the Serial counter to 0 */
}

table
{
    border-collapse: separate;
}

tr td:first-child:before
{
  counter-increment: Serial;      /* Increment the Serial counter */
  content: counter(Serial); /* Display the counter */
}
</style>
</head>
<body>
<%@ include file = "admin_header.jsp" %>
<br><br><br><br><br><br><br>

<%@ page import ="java.sql.*"
%>
<%!
public ResultSet results;
public ResultSet results2;
public ResultSet results3;
public String app_no;
public Connection con;
public int rowcount;
%>

<%@ page import ="java.io.*"
%>
<%
if(session==null||((String)session.getAttribute("emp_code"))==null||((Integer)session.getAttribute("admin"))==0)
{
	try{
			
			PrintWriter out2=response.getWriter();
		 	out2.println("<script type=\"text/javascript\">");
		
		   out2.println("location='login.jsp';");
		   out2.println("</script>");
		   return;
	}
	catch(Exception e){
		System.out.println(e.getMessage());
	}
}
%>
<%
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	
	 app_no=request.getParameter("app_no");
	 System.out.println(app_no);
	String q="select *from application where app_no=?";
	PreparedStatement st=con.prepareStatement(q);
	st.setString(1, app_no);
	results=st.executeQuery();
	int rowcount = 0;
	if (results.last()) {
	  rowcount = results.getRow();
	  results.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
	}
	
	if(rowcount==0){
		out.println("<script type=\"text/javascript\">");
    	   out.println("alert('ENTER VALID DATA');");
    	   out.println("location='admin_index.jsp';");
    	   out.println("</script>");
    	   return;
	}
}
catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>
<h2 style="text-align: center;">APPLICATION NO <%=app_no %></h2>
<div style="overflow:auto; margin: 20px">
<table class="ui celled table">
<thead>
<tr>
<th>Sr. No</th>
<th class="sticky-col">
APPLICATION NO
</th>
<th>
EMPLOYEE CODE
</th>
<th>
NAME
</th>
<th>
PURPOSE</th>
<th>
ADDRESS OF COMMUNICATION</th>
<th>
NO OF PASSENGER</th>
<th>
START DATE
</th>
<th>
END DATE(EXPECTED)
</th>
<th>
START TIME
</th>
<th>
DESTINATION
</th>
<th>
REMARKS
</th>
<th>
APPROVED
</th>
<th>
ALLOTED
</th>
<th>
CANCELLED
</th>
<th>
CANCELLATION REMARK USER
</th>
<th>
CANCELLATION REMARK ADMIN
</th>
<th>
VEHICLE MAKE
</th>
<th>
VEHICLE CHASSIS  NO
</th>
<th>
VEHICLE REGISTERATION NO
</th>
<th>
DRIVER CODE
</th>
<th>
DRIVER NAME
</th>
<th>
DRIVER CONTACT NO
</th>
<th>
END DATE (ACTUAL)
</th>
<th>
VEHICLE START KILOMETER READING
</th>
<th>
VEHICLE END KILOMETER READING
</th>
<th>
JOURNEY STARTED
</th>
<th>
JOURNEY COMPLETED
</th>
<th>
RATE PER KILOMETER
</th>
<th>
PAYABLE AMOUNT (IN RS)
</th>
</tr>
</thead>
<%while(results.next()) {%>
	<% if(results.getInt("cancel")==1 || results.getInt("alloted")==0){ %>
		<tr>
		<td></td>
		<td class="sticky-col">
		<%= results.getString("app_no") %>
		</td>
		<td>
		<%= results.getString("emp_code") %>
		</td>
		<td>
		<%= results.getString("name") %>
		</td>
		<td>
		<%= results.getString("purpose") %>
		</td>
		<td>
		<%= results.getString("address") %>
		</td>
		<td>
		<%= results.getInt("passenger") %>
		</td>
		<td>
		<%= results.getString("start_date") %>
		</td>
		<td>
		<%= results.getString("end_date") %>
		</td>
		<td>
		<%= results.getString("start_time") %>
		</td>
		<td>
		<%= results.getString("destination") %>
		</td>
		<td>
		<%= results.getString("remarks") %>
		</td>
		<td>
		<% if(results.getInt("approve")==1){%>
		TRUE
		<%} %>
		<%if(results.getInt("approve")==0){%>
		FALSE
		<%} %>
		<%if(results.getInt("approve")==2){%>
		REJECTED APPLICATION
		<%} %>
	</td>
	<td>
	<% if(results.getInt("alloted")==1) {%>
		TRUE
	<%} %>
	<% if(results.getInt("alloted")==0) {%>
		FALSE
	<%} %>
	</td>
	<td>
	<% if(results.getInt("cancel")==1) {%>
		TRUE
	<%} %>
	<% if(results.getInt("cancel")==0) {%>
		FALSE
	<%} %>
	</td>
	<td>
		<%= results.getString("cancel_remark_user") %>
		</td>
		<td>
		<%= results.getString("cancel_remark_admin") %>
		</td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td><td></td>
		<td></td><td></td>
		</tr>
	<%} %>
	<% if(results.getInt("alloted")==1){ %>
	<%
	String q2="select vehicle.vehicle_make,vehicle.registeration_no, vehicle.chassis_no, driver.driver_code, driver.name, driver.contact_no, journey.end_date as a_end_date, journey.present_km, journey.final_km,journey.start,journey.completed,journey.rate, journey.payable from application,journey,vehicle,driver where application.app_no=? and application.app_no=journey.app_no and journey.driver_code=driver.driver_code and journey.registeration_no=vehicle.registeration_no";
	PreparedStatement st=con.prepareStatement(q2);
	st.setString(1, results.getString("app_no"));
	results2=st.executeQuery();
	
	%>
	<tr>
	<td></td>
		<td class="sticky-col">
		<%= results.getString("app_no") %>
		</td>
		<td>
		<%= results.getString("emp_code") %>
		</td>
		<td>
		<%= results.getString("name") %>
		</td>
		<td>
		<%= results.getString("purpose") %>
		</td>
		<td>
		<%= results.getString("address") %>
		</td>
		<td>
		<%= results.getInt("passenger") %>
		</td>
		<td>
		<%= results.getString("start_date") %>
		</td>
		<td>
		<%= results.getString("end_date") %>
		</td>
		<td>
		<%= results.getString("start_time") %>
		</td>
		<td>
		<%= results.getString("destination") %>
		</td>
		<td>
		<%= results.getString("remarks") %>
		</td>
		<td>
		<% if(results.getInt("approve")==1){%>
		TRUE
		<%} %>
		<%if(results.getInt("approve")==0){%>
		FALSE
		<%} %>
		<%if(results.getInt("approve")==2){%>
		REJECTED APPLICATION
		<%} %>
	</td>
	<td>
	<% if(results.getInt("alloted")==1) {%>
		TRUE
	<%} %>
	<% if(results.getInt("alloted")==0) {%>
		FALSE
	<%} %>
	</td>
	<td>
	<% if(results.getInt("cancel")==1) {%>
		TRUE
	<%} %>
	<% if(results.getInt("cancel")==0) {%>
		FALSE
	<%} %>
	</td>
	<td>
		<%= results.getString("cancel_remark_user") %>
		</td>
		<td>
		<%= results.getString("cancel_remark_admin") %>
		</td>
		<%rowcount = 0;
		if (results2.last()) {
			  rowcount = results2.getRow();
			  results2.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
			}
		%>
		<%if(rowcount==0){ %>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td><td></td>
		<td></td><td></td>
		<%} else{ %>
		<% while(results2.next()){ %>
		<td>
		<%= results2.getString("vehicle_make") %>
		</td>
		<td>
		<%= results2.getString("chassis_no") %>
		</td>
		<td>
		<%= results2.getString("registeration_no") %>
		</td>
		<td>
		<%= results2.getString("driver_code") %>
		</td>
		<td>
		<%= results2.getString("name") %>
		</td>
		<td>
		<%= results2.getString("contact_no") %>
		</td>
		<td>
		<%= results2.getString("a_end_date") %>
		</td>
		<td>
		<%= results2.getDouble("present_km") %>
		</td>
		<td>
		<%= results2.getDouble("final_km") %>
		</td>
		<td>
	<% if(results2.getInt("start")==1) {%>
		TRUE
	<%} %>
	<% if(results2.getInt("start")==0) {%>
		FALSE
	<%} %>
	</td>
	<td>
	<% if(results2.getInt("completed")==1) {%>
		TRUE
	<%} %>
	<% if(results2.getInt("completed")==0) {%>
		FALSE
	<%} %>
	</td>
	<td>
		<%= results2.getDouble("rate") %>
		</td>
		<td>
			<% if(results2.getInt("completed")==1) {%>
			<%= results2.getDouble("payable") %>
	<%} %>
	<% if(results2.getInt("completed")==0) {%>
		NA
	<%} %>
		</td>
		<%} %>
		</tr>
	<%} %>
<%} %>
<%} %>
</table>
</div>
<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
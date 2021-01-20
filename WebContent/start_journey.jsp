<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
        <style>
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
.sticky-col {
  position:sticky; left: 0px; background-color: #feceab;
}
</style>
</head>
<body>
<%@ include file = "admin_header.jsp" %>
<br><br><br><br><br><br><br>
<%@ page import ="java.sql.*"
%>

<%@ page import ="java.io.*"
%>
<%
if(session==null||((String)session.getAttribute("emp_code"))==null||(((Integer)session.getAttribute("gate"))==0&&((Integer)session.getAttribute("admin"))==0))
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
<%!
public ResultSet results;
%>

<%
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="select application.app_no, application.name, application.emp_code, application.destination, application.start_date, application.end_date, application.start_time, vehicle.chassis_no,vehicle.vehicle_make,vehicle.registeration_no,driver.driver_code, driver.name as driver_name,driver.contact_no,vehicle.present_km from application,journey,driver,vehicle where journey.completed=0 and journey.start=0 and application.alloted=1 and application.cancel=0 and application.app_no=journey.app_no and  journey.driver_code=driver.driver_code and journey.registeration_no=vehicle.registeration_no; ";
	
	PreparedStatement st=con.prepareStatement(q);
	results=st.executeQuery();
	
	/*while(results.next()){
	 current=results.getInt("prev");
	}

	//System.out.println(current+" hellllo");
	current++;*/
	
	
}
catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}

%>
<h2 style="text-align: center;">START JOURNEY</h2>
<div style="overflow:auto; margin: 20px">
<table class="ui celled table">
<thead>
<tr>

<th>
APPLICATION NO
</th>
<th>
NAME
</th>
<th>
EMPLOYEE CODE
</th>
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
VEHCILE CHASSIS NO
</th>
<th>
VEHICLE MAKE
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
DRIVER 	CONTACT NO
</th>
<th>
VEHICLE PRESENT KILOMETER
</th>
<th>
START JOURNEY
</th>
</tr>
<%
	while(results.next()){%>
		<tr>
		<form action="start_journeydetails.jsp" method="post">
		
		<td>
	<%=results.getInt("app_no")%>	
	</td>
<td>
	<%=results.getString("name")%>
	</td>
	<td>
	<%=results.getString("emp_code")%>
	</td>
	
	<td>
	<%=results.getString("start_date")%>
	</td>
	<td>
	<%=results.getString("end_date")%>
	</td>
	<td>
	<%=results.getString("start_time")%>
	</td>	
	<td>
	<%=results.getString("chassis_no")%>
	</td>
		<td>
	<%=results.getString("vehicle_make")%>
	</td>
		<td>
	<%=results.getString("registeration_no")%>
	</td>
		<td>
	<%=results.getString("driver_code")%>
	</td>
		<td>
	<%=results.getString("driver_name")%>
	</td>
		<td>
	<%=results.getString("contact_no")%>
	</td>
		<td>
	<%=results.getDouble("present_km")%>
	</td>
	<td>
	<button class="ui button" type="submit">
  START JOURNEY
</button>

	</td>
	<input type="hidden" name="app_no" value="<%=results.getInt("app_no")%>">
	<input type="hidden" name="present_km" value="<%=results.getDouble("present_km")%>">
	</form>
</tr>	
	<%}
%>
</table>
</div>
<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
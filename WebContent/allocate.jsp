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
<title>Insert title here</title>
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
<%!
public ResultSet results;
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
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="select * from application where alloted=0 and approve=1 and cancel=0;";
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
<h2 style="text-align: center;">ALLOCATE APPLICATION </h2>
<div style="overflow-x:auto; margin: 20px">
<table class="ui celled table">
<thead>
<tr>
<th>Sr.No</th>
<th>APPLICATION NO</th>
<th>NAME</th>
<th>EMPLOYEE CODE</th>
<th>PHONE NUMBER</th>
<th>PURPOSE</th>
<th>DESTINATION</th>
<th>PASSENGER</th>
<th>ADDRESS</th>
<th>START DATE</th>
<th>END DATE</th>
<th>START TIME</th>
<th>REMARKS</th>
<th>ALLOCATE</th>
<th>CANCEL</th>
</tr>

<%
	while(results.next()){%>
		<tr>
		<td></td>
		<td >
	<%=results.getString("app_no")%>
	</td>
<td>
	<%=results.getString("name")%>
	</td>
	<td>
	<%=results.getString("emp_code")%>
	</td>
	<td>
	<%=results.getString("number")%>
	</td>
	<td>
	<%=results.getString("purpose")%>
	</td>
	<td>
	<%=results.getString("destination")%>
	</td>
	<td>
	<%=results.getInt("passenger")%>
	</td>
	<td>
	<%=results.getString("address")%>
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
	<%=results.getString("remarks")%>
	</td>
	<td>
	<form action="allocatedv.jsp" method="post">
	<input type="hidden" name="app_no" value="<%=results.getString("app_no")%>">
	<button class="ui button" type="submit">
  ALLOCATE
</button>
</form>
</td>
<td>
<form action="admin_cancel.jsp" method="post">
<input type="hidden" name="app_no" value="<%=results.getString("app_no")%>">
<button class="ui button" type="submit">
  CANCEL
</button>
</form>
</td>

</tr>	
	<%  
	}
%>
<script>
function redirect1(){
	document.getElementById("f").action="allocatedv.jsp";
	document.getElementById("f").submit();
}
function redirect2(){
	document.getElementById("f").action="admin_cancel.jsp";
	document.getElementById("f").submit();
}
</script>

</table>
</div>
<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
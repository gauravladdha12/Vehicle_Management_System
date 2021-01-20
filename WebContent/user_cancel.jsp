<%@page import="vehicle_management.validate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<title>Insert title here</title>
<style>
body{
overflow: auto; 
}
</style>
</head>
<body>
<%@ include file = "header.jsp" %>
<br><br><br><br><br><br><br>
<h2 style="text-align: center;">CANCEL APPLICATION NO <%= request.getParameter("app_no") %> </h2>
<%@ page import ="java.sql.*"
%>
<%@ page import ="java.io.*"
%>

<%@ page import ="java.io.*"
%>
<%
if(session==null||((String)session.getAttribute("emp_code"))==null||((Integer)session.getAttribute("admin"))==1)
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
public ResultSet results2;
public ResultSet results3;
%>
<%
String r=request.getParameter("app_no");
validate rv=new validate();
if(!rv.isvalid(r,(String)session.getAttribute("emp_code")))
{
	//System.out.println("okkkkk  ");
	 out.println("<script type=\"text/javascript\">");
	   out.println("alert('ENTER VALID DATA');");
	   out.println("location='user_index.jsp';");
	   out.println("</script>");
	   return;
}
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="Select *from application where app_no=?";
	PreparedStatement st=con.prepareStatement(q);
	st.setString(1,request.getParameter("app_no"));
	results=st.executeQuery();
	int rowcount = 0;
	if (results.last()) {
	  rowcount = results.getRow();
	  results.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
	}
	
	if(rowcount==0){
		out.println("<script type=\"text/javascript\">");
    	   out.println("alert('ENTER VALID DATA');");
    	   out.println("location='user_index.jsp';");
    	   out.println("</script>");
    	   return;
	}
	results.next();
	
	
	if(results.getInt("cancel")==1){
		//System.out.println("hellllooo");
		PrintWriter ot=response.getWriter();
		  ot.println("<script type=\"text/javascript\">");
  	   	ot.println("alert('APPLICATION ALREADY CANCELLED');");
  	   ot.println("location='user_index.jsp';");
  	   ot.println("</script>");
	}
%>

<%if(results.getInt("alloted")==1) {%>
<%

	String q3="Select *from journey where app_no=?";
	PreparedStatement st3=con.prepareStatement(q3);
	st3.setString(1,request.getParameter("app_no"));
	results3=st3.executeQuery();
	results3.next();
	if(results3.getInt("start")==1){
		//System.out.println("hellllooo");
		PrintWriter ot=response.getWriter();
		  ot.println("<script type=\"text/javascript\">");
  	   	ot.println("alert('JOURNEY ALREADY STARTED');");
  	   ot.println("location='user_index.jsp';");
  	   ot.println("</script>");
  	   return;
	}
%>
 
<%if(results3.getInt("completed")==0){ %>
	<%String q2="select application.app_no, application.name, application.emp_code, application.destination, application.start_date, application.end_date, application.start_time, vehicle.chassis_no,vehicle.vehicle_make,vehicle.registeration_no,driver.driver_code, driver.name as driver_name,driver.contact_no,vehicle.present_km from application,journey,driver,vehicle where application.app_no=? and journey.completed=0 and application.alloted=1 and application.cancel=0 and application.app_no=journey.app_no and  journey.driver_code=driver.driver_code and journey.registeration_no=vehicle.registeration_no; ";

PreparedStatement st2=con.prepareStatement(q2);
st2.setString(1,request.getParameter("app_no"));
 results2=st2.executeQuery();
  %>
 
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
JOURNEY COMPLETED
</th>
<th>
CANCEL APPLICATION
</th>
</tr>
</thead>

<%

	while(results2.next()){%>
		<tr>
		<form class="ui form" method="post" action="user_cancelremark.jsp">
		<td>
	<%=results2.getInt("app_no")%>	
	</td>
<td>
	<%=results2.getString("name")%>
	</td>
	<td>
	<%=results2.getString("emp_code")%>
	</td>
	
	<td>
	<%=results2.getString("start_date")%>
	</td>
	<td>
	<%=results2.getString("end_date")%>
	</td>
	<td>
	<%=results2.getString("start_time")%>
	</td>	
	<td>
	<%=results2.getString("chassis_no")%>
	</td>
		<td>
	<%=results2.getString("vehicle_make")%>
	</td>
		<td>
	<%=results2.getString("registeration_no")%>
	</td>
		<td>
	<%=results2.getString("driver_code")%>
	</td>
		<td>
	<%=results2.getString("driver_name")%>
	</td>
		<td>
	<%=results2.getString("contact_no")%>
	</td>
		<td>
	<%=results2.getDouble("present_km")%>
	</td>
	<td>FALSE</td>
	<input type="hidden" value="<%=results2.getInt("app_no")%>" name="app_no">
		<input type="hidden" value="1" name="alloted">
	<td><button class="ui button" type="submit">CANCEL</button></td>
	</form>
</tr>
	<%}
%>

</table>
	<%} %>
<%} %>
<%
if(results.getInt("alloted")==0) {
%>
<%
String q2="select *from application where app_no=? and cancel=0";
PreparedStatement st2=con.prepareStatement(q2);
st2.setString(1,request.getParameter("app_no"));
results2=st2.executeQuery();
%>

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
PURPOSE</th>
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
CANCEL APPLICATION
</th>
</tr>
</thead>
<%
	while(results2.next()){%>
		<tr>
		<form class="ui form" method="post" action="user_cancelremark.jsp">
		<td>
	<%=results2.getInt("app_no")%>	
	</td>
<td>
	<%=results2.getString("name")%>
	</td>
	<td>
	<%=results2.getString("purpose")%>
	</td>
	
	<td>
	<%=results2.getString("start_date")%>
	</td>
	<td>
	<%=results2.getString("end_date")%>
	</td>
	<td>
	<%=results2.getString("start_time")%>
	</td>	
	<td>
	<%=results2.getString("destination")%>
	</td>
		<td>
	<%=results2.getString("remarks")%>
	</td>
		<td>
		<% if(results2.getInt("approve")==1){%>
		TRUE
		<%} %>
		<%if(results2.getInt("approve")==0){%>
		FALSE
		<%} %>
		<%if(results2.getInt("approve")==2){%>
		REJECTED APPLICATION
		<%} %>
	</td>
		<td>
	FALSE
	</td>
	<input type="hidden" value="<%=results2.getInt("app_no")%>" name="app_no">
		<input type="hidden" value="0" name="alloted">
	<td><button class="ui button" type="submit">CANCEL</button></td>
	</form>
	</tr>
	<%}
%>

</table>
<%} %>
 <script src="resources/js/main.js"></script>
 <br><br><br>
	<%@ include file = "footer.jsp" %>
</body>
</html>
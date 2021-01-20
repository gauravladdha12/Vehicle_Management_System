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
<body>
<%@ include file = "admin_header.jsp" %>
<br><br><br><br><br><br><br>
<h2 style="text-align: center;"> CURRENT STATUS </h2>
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
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
String q="select *from journey,driver where  completed=0 and journey.driver_code=driver.driver_code order by journey.app_no;";
PreparedStatement st=con.prepareStatement(q);
results=st.executeQuery();
%>

<div style="overflow:auto; margin: 20px">
<table class="ui celled table" id="b" >
<thead>
<tr>
<th >Sr. No</th>
<th>
APPLICATION NO
</th>
<th>
DRIVER CODE
</th>
<th>
DRIVER NAME
</th>
<th>
REGISTERATION NO
</th>
<th>
START DATE
</th>
<th>
END DATE(EXPECTED)
</th>
<th>
START
</th>
<th>
MODIFY
</th>
</tr>
</thead>
<%while(results.next()){ %>
<tr>
<td></td>
<td>
<%= results.getString("app_no") %>
</td>
<td>
<%= results.getString("driver_code") %>
</td>
<td>
<%= results.getString("name") %>
</td>
<td>
<%= results.getString("registeration_no") %>
</td>
<td>
<%
	String q2="select *from application where app_no=?";
	PreparedStatement st2=con.prepareStatement(q2);
	st2.setString(1,results.getString("app_no"));
	ResultSet r=st2.executeQuery();
	r.next();
%>
<%= r.getString("start_date") %>
</td>
<td>
<%= r.getString("end_date") %>
</td>
<td>
<% if(results.getInt("start")==1){%>
		TRUE
		<%} %>
		<%if(results.getInt("start")==0){%>
		FALSE
		<%} %>
</td>
<td>
<form action="admin_modify.jsp" method="post">
<input type="hidden" name="app_no" value="<%= results.getString("app_no") %>" >
<button class="ui button" type="submit">
MODIFY
</button>
</form>
</td>
</tr>

<%} %>
</table>
</div>
<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
	</body>
</html>
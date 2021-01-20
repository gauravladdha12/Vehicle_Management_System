<%@page import="java.time.LocalDate"%>
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
<h2 style="text-align: center;"> DUE DATES </h2>
<%@ page import ="java.sql.*"
%>
<%@ page import ="java.text.*"
%>
<%!
public ResultSet results;
public LocalDate current;
%>
<%@ page import ="java.io.*"
%>
<%
if(session==null||((String)session.getAttribute("emp_code"))==null||((Integer)session.getAttribute("admin"))==0)
{
	try{
			
			PrintWriter out3=response.getWriter();
		 	out3.println("<script type=\"text/javascript\">");
		
		   out3.println("location='login.jsp';");
		   out3.println("</script>");
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
	String q="select *from vehicle_transaction where CURDATE() > insurance_upto or curdate() > servicing_upto or curdate() > pollution_control_valid or curdate() > certificate_of_fitness ";
	PreparedStatement st=con.prepareStatement(q);
	results=st.executeQuery();
	SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd");
	current=LocalDate.now();
	//current=sdformat.parse(LocalDate.now());
%>
<div style="overflow:auto; margin: 20px">
<table class="ui celled table" id="b" >
<thead>
<tr>
<th>Sr. No</th>
<th>
REGISTERATION NO
</th>
<th>
INSURANCE VALID DATE
</th>
<th>
SERVICING VALID DATE
</th>
<th>
POLLUTION CONTROL VALID DATE
</th>
<th>
CERTIFICATE OF FITNESS VALID DATE
</th>
</tr>
</thead>
<%while(results.next()){ %>
<tr>
<td></td>
<td>
<%= results.getString("registeration_no") %>
</td>
<% 
LocalDate iu=LocalDate.parse(results.getString("insurance_upto"));
if(current.compareTo(iu)>0)	{%>

<td class="warning">
<%= results.getString("insurance_upto") %>
</td>	

<%}else{ %>
<td>
<%= results.getString("insurance_upto") %>
</td>	
<%} %>


<% 
LocalDate su=LocalDate.parse(results.getString("servicing_upto"));
if(current.compareTo(su)>0)	{%>


<td class="warning">
<%= results.getString("servicing_upto") %>
</td>	

<% 
}else{ %>
<td>
<%= results.getString("servicing_upto") %>
</td>	
<%} %>

<% 
LocalDate pv=LocalDate.parse(results.getString("pollution_control_valid"));
if(current.compareTo(pv)>0)	{%>
<td class="warning">
<%= results.getString("pollution_control_valid") %>
</td>	
<%}else{ %>
<td>
<%= results.getString("pollution_control_valid") %>
</td>	
<%} %>

<% 
LocalDate cf=LocalDate.parse(results.getString("certificate_of_fitness"));
if(current.compareTo(cf)>0)	{%>

<td class="warning">
<%= results.getString("certificate_of_fitness") %>
</td>	

<%}else{ %>
<td>
<%= results.getString("certificate_of_fitness") %>
</td>	
<%} %>

</tr>
<%} %>
</table>
</div>
<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
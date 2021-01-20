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
</head>
<body onload="hide()">
<%@ include file = "admin_header.jsp" %>
<br><br><br><br><br><br><br>
<h2 style="text-align: center;">MODIFY APPLICATION</h2>

<%@ page import ="java.sql.*"
%>
<%@ page import ="java.util.*"
%>
<%@ page import ="java.text.SimpleDateFormat"
%>
<%@ page import ="java.util.Date"
%>

<%!
public ResultSet results1;
public ResultSet results2;
public ResultSet results3;
public ResultSet results4;
public ResultSet results5;
public ResultSet results;
public String app_no;
public Connection con;
public ArrayList<String> driver;
public ArrayList<String> name;
public ArrayList<String> vehicle;
%>
<%!
public ResultSet w;
public String n;
public int size;
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
	String e1="select *from journey where app_no=? and start=0 and completed=0";
	PreparedStatement str=con.prepareStatement(e1);
	str.setString(1,request.getParameter("app_no"));
	w=str.executeQuery();
	
	size=0;
	if(w!=null)
	{
		w.last();
		size=w.getRow();
		w.beforeFirst();
	}

	//System.out.println(size);
	if(size==0)
	{
		//PrintWriter out=res.getWriter();
		//response.sendRedirect("www.google.com");
		out.println("<script type=\"text/javascript\">");
  	   out.println("alert('Enter valid data');");
  	   out.println("location='admin_index.jsp';");
  	   out.println("</script>");
  	   return;
	}
	
	if(size!=0){	
	w.next();
	String e2="select *from driver where driver_code=?";
	PreparedStatement str2=con.prepareStatement(e2);
	str2.setString(1,w.getString("driver_code"));
	ResultSet r2=str2.executeQuery();
	r2.next();
	n=r2.getString("name");
	}

%>
<table class="ui celled table" id="b" >
<caption>ALLOCATED DETAILS</caption>
<thead>
<tr>
<th>
DRIVER CODE
</th>
<th>
DRIVER NAME
</th>
<th>
VEHICLE REGISTERATION NO
</th>
<th>
CANCEL APPLICATION
</th>
</tr>
</thead>
<tr>
<td>
<% if(size!=0){%>
<%= w.getString("driver_code") %>
<%} %>
</td>
<td>
<%= n %>
</td>
<td>
<% if(size!=0){%>
<%= w.getString("registeration_no") %>
<%} %>
</td>
<td>
<form method="post" action="admin_cancel.jsp">
<input type="hidden" name="app_no" value="<%=request.getParameter("app_no") %>">
<button class="ui button" type="submit">CANCEL APPLICATION</button>
</form>
</td>
</tr>

</table>

<%
try {
	app_no=request.getParameter("app_no");
	vehicle=new ArrayList<String>();
	driver=new ArrayList<String>();
	name=new ArrayList<String>();
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	
	String q1="select start_date, end_date from application where app_no=?";
	PreparedStatement st1=con.prepareStatement(q1);
	st1.setString(1,request.getParameter("app_no"));
	results=st1.executeQuery();
	results.next();
	
	String q5="select application.start_date ,application.end_date, driver.name, journey.driver_code, registeration_no from driver, journey,application where journey.completed=0 and journey.app_no=application.app_no and journey.driver_code=driver.driver_code";
	st1=con.prepareStatement(q5);
	ResultSet results6=st1.executeQuery();
	Date a_start_date=new SimpleDateFormat("yyyy-MM-dd").parse(results.getString("start_date"));
	Date a_end_date=new SimpleDateFormat("yyyy-MM-dd").parse(results.getString("end_date"));
	
	
	Set<String> ndriver=new HashSet<>();
	Set<String> nvehicle=new HashSet<>();
	
	
	//System.out.println(a_start_date+" "+a_end_date+"heloji");
	while(results6.next()){
		Date start_date=new SimpleDateFormat("yyyy-MM-dd").parse(results6.getString("start_date")); 
		Date end_date=new SimpleDateFormat("yyyy-MM-dd").parse(results6.getString("end_date"));
		//System.out.println(start_date+" "+end_date);
		//System.out.println(start_date.compareTo(a_end_date)+" "+end_date.compareTo(a_start_date));
		
		
		//System.out.println("yoooo "+results6.getString("driver_code")+" "+results6.getString("registeration_no")+" yooooo");
		if(start_date.compareTo(a_end_date) >0 ){
			if(!vehicle.contains(results6.getString("registeration_no"))){
				vehicle.add(results6.getString("registeration_no"));
			}
			if(!driver.contains(results6.getString("driver_code"))){
				name.add(results6.getString("name"));
				driver.add(results6.getString("driver_code"));
			}
		}
		else if(a_start_date.compareTo(end_date)>0){
			if(!vehicle.contains(results6.getString("registeration_no"))){
				vehicle.add(results6.getString("registeration_no"));
			}
			if(!driver.contains(results6.getString("driver_code"))){
				driver.add(results6.getString("driver_code"));
				name.add(results6.getString("name"));
			}
		}
		else{
			/*if(vehicle.contains(results6.getString("registeration_no"))){
				vehicle.remove(new String(results6.getString("registeration_no")));
			}
			if(driver.contains(results6.getString("driver_code"))){
				driver.remove(new String(results6.getString("driver_code")));
			}*/
			nvehicle.add(results6.getString("registeration_no"));
			ndriver.add(results6.getString("driver_code"));
		}
	}
	
	for(int i=0;i<vehicle.size();i++){
		if(nvehicle.contains(vehicle.get(i))){
			vehicle.remove(new String(vehicle.get(i)));
		}
		
	}
	for(int i=0;i<driver.size();i++){
		if(ndriver.contains(driver.get(i))){
			driver.remove(new String(driver.get(i)));
		}
	}
	//System.out.println("ohhhh"+)
	/*for(int i=0;i<driver.size();i++){
		System.out.println(driver.get(i)+" okk");
	}*/
	
	 String q3="select *from vehicle where available=1 and live=1 and usable=1";
	 PreparedStatement st3=con.prepareStatement(q3);
	 results3=st3.executeQuery();
	 
	 String q4="select *from driver where available=1 and live=1";
	 PreparedStatement st4=con.prepareStatement(q4);
	 results4=st4.executeQuery();
	 //System.out.println("yooo");
	 //System.out.println("hello"+vehicle.size()+" "+driver.size()+"byyyy");
	
}
catch (Exception e) {
	// TODO Auto-generated catch block
	System.out.println("noooooooo"+e.getMessage());
	e.printStackTrace();
}
	
%>

<form class="ui form" action="modify_details" method="post">
<input type="hidden" name="app_no" value="<%= app_no %>">
<div class="two fields">
	<div class="field">
	<label>VEHICLE REGISTERATION NO</label>
	<div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="registeration_no">
  <i class="dropdown icon"></i>
  <div class="default text">Select vehicle registeration no</div>
  <div class="menu">
  <% while(results3.next()){ %>
   <div class="item" data-value= "<%= results3.getString("registeration_no") %>" > <%= results3.getString("registeration_no") %>  </div>
   <%} %>
   
   <%
	for(int i=0;i<vehicle.size();i++){ %>
	 <div class="item"><%= vehicle.get(i)%> </div>
	<%} %>
  </div>
  </div>
	
	</div>
	<div class="field">
	<label>DRIVER NO</label>
 <div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="driver_code">
  <i class="dropdown icon"></i>
  <div class="default text">Select driver code</div>
  <div class="menu">
  <% while(results4.next()){ %>
   <div class="item" data-value= "<%= results4.getString("driver_code") %>" > <%= results4.getString("name") %>  <%= results4.getString("driver_code") %>  </div>
   <%} %>
   <%
	for(int i=0;i<driver.size();i++){
	%>
	 <div class="item" data-value= "<%= driver.get(i) %>"><%= name.get(i)%> <%= driver.get(i)%></div>
	<%} %>
  </div>
  </div>
	</div>
	</div>
	 <button class="ui button" type="submit">SUBMIT</button>
	</form>
	
	<script type="text/javascript">
	
	function hide(){
		 $('.ui.dropdown').dropdown();
	}
	</script>
<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
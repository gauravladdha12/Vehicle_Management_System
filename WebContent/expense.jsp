<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script>
        <script type="text/javascript" src="jspdf.plugin.autotable.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.22/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script><title>Insert title here</title>
 <script src="resources/js/xlsx.mini.js"></script>
  <script src="resources/js/FileSaver.min.js"></script>
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

.g tr td:first-child:before
{
  counter-increment: Serial;      /* Increment the Serial counter */
  content: counter(Serial); /* Display the counter */
}
</style>
</head>
<body>
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

<%@ include file = "admin_header.jsp" %>
<br><br><br><br><br><br><br>
<%@ page import ="java.sql.*"
%>
<%!
public ResultSet results;
//public ResultSet results2;
public HashMap<String,rep> hm;
public String s_date;
public String f_date;
public double val[][];
public double sum;
double personal;
Connection con;
public class rep{
	
	
	String make,model,name_of_user,last_service_date,registeration_no,remark;
	double km_run,fuel,fuel_cost,average,cost_per_km,opening_km, closing_km,service_km;
	/*rep(String make,String model, String name_of_user, double km_run, double fuel, double fuel_cost, double average, double cost_per_km, double opening_km , double closing_km, double km,String last_service_date,double service_km){
		this.make=make;
		this.model=model;
		this.name_of_user=name_of_user;
		this.last_service_date=last_service_date;
		this.km_run=km_run;
		this.fuel=fuel;
		this.fuel_cost=fuel_cost;
		this.average=average;
		this.cost_per_km=cost_per_km;
		this.opening_km=opening_km;
		this.closing_km=closing_km;
		this.service_km=service_km;
		this.km=km;
	}*/
	}
%>
<%
try {
	sum=0;
	personal=0;
	out.flush();
	Class.forName("com.mysql.cj.jdbc.Driver");
	 Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	 hm= new HashMap<String,rep>();
	 s_date=request.getParameter("s_date");
	 f_date=request.getParameter("f_date");
	 
	 String q=" select journey.registeration_no, min(journey.present_km) as opening, max(final_km) as closing, sum(final_km-journey.present_km) as km,  vehicle_make, model_name, servicing_date, servicing_km from journey inner join vehicle on journey.registeration_no=vehicle.registeration_no inner join vehicle_transaction on  journey.registeration_no=vehicle_transaction.registeration_no where journey.completed=1 and vehicle.usable=1 and journey.end_date< ? and journey.end_date >? group by journey.registeration_no;";
	 PreparedStatement st=con.prepareStatement(q);
	 st.setString(1,f_date);
	 st.setString(2,s_date);
	 results=st.executeQuery();
	 
	 
	 String pu=" select journey.registeration_no, min(journey.present_km) as opening, max(final_km) as closing, sum(final_km-journey.present_km) as km, vehicle_make, model_name, servicing_date, servicing_km from application inner join journey on journey.app_no=application.app_no and journey inner join vehicle on journey.registeration_no=vehicle.registeration_no inner join vehicle_transaction on  journey.registeration_no=vehicle_transaction.registeration_no where journey.completed=1 and journey.end_date< ? and journey.end_date >? group by journey.registeration_no;";
	 PreparedStatement stt=con.prepareStatement(pu);
	 
	 
	 
	 //System.out.println("helloooo1");
	 while(results.next()){
		 //System.out.println("yooooooooo");
		 //ArrayList<rep> arr=new ArrayList<>();
		 //arr2.add(results.getString("registeration_no"));
		 rep r=new rep();
		 r.registeration_no=results.getString("registeration_no");
		 //System.out.println("yooooo");
		 r.make=results.getString("vehicle_make");
		 r.model=results.getString("model_name");
		 r.make=results.getString("vehicle_make");
		 r.km_run=results.getDouble("km");
		 r.last_service_date=results.getString("servicing_date");
		 r.service_km=results.getDouble("servicing_km");
		 r.opening_km=results.getDouble("opening");
		 r.closing_km=results.getDouble("closing");
		// System.out.println("yooooooooo3"+results.getString("registeration_no"));
		 hm.put((String)results.getString("registeration_no"),(rep)r);
		// System.out.println("yooooooooo2");
	 }
	 
	 
	 
	// System.out.println("ohhhh");
	 //ArrayList<String> arr2=new ArrayList<>();
	 String q2="select registeration_no , sum(liter) as liter, sum(cost) as cost, avg(average) as average, sum(cost_per_km) as cpk from fuel_transaction where fuel_transaction.filling_date< ? and fuel_transaction.filling_date > ? group by fuel_transaction.registeration_no;";
	 PreparedStatement st2=con.prepareStatement(q2);
	 st2.setString(1,f_date);
	 st2.setString(2,s_date);
	 ResultSet results2=st2.executeQuery();
	
	 //System.out.println("hello1");
	 
	 //System.out.println("hello2");
	 while(results2.next()){
		// System.out.println(results2.getString("registeration_no")+" okkkkk");
		 if(hm.containsKey(results2.getString("registeration_no"))){
			 rep p=(rep)hm.get(results2.getString("registeration_no"));
			 System.out.println("ohhh2");
			 p.fuel= Double.parseDouble(results2.getString("liter"));
			 System.out.println("ohhh3");
			 p.fuel_cost=results2.getDouble("cost");
			 p.average=results2.getDouble("average");
			 p.cost_per_km=results2.getDouble("cpk");
			 hm.put(results2.getString("registeration_no"), p);
		 }
		 else{
			 rep p=new rep();
			 p.registeration_no=results2.getString("registeration_no");
			 p.fuel=results2.getDouble("liter");
			 p.fuel_cost=results2.getDouble("cost");
			 p.average=results2.getDouble("average");
			 p.cost_per_km=results2.getDouble("cpk");
			 System.out.println(results2.getString("registeration_no")+" yoooo");
			 String q4="select *from vehicle,vehicle_transaction where vehicle.registeration_no=? and vehicle.usable=1 and vehicle.registeration_no=vehicle_transaction.registeration_no;";
			 PreparedStatement st4=con.prepareStatement(q4);
			 st4.setString(1,results2.getString("registeration_no"));
			 ResultSet results4=st4.executeQuery();
			 results4.next();
			 p.make=results4.getString("vehicle_make");
			 p.model=results4.getString("model_name");
			 p.service_km=results4.getDouble("servicing_km");
			 p.last_service_date=results4.getString("servicing_date");
			 p.opening_km=results4.getDouble("present_km");
			 p.closing_km=results4.getDouble("present_km");
			 hm.put(results2.getString("registeration_no"), p);
		 }
	 }
	 //System.out.println("hello3");
	 String q3="select *from vehicle where usable=1";
	 PreparedStatement st3=con.prepareStatement(q3);
	 ResultSet results3=st3.executeQuery();
	 while(results3.next()){
		 System.out.println("ohhhhh");
		 if(hm.containsKey(results3.getString("registeration_no"))){
			 rep p=(rep)hm.get(results3.getString("registeration_no"));
			 p.name_of_user=results3.getString("user");
			 p.remark=results3.getString("remark");
			 hm.put(results3.getString("registeration_no"), p);
		 }
		 else{
			 rep p=new rep();
			 String q5="select *from vehicle,vehicle_transaction where vehicle.usable=1 and vehicle.registeration_no=? and vehicle.registeration_no=vehicle_transaction.registeration_no;";
			 PreparedStatement st5=con.prepareStatement(q5);
			 st5.setString(1,results3.getString("registeration_no"));
			 ResultSet results5=st5.executeQuery();
			 //results5.next();
			 p.registeration_no=results3.getString("registeration_no");
			 p.make=results3.getString("vehicle_make");
			 p.model=results3.getString("model_name");
			 p.name_of_user=results3.getString("user");
			 p.remark=results3.getString("remark");
			 p.opening_km=results3.getDouble("present_km");
			 p.closing_km=results3.getDouble("present_km");
			 //System.out.println("yesssss"+results5);
			 while(results5.next()){
			 p.service_km=results5.getDouble("servicing_km");
			 p.last_service_date=results5.getString("servicing_date");
			
			 }
			 hm.put(results3.getString("registeration_no"), p);
		 }
	 }
	 
	 String w="select registeration_no, sum(km_run) as km_run, sum(liter) as liter, avg(average) as average, sum(cost_per_km) as cost_per_km, min(opening) as opening , max(closing) as closing, min(last_service_date) as last_service_date, min(service_km) as service_km from private_expense where start> ? and upto<? group by registeration_no;";
	 PreparedStatement wt=con.prepareStatement(w);
	 wt.setString(1, s_date);
	 wt.setString(2, f_date);
	 ResultSet re=wt.executeQuery();
	 while(re.next()){
		 rep p=new rep();
		 p.km_run=re.getDouble("km_run");
		 p.fuel=re.getDouble("liter");
		 p.average=re.getDouble("average");
		 p.cost_per_km=re.getDouble("cost_per_km");
		 p.opening_km=re.getDouble("opening");
		 p.closing_km=re.getDouble("closing");
		 p.last_service_date=re.getString("last_service_date");
		 p.service_km=re.getDouble("service_km");
		 p.registeration_no=re.getString("registeration_no"); 
		 hm.put(re.getString("registeration_no"), p);
	 }
	 
	 q3="select *from vehicle";
	 st3=con.prepareStatement(q3);
	 results3=st3.executeQuery();
	 while(results3.next()){
		 if(hm.containsKey(results3.getString("registeration_no"))){
			 rep p=(rep)hm.get(results3.getString("registeration_no"));
			 p.name_of_user=results3.getString("user");
			 p.remark=results3.getString("remark");
			 hm.put(results3.getString("registeration_no"), p);
		 }
		 else{
			 rep p=new rep();
			 String q5="select *from vehicle,vehicle_transaction where vehicle.registeration_no=? and vehicle.registeration_no=vehicle_transaction.registeration_no";
			 PreparedStatement st5=con.prepareStatement(q5);
			 st5.setString(1,results3.getString("registeration_no"));
			 ResultSet results5=st5.executeQuery();
			 //results5.next();
			 p.registeration_no=results3.getString("registeration_no");
			 p.make=results3.getString("vehicle_make");
			 p.model=results3.getString("model_name");
			 p.name_of_user=results3.getString("user");
			 p.remark=results3.getString("remark");
			 p.opening_km=results3.getDouble("present_km");
			 p.closing_km=results3.getDouble("present_km");
			 //System.out.println("yesssss"+results5);
			 while(results5.next()){
			 p.service_km=results5.getDouble("servicing_km");
			 p.last_service_date=results5.getString("servicing_date");
			
			 }
			 hm.put(results3.getString("registeration_no"), p);
		 }
	 }
	 
	 System.out.println("okkkkkk");
	val=new double[20][2];
	for(rep p: hm.values()){
		val[0][0]=val[0][0]+p.km_run;
		val[0][1]++;
		
		val[1][0]=val[1][0]+p.fuel;
		val[1][1]++;
		
		val[2][0]=val[2][0]+p.fuel_cost;
		val[2][1]++;
		
		val[3][0]=val[3][0]+p.average;
		val[3][1]++;
		
		val[4][0]=val[4][0]+p.cost_per_km;
		val[4][1]++;
	 }

	
	
	String d="select sum(payable) as p from journey , application where journey.app_no=application.app_no and application.start_date>? and application.purpose=? and journey.end_date<?;";
	PreparedStatement dt=con.prepareStatement(d);
	dt.setString(1, s_date);
	dt.setString(2, "PERSONAL");
	dt.setString(3, f_date);
	ResultSet temp=dt.executeQuery();
	while(temp.next())
		personal=temp.getDouble("p");
	
}
catch (Exception e) {
	// TODO Auto-generated catch block
	  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('Enter valid data');");
	    	   out.println("location='admin_index.jsp';");
	    	   out.println("</script>");
			System.out.println(e.getMessage());
			e.printStackTrace();
}
%>
<br>
<h2 style="text-align: center;">DETAILS OF VEHICLE RUNNING EXPENSE FOR MONTH BETWEEN <%= s_date %> AND <%= f_date %></h2>
<div class="g" style="overflow:auto; margin: 20px">
<table class="ui celled table" id="ex1" >

<thead>
<tr>
<th>Sr. No</th>
<th>
MAKE
</th>
<th>
MODEL
</th>
<th>
REGISTERATION NO
</th>
<th>
NAME OF USER
</th>
<th>
KM RUN
</th>
<th>
FUEL(IN Ltrs)
</th>
<th>
FUEL COST
</th>
<th>
AVERAGE 
</th>
<th>
COST PER KM
</th>
<th>
MAINTENANCE COST
</th>
<th>
OPENING
</th>
<th>
CLOSING
</th>
<th>
LAST SERVICE DATE
</th>
<th>
LAST SERVICE KM
</th>
<th>
REMARKS
</th>
</tr>
</thead>
<tbody>
 
<% for(rep p: hm.values()){ %>

<%
con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
String fu="select sum(cost) as cost from maintenance where start>? and upto<? and registeration_no=? group by registeration_no;";
PreparedStatement ft=con.prepareStatement(fu);
double maintenance=0;

//System.out.println(maintenance+" okkk");

ft.setString(1, s_date);
ft.setString(2, f_date);
ft.setString(3, p.registeration_no);
ResultSet fb=ft.executeQuery();
while(fb.next())
	maintenance=fb.getDouble("cost");

//System.out.println(maintenance+" BYYYYY");
sum=sum+maintenance;
%>
	<tr>
	<td></td>
	<td>
	<%= p.make %>
	</td>
	<td>
	<%= p.model %>
	</td>
	<td>
	<%= p.registeration_no %>
	</td>
	<td>
	<%= p.name_of_user %>
	</td>
	<td>
	<%= p.km_run %>
	</td>
	<td>
	<%= p.fuel %>
	</td>
	<td>
	<%= p.fuel_cost %>
	</td>
	<td>
	<%= p.average %>
	</td>
	<td>
	<%= p.cost_per_km %>
	</td>
	<td>
	<%= maintenance %>
	</td>
	<td>
	<%= p.opening_km %>
	</td>
	<td>
	<%= p.closing_km %>
	</td>
	<td>
	<%= p.last_service_date %>
	</td>
	<td>
	<%= p.service_km %>
	</td>
	<td>
	<%= p.remark %>
	</td>
	</tr>
<%} %>
</tbody>
<tfoot>
<tr>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th>
<%= val[0][0] %>
</th>
<th>
<%= val[1][0] %>
</th>
<th>
<%= val[2][0] %>
</th>
<th>
<%= val[3][0]/val[3][1] %>
</th>
<th>
<%= val[4][0] %>
</th>
<th><%= sum %></th>
<th></th>
<th></th>
<th></th>
<th></th>
<th></th>
</tr>
</tfoot>
</table>
</div>
<br>
<div style="overflow:auto; margin: 20px">
<table class="ui celled table" id="ex2" >
<caption></caption>
<thead>
<tr>
<th colspan="3">
ACTUAL COST BETWEEN DATE <%= s_date %> AND <%= f_date %>
</th>
</tr>
<tr>
<td>
TOTAL VEHICLE EXPENSE
</td>
<td>
</td>
<td>
<%=sum+val[2][0]  %>
</td>
</tr>
<tr>
<td>
PERSONAL USE DEDUCTION
</td>
<td></td>
<td>
<%= personal %>
</td>
</tr>
<tr>
<td>
NET COST FOR COMPANY
</td>
<td></td>
<td>
<%= sum+val[2][0]-personal %>
</td>
</tr>
</thead>
</table>
</div>
<br>
<br>
<button class="ui button" id="button-a">Create Excel1</button>
<button class="ui button" id="button-b">Create Excel2</button>

<script>
        var wb1 = XLSX.utils.table_to_book(document.getElementById('ex1'), {sheet:"Sheet JS"});
        var wbout1 = XLSX.write(wb1, {bookType:'xlsx', bookSST:true, type: 'binary'});
        function s2ab1(s) {
                        var buf = new ArrayBuffer(s.length);
                        var view = new Uint8Array(buf);
                        for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
                        return buf;
        }
        $("#button-a").click(function(){
        saveAs(new Blob([s2ab1(wbout1)],{type:"application/octet-stream"}), 'details.xlsx');
        });
</script>
<script>
        var wb = XLSX.utils.table_to_book(document.getElementById('ex2'), {sheet:"Sheet JS"});
        var wbout = XLSX.write(wb, {bookType:'xlsx', bookSST:true, type: 'binary'});
        function s2ab(s) {
                        var buf = new ArrayBuffer(s.length);
                        var view = new Uint8Array(buf);
                        for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
                        return buf;
        }
        $("#button-b").click(function(){
        saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), 'actual_cost.xlsx');
        });
        
</script>

<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
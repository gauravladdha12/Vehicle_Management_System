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
 
 <script src="https://cdn.rawgit.com/unconditional/jquery-table2excel/master/src/jquery.table2excel.js"></script>
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
<h2 style="text-align: center;">FUEL REPORT</h2>
<%@ page import ="java.sql.*"
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

<%!
public ResultSet results;
%>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="select *from fuel_transaction where filling_date> ? and filling_date< ?";
	PreparedStatement st=con.prepareStatement(q);
	st.setString(1,request.getParameter("s_date"));
	st.setString(2,request.getParameter("f_date"));
	results=st.executeQuery();
%>
<div style="overflow:auto; margin: 20px">
<table class="ui celled table" id="mytable" >
<thead>
<tr>
<th>Sr. No</th>
<th>
BILL NO
</th>
<th>
FILLING DATE
</th>
<th>
NAME OF PARTY
</th>
<th>
PRESENT KM
</th>
<th>
LITER
</th>
<th>
COST
</th>
<th>
AVERAGE
</th>
<th>
RUNNING COST PER KM
</th>
<th>
REMARK
</th>
</tr>
</thead>
<%while(results.next()){ %>
<tr>
<td></td>
<td>
<%= results.getString("bill_no") %>
</td>
<td>
<%= results.getString("filling_date") %>
</td>
<td>
<%= results.getString("name_of_party") %>
</td>
<td>
<%= results.getString("present_km") %>
</td>
<td>
<%= results.getString("liter") %>
</td>
<td>
<%= results.getString("cost") %>
</td>
<td>
<%= results.getString("average") %>
</td>
<td>
<%= results.getString("cost_per_km") %>
</td>
<td>
<%= results.getString("remark") %>
</td>
</tr>
<%} %>
</table>
</div>

<button class="ui button" id="button-a">Create Excel</button>
<script>
        var wb = XLSX.utils.table_to_book(document.getElementById('mytable'), {sheet:"Sheet JS"});
        var wbout = XLSX.write(wb, {bookType:'xlsx', bookSST:true, type: 'binary'});
        function s2ab(s) {
                        var buf = new ArrayBuffer(s.length);
                        var view = new Uint8Array(buf);
                        for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF;
                        return buf;
        }
        $("#button-a").click(function(){
        saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), 'fuel_report.xlsx');
        });
</script>

<script src="resources/js/main.js"></script>

	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
	
	
	
</body>
</html>
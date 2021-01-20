<%@page import="vehicle_management.validate"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <meta charset="utf-8">
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
	<%@ page import ="java.sql.*"
%>
<%@ page import ="java.io.*"
%>
<%!
public String app_no;
public ResultSet results;
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
<%
	try{
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
		app_no=request.getParameter("app_no");
		String q="select *from application where app_no=?";
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
			//PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('APPLICATION IS CANCELLED. PLEASE CHECK STATUS');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
	    	   return;
		}
		
		if(results.getInt("approve")==2){
			//PrintWriter out=res.getWriter();
			  out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('APPLICATION REJECTED');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
	    	   return;
		}
		if(results.getInt("approve")==1&&results.getInt("outs")==1){
			 out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('APPLICATION APPROVED NO MODIFICATION CAN BE MADE');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
	    	   return;
		}
		if(results.getInt("alloted")==1&&results.getInt("outs")==0){
			 out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('APPLICATION ALLOTED NO MODIFICATION CAN BE MADE');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
	    	   return;
		}
		
		String q2="select *from journey where app_no=?";
		PreparedStatement st2=con.prepareStatement(q2);
		st2.setString(1,request.getParameter("app_no"));
		ResultSet re2= st2.executeQuery();
		
		int c=0;
		while(re2.next()){
			c++;
		}
		re2.beforeFirst();
		re2.next();
		if(c>0 && re2.getInt("start")==1){
			 out.println("<script type=\"text/javascript\">");
	    	   out.println("alert('JOURNEY STARTED');");
	    	   out.println("location='user_index.jsp';");
	    	   out.println("</script>");
		}
		
	}
catch (Exception e) {
	e.printStackTrace();
	 out.println("<script type=\"text/javascript\">");
	   out.println("alert('JOURNEY STARTED');");
	   out.println("location='user_index.jsp';");
	   out.println("</script>");
}
%>
<%@ include file = "header.jsp" %>

<!-- 
<form class="ui form" action="user_modify" method="post">
<div class="two fields">
	<div class="field">
	<label>APPLICATION NO</label>
	<input type="text" name="app_no" value="<%= results.getString("app_no") %>" readonly >
	</div>
	<div class="field">
	<label>NAME</label>
	<input type="text" name="name" value="<%= results.getString("name") %>">
	</div>
	</div>
	<div class="two fields">
	<div class="field">
	<label>EMPLOYEE CODE</label>
	<input type="text" name="emp_code" value="<%= results.getString("emp_code") %>" readonly>
	</div>
	<div class="field">
	<label>DESTINATION</label>
	<input type="text" name="destination" value="<%= results.getString("destination") %>">
	</div>
	</div>
	
	<div class="two fields">
	<div class="field">
	<label>PASSENGER</label>
	<input type="number" name="passenger" value="<%= results.getInt("passenger") %>">
	</div>
	<div class="field">
	<label>ADDRESS</label>
	<input type="text" name="address" value="<%= results.getString("address") %>">
	</div>
	</div>
	
	<div class="two fields">
	<div class="field">
	<label>START DATE</label>
	<input type="date" name="start_date" value="<%= results.getString("start_date") %>">
	</div>
	<div class="field">
	<label>END DATE</label>
	<input type="date" name="end_date" value="<%= results.getString("end_date") %>">
	</div>
	</div>
	
	<div class="two fields">
	<div class="field">
	<label>START TIME</label>
	<input type="time" name="start_time" value="<%= results.getString("start_time") %>">
	</div>
	<div class="field">
	<label>PURPOSE</label>
	<div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="purpose">
	<i class="dropdown icon"></i>
	 <div class="default text">Select purpose</div>
	 
	 <div class="menu">
	  <div class="item" data-value="PERSONAL">PERSONAL</div>
	  <div class="item" data-value="OFFICIAL">OFFICIAL</div>
	 </div>
	</div>
	</div>
	</div>
	<div class="two fields">
	
	
	<div class="field">
	<label>PHONE NUMBER</label>
	<input type="tel" name="phone" value="<%= results.getString("number") %>" pattern="^[6-9]\d{9}$" >
	</div>
	</div>
	
	<div class="field">
	<label>REMARKS</label>
	<textarea rows="2" name="remarks">
	<%= results.getString("remarks") %>
	</textarea>
	</div>
	 <button class="ui button" type="submit">
 SUBMIT
</button>
</form>-->
<br><br><br><br><br><br><br>
<div class="container-contact100">
<div class="wrap-contact100">
<form class="contact100-form validate-form" method="post" action="user_modify">
<span class="contact100-form-title">
					Modify Application
</span>
<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Application_no</span>
					<input class="input100" type="text" id="input" name="app_no" value='<%=results.getString("app_no") %>' readonly="readonly">
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your emp_code">
					<span class="label-input100">Emp Code</span>
					<input class="input100" type="text" name="emp_code"  value="<%= (String)session.getAttribute("emp_code") %>" readonly >
				</div>
				<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
					<span class="label-input100">FULL NAME</span>
					<input class="input100" type="text" name="name" placeholder="Enter Your Name" value='<%=results.getString("name") %>' required >
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Destination</span>
					<input class="input100" type="text" name="destination"  value='<%=results.getString("destination") %>' required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">No of passenger</span>
					<input class="input100" type="number" name="passenger"  min="1" value='<%=results.getString("passenger") %>' required>
				</div>
					<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Start Date</span>
					<input class="input100" type="date" name="start_date"  value='<%=results.getString("start_date") %>' required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Return date</span>
					<input class="input100" type="date" name="end_date" value='<%=results.getString("end_date") %>' required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Phone</span>
					<input class="input100" type="tel" name="phone"  pattern="^[6-9]\d{9}$" value="<%= results.getString("number")%>" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">start time</span>
					<input class="input100" type="time" name="start_time"  value='<%=results.getString("start_time") %>' required>
				</div>
				
				<div class="wrap-input100 validate-input bg1" data-validate="Please enter purpose of visit" >
					<span class="label-input100">Purpose</span>
					<div>
						<select class="js-select2" name="purpose">
							<option>PERSONAL</option>
							<option>OFFICIAL</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>
				<div class="wrap-input100 validate-input bg0">
					<span class="label-input100">Address for communication</span>
					<input class="input100" type="text" name="address"  value='<%=results.getString("address") %>' required>
				</div>
				
					<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Message">
					<span class="label-input100">Remarks</span>
					<textarea class="input100" name="remarks" placeholder="Your remarks here...">
					</textarea>
				</div>
				
					<div class="container-contact100-form-btn">
					<button class="contact100-form-btn" type="submit">
						<span>
							Submit
							<i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
						</span>
					</button>
				</div>
				
</form>
</div>
</div>


	<!--===============================================================================================-->
	<script src="resources_application/vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="resources_application/vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="resources_application/vendor/bootstrap/js/popper.js"></script>
	<script src="resources_application/vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="resources_application/vendor/select2/select2.min.js"></script>
	<script>
		$(".js-select2").each(function(){
			$(this).select2({
				minimumResultsForSearch: 20,
				dropdownParent: $(this).next('.dropDownSelect2')
			});


			$(".js-select2").each(function(){
				$(this).on('select2:close', function (e){
					if($(this).val() == "Please chooses") {
						$('.js-show-service').slideUp();
					}
					else {
						$('.js-show-service').slideUp();
						$('.js-show-service').slideDown();
					}
				});
			});
		})

		var timepicker = new TimePicker('time', {
  lang: 'en',
  theme: 'dark'
});
timepicker.on('change', function(evt) {
  
  var value = (evt.hour || '00') + ':' + (evt.minute || '00');
  evt.element.value = value;

});
	</script>
	
<!--===============================================================================================-->
	
<script type="text/javascript">
	
	function hide(){
		 $('.ui.dropdown').dropdown();
	}
	</script>
	<script>
	var today = new Date().toISOString().split('T')[0];
	document.getElementsByName("start_date")[0].setAttribute('min', today);
	document.getElementsByName("end_date")[0].setAttribute('min', today);
	</script>
	
	
	  <script src="resources/js/main.js"></script>
	  <br><br><br>
	<%@ include file = "footer.jsp" %>
</body>
</html>
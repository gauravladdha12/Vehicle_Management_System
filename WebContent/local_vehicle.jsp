<%@page import="com.sun.xml.internal.bind.v2.schemagen.xmlschema.Import"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
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
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->

<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/vendor/noui/nouislider.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="resources_application/css/util.css">
	<link rel="stylesheet" type="text/css" href="resources_application/css/main.css">


<!--===============================================================================================-->

</head>
<body onload="hide()">
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
public int current =0;
public String app_no="";
%>
<%
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="select total_application as prev from employee where emp_code=?;";
	PreparedStatement st=con.prepareStatement(q);
	//HttpSession session = request.getSession();
	st.setString(1,(String)session.getAttribute("emp_code"));
	ResultSet results=st.executeQuery();
	while(results.next())
	 current=results.getInt("prev");
	
	current++;
	//System.out.println(current+" hellllo");
	System.out.println("hellooooo"+(String)session.getAttribute("emp_code"));
	app_no=(String)session.getAttribute("emp_code")+current;
}
catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}


%>
	<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="local_vehicle">
			<input type="hidden" value="<%=current %>" name="current">
				<span class="contact100-form-title">
					Application For Vehicle
				</span>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Application_no</span>
					<input class="input100" type="text" id="input" name="app_no" value='<%=app_no %>' readonly="readonly">
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your emp_code">
					<span class="label-input100">Emp Code</span>
					<input class="input100" type="text" name="emp_code" placeholder="Enter Your emp_code " value="<%= (String)session.getAttribute("emp_code") %>" readonly required>
				</div>
				
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Destination</span>
					<input class="input100" type="text" name="dest" placeholder="Enter Destination" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">No of passenger</span>
					<input class="input100" type="number" name="no_passenger" placeholder="Enter no of passenger" min="1" required>
				</div>
				
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Start Date</span>
					<input class="input100" type="date" id="st_date" name="st_date" placeholder="Enter start date" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Return date</span>
					<input class="input100" type="date" id="end_date" name="end_date" placeholder="Enter end date" required>
				</div>
				<div class="wrap-input100 validate-input bg1">
					<span class="label-input100">start time</span>
					<input class="input100" type="time" id="st_time" name="st_time" placeholder="Enter start time" required>
				</div>

				
				<div class="wrap-input100 validate-input bg0">
					<span class="label-input100">Address for communication</span>
					<input class="input100" type="text" name="address" placeholder="Enter address for communication">
				</div>
				<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Message">
					<span class="label-input100">Remarks</span>
					<textarea class="input100" name="remark" placeholder="Your remarks here..."></textarea>
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
	document.getElementsByName("st_date")[0].setAttribute('min', today);
	document.getElementsByName("end_date")[0].setAttribute('min', today);
	</script>
	
	<script>
	jQuery.validator.addMethod("greaterThan", 
			function(value, element, params) {

			    if (!/Invalid|NaN/.test(new Date(value))) {
			        return new Date(value) > new Date($(params).val());
			    }

			    return isNaN(value) && isNaN($(params).val()) 
			        || (Number(value) > Number($(params).val())); 
			},'Must be greater than {0}.');
	$("#end_date").rules('add', { greaterThan: "#st_date" });
	</script>
	<script src="resources/js/main.js"></script>
	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>

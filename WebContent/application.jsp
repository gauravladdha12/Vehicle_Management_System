<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
 <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>RSWM VEHICLE MANAGEMENT SYSTEM</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- <link rel="manifest" href="site.webmanifest"> -->
    <link rel="shortcut icon" type="image/x-icon" href="resources/img/banner/rswm-logo.svg">
    <!-- Place favicon.ico in the root directory -->

    <!-- CSS here -->
    <link rel="stylesheet" href="resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/owl.carousel.min.css">
    <link rel="stylesheet" href="resources/css/magnific-popup.css">
    <link rel="stylesheet" href="resources/css/font-awesome.min.css">
    <link rel="stylesheet" href="resources/css/themify-icons.css">
    <link rel="stylesheet" href="resources/css/nice-select.css">
    <link rel="stylesheet" href="resources/css/flaticon.css">
    <link rel="stylesheet" href="resources/css/animate.css">
    <link rel="stylesheet" href="resources/css/slicknav.css">
    <link rel="stylesheet" href="resources/css/style.css">
    
   
    	
<%@ include file = "application_resources.jsp" %>
    
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
</head>
<body onload="hide()">

<%@ include file = "header.jsp" %>
    
    <%@ page import ="java.sql.*"
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
	//System.out.println(current+" yooo");
}
catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>
<br>
<br>

<br>
<br>

<br>
<br>

<br>
	<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="application_request">
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
					
				
				<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
					<span class="label-input100">FULL NAME</span>
					<input class="input100" type="text" name="name" placeholder="Enter Your Name" required>
				</div>
		
				

				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your Email (e@a.x)">
					<span class="label-input100">Email</span>
					<input class="input100" type="email" name="email" placeholder="Enter Your Email" required>
				</div>

				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Phone</span>
					<input class="input100" type="tel" name="phone" placeholder="Enter Number Phone" pattern="^[6-9]\d{9}$" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your Email (e@a.x)">
					<span class="label-input100">Departement</span>
					<input class="input100" type="text" name="email" placeholder="Enter Your Departement " required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">OUT OF STATION</span>
					<div>
						<select class="js-select2" name="outs">
							<option value="1">YES</option>
							<option value="0">NO</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>

				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Destination</span>
					<input class="input100" type="text" name="dest" placeholder="Enter Destination" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">No of passenger</span>
					<input class="input100" type="number" name="no_passenger" placeholder="Enter no of passenger" min="1" required>
				</div>
				<div class="wrap-input100 validate-input bg1" data-validate="Please enter purpose of visit">
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
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Start Date</span>
					<input class="input100" type="date" name="st_date" placeholder="Enter start date" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Return date</span>
					<input class="input100" type="date" name="end_date" placeholder="Enter end date" required>
				</div>
				<div class="wrap-input100 validate-input bg1">
					<span class="label-input100">start time</span>
					<input class="input100" type="time" name="st_time" placeholder="Enter start time" required>
				</div>
<!--
				<div class="wrap-input100 input100-select bg1">
					<span class="label-input100">Needed Services *</span>
					<div>
						<select class="js-select2" name="service">
							<option>Please chooses</option>
							<option>eCommerce Bussiness</option>
							<option>UI/UX Design</option>
							<option>Online Services</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
				</div>
-->
				
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
	
    <br>
    <br>
<%@ include file = "footer.jsp" %>
    <script src="resources/js/main.js"></script>
    
</body>
</html>
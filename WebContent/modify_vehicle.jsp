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
Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
String q="Select *from vehicle where registeration_no=?";
PreparedStatement st=con.prepareStatement(q);
st.setString(1,request.getParameter("registeration_no"));
results=st.executeQuery();
results.next();
%>

	
	
	<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="modify_vehicle">
			<span class="contact100-form-title">
			MODIFY VEHICLE
			</span>
			
							<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Registeration No</span>
					<input class="input100" type="text" name="registeration_no" placeholder="Enter Vehicle Registeration No" value="<%= results.getString("registeration_no") %>" readonly required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Chassis No</span>
					<input class="input100" type="text" name="chassis_no" placeholder="Enter Vehicle Chassis No" value="<%= results.getString("chassis_no") %>" readonly required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">User Name</span>
					<input class="input100" type="text" name="user" placeholder="Enter user name" value="<%= results.getString("user") %>"  required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">Usable For Public</span>
					<div>
						<select class="js-select2" name="usable">
							<option value="1">YES</option>
							<option value="0">NO</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>
							
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Vehicle Class</span>
					<input class="input100" type="text" name="vehicle_class" placeholder="Enter vehicle class" value="<%= results.getString("vehicle_class") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Model Name</span>
					<input class="input100" type="text" name="model_name" placeholder="Enter Model Name" value="<%= results.getString("model_name") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Vehicle Make</span>
					<input class="input100" type="text" name="vehicle_make" placeholder="Enter vehicle make" value="<%= results.getString("vehicle_make") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Purchase Date</span>
					<input class="input100" type="date" name="pur_date" value="<%= results.getString("purchase_date") %>" required>
				</div>
				
							<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Engine No</span>
					<input class="input100" type="text" name="engine_no" placeholder="Enter Vehicle Engine No" value="<%= results.getString("engine_no") %>" required>
				</div>
						<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Manufacturing Date</span>
					<input class="input100" type="date" name="mfg_date" value="<%= results.getString("manufacturing_date") %>" required>
				</div>
				
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Wheel Base</span>
					<input class="input100" type="text" name="wheel_base" placeholder="Enter wheel base" value="<%= results.getString("wheel_base") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Cubic Capacity</span>
					<input class="input100" type="number" step="0.01" name="cubic_cap" placeholder="Enter Cubic Capacity" value="<%= results.getInt("cubic_capacity") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Engine Capacity</span>
					<input class="input100" type="number" step="0.01" name="engine_cap" placeholder="Enter Engine Capacity" value="<%= results.getInt("engine_capacity") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Seating Capacity</span>
					<input class="input100" type="number" step="0.01" name="seat_cap" placeholder="Enter Seating Capacity" value="<%= results.getInt("sitting_capacity") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Registeration Date</span>
					<input class="input100" type="date" name="reg_date" value="<%= results.getString("registeration_date") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Body Type</span>
					<input class="input100" type="text" name="body_type" value="<%= results.getString("body_type") %>" required>
				</div>
					<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">Fuel Type</span>
					<div>
						<select class="js-select2" name="fuel_type">
							<option >PETROL</option>
							<option >DIESEL</option>
							<option >GAS</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>
					<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Color</span>
					<input class="input100" type="text" name="color" value="<%= results.getString("color") %>"  required>
				</div>
					<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">Vehicle Live</span>
					<div>
						<select class="js-select2" name="live">
							<option value="1">YES</option>
							<option value="0">NO</option>
							
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">Company Owner</span>
					<div>
						<select class="js-select2" name="company_flag">
							<option>RSWM</option>
							<option>OTHER</option>
							
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Cylinder</span>
					<input class="input100" type="number" step="0.01" name="cylinder" value="<%= results.getInt("cylinder") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Registeration Validity</span>
					<input class="input100" type="date" name="reg_valid" value="<%= results.getString("registeration_validity") %>" required>
				</div>
					<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Present Km</span>
					<input class="input100" type="number" step="0.01" name="present_km" value="<%= results.getDouble("present_km") %>" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">Vehicle Currently Available</span>
					<div>
						<select class="js-select2" name="available">
							<option value="1">YES</option>
							<option value="0">NO</option>
							
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>
				<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Message">
					<span class="label-input100">Remarks</span>
					<textarea class="input100" name="remark" placeholder="Your remarks here...">
					<%= results.getString("remark") %>
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
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
String q="Select *from driver where driver_code=?";
PreparedStatement st=con.prepareStatement(q);
st.setString(1,request.getParameter("driver_code"));
results=st.executeQuery();
results.next();
%>
<!-- 
<form class="ui form" action="modify_driver" method="post">
	<div class="two fields">
	<div class="field">
	<label>DRIVER CODE</label>
	<input type="text" name="driver_code" value="<%=results.getString("driver_code") %>" readonly>
	</div>
	<div class="field">
	<label>NAME</label>
	<input type="text" name="name" value="<%=results.getString("name") %>" >
	</div>
	</div>
<div class="two fields">
	<div class="field">
	<label>FATHER'S NAME</label>
	<input type="text" name="father_name" value="<%=results.getString("father_name") %>">
	</div>
	<div class="field">
	<label>LICENSE NO</label>
	<input type="text" name="license_no" value="<%=results.getString("license_no") %>">
	</div>
	</div>
	<div class="two fields">
	<div class="field">
	<label>DATE OF BIRTH</label>
	<input type="date" name="dob" value="<%=results.getString("dob") %>">
	</div>
	<div class="field">
	<label>DATE OF JOINING</label>
	<input type="date" name="doj" value="<%=results.getString("doj") %>">
	</div>
	</div>
	<div class="two fields">
	<div class="field">
	<label>LIVE</label>
	<%if(results.getInt("live")==1){ %>
			<select name="live">
	<option value="1" selected="selected">
	TRUE
	</option>
	<option value="0">
	FALSE
	</option>
	</select>
			
			<%} %>
			<%if(results.getInt("live")==0){ %>
			<select name="live">
	<option value="1">
	TRUE
	</option>
	<option value="0" selected="selected">
	FALSE
	</option>
	</select>
			<%} %>
	
	</div>
	<div class="field">
	<label>OWNER</label>
	
	<%if(results.getString("company_flag").compareTo("RSWM")==0
){ %>
		<select name="company_flag">
		<option selected="selected">
		RSWM
		</option>
		<option>
		OTHER
		</option>
	</select>
	<%} %>
	
	<%if(results.getString("company_flag").compareTo("OTHER")==0
){ %>
		<select name="company_flag">
		<option>
		RSWM
		</option>
		<option selected="selected">
		OTHER
		</option>
	</select>
	<%} %>
		
	</div>
	</div>
	<div class="two fields">
	<div class="field">
	<label>CONTACT NO.</label>
	<input type="tel" pattern="^[6-9]\d{9}$" name="number" value="<%=results.getString("contact_no") %>">
	</div>
	<div class="field">
	<label>LICENSE VALID</label>
	<input type="date" name="license_valid" value="<%=results.getString("license_valid") %>">
	</div>
	</div>
	<div class="field">
	<label>AVAILABLE</label>
	<input type="text" name="available" value="<%=results.getString("available") %>">
	</div>
	<div class="field">
    <label>ADDRESS</label>
    <textarea rows="2" name="address" ><%=results.getString("address") %></textarea>
  </div>
	 <button class="ui button" type="submit">
 SUBMIT
</button>
</form>
-->


<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="modify_driver">
			<span class="contact100-form-title">
			MODIFY DRIVER
			</span>
			<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Driver Code</span>
					<input class="input100" type="text" name="driver_code" placeholder="Enter Driver Code" value="<%=results.getString("driver_code") %>" readonly  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Name</span>
					<input class="input100" type="text" name="name" placeholder="Enter Driver Name" value="<%=results.getString("name") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Father Name</span>
					<input class="input100" type="text" name="father_name" placeholder="Enter Father Name" value="<%=results.getString("father_name") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">License No</span>
					<input class="input100" type="text" name="license_no" placeholder="Enter Driver Code" value="<%=results.getString("license_no") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Date Of Birth</span>
					<input class="input100" type="date" name="dob" placeholder="Enter Driver Code" value="<%=results.getString("dob") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Date Of Joining</span>
					<input class="input100" type="date" name="doj" placeholder="Enter Driver Code" value="<%=results.getString("doj") %>"  required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Contact No</span>
					<input class="input100" type="tel" name="number" placeholder="Enter Phone Number" pattern="^[6-9]\d{9}$" value="<%=results.getString("contact_no") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">License Valid</span>
					<input class="input100" type="date" name="license_valid" placeholder="Enter Driver Code" value="<%=results.getString("license_valid") %>" required>
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
							<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate="Please enter purpose of visit">
					<span class="label-input100">Driver Currently Available</span>
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
					<span class="label-input100">Address</span>
					<input class="input100" type="text" name="address" placeholder="Enter Driver Address" value="<%=results.getString("address") %>" required>
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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<title>RSWM VEHICLE MANAGEMENT SYSTEM</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	 <link rel="shortcut icon" type="image/x-icon" href="resources/img/banner/rswm-logo.svg">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login_resources/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login_resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login_resources/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login_resources/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="login_resources/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="login_resources/vendor/animsition/css/animsition.min.css">

	<link rel="stylesheet" type="text/css" href="login_resources/vendor/select2/select2.min.css">

	<link rel="stylesheet" type="text/css" href="login_resources/vendor/daterangepicker/daterangepicker.css">

	<link rel="stylesheet" type="text/css" href="login_resources/css/util.css">
	<link rel="stylesheet" type="text/css" href="login_resources/css/main.css">
	<style type="text/css">
		
#myVideo {
  position: fixed;
  right: 0;
  bottom: 0;
  min-width: 100%; 
  min-height: 100%;
}
	</style>
</head>
<body>
	<video autoplay muted loop id="myVideo">
  <source src="login_resources/images/rswm_home_page.mp4" type="video/mp4">
  Your browser does not support HTML5 video.
</video>

	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-30 p-b-50">
				<span class="login100-form-title p-b-41">
					Account Registration
				</span>
				<div class="g">
				<form class="login100-form validate-form p-b-33 p-t-5" method="post" action="register">
			

				 	<div class="wrap-input100 validate-input" data-validate = "Enter username">
						<input class="input100" type="text" name="username" placeholder="User name" required>
						<span class="focus-input100" data-placeholder="&#xe82a;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter email id">
						<input class="input100" type="email" name="email" placeholder="Email" required>
						<span class="focus-input100" data-placeholder="&#xe80f;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter password">
						<input class="input100" type="password" name="password" placeholder="Password" required>
						<span class="focus-input100" data-placeholder="&#xe80f;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter employee code">
						<input class="input100" type="text" name="emp_code" placeholder="Emp_code" required>
						<span class="focus-input100" data-placeholder="&#xe80f;"></span>
					</div>
					<div class="wrap-input100 validate-input" data-validate="Enter Departement">
						<input class="input100" type="text" name="emp_dept" placeholder="Emp_dept" required>
						<span class="focus-input100" data-placeholder="&#xe80f;"></span>
					</div>
					<div class="container-login100-form-btn m-t-32">
						<button class="login100-form-btn" type="submit">
							Register
						</button>
					</div>
					<a href="http://localhost:8080/vehicle_management/login.jsp">
					<div class="container-login100-form-btn m-t-32">
						Login
					</div>
					</a>
				</form>
			</div>
		</div>
	</div>

</body>
</html>
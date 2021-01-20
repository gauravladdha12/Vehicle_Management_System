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
<style>
body{
overflow: auto; 
}
</style>
</head>
<body>
<%@ include file = "header.jsp" %>
<br><br><br><br><br>
<%@ page import ="java.sql.*"
%>
<%!
public String app_no;
public int alloted;
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
	app_no=request.getParameter("app_no");
	alloted=Integer.parseInt(request.getParameter("alloted"));
%>
<!-- 
<form class="ui form" action="user_cancel" method="post">
<input type="hidden" name="app_no" value="<%= app_no %>">
<input type="hidden" name="alloted" value="<%= alloted %>">
<div class="field">
	<label>USER CANCELLATION REMARK</label>
	<textarea rows="2" name="cancel_remarks">
	</textarea>
	</div>
	 <button class="ui button" type="submit">
 SUBMIT
</button>
</form> -->


<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="user_cancel">
			<input type="hidden" name="app_no" value="<%= app_no %>">
		<input type="hidden" name="alloted" value="<%= alloted %>">
				<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Message">
					<span class="label-input100">User Cancellation Remark</span>
					<textarea class="input100" name="cancel_remarks" placeholder="Your remarks here..."></textarea>
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

<script src="resources/js/main.js"></script>
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
	  <br><br><br>
	<%@ include file = "footer.jsp" %>
</body>
</html>
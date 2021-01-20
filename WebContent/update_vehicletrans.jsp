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
String q="Select *from vehicle_transaction where registeration_no=?";
PreparedStatement st=con.prepareStatement(q);
st.setString(1,request.getParameter("registeration_no"));
results=st.executeQuery();
int rowcount = 0;
if (results.last()) {
  rowcount = results.getRow();
  results.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
}

if(rowcount==0){
	out.println("<script type=\"text/javascript\">");
	   out.println("alert('ENTER VALID DATA');");
	   out.println("location='admin_index.jsp';");
	   out.println("</script>");
	   return;
}
results.next();
%>

	<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="updatevehicle_trans">
			<span class="contact100-form-title">
			UPDATE VEHICLE TRANSACTION
			</span>
			<div class="wrap-input100 validate-input bg0 rs1-alert-validate">
					<span class="label-input100">Registeration No</span>
					<input class="input100" type="text" name="registeration_no" placeholder="Enter Driver Code" value="<%=results.getString("registeration_no") %>" readonly  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Insurance Valid Upto</span>
					<input class="input100" type="date" name="insurance_upto" placeholder="Enter Driver Code" value="<%=results.getString("insurance_upto") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Servicing Date</span>
					<input class="input100" type="date" name="servicing_date" placeholder="Enter Driver Code" value="<%=results.getString("servicing_date") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Servicing Valid Upto</span>
					<input class="input100" type="date" name="servicing_upto" placeholder="Enter Driver Code" value="<%=results.getString("servicing_upto") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">PUC Valid Upto</span>
					<input class="input100" type="date" name="pollution_control_valid" placeholder="Enter Driver Code" value="<%=results.getString("pollution_control_valid") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Certificate of Fittness Valid Upto</span>
					<input class="input100" type="date" name="certificate_of_fitness" placeholder="Enter Driver Code" value="<%=results.getString("certificate_of_fitness") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Servicing Km Reading</span>
					<input class="input100" type="number" step="0.01" name="servicing_km" placeholder="Enter Servicing km" value="<%=results.getDouble("servicing_km") %>" required>
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
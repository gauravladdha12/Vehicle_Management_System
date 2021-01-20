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
String q="Select *from fuel_transaction where bill_no=?";
PreparedStatement st=con.prepareStatement(q);
st.setString(1,request.getParameter("bill_no"));
results=st.executeQuery();
results.next();
%>
	
	<% 
  //ResultSet ve=(ResultSet)hm.get("vehicle_results");
  Class.forName("com.mysql.cj.jdbc.Driver");
 con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
  String q5="select *from vehicle";
  PreparedStatement st5=con.prepareStatement(q5);
  ResultSet vehicle_results=st5.executeQuery();
 %>
	<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="updatefuel_trans">
			<span class="contact100-form-title">
			UPDATE FUEL TRANSACTION
			</span>
			<div class="wrap-input100 validate-input bg0 rs1-alert-validate">
					<span class="label-input100">Bill No</span>
					<input class="input100" type="text"  name="bill_no" placeholder="Enter Bill No" value="<%=results.getString("bill_no") %>" readonly  required>
				</div>
			<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate="Please enter purpose of visit">
					<span class="label-input100">Vehicle Registeration No</span>
					<div>
						<select class="js-select2" name=registeration_no>
							<% while(vehicle_results.next()){ %>
							<%if(vehicle_results.getString("registeration_no").compareTo(results.getString("registeration_no"))==0){ %>
							<option selected="selected" value="<%= vehicle_results.getString("registeration_no") %>"> <%= vehicle_results.getString("registeration_no") %></option>
							<%}else{ %>
							<option value="<%= vehicle_results.getString("registeration_no") %>"> <%= vehicle_results.getString("registeration_no") %></option>
							<%} %>
							<%} %>
							
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					<!-- <input class="input100" type="text" name="purpose" placeholder="Enter purpose of visit"> -->
				</div>
			
				
				<div class="wrap-input100 validate-input bg0 rs1-alert-validate">
					<span class="label-input100">Fill Date</span>
					<input class="input100" type="date"  name="filling_date" placeholder="Enter Bill No" value="<%=results.getString("filling_date") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Name of Party</span>
					<input class="input100" type="text"  name="name_of_party" placeholder="Enter Name Of Party" value="<%=results.getString("name_of_party") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Present Km</span>
					<input class="input100" type="number" step="0.01" name="present_km" placeholder="Enter present km" value="<%=results.getDouble("present_km") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Fuel In Liters</span>
					<input class="input100" type="number" step="0.01" name="liter" placeholder="Enter fuel liters" value="<%=results.getDouble("liter") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Cost</span>
					<input class="input100" type="number" step="0.01" name="cost" placeholder="Enter cost" value="<%=results.getDouble("cost") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Average</span>
					<input class="input100" type="number" step="0.01" name="average" placeholder="Enter Average" value="<%=results.getDouble("average") %>"  required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Cost per Km</span>
					<input class="input100" type="number" step="0.01" name="cost_per_km" placeholder="Enter cost per km" value="<%=results.getDouble("cost_per_km") %>" required>
				</div>
				<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Message">
					<span class="label-input100">Remarks</span>
					<textarea class="input100" name="remark" placeholder="Your remarks here...">
					<%=results.getString("remark") %>
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
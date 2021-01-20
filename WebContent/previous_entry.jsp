<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

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
<body onload="hide();">
<%@ include file = "admin_header.jsp" %>
<br><br><br><br><br><br><br>
<%@ page import ="java.sql.*"
%>
<%!
public int current =0;
public String app_no="";
public ResultSet driver;
public ResultSet vehicle;
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
	//System.out.println("hellooooo"+(String)session.getAttribute("emp_code"));
	app_no=(String)session.getAttribute("emp_code")+current;
	
	
	String q2="select *from driver";
	PreparedStatement st2=con.prepareStatement(q2);
	driver=st2.executeQuery();
	
	String q3="select *from vehicle";
	PreparedStatement st3=con.prepareStatement(q3);
	vehicle=st3.executeQuery();
	
}
catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>



<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="p_entry">
			<span class="contact100-form-title">
			ADD PREVIOUS ENTRY
			</span>
			
				
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your emp_code">
					<span class="label-input100">Emp Code</span>
					<input class="input100" type="text" id="emp_code" name="emp_code" placeholder="Enter Your emp_code " required>
				</div>
				
				<button class="ui button" type="button" name="f_a" id="f_a">GET APPLICATION NO</button>
				
					<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Application_no</span>
					<input class="input100" type="text"  name="app_no" id="app_no" readonly>
				</div>
				
				<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
					<span class="label-input100">FULL NAME</span>
					<input class="input100" type="text" name="name" placeholder="Enter Your Name" required>
				</div>
		
				

				

				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Phone</span>
					<input class="input100" type="tel" name="phone" placeholder="Enter Number Phone" pattern="^[6-9]\d{9}$" required>
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
					<input class="input100" type="text" name="destination" placeholder="Enter Destination" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">No of passenger</span>
					<input class="input100" type="number" name="passenger" placeholder="Enter no of passenger" min="1" required>
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
					<input class="input100" type="date" name="start_date" placeholder="Enter start date" required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Return date</span>
					<input class="input100" type="date" name="end_date" placeholder="Enter end date" required>
				</div>
				<div class="wrap-input100 validate-input bg1">
					<span class="label-input100">start time</span>
					<input class="input100" type="time" name="start_time" placeholder="Enter start time" required>
				</div>
				<div class="wrap-input100 validate-input bg0">
					<span class="label-input100">Address for communication</span>
					<input class="input100" type="text" name="address" placeholder="Enter address for communication">
				</div>
				<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Message">
					<span class="label-input100">Remarks</span>
					<textarea class="input100" name="remarks" placeholder="Your remarks here..."></textarea>
				</div>

											<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">Vehicle Registeration No</span>
					<div>
						<select class="js-select2" name="registeration_no" required>
							<%while(vehicle.next()){ %>
	 <option value="<%= vehicle.getString("registeration_no")%>"><%= vehicle.getString("registeration_no")%></option>
	 <%} %>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					</div>
					
												<div class="wrap-input100 bg1 rs1-wrap-input100" data-validate="Please enter purpose of visit">
					<span class="label-input100">Driver</span>
					<div>
						<select class="js-select2" name="driver_code" required>
							<%while(driver.next()){ %>
	 <option value="<%=driver.getString("driver_code")%>"><%= driver.getString("name")%>  <%= driver.getString("driver_code")%></option>
	 <%} %>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
					</div>
					
					<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Start Km Reading</span>
					<input class="input100" type="number" step="0.01" name="present_km" placeholder="Enter present Km"  required>
				</div>
												<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Final Km Reading</span>
					<input class="input100" type="number" step="0.01" name="final_km" placeholder="Enter final Km"  required>
				</div>
				
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Rate</span>
					<input class="input100" type="number" step="0.01" name="rate" placeholder="Enter Rate"  required>
				</div>
												<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Payable Amount (IN RS)</span>
					<input class="input100" type="number" step="0.01" name="payable" placeholder="Enter Amount TO Pay"  required>
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
			



<script type="text/javascript">
	
	function hide(){
		 $('.ui.dropdown').dropdown();
	}
	</script>
	
	<script>
	$(document).ready(function(){
		$('#f_a').click(function(){
			$.post("get_app",{emp_code: $('#emp_code').val()},
				function(data){
				//alert(data);
				if(data==-1){
					alert("enter valid data");
					window.location.reload();
				}
					$('#app_no').val(data);
			}	
			);
		});
	});
	</script>
	
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
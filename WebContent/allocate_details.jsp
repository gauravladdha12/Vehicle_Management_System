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
public ResultSet results1;
public ResultSet results2;
public ResultSet results3;
public ResultSet results4;
public ResultSet results5;
public String app_no;
public String registeration_no;
public String driver_code;
public Connection con;
public String g;
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
	app_no=request.getParameter("app_no");
	registeration_no=request.getParameter("registeration_no");
	driver_code=request.getParameter("driver_code");
	Class.forName("com.mysql.cj.jdbc.Driver");
	con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="select * from application where app_no=?;";
	
	PreparedStatement st=con.prepareStatement(q);
	st.setString(1,app_no);
	 results1=st.executeQuery();
	 results1.next();
	 
	 String q2="select *from employee where emp_code=?";
	 PreparedStatement st2=con.prepareStatement(q2);
	 st2.setString(1,results1.getString("emp_code"));
	 results2=st2.executeQuery();
	 results2.next();
	/*while(results.next()){
	 current=results.getInt("prev");
	}

	//System.out.println(current+" hellllo");
	current++;*/
	 String q3="select *from vehicle where registeration_no = ?";
	 PreparedStatement st3=con.prepareStatement(q3);
	 st3.setString(1,registeration_no);
	 results3=st3.executeQuery();
	 results3.next();
	 
	 String q4="select *from driver where driver_code= ?";
	 PreparedStatement st4=con.prepareStatement(q4);
	 st4.setString(1,driver_code);
	 results4=st4.executeQuery();
	 results4.next();
	 
	 
	 if(results1.getInt("outs")==1)
		 g="YES";
	 else
		 g="NO";
	
}
catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>


<h2 style="text-align: center;">CONFIRM DETAILS</h2>

<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="add_journey">
				<span class="contact100-form-title">
					Application For Vehicle
				</span>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Application_no</span>
					<input class="input100" type="text" id="input" name="app_no" value='<%=results1.getString("app_no") %>' readonly="readonly">
				</div>
				
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your emp_code">
					<span class="label-input100">Emp Code</span>
					<input class="input100" type="text" name="emp_code" placeholder="Enter Your emp_code " value="<%=results1.getString("emp_code") %>" readonly>
				</div>
					
				
				<div class="wrap-input100 validate-input bg1" data-validate="Please Type Your Name">
					<span class="label-input100">FULL NAME</span>
					<input class="input100" type="text" name="name" placeholder="Enter Your Name" value="<%=results1.getString("name") %>" readonly required>
				</div>
		
				


				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Phone</span>
					<input class="input100" type="tel" name="number" placeholder="Enter Number Phone" value="<%=results1.getString("number") %>" readonly pattern="^[6-9]\d{9}$" required>
				</div>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your Email (e@a.x)">
					<span class="label-input100">Departement</span>
					<input class="input100" type="text" name="dept" placeholder="Enter Your Departement " value="<%=results2.getString("emp_dept") %>" readonly required>
				</div>
				
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Your Email (e@a.x)">
					<span class="label-input100">Out of Station</span>
					<input class="input100" type="text" name="outs" placeholder="Enter Your Departement " value="<%= g%>" readonly required>
				</div>
				
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Destination</span>
					<input class="input100" type="text" name="destination" placeholder="Enter Destination" value="<%=results1.getString("destination") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">No of passenger</span>
					<input class="input100" type="number" name="passenger" placeholder="Enter no of passenger" min="1" value="<%=results1.getString("passenger") %>" readonly required>
				</div>
				
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Purpose</span>
					<input class="input100" type="text" name="purpose" placeholder="Enter Destination" value="<%=results1.getString("purpose") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Start Date</span>
					<input class="input100" type="date" name="start_date" placeholder="Enter start date" value="<%=results1.getString("start_date") %>" readonly  required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Return date</span>
					<input class="input100" type="date" name="end_date" placeholder="Enter end date" value="<%=results1.getString("end_date") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">start time</span>
					<input class="input100" type="time" name="start_time" placeholder="Enter start time" value="<%=results1.getString("start_time") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Address for communication</span>
					<input class="input100" type="text" name="address" placeholder="Enter address for communication" value="<%=results1.getString("address") %>" readonly>
				</div>
				<div class="wrap-input100 validate-input bg0 rs1-alert-validate" data-validate = "Please Type Your Message" >
					<span class="label-input100">Remarks</span>
					<textarea class="input100" name="remarks" placeholder="Your remarks here...">
					<%=results1.getString("remarks") %>
					</textarea>
				</div>
								<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Vehicle Name</span>
					<input class="input100" type="text" name="model_name" placeholder="Enter start time" value="<%=results3.getString("model_name") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Vehicle Make</span>
					<input class="input100" type="text" name="vehicle_make" placeholder="Enter address for communication" value="<%=results3.getString("vehicle_make") %>" readonly>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Vehicle Registeration No</span>
					<input class="input100" type="text" name="registeration_no" placeholder="Enter start time" value="<%=results3.getString("registeration_no") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Vehicle Chassis No</span>
					<input class="input100" type="text" name="chassis_no" placeholder="Enter address for communication" value="<%=results3.getString("chassis_no") %>" readonly>
				</div>
				
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Driver Code</span>
					<input class="input100" type="text" name="st_time" placeholder="Enter start time" value="<%=results4.getString("driver_code") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Driver Name</span>
					<input class="input100" type="text" name="driver_name" placeholder="Enter address for communication" value="<%=results4.getString("name") %>" readonly>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Driver Contact No</span>
					<input class="input100" type="text" name="contact_no" placeholder="Enter start time" value="<%=results4.getString("contact_no") %>" readonly required>
				</div>
				<div class="wrap-input100 bg1 rs1-wrap-input100">
					<span class="label-input100">Vehicle Present Km</span>
					<input class="input100" type="text" name="present_km" placeholder="Enter address for communication" value="<%=results3.getString("present_km") %>" readonly>
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
	
	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
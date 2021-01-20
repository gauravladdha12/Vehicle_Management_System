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
<%@ page import ="java.io.*"
%>
<%
if(session==null||((String)session.getAttribute("emp_code"))==null||(((Integer)session.getAttribute("gate"))==0&&((Integer)session.getAttribute("admin"))==0))
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
public String app_no;
public double rate=0;
%>
<%
app_no=request.getParameter("app_no");
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="select *from application where app_no=?";
	PreparedStatement st=con.prepareStatement(q);
	st.setString(1, request.getParameter("app_no"));
	ResultSet results=st.executeQuery();
	results.next();
	
	q="select *from journey where app_no=?";
	st=con.prepareStatement(q);
	st.setString(1, request.getParameter("app_no"));
	ResultSet results3=st.executeQuery();
	results3.next();
	
	String q2="select registeration_no, rate, valid_upto,DATEDIFF(rate.valid_upto,?) as diff from rate where valid_upto > ? and registeration_no=? ;";
	PreparedStatement st2=con.prepareStatement(q2);
	st2.setString(1, results.getString("start_date"));
	st2.setString(2, results.getString("start_date"));
	st2.setString(3, results3.getString("registeration_no"));
	ResultSet results2=st2.executeQuery();
	
	int min=999999;
	while(results2.next()){
		if(results2.getInt("diff")<min){
			min=results2.getInt("diff");
			rate=results2.getDouble("rate");
		}
	}
	//System.out.println("hello"+app_no);
}
catch (Exception e) {
	// TODO Auto-generated catch block
	System.out.println("nooooo"+e.getMessage());
	e.printStackTrace();
}
%>
<!-- 
<form class="ui form" action="end_journey" method="post">
<input type="hidden" name="app_no" value="<%= app_no %>">
<div class="two fields">
	<div class="field">
	<label>END DATE</label>
	<input type="date" name="end_date">
	</div>
	<div>
	<label>FINAL KILOMETER READING</label>
	<input type="number" name="final_km" step="0.01">
	</div>
	</div>
	<div>
	<label>RATE IN RS PER KILOMETER</label>
	<input type="number" name="rate" step="0.01" value="<%= rate %>">
	</div>
	<button class="ui button" type="submit">SUBMIT</button>
</form>-->

<div class="container-contact100">
		<div class="wrap-contact100">
			<form class="contact100-form validate-form" method="post" action="end_journey">
			<input type="hidden" value="<%=app_no %>" name="app_no">
			<span class="contact100-form-title">
					END JOURNEY DETAILS
				</span>
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100">
					<span class="label-input100">Actual End Date</span>
					<input class="input100" type="date"  name="end_date" required>
				</div>
				
				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Final Km Reading">
					<span class="label-input100">Final Km Reading</span>
					<input class="input100" type="number" step="0.01" name="final_km" placeholder="Enter Final Km Reading" required>
				</div>
				
				<div class="wrap-input100 validate-input bg1">
					<span class="label-input100">Rate in Rs Per Km</span>
					<input class="input100" type="number" step="0.01" id="input" name="rate" value='<%= rate %>'>
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
	document.getElementsByName("end_date")[0].setAttribute('min', today);
	</script>
	
	  <br><br><br>
	<%@ include file = "admin_footer.jsp" %>
</body>
</html>
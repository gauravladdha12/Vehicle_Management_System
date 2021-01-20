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
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>
<style>
body{
overflow: auto; 
}
.g{
margin :20px;
}
</style>
</head>
<body>
 <script src="resources/js/main.js"></script>
        <header>
        <div class="header-area " style="background-color: #460000;">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid p-0">
                    <div class="row align-items-center justify-content-between no-gutters">
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo-img">
                                <a href="user_index.jsp">
                                    <img src="resources/img/banner/rswm-logo.svg" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-7 col-lg-7">
                            <div class="main-menu  d-none d-lg-block">
                                <nav>
                                    <ul id="navigation">
                                        <li><a class="active" href="index.html" style="font-size: 20px">home</a></li>
                                        <li><a href="about.html" style="font-size: 20px">About</a></li>
                                        <li><a href="causes.html" style="font-size: 20px">Rules</a></li>
                                        <li><a href="impact.html" style="font-size: 20px">Apply For Vehicle</a></li>
                                        <li><a href="impact.html" style="font-size: 20px">History</a></li>
                                      <!--  <li><a href="#">blog <i class="ti-angle-down"></i></a>
                                            <ul class="submenu">
                                                <li><a href="blog.html">blog</a></li>
                                                <li><a href="single-blog.html">single-blog</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="#">pages <i class="ti-angle-down"></i></a>
                                            <ul class="submenu">
                                                <li><a href="causes-details.html">causes-details</a></li>
                                                <li><a href="elements.html">elements</a></li>
                                            </ul>
                                        </li>-->
                                        <li><a href="contact.html" style="font-size: 20px">Contact</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                        <div class="col-xl-3 col-lg-3 d-none d-lg-block">
                            <div class="donate_now">
                              <a href="#" class="boxed-btn">LOG OUT</a>
                               
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="mobile_menu d-block d-lg-none"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <br>
<br>


<script type="text/javascript">
var a1=new Array();
var a2=new Array();
</script>
<%@ page import ="java.sql.*"
%>
<%!
public ResultSet results;
%>
<%
try {
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
	String q="select * from application where approve=0 and cancel=0;";
	PreparedStatement st=con.prepareStatement(q);
	results=st.executeQuery();
}
catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
%>

<br><br><br><br><br><br><br>
<div class="g">
		<form class="ui form" method="post" action="approve">

<table class="ui celled table">
<thead>
<tr>
<th>
APPLICATION NO
</th>
<th>
NAME
</th>
<th>
EMPLOYEE CODE
</th>
<th>
PURPOSE
</th>
<th>
DESTINATION
</th>
<th>
NO OF PASSENGERS
</th>
<th>
ADDRESS
</th>
<th>
START DATE
</th>
<th>
END DATE
</th>
<th>
START TIME
</th>
<th>
REMARKS
</th>
<th>
APPROVE
</th>
<th>
REJECT
</th>
</tr>
</thead>
<%
	while(results.next()){%>
		<tr>
		<td>
	<%=results.getInt("app_no")%>	
	</td>
<td>
	<%=results.getString("name")%>
	</td>
	<td>
	<%=results.getString("emp_code")%>
	</td>
	<td>
	<%=results.getString("purpose")%>
	</td>
	<td>
	<%=results.getString("destination")%>
	</td>
	<td>
	<%=results.getInt("passenger")%>
	</td>
	<td>
	<%=results.getString("address")%>
	</td>
	<td>
	<%=results.getString("start_date")%>
	</td>
	<td>
	<%=results.getString("end_date")%>
	</td>
	<td>
	<%=results.getString("start_time")%>
	</td>	
		<td>
	<%=results.getString("remarks")%>
	<td>
	<input type="checkbox" value="<%=results.getString("app_no")%>" id="g" onclick="add1(<%=results.getString("app_no") %>);">
	</td>
	<td>
	<input type="checkbox" value="<%=results.getString("app_no")%>" id="g" onclick="add2(<%=results.getString("app_no") %>);">
	</td>
	</tr>
	<%}
%>
</table>

<input type="hidden" name="arr1" id="arr1">
<input type="hidden" name="arr2" id="arr2">
<button class="ui button" type="submit">SUBMIT</button>
</form>
</div>
<script type="text/javascript">
function add1(app){
	console.log("hello");
	console.log(app);
	a1.push(app);
	console.log(a1);
	//var my = JSON.stringify(a1);
	document.getElementById("arr1").value=a1;
	//console.log(document.getElementById("arr1").value);
}
function add2(app){
	a2.push(app);
	document.getElementById("arr2").value=a2;
}
function printt(){
	console.log("hi");
	console.log(document.getElementById("arr1").value);
	console.log(document.getElementById("arr2").value);
}
</script>

<br><br>

    <footer class="footer">
        <div class="footer_top">
            <div class="container">
                <div class="row">
                     <div class="col-md-4 col-sm-12">
                        <div class="footer_widget">
                            <h3 class="footer_title">
                                Quick Links
                            </h3>
                            <p class="footer_text doanar">
                             <a href="https://www.rswm.in/" class="links">RSWM</a><br>
                            <a href="#" class="links">Apply For Vehicle</a><br>
                    <a href="#" class="links">History</a><br>
                            </p>
                                 
                        </div>
                          <div class="socail_links">
                                <ul>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-facebook-square"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-twitter"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-instagram"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#">
                                            <i class="fa fa-linkedin"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                    </div>
                    <div class="col-md-8">
                        <div class="row">
                            <div class="col-md-4 col-sm-5">
                                <div class="footer_widget">
                                     <h3 class="footer_title">Download</h3>
                                     <p class="footer_text doanar">
                                    <a href="https://www.rswm.in/wp-content/themes/rswm/images/pdf/rswm-corporate-brochure.pdf" class="links">Corporate Brochure</a><br>
                                      <a href="https://www.rswm.in/wp-content/uploads/2020/04/RSWM_Cares_covid19.pdf" class="links">Response to COVID-19</a><br>
                                       <a href="https://www.rswm.in/wp-content/themes/rswm/images/pdf/RSWM_SOP_Back_to_Work.pdf" class="links">Back to work after COVID-19</a></p><br>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <div class="footer_widget">
                                    <h3 class="footer_title">CONTACT US</h3>
                                  <!--  <p class="footer_text doanar">
                                    <ul>
                                        <li>III cell</li>
                                        <li>Guest House</li>
                                        <li>Nirma University, S G Highway , Ahmedabad – 382481</li>
                                        <li>iiicell@nirmauni.ac.in</li>
                                        <li>9265040273</li>
                                                                           <!-- <li><a href="#" class="links"><i class="material-icons">location_on</i>III cell
                                                <br>Guest House
                                                <br>Nirma University, S G Highway , Ahmedabad – 382481</a></li>
                                        <li><a href="#" class="links"><i class="material-icons">email</i>iiicell@nirmauni.ac.in</a></li>
                                        <li><a href="#" class="links"><i class="material-icons">call</i>9265040273</a></li>-->
                                  <!--  </ul>
                                </p>-->
                                <p class="footer_text">Mayur Mill Lodha, Banswara<br>
                                +9521433602 <br>
                                <a class="domain" href="#">contact@rswm</a></p>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-3">
                                <div class="footer_widget">
                                    <h3 class="footer_title">USEFUL LINKS</h3>
                                    <p>
                                    <ul>
                                        <li><a href="#">Home</a></li>
                                        <li><a href="#">Rules</a></li>
                                        <li><a href="#">History</a></li>
                                        <li><a href="#">Cancel Application</a></li>
                                        
                                    </ul>
                                </p>
                                </div>
                            </div>

                        </div>
                    </div>
            </div>
        </div>
    </div>
</footer>

    </body>
    </html>
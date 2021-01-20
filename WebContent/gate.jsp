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
    
    <!-- <link rel="stylesheet" href="css/responsive.css"> -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
        <script src="https://code.jquery.com/jquery-3.1.1.min.js" integrity="sha256-hVVnYaiADRTO2PzUGmuLJr8BLUSjGIZsDYGmIJLv2b8=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>


</head>
<body>
<%@ page import ="java.io.*"
%>
<%
if(session==null||((String)session.getAttribute("emp_code"))==null||((Integer)session.getAttribute("gate"))==0)
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
        <header>
        <div class="header-area ">
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
                                        <li><a  href="gate.jsp" style="font-size: 20px">home</a></li>
                                        <li><a href="#" style="font-size: 20px">About</a></li>
                                        <li><a href="start_journey.jsp" style="font-size: 20px">Start Journey</a></li>
                                        <li><a href="end_journey.jsp" style="font-size: 20px">End journey</a></li>
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
                                        <li><a href="contact.jsp" style="font-size: 20px">Contact</a></li>
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

        <div class="slider_area slider_bg_1  d-flex align-items-center">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="single_slider">
                        <div class="slider_text">
                            <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
                           <h3 style="left: -10%">Stay Safe<br>
                                We Care For You</h3>

                                <br>
                                <br>
                                <br>
                           <!-- <a href="#" class="boxed-btn2">Join Us Today</a>-->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <div class="servce_area">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="section_title text-center mb-60">
                        <h3>
                            GATE FEATURES
                            <p>                                     
                            <br><br>
                            </p>
                        </h3>
                    </div>
                </div>
            </div>

            <div class="row">
               
                <div class="col-xl-3 col-md-3">
                    <div class="single_serve text-center">
                        
                       
                    </div>
                </div>
             
                 <div class="col-xl-3 col-md-3" id="m5">
                            <div class="single_serve text-center">
                        <div class="serve_icon">
                            <i class="fa fa-play"></i>
                        </div>
                        <form class="ui form" action="start_journey.jsp" method="post">
                         <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">
                        <h3>Start Journey</h3>
                    </button>
                </form>
                       
                    </div>
                </div>
                 <div class="col-xl-3 col-md-3" id="m6">
                    <div class="single_serve text-center">
                        <div class="serve_icon">
                            <i class="fa fa-stop"></i>
                        </div>
                         <form class="ui form" action="end_journey.jsp" method="post">
                        <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">
                        <h3>End Journey</h3>
                    </button>
                    </form>
                     
                    </div>
                </div>
                <div class="col-xl-3 col-md-3">
                    <div class="single_serve text-center">
                       
                    </div>
                </div>
            </div>

            <br><br><br>

             
        </div>
    </div>







<br>
<br>

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
                            <a href="http://lnjbhilwara.com/" class="links">LNJ GROUP</a><br>
                    
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
                                        <li><a href="gate.jsp">Home</a></li>
                                         <li><a href="start_journey.jsp" style="font-size: 20px">Start Journey</a></li>
                                        <li><a href="end_journey.jsp" style="font-size: 20px">End journey</a></li>
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






   

    <script src="resources/js/main.js"></script>

    </body>
    </html>
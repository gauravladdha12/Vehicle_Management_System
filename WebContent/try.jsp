<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.jdbc.result.ResultSetFactory"%>
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
		
		
		
		
        <style>
        
      .navbar {
  overflow: hidden;
  background-color: #333;
}

.navbar a {
  float: left;
  font-size: 16px;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

.dropdown {
  float: left;
  overflow: hidden;
}

.dropdown .dropbtn {
  font-size: 16px;  
  border: none;
  outline: none;
  color: white;
  padding: 14px 16px;
  background-color: inherit;
  font-family: inherit;
  margin: 0;
}

.navbar a:hover, .dropdown:hover .dropbtn {
  background-color: red;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f9f9f9;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  float: none;
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
  text-align: left;
}

.dropdown-content a:hover {
  background-color: #ddd;
}

.dropdown:hover .dropdown-content {
  display: block;
}
      
 .notification {
  background-color: #555;
  color: white;
  text-decoration: none;
  padding: 15px 26px;
  position: relative;
  display: inline-block;
  border-radius: 2px;
}


.notification .badge {
  position: absolute;
  top: -10px;
  right: -10px;
  padding: 5px 10px;
  border-radius: 50%;
  background-color: #85C1E9 ;
  color: white;
}



<%@ page import ="java.sql.*"
%>
<%@ page import ="java.util.*"
%>
<%!
public ResultSet driver_results;
public ResultSet vehicle_results;
public HashMap<String,ResultSet> hm;
public ResultSet vehicletrans_results;
public ResultSet fueltrans_results;
public int x1;
public int x2;
%>
<%

Class.forName("com.mysql.cj.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
hm=new HashMap<>();
String q="select *from driver";
PreparedStatement st=con.prepareStatement(q);
driver_results=st.executeQuery();

hm.put("driver_results", driver_results);

String q2="select *from vehicle";
PreparedStatement st2=con.prepareStatement(q2);
vehicle_results=st2.executeQuery();
hm.put("vehicle_results", vehicle_results);

String q3="select *from vehicle_transaction";
PreparedStatement st3=con.prepareStatement(q3);
vehicletrans_results=st3.executeQuery();

String q4="select *from fuel_transaction";
PreparedStatement st4=con.prepareStatement(q4);
fueltrans_results=st4.executeQuery();

String q6="select *from vehicle_transaction where CURDATE() > insurance_upto or curdate() > servicing_upto or curdate() > pollution_control_valid or curdate() > certificate_of_fitness ";

PreparedStatement st6=con.prepareStatement(q6);
ResultSet s1=st6.executeQuery();
x1=0;
while(s1.next()){
	x1++;
}

String q7="select * from application where alloted=0 and approve=1 and cancel=0;";
PreparedStatement st7=con.prepareStatement(q7);
ResultSet s2=st7.executeQuery();
x2=0;
while(s2.next()){
	x2++;
}
%>

</style>

</head>
<body>


<div id="mySidenav" class="sidenav" style="margin-top: 120px;overflow:auto;height:510px;">
 
  
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
   <ul class="list-unstyled components mb-5">
   <li>
   <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer; " type="reset" onclick="appear11();">
  Update Rate
  </button>
   </li>
   <br>
   <li>
   <form method="post" action="previous_entry.jsp">
    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer; " type="submit">
  Enter Past Entries
  </button>
  </form>
  </li>
  <br>
  <li>
  <form method="post" action="add_maintenance.jsp">
    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">
    Add Maintenance
  </button>
  </form>
  </li>
  <br>
  <li>
   <form method="post" action="add_private.jsp">
   <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer; " type="submit">
  Private Vehicle Expense
  </button>
  </form>
  </li>
   <br>
               <li>
              <a href="#a" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Vehicle</a>
              <ul class="collapse list-unstyled" id="a">
              <br>
                <li>
                <form method="post" action="add_vehicle.jsp">
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">Add Vehicle</button>
                </form>
                </li>
                <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear2();">Modify Vehicle</button>
                </li>
              </ul>
            </li>
            <br>
                           <li>
              <a href="#b" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Driver</a>
              <ul class="collapse list-unstyled" id="b">
              <br>
                <li>
                 <form method="post" action="add_driver.jsp">
                    <button style="padding: 0;border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">Add Driver</button>
              </form>
                </li>
                <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear3();">Modify Driver</button>
                </li>
              </ul>
            </li>
            
             <br>
                           <li>
              <a href="#c" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Vehicle Transaction</a>
              <ul class="collapse list-unstyled" id="c">
              <br>
                <li>
                 <form method="post" action="add_vehicletrans.jsp">
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">Add </button>
                </form>
                </li>
                <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear4();">Update </button>
                </li>
              </ul>
            </li>
            
             <br>
                           <li>
                          
              <a href="#d" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Fuel Transaction</a>
              <ul class="collapse list-unstyled" id="d">
              <br>
                <li>
                 <form method="post" action="add_fueltrans.jsp">
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">Add </button>
               </form>
                </li>
                <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear5();">Modify </button>
                </li>
              </ul>
            </li>
            <br>
                           <li>
              <a href="#e" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Reports</a>
              <ul class="collapse list-unstyled" id="e">
              <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear7();">Expense Report</button>
                </li>
                <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear6();">Fuel Report</button>
                </li>
              </ul>
            </li>
             <br>
                           <li>
              <a href="#f" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Filter Application</a>
              <ul class="collapse list-unstyled" id="f">
              <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear10();">By Date</button>
                </li>
                <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear8();">By Application no</button>
                </li>
                <br>
                <li>
                    <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear9();">By Employee code</button>
                </li>
              </ul>
            </li>
            <br><br><br>
            </ul>
  </div>

	        <header>
        <div class="header-area ">
            <div id="sticky-header" class="main-header-area">
                <div class="container-fluid p-0">
                    <div class="row align-items-center justify-content-between no-gutters">
                        <div class="col-xl-2 col-lg-2">
                            <div class="logo-img">
                                <a href="admin_index.jsp">
                                    <img src="resources/img/banner/rswm-logo.svg" alt="">
                                </a>
                            </div>
                        </div>
                        <div class="col-xl-7 col-lg-7">
                            <div class="main-menu  d-none d-lg-block">
                                     <nav>

                                    <ul>
                                        <li><a  href="user_admin.jsp" style="font-size: 20px">home</a></li>
                                        
                                         <li><a href="allocate.jsp" style="font-size: 20px">Allocate</a></li>
                                        <li><a href="start_journey.jsp" style="font-size: 20px">Start Journey</a></li>
                                        <li><a href="end_journey.jsp" style="font-size: 20px">end journey</a></li>
                                     
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
                                        <li><a href="contact_admin.jsp" style="font-size: 20px">Contact</a></li>
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
                         <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; open</span> 
                            ADMIN FEATURES
                            <p>                                     
                            <br><br>
                            </p>
                        </h3>
                    </div>
                </div>
            </div>

            <div class="row" id="d1">
                <div class="col-xl-3 col-md-3" id="m7">
                    <div class="single_serve text-center">
               
                        <div class="serve_icon notification">
                         <% if(x2!=0){ %>
			<span class="badge"><%= x2 %></span>
	<%} %>
                            <i class="fa fa-tasks"></i>
                    	 
                        </div>
                        <form class="ui form" action="allocate.jsp" method="post">
                         <button style="border: none; background: none;" type="submit" class="ui button notification">
                        <h3>Allocate Application</h3>
                       
                    </button>
                </form> 
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
                
                <div class="col-xl-3 col-md-3" id="m8">
                       <div class="single_serve text-center">
                        <div class="serve_icon">
                            <i class="fa fa-home"></i>
                        </div>
                        <form class="ui form" action="local_vehicle.jsp" method="post">
                         <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">
                        <h3>Apply for Local Vehicle</h3>
                    </button>
                </form>
                       
                    </div>
                </div>
            </div>
            <br><br>
            
                        <div class="row" id="d1">
           
               
                <div class="col-xl-3 col-md-3" id="m5">
                            <div class="single_serve text-center">
                        <div class="serve_icon notification">
                        <% if(x1!=0){ %>
	<span class="badge"><%= x1 %></span>
	<%} %>	
                            <i class="fa fa-exclamation-triangle"></i>
                        </div>
                        <form class="ui form" action="due.jsp" method="post">
                         <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">
                        <h3>Due Dates for vehicles</h3>
                    </button>
                </form>
                       
                    </div>
                </div>
             
                <div class="col-xl-3 col-md-3" id="m6">
                    <div class="single_serve text-center">
                        <div class="serve_icon">
                            <i class="fa fa-refresh"></i>
                        </div>
                         <form class="ui form" action="admin_recent.jsp" method="post">
                        <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">
                        <h3>Recent Applications</h3>
                    </button>
                    </form>
                     
                    </div>
                </div>
                <div class="col-xl-3 col-md-3" id="m7">
                    <div class="single_serve text-center">
                        <div class="serve_icon">
                            <i class="fa fa-clock-o"></i>
                        </div>
                        <form class="ui form" action="vd_status.jsp" method="post">
                         <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="submit">
                        <h3>Current Status of Vehicles</h3>
                    </button>
                </form> 
                    </div>
                </div>
                <div class="col-xl-3 col-md-3" id="m8">
                       <div class="single_serve text-center">
                        <div class="serve_icon">
                            <i class="fa fa-pencil-square-o"></i>
                        </div>
                     
                      <button style="padding: 0; border: none; background: none; overflow: hidden; cursor:pointer;" type="reset" onclick="appear1();">
                        <h3>Modify Application</h3>
                   
                       </button>
      
                    </div>
                </div>
            </div>
            
        </div>
    </div>
    
       <div class="ui basic modify_app modal">
  <div class="header">MODIFY APPLICATION</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="admin_modify.jsp">
    <div class="field">
          APPLICATION NO FOR MODIFICATION:
          <br>
          <br> <input type="text" name="app_no" required>
          </div>
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

       <div class="ui basic modify_vehicle modal">
  <div class="header">MODIFY VEHICLE</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="modify_vehicle.jsp">
    <div class="field">
          REGISTERATION NO FOR MODIFICATION:
          <br><br>
          <div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="registeration_no">
  <i class="dropdown icon"></i>
  <div class="default text">Select vehicle registeration no</div>
  <div class="menu">
  
  <% 
  //ResultSet ve=(ResultSet)hm.get("vehicle_results");
  String q5="select *from vehicle";
  PreparedStatement st5=con.prepareStatement(q5);
  vehicle_results=st5.executeQuery();
  while(vehicle_results.next()){ %>
   <div class="item" data-value= "<%= vehicle_results.getString("registeration_no") %>" > <%= vehicle_results.getString("registeration_no") %>  </div>
   <%} %>
  </div>
  </div>
          </div>
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

       <div class="ui basic modify_driver modal">
  <div class="header">MODIFY DRIVER</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="modify_driver.jsp">
    <div class="field">
          DRIVER CODE FOR MODIFICATION:
          <br><br>
          		 <div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="driver_code">
  <i class="dropdown icon"></i>
  <div class="default text">Select driver code and name</div>
  <div class="menu">
  
  <%
  Class.forName("com.mysql.cj.jdbc.Driver");
  Connection con2=DriverManager.getConnection("jdbc:mysql://localhost:3306/vehicle","root","gaurav");
  
  ResultSet dr=(ResultSet)hm.get("driver_results");
  //System.out.println(dr.next());
  
  while(dr.next()){ %>
   <div class="item" data-value= "<%= dr.getString("driver_code") %>" > <%= dr.getString("name") %>  <%= dr.getString("driver_code") %>  </div>
   <%} %>
  </div>
  </div>
          </div>
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>


       <div class="ui basic update_vehicletrans modal">
  <div class="header">UPDATE VEHICLE TRANSACTION</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="update_vehicletrans.jsp">
    <div class="field">
          REGISTERATION NO FOR MODIFICATION:
          <br><br>
          <div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="registeration_no">
  <i class="dropdown icon"></i>
  <div class="default text">Select vehicle registeration no</div>
  <div class="menu">
  
  <% 
  //ResultSet ve=(ResultSet)hm.get("vehicle_results");
  String p5="select *from vehicle";
  PreparedStatement stp5=con.prepareStatement(p5);
  vehicle_results=stp5.executeQuery();
  while(vehicle_results.next()){ %>
   <div class="item" data-value= "<%= vehicle_results.getString("registeration_no") %>" > <%= vehicle_results.getString("registeration_no") %>  </div>
   <%} %>
  </div>
  </div>
          </div>
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

       <div class="ui basic update_fueltrans modal">
  <div class="header">UPDATE FUEL TRANSACTION</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="update_fueltrans.jsp">
    <div class="field">
          BILL NO FOR MODIFICATION:
          <br><br>
          <%
          q4="select *from fuel_transaction";
          st4=con.prepareStatement(q4);
          ResultSet fueltrans_results=st4.executeQuery();
          %>
     	 <div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="bill_no">
  <i class="dropdown icon"></i>
  <div class="default text">Select bill no</div>
  <div class="menu">
  
  <% while(fueltrans_results.next()){ %>
   <div class="item" data-value= "<%= fueltrans_results.getString("bill_no") %>" > <%= fueltrans_results.getString("bill_no") %> <%= fueltrans_results.getString("registeration_no") %>  </div>
   <%} %>
  </div>
  </div>
          </div>
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

<div class="ui basic fuel_report modal">
  <div class="header">FUEL REPORT</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="fuel_report.jsp">
    <div class="field">
          DATE FROM:
          <br>
          <br> <input type="date" name="s_date" required>
          </div>

<br>
 <div class="field">
          DATE UPTO:
          <br>
          <br> <input type="date" name="f_date" required>
          </div>          
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

<div class="ui basic expense_report modal">
  <div class="header">EXPENSE REPORT</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="expense.jsp">
    <div class="field">
          DATE FROM:
          <br>
          <br> <input type="date" name="s_date" required>
          </div>

<br>
 <div class="field">
          DATE UPTO:
          <br>
          <br> <input type="date" name="f_date" required>
          </div>          
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

<div class="ui basic filter_app modal">
  <div class="header">FILTER BY APPLICATION NO</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="filter_appno.jsp">
    <div class="field">
          APPLICATION NO:
          <br>
          <br> <input type="text" name="app_no" required>
          </div>
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

<div class="ui basic filter_emp modal">
  <div class="header">FILTER BY EMPLOYEE CODE</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="filter_emp.jsp">
        <div class="field">
         	EMPLOYEE CODE:
          <br>
          <br> <input type="text" name="emp_code" required>
          </div>
    <div class="field">
          DATE FROM:
          <br>
          <br> <input type="date" name="s_date" required>
          </div>

<br>
 <div class="field">
          DATE UPTO:
          <br>
          <br> <input type="date" name="f_date" required>
          </div>          
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>
<div class="ui basic filter_date modal">
  <div class="header">FILTER BY DATE</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="filter_date.jsp">
    <div class="field">
          DATE FROM:
          <br>
          <br> <input type="date" name="s_date" required>
          </div>

<br>
 <div class="field">
          DATE UPTO:
          <br>
          <br> <input type="date" name="f_date" required>
          </div>          
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

<div class="ui basic update_rate modal">
  <div class="header">UPDATE RATE</div>
  <div class="content">
    <p></p>
  </div>
  <div class="actions">
    <form class="ui form" method="post" action="modify_rate">
    <div class="field">
          Vehicle Registeration No:
          <br><br>
          <div class="ui fluid search selection dropdown" >
		 <input type="hidden" name="registeration_no">
  <i class="dropdown icon"></i>
  <div class="default text">Select vehicle registeration no</div>
  <div class="menu">
  
  <% 
  //ResultSet ve=(ResultSet)hm.get("vehicle_results");
  String p6="select *from vehicle";
  PreparedStatement stp6=con.prepareStatement(q6);
  vehicle_results=st5.executeQuery();
  while(vehicle_results.next()){ %>
   <div class="item" data-value= "<%= vehicle_results.getString("registeration_no") %>" > <%= vehicle_results.getString("registeration_no") %>  </div>
   <%} %>
  </div>
  </div>
          </div>

<br>
 <div class="field">
          Rate Per Km:
          <br>
          <br> <input type="number" step="0.01" name="rate" required>
          </div>  
              <div class="field">
          Valid Upto:
          <br>
          <br><input type="date" name="valid_upto">
          </div>    
          <br>
         <button  class="ui button" type="submit">SUBMIT</button>
    </form>
    <br>
    <div class="ui cancel button">Cancel</div>
  </div>
</div>

<script type="text/javascript">
function appear1() {
    // body...
    $('.ui.basic.modify_app.modal')
  .modal('show');
  }
function appear2() {
    // body...
    $('.ui.basic.modify_vehicle.modal')
  .modal('show');
  }
function appear3() {
    // body...
    $('.ui.basic.modify_driver.modal')
  .modal('show');
  }
function appear4() {
    // body...
    $('.ui.basic.update_vehicletrans.modal')
  .modal('show');
  }
function appear5() {
    // body...
    $('.ui.basic.update_fueltrans.modal')
  .modal('show');
  }
function appear6() {
    // body...
    $('.ui.basic.fuel_report.modal')
  .modal('show');
  }
function appear7() {
    // body...
    $('.ui.basic.expense_report.modal')
  .modal('show');
  }
function appear8() {
    // body...
    $('.ui.basic.filter_app.modal')
  .modal('show');
  }
function appear9() {
    // body...
    $('.ui.basic.filter_emp.modal')
  .modal('show');
  }
function appear10() {
    // body...
    $('.ui.basic.filter_date.modal')
  .modal('show');
  }
function appear11() {
    // body...
    $('.ui.basic.update_rate.modal')
  .modal('show');
  }
</script>


    

    <div class="become_volunter volunter_bg_1">
        <div class="container">
            <div class="row">
                <div class="col-xl-8 offset-xl-2 col-md-10 offset-md-1">
                     <div class="volunter_text text-center">
                        <h3>Apply for Vehicle</h3>
                        <p>Apply for Vehicle Now !</p>
                        <a class="boxed-btn4" href="#">Now</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

<br>
<br>
    <div class="navbar">
  <a href="#home">Home</a>
  <a href="#news">News</a>
  <div class="dropdown">
    <button class="dropbtn">Dropdown 
      <i class="fa fa-caret-down"></i>
    </button>
    <div class="dropdown-content">
      <a href="#">Link 1</a>
      <a href="#">Link 2</a>
      <a href="#">Link 3</a>
    </div>
  </div> 
</div>

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
                                        <li><a href="admin_index.jsp">Home</a></li>
                                        <li><a href="allocate.jsp">Allocate</a></li>
                                        <li><a href="admin_recent.jsp">Recent Application</a></li>
                                        <li><a href="vd_status.jsp">Status of Vehicles</a></li>
                                        
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


<script>
function openNav() {
  document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
  document.getElementById("mySidenav").style.width = "0";
}
</script>

<script>
document.getElementById("h2").style.display = "none";
</script>

 <script>
/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
var dropdown = document.getElementsByClassName("dropdown-toggle");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
  this.classList.toggle("active");
  var dropdownContent = this.nextElementSibling;
  if (dropdownContent.style.display === "block") {
  dropdownContent.style.display = "none";
  } else {
  dropdownContent.style.display = "block";
  }
  });
}
</script>
   <script>
  
   $('.ui.dropdown').dropdown();
   </script>
  
    <script src="resources/js/main.js"></script>
</body>
</html>
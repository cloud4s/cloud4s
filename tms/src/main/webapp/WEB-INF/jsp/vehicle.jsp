<!doctype html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<link rel="icon" type="image/png" href="assets/img/favicon.ico">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

	<title>Light Bootstrap Dashboard by Creative Tim</title>

	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="assets/css/bootstrap.min.css" rel="stylesheet" />
	
	
	
	
    <!-- Animation library for notifications   -->
    <link href="assets/css/animate.min.css" rel="stylesheet"/>

    <!--  Light Bootstrap Table core CSS    -->
    <link href="assets/css/light-bootstrap-dashboard.css" rel="stylesheet"/>


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <link href="assets/css/demo.css" rel="stylesheet" />


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="assets/css/pe-icon-7-stroke.css" rel="stylesheet" />

</head>
<body>
	<div class="sidebar" data-color="azure" data-image="assets/img/sidebar-5.jpg">

    <!--
		Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag
	-->
		<div class="sidebar-wrapper">
            <div class="logo">
                <a href="http://www.creative-tim.com" class="simple-text">
                    Sithumina Transport
                </a>
            </div>

            <ul class="nav">
                <li class="deactive">
                    <a href="dashboard.html">
                        <i class="pe-7s-graph"></i>
                        <p>Home</p>
                    </a>
                </li>
				<li>
                    <a href="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/user-accout.html">
                        <i class="pe-7s-user"></i>
                        <p>User Accounts</p>
                    </a>
                </li>
                <li class="">
                    <a href="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/employee.html">
                        <i class="pe-7s-user"></i>
                        <p>Employee</p>
                    </a>
                </li>
                <li><li class="active">
                    <a href="vehicle.jsp">
                        <i class="pe-7s-note2"></i>
                        <p>Vehicle</p>
                    </a>
                </li></li>
                <li>
                    <a href="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/root.html">
                        <i class="pe-7s-news-paper"></i>
                        <p>Root</p>
                    </a>
                </li>
                <li>
                    <a href="icons.html">
                        <i class="pe-7s-science"></i>
                        <p>Product</p>
                    </a>
                </li>
                <li>
                    <a href="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/maps.html">
                        <i class="pe-7s-map-marker"></i>
                        <p>Fleets</p>
                    </a>
                </li>
				<li>
                    <a href="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/table.html">
                        <i class="pe-7s-note2"></i>
                        <p>Report Generator</p>
                    </a>
                </li>
                <li>
                    <a href="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/notifications.html">
                        <i class="pe-7s-bell"></i>
                        <p>Notifications</p>
                    </a>
                </li>
				<li class="active-pro">
                    <a href="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/upgrade.html">
                        <i class="pe-7s-rocket"></i>
                        <p>Upgrade to PRO</p>
                    </a>
                </li>
            </ul>
    	</div>
    </div>
 <div>
            <form action="/logout" method="post">
                <button type="submit" class="btn btn-danger">Log Out</button>
                <input type="hidden" name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
            </form>
</div>
<div class="wrapper">
	<div class="main-panel">
        <nav class="navbar navbar-default navbar-fixed">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Dashboard</a>
                </div>
                <div class="collapse navbar-collapse">
                    <ul class="nav navbar-nav navbar-left">
                        <li>
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-dashboard"></i>
								<p class="hidden-lg hidden-md">Dashboard</p>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-globe"></i>
                                    <b class="caret hidden-sm hidden-xs"></b>
                                    <span class="notification hidden-sm hidden-xs">5</span>
									<p class="hidden-lg hidden-md">
										5 Notifications
										<b class="caret"></b>
									</p>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">Notification 1</a></li>
                                <li><a href="#">Notification 2</a></li>
                                <li><a href="#">Notification 3</a></li>
                                <li><a href="#">Notification 4</a></li>
                                <li><a href="#">Another notification</a></li>
                              </ul>
                        </li>
                        <li>
                           <a href="">
                                <i class="fa fa-search"></i>
								<p class="hidden-lg hidden-md">Search</p>
                            </a>
                        </li>
                    </ul>

                    <ul class="nav navbar-nav navbar-right">
                        <li>
                           <a href="">
                               <p>Account</p>
                            </a>
                        </li>
                        <li class="dropdown">
                              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <p>
										Dropdown
										<b class="caret"></b>
									</p>
                              </a>
                              <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                              </ul>
                        </li>
                        <li>
                            <a href="#">
                                <p>Log out</p>
                            </a>
                        </li>
						<li class="separator hidden-lg hidden-md"></li>
                    </ul>
                </div>
            </div>
        </nav>
		
         <div class="content"> 
              <div class="container-fluid"> 
                <div class="row"> 
                    <div class="col-md-9"> 
                         <div class="card">  
                            <div class="header">
                                <h4 class="title">Vehicle Information Management</h4><br><br>
                           
							
							
							
							<div class="col-md-8">
							
							<div class="pull-center">
												<input type="text" class="form-control" placeholder="TYPE YOUR REG NO HERE" name="search"><br>
												<button type="submit" class="btn btn-info btn-fill pull-center">Search</button>&nbsp &nbsp &nbsp
												
												<br>
												</div><br><br>
							
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th>ID</th>
                                    	<th>Name</th>
                                    	<th>Salary</th>
                                    	<th>Country</th>
                                    	<th>City</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td>Dakota Rice</td>
                                        	<td>$36,738</td>
                                        	<td>Niger</td>
                                        	<td>Oud-Turnhout</td>
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td>Minerva Hooper</td>
                                        	<td>$23,789</td>
                                        	<td>Curaçao</td>
                                        	<td>Sinaai-Waas</td>
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td>Sage Rodriguez</td>
                                        	<td>$56,142</td>
                                        	<td>Netherlands</td>
                                        	<td>Baileux</td>
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td>Philip Chaney</td>
                                        	<td>$38,735</td>
                                        	<td>Korea, South</td>
                                        	<td>Overland Park</td>
                                        </tr>
                                        <tr>
                                        	<td>5</td>
                                        	<td>Doris Greene</td>
                                        	<td>$63,542</td>
                                        	<td>Malawi</td>
                                        	<td>Feldkirchen in Kärnten</td>
                                        </tr>
                                        <tr>
                                        	<td>6</td>
                                        	<td>Mason Porter</td>
                                        	<td>$78,615</td>
                                        	<td>Chile</td>
                                        	<td>Gloucester</td>
                                        </tr>
                                    </tbody>
                                </table>

								<br>
								<br>
								<div class="pull-center">
												
												<button type="submit" class="btn btn-info btn-fill pull-center">Update</button>&nbsp &nbsp &nbsp
												<button type="submit" class="btn btn-info btn-fill pull-center">Delete</button>&nbsp &nbsp &nbsp
												<button type="submit" class="btn btn-info btn-fill pull-center">Clear</button>
												<br>
												</div>
								
                            </div>
							</div>
							</div>
							<br>
							<br>
                            <div class="content">
                                <form>
                                    <div class="row">
                                        <div class="col-md-7">
                                            <div class="form-group">
											<br>
							<br>
                                                <div class="pull-left">
												<label>Reg No</label>
                                                <input type="text" class="form-control" placeholder="xx-1234" value="">
												<br>
												<br>
												<div class="dropdown">
													<label>Vehicle Type</label>&nbsp &nbsp &nbsp
													  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
														Vehicle Type: <span class="selected"></span>
														<span class="caret"></span>
													  </button>
													  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
														<li><a href="#">Lorry 20 feet</a></li>
														<li><a href="#">Lorry 40 feet</a></li>
														<li><a href="#">Van</a></li>
														<li><a href="#">Bike</a></li>
													  </ul>
													</div>
												<br>
												<div class="dropdown">
													<label>Capacity</label> &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
													  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
														 Capacity: <span class="selected"></span>
														<span class="caret"></span>
													  </button>
													  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
														<li><a href="#">Lorry 20 feet</a></li>
														<li><a href="#">Lorry 40 feet</a></li>
														<li><a href="#">Van</a></li>
														<li><a href="#">Bike</a></li>
													  </ul>
													</div>
												<br>
												<div class="dropdown">
													<label>Fuel Type</label> &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
													  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
														Fuel Type: <span class="selected"></span>
														<span class="caret"></span>
													  </button>
													  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
														<li><a href="#">Petrol</a></li>
														<li><a href="#">Diesel</a></li>
														<li><a href="#">Hybride</a></li>
														<li><a href="#">Electric</a></li>
													  </ul>
													</div>
												<br>
												<div class="dropdown">
													<label>Owner</label>&nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp  
													  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
														Owner: <span class="selected"></span>
														<span class="caret"></span>
													  </button>
													  <ul class="dropdown-menu" aria-labelledby="dropdownMenu1">
														<li><a href="#">Company</a></li>
														<li><a href="#">User01</a></li>
														<li><a href="#">User02</a></li>
														<li><a href="#">User03</a></li>
													  </ul>
													</div>
												<br>
												<label>Chassis No</label>
                                                <input type="text" class="form-control" placeholder="0123456789XX" value="">
												<br>
												<label>Engine No</label>
                                                <input type="text" class="form-control" placeholder="0123456789PP" value="">
												<br>
												<label>Model</label>
                                                <input type="text" class="form-control" placeholder="example - Toyota" value="">
												<br>
												<label>Milage</label>
                                                <input type="text" class="form-control" placeholder="123KM" value="">
												
												<br>
													<button type="submit" class="btn btn-info btn-fill pull-left">Register</button>
													<br>
													<br>
													<br>
													
                                    
													<div class="clearfix"></div>
												
												</div>
												<br> <br>
												
												
											  
												<!--<div class="pull-right">
												<input type="text" class="form-control" placeholder="TYPE YOUR NIC HERE" name="search"><br>
												<button type="submit" class="btn btn-info btn-fill pull-center">Search</button>&nbsp &nbsp &nbsp
												<button type="submit" class="btn btn-info btn-fill pull-center">Update</button>&nbsp &nbsp &nbsp
												<button type="submit" class="btn btn-info btn-fill pull-center">Delete</button>
												<br>
												</div> -->
												
                                            </div>
                                        </div>
									</div>
                                    <div class="clearfix"></div>
									
								
                                </form>
							</div>
                        </div>
                    </div>                             
					
		<!--	<div class="content"> 
              <div class="container-fluid"> 
                <div class="row"> 
                    <div class="col-md-7"> 
							<div class="card">
							<form>
							
							<div class="pull-right">
                                <div class="col-md-5">
											<div class="pull-right">
                                            <div class="form-group">
                                                <label>Email</label>
                                                <input type="text" class="form-control" placeholder="myname@example.com" value="">
                                            </div>
											</div>
                                        </div>
									</div>
							
							
							
							</form>


							</div>
					</div>
                  </div>
				</div>
			</div> -->
				  
				  
				  
					<div class="col-md-2">
                        <div class="card card-user">
                            <div class="image">
                                <img src="" alt="..."/>
                            </div>
                            <div class="content">
                                <div class="author">
                                     <a href="#">
                                    <img class="avatar border-gray" src="../../../../../../../ravi/light-bootstrap-dashboard-master-edit-3/lorry.png" alt="..."/>

                                      <h4 class="title"><br />
                                         <small>Sithumina Transport Management</small>
                                      </h4>
                                    </a>
                                </div>
                                <p class="description text-center"> To get user name and password  <br>
                                                    first register from user accounts <br>
                                                    <b>Sithumina Transport Adiministration</b>
													
                                </p>
                            </div>
                            <hr>
                            <div class="text-center">
                                <button href="#" class="btn btn-simple"><i class="fa fa-facebook-square"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-twitter"></i></button>
                                <button href="#" class="btn btn-simple"><i class="fa fa-google-plus-square"></i></button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>                  
                                    
                 
                    

                


        <footer class="footer">
            <div class="container-fluid">
                <nav class="pull-left">
                    <ul>
                        <li>
                            <a href="#">
                                Home
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Company
                            </a>
                        </li>
                        <li>
                            <a href="#">
                                Portfolio
                            </a>
                        </li>
                        <li>
                            <a href="#">
                               Blog
                            </a>
                        </li>
                    </ul>
                </nav>
                <p class="copyright pull-right">
                    &copy; <script>document.write(new Date().getFullYear())</script> <a href="http://www.creative-tim.com">Creative Tim</a>, made with love for a better web
                </p>
            </div>
        </footer>

    </div>
</div>

									


</body>

    <!--   Core JS Files   -->
    <script src="assets/js/jquery-1.10.2.js" type="text/javascript"></script>
	<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>

	<!--  Checkbox, Radio & Switch Plugins -->
	<script src="assets/js/bootstrap-checkbox-radio-switch.js"></script>

	<!--  Charts Plugin -->
	<script src="assets/js/chartist.min.js"></script>

    <!--  Notifications Plugin    -->
    <script src="assets/js/bootstrap-notify.js"></script>

    <!--  Google Maps Plugin    -->
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

    <!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
	<script src="assets/js/light-bootstrap-dashboard.js"></script>

	<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
	<script src="assets/js/demo.js"></script>

	
	

</html>

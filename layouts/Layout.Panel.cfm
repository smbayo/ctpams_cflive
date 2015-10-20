<cfset oSession = getPlugin("SessionStorage")>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<cfoutput>
		<base href="#getSetting('htmlBaseURL')#">
	</cfoutput>

    <title>Project Activity Management System (PAMS)</title>


    <link href="includes/styles/bootstrap.min.css" rel="stylesheet">
	<link href="includes/styles/bootstrap-theme.min.css" rel="stylesheet">
    <link href="includes/styles/metisMenu.min.css" rel="stylesheet">
	<link href="includes/styles/dataTables.bootstrap.css" rel="stylesheet">
	<link href="includes/styles/dataTables.responsive.css" rel="stylesheet">
    <link href="includes/styles/sb-admin-2.css" rel="stylesheet">
    <link href="includes/styles/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="includes/styles/bootstrap-multiselect.css" type="text/css"/>
	<link rel="stylesheet" href="includes/styles/custom.css" type="text/css"/>
	<link href="includes/styles/jquery-ui.min.css" rel="stylesheet">
	<link href="includes/styles/jquery-ui.theme.min.css" rel="stylesheet">


	<cfif not (#CGI.HTTP_USER_AGENT# CONTAINS 'MSIE 7.0' or #CGI.HTTP_USER_AGENT# CONTAINS 'MSIE 8.0')>
		<style>
			body {
			padding-top:50px
			}
		</style>
	</cfif>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body>

<cfoutput>
	<div class="ct-logo-back"><img src="includes/images/usdos-logo-seal.gif" height="120px" width="120px"></div>
    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default <cfif (#CGI.HTTP_USER_AGENT# CONTAINS 'MSIE 7.0' or #CGI.HTTP_USER_AGENT# CONTAINS 'MSIE 8.0')>navbar-static-top<cfelse>navbar-fixed-top</cfif>" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <img src="includes/images/usdos-logo-seal-small.gif" height="40px" width="40px" class="pull-left"><a class="navbar-brand" href="#event.buildLink("")#">PAMS</a>

            </div>








            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">


                 <li><a href="#event.buildLink("help/index")#"><i class="fa fa-book fa-fw"></i> Help</a></li>
				<li><a href="mailto:pamshelp1@state.gov?Subject=PAMS Support Request"><i class="fa fa-envelope fa-fw"></i> Contact</a></li>
				<li><a href="#event.buildLink("admin/viewuser/sysuserid/#getPlugin("SessionStorage").getVar("sysUserid")#")#"><i class="fa fa-user fa-fw"></i> Profile</a></li>
                 <li><a href="#event.buildLink("general.dologout")#"><i class="fa fa-sign-out fa-fw"></i> Logout &nbsp;</a></li>
                <!-- /.dropdown -->

            </ul>

			<cfif IsUserInRole("search enabled")>
			  <form class="navbar-form navbar-right" role="search" method="post" action="<cfoutput>#event.buildLink('reports.search')#</cfoutput>">
		        <div class="input-group custom-search-form">
											<input name="searchType" type="hidden" value="All">
									     <input type="text" id="searchTerm" name="searchTerm" autocomplete="off" class="form-control" placeholder="Search">
		                                <span class="input-group-btn">
		                                    <button class="btn btn-default" type="submit">
		                                        <i class="fa fa-search"></i>
		                                    </button>
		                                </span>

	                            </div>
		      </form>
	      </cfif>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">


						<cfif IsUserInRole("has workload")>
							<li>
	                            <a href="##"><i class="fa fa-tasks fa-fw"></i> Workload<span class="fa arrow"></span></a>
	                            <ul class="nav nav-second-level">
	                                <li><a href="#event.buildLink("summary/index")#">Summary</a></li>
				                    <cfif IsUserInRole("has workload dashboard") and not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
				                    	<li><a href="#event.buildLink("summary/dashboard")#">Dashboard</a></li>
				                    </cfif>
				                    <li><a href="#event.buildLink("summary/myprojects")#">My Projects</a></li>
	                            </ul>
	                        </li>
						</cfif>
						<cfif IsUserInRole("view approval status") >
							<li>
	                            <a href="#event.buildLink("status/index")#"><i class="fa fa-random fa-fw"></i> Status</a>
	                        </li>
						</cfif>
						<cfif IsUserInRole("view system reports")>
							<li>
	                            <a href="#event.buildLink("reports/index")#?#getPlugin('SessionStorage').getVar('filtereportquerystring')#"><i class="fa fa-search fa-fw"></i> Search</a>
	                        </li>
	                        <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
								<li>
		                            <a href="##"><i class="fa fa-globe fa-fw"></i> Maps<span class="fa arrow"></span></a>
		                            <ul class="nav nav-second-level">

						                    <li><a href="#event.buildLink("reports/fundsbycountrymap")#?#getPlugin('SessionStorage').getVar('mapquerystring')#">Funding</a></li>
						                    <li><a href="#event.buildLink("reports/staffmap")#" target="_blank">Staff</a></li>

		                            </ul>
		                            <!-- /.nav-second-level -->
		                        </li>
		                        <li>
		                            <a href="##"><i class="fa fa-bar-chart-o fa-fw"></i> Charts<span class="fa arrow"></span></a>
		                            <ul class="nav nav-second-level">

						                    <li><a href="#event.buildLink("reports/filteredchartbyprogram")#?#getPlugin('SessionStorage').getVar('programchartquerystring')#">Program</a></li>
						                    <li><a href="#event.buildLink("reports/filteredchartbyregion")#?#getPlugin('SessionStorage').getVar('regionchartquerystring')#">Region</a></li>
						                    <li><a href="#event.buildLink("reports/filteredchartbycountry")#?#getPlugin('SessionStorage').getVar('countrychartquerystring')#">Country</a></li>
						                    <li><a href="#event.buildLink("reports/filteredchartbyorg")#?#getPlugin('SessionStorage').getVar('orgchartquerystring')#">Organization</a></li>
						                    <li><a href="#event.buildLink("reports/filteredchartbyimplementer")#">Implementer</a></li>

		                            </ul>
		                            <!-- /.nav-second-level -->
		                        </li>
	                        </cfif>
						</cfif>
<!--- 						<cfif IsUserInRole("view framework") and not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
							<li>
	                            <a href="#event.buildLink("framework/visualization")#"><i class="fa fa-sitemap fa-fw"></i> Framework</a>
	                        </li>
						</cfif> --->
						<cfif IsUserInRole("view dashboard") and not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
	                        <li>
	                            <a href="#event.buildLink("budgetdashboard")#"><i class="fa fa-dashboard fa-fw"></i> Dashboard</a>
	                        </li>
						</cfif>
						<cfif IsUserInRole("administer users")>
							<li>
	                            <a href="##"><i class="fa fa-users fa-fw"></i> Admin<span class="fa arrow"></span></a>
	                            <ul class="nav nav-second-level">
	                                <li><a href="#event.buildLink("admin/userlist")#">Users</a></li>
				                    <li><a href="#event.buildLink("admin/rolelist")#">Roles</a></li>
	                            </ul>
	                            <!-- /.nav-second-level -->
	                        </li>
						</cfif>


                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <!-- Page Content -->
        <div id="page-wrapper">
		<cfif not (#CGI.HTTP_USER_AGENT# CONTAINS 'MSIE 7.0' or #CGI.HTTP_USER_AGENT# CONTAINS 'MSIE 8.0')>
			 <div class="loadstack">
		        <div class="spinner"></div>
		    </div>
	    </cfif>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
						<script src="includes/javascript/jquery-2.1.3.min.js"></script>
					    <script src="includes/javascript/bootstrap.min.js"></script>
						<script src="includes/javascript/bootstrap-multiselect.js"></script>
						<script src="includes/javascript/metisMenu.min.js"></script>
						<script src="includes/javascript/jquery.dataTables.min.js"></script>
						<script src="includes/javascript/jquery.jeditable.mini.js"></script>
						<script src="includes/javascript/jquery.bsAlerts.js"></script>
						<script src="includes/javascript/dataTables.bootstrap.min.js"></script>
   						 <script src="includes/javascript/sb-admin-2.js"></script>
						<script src="includes/javascript/jquery.jeditable.mini.js"></script>
						<script src="includes/javascript/jquery-ui.min.js"></script>

						 <cfif not getPlugin("MessageBox").isEmpty()>
							<div class="fixed-alert">#getPlugin("MessageBox").renderit()#</div>
						</cfif>

						<cfif StructKeyExists(rc,"arrErrors") and arrayLen(rc.arrErrors) >
							<cfloop array="#rc.arrErrors#" index="thisError">
								  <p class="fixed-alert">#thisError.message#</p>
							</cfloop>
						</cfif>

						<div data-alerts="alerts" data-fade="2000" class="fixed-alert"></div>

						#renderView()#
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /##page-wrapper -->

    </div>
    <!-- /##wrapper -->

</cfoutput>
<script>

		function doFormEvent (e, frm, enc) {
			var enc = (enc == null) ? "true" : enc;
			var pars = "event=" + e + "&";
			var methodType = (methodType == null) ? "GET" : methodType;
			pars = pars + $( frm ).serialize();
			//alert(picked);
			return $.ajax( {type: "POST",
					  url: "index.cfm",
					  dataType:"html",
					  data: pars
					  });
		}

		function doEvent (e, params, methodType) {
			var pars = "event=" + e + "&";
			var methodType = (methodType == null) ? "GET" : methodType;
			for(p in params) pars = pars + p + "=" + escape(params[p]) + "&";
			//alert(pars);
			return $.ajax( {type: methodType,
					  url: "index.cfm",
					  dataType:"html",
					  data: pars
					  });

		}

$(document).ready(function($) {

	 $('.cbox_messagebox_info').delay(5000).fadeOut(1000);
		  $('.cbox_messagebox_warning').delay(5000).fadeOut(1000);
		  $('.cbox_messagebox_error').delay(5000).fadeOut(1000);

	$('[data-toggle="tooltip"]').tooltip({html: true})
	//$('#filteredreport').DataTable({
   //             responsive: true
     //   });

    $('#filteredreport').DataTable({ "aLengthMenu": [
            [10, 25, 50, 100, 200, -1],
            [10, 25, 50, 100, 200, "All"]
        ], "iDisplayLength" : -1 });

    "use strict";
	jQuery(window).load(function () {
        jQuery(".loadstack").fadeOut();
    });
});
</script>
</body>

</html>

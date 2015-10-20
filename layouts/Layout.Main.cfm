

<cfset oSession = getPlugin("SessionStorage")>
<!DOCTYPE html>
<html lang="en">
<head>

	<title><cfif isdefined('rc.pageTitle')><cfoutput>#rc.pageTitle#</cfoutput> |</cfif> CT Project Management System bs3</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

	<cfoutput>
		<base href="#getSetting('htmlBaseURL')#">
	</cfoutput>


	<link rel="stylesheet" href="includes/styles/bootstrap.min.css" type="text/css">
	<style>
		body {background-image:url('includes/images/map-negative.jpg');}
		.nav{font-size:16px!important}
		legend a {text-decoration:none !important;}
	</style>


	<link rel="stylesheet" href="includes/styles/core.css" type="text/css">



	<link rel="stylesheet" href="includes/styles/font-awesome.min.css" type="text/css">
	<link rel="stylesheet" href="includes/styles/bootstrap-theme.min.css" type="text/css">
	<link rel="stylesheet" href="includes/styles/jquery.dataTables.min.css" type="text/css">
	<link rel="stylesheet" href="includes/styles/bootstrap-multiselect.css" type="text/css"/>

	<script type="text/javascript" src="includes/javascript/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="includes/javascript/jquery.cookie.js"></script>
	<script type="text/javascript" src="includes/javascript/jquery-ui.min.js"></script>
	<script type="text/javascript" src="includes/javascript/jquery.tablesorter.min.js"></script>
	<script type="text/javascript" src="includes/javascript/jquery.jeditable.mini.js"></script>
	<script type="text/javascript" src="includes/javascript/bootstrap.min.js"></script>
	<script type="text/javascript" src="includes/javascript/bootstrap-multiselect.js"></script>



</head>
	<body>

	<div class="ct-logo-back"><img src="includes/images/usdos-logo-seal.gif" height="180px" width="180px"></div>
	<div id="wrap">
	<cfoutput>
		<div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target="##outer-collapse">
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
             <a href="#event.buildLink("")#"><span class="brand">PAMS</span></a>
			<!--- <span class="brand">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> --->
            <div class="nav-collapse collapse" id="outer-collapse">

              <ul class="nav">
				<cfif IsUserInRole("has workload")>
	               	 <cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0">
						<li<cfif #cgi.PATH_INFO# contains "/summary"> class="active"</cfif>><a href="#event.buildLink("summary/index")#"><i class="icon-tasks<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Workload</a></li>
					<cfelse>
						<li class="dropdown <cfif #cgi.PATH_INFO# contains "/summary" OR #cgi.PATH_INFO# is "">active</cfif>">
			                  <a href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-tasks<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Workload<b class="caret"></b></a>
			                  <ul class="dropdown-menu">
			                    <li><a href="#event.buildLink("summary/index")#">Summary</a></li>
			                    <cfif IsUserInRole("has workload dashboard")>
			                    	<li><a href="#event.buildLink("summary/dashboard")#">Dashboard</a></li>
			                    </cfif>
			                    <li><a href="#event.buildLink("summary/myprojects")#">My Projects</a></li>
			                  </ul>
			                </li>
		            </cfif>
				</cfif>
				<cfif IsUserInRole("view approval status") >
					<cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0">
						<li<cfif #cgi.PATH_INFO# contains "/status"> class="active"</cfif>><a href="#event.buildLink("status/index")#"><i class="icon-random<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Status</a></li>
					<cfelse>
						 <li class="dropdown <cfif #cgi.PATH_INFO# contains "/status">active</cfif>">
		                  <a href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-random<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Status<b class="caret"></b></a>
		                  <ul class="dropdown-menu">
		                    <li><a href="#event.buildLink("status/index")#">Review Pending</a></li>
		                    <li><a href="#event.buildLink("status/cnpending")#">CN Pending</a></li>
		                    <li><a href="#event.buildLink("status/mechanism")#">Funding Mechanism</a></li>
		                    <li><a href="#event.buildLink("status/obstatus")#">Obligation Status</a></li>
		                  </ul>
		                </li>
	                </cfif>
				</cfif>
			    <cfif IsUserInRole("view system reports")>
			       <cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0">
						<li<cfif #cgi.PATH_INFO# contains "/reports"> class="active"</cfif>><a href="#event.buildLink("reports/index")#"><i class="icon-signal<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Reports</a></li>
					<cfelse>
				        <li class="dropdown <cfif #cgi.PATH_INFO# contains "/reports">active</cfif>">
		                  <a href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-bar-chart<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Reports<b class="caret"></b></a>
		                  <ul class="dropdown-menu">
			                <cfif IsUserInRole("view system reports")>
		                    <li><a href="#event.buildLink("reports/index")#?#getPlugin('SessionStorage').getVar('filtereportquerystring')#">Filtered Report</a></li>
		                    <li><a href="#event.buildLink("reports/fundsbycountrymap")#?#getPlugin('SessionStorage').getVar('mapquerystring')#">Funding Map</a></li>
		                    <li><a href="#event.buildLink("reports/staffmap")#" target="_blank">Staff Map</a></li>
		                    <li><a href="#event.buildLink("reports/filteredchartbyprogram")#?#getPlugin('SessionStorage').getVar('programchartquerystring')#">Program Chart</a></li>
		                    <li><a href="#event.buildLink("reports/filteredchartbyregion")#?#getPlugin('SessionStorage').getVar('regionchartquerystring')#">Region Chart</a></li>
		                    <li><a href="#event.buildLink("reports/filteredchartbyCountry")#?#getPlugin('SessionStorage').getVar('countrychartquerystring')#">Country Chart</a></li>
		                    <li><a href="#event.buildLink("reports/filteredchartbyorg")#?#getPlugin('SessionStorage').getVar('orgchartquerystring')#">Organization Chart</a></li>
		                    <li><a href="#event.buildLink("reports/filteredchartbyimplementer")#">Implementer Chart</a></li>
		                    <!--- <li><a href="#event.buildLink("reports/cannedreports")#">Misc Reports</a></li> --->
		                    </cfif>

		                  </ul>
		                </li>
	                </cfif>
			     </cfif>

			     <cfif IsUserInRole("view framework") and not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
               	 <li<cfif #cgi.PATH_INFO# contains "/framework"> class="active"</cfif>><a href="#event.buildLink("framework/visualization")#"><cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0"><i class="icon-align-center<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i><cfelse><i class="icon-sitemap"></i></cfif> Framework</a></li>
				</cfif>

				<cfif IsUserInRole("view dashboard") and not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
               	 <li<cfif #cgi.PATH_INFO# contains "/budgetdashboard"> class="active"</cfif>><a href="#event.buildLink("budgetdashboard")#"><cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0"><i class="icon-align-center<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i><cfelse><i class="icon-dashboard"></i></cfif> Dashboard</a></li>
				</cfif>

			     <cfif IsUserInRole("administer users")>
				     <cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0">
						<li<cfif #cgi.PATH_INFO# contains "/admin"> class="active"</cfif>><a href="#event.buildLink("admin/userlist")#"><i class="icon-pencil<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Admin</a></li>
					<cfelse>
				        <li class="dropdown <cfif #cgi.PATH_INFO# contains "admin">active</cfif>">
				        	<a href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-pencil<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i> Admin</a>
						 <ul class="dropdown-menu">
		                    <li><a href="#event.buildLink("admin/userlist")#">User List</a></li>
		                    <li><a href="#event.buildLink("admin/rolelist")#">Role List</a></li>
		                    <li><a href="#event.buildLink("admin/viewuser")#">Add New User</a></li>
		                    <li><a href="#event.buildLink("admin/viewrole")#">Add New Role</a></li>
		                  </ul>
						</li>
					</cfif>
			     </cfif>


              </ul>

				<ul class="nav pull-right">
				<cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0">
					<li class="pull-right"><a href="#event.buildLink("general.dologout")#"><i class="icon-off<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i></a></li>
				<cfelse>
					<li class="dropdown">
	                  <a href="##" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-cog<cfif cookie.styles is not 'cleanstyle'> icon-white</cfif>"></i></a>
	                  <ul class="dropdown-menu span3">
						<li class="nav-header ttip" title="#getPlugin('SessionStorage').getVar('curUserAuth.roleName')#" data-placement="right">#GetAuthUser()# </li>
	                    <li><a href="#event.buildLink("admin/viewuser/sysuserid/#getPlugin("SessionStorage").getVar("sysUserid")#")#"><i class="icon-pencil"></i> User Account</a></li>
	                    <li><a href="#event.buildLink("general.dologout")#"><i class="icon-off"></i> Log Out</a></li>
						<li class="divider"></li>
						<li><a href="#event.buildLink("help/index")#"><i class="icon-info-sign"></i> Help</a></li>
						<li><a href="mailto:pamshelp@state.gov?Subject=PAMS Support Request"><i class="icon-envelope"></i>  Contact Support</a></li>
						<li class="divider"></li>
						<li class="nav-header" data-placement="right">Appearance </li>
						<li><a href="index.cfm#cgi.PATH_INFO#?styles=classicstyle">Classic</a></li>
						<li><a href="index.cfm#cgi.PATH_INFO#?styles=cleanstyle">Clean</a></li>
						<li><a href="index.cfm#cgi.PATH_INFO#?styles=carbonstyle">Carbon</a></li>
	                  </ul>
	                </li>
	               </cfif>
				</ul>

			<cfif IsUserInRole("search enabled")>
				<form method="post" action="<cfoutput>#event.buildLink('reports.search')#</cfoutput>" class="navbar-form pull-right form-search">
					<input name="searchType" type="hidden" value="All">
					<div class="input-append">
				     <input id="searchTerm" name="searchTerm"  type="text"  value="" autocomplete="off"  class="input-small search-query" data-provide="typeahead">
				     <button type="submit" class="btn"><i class="icon-search"></i></button>
				     </div>
				</form>
			</cfif>


            </div><!--/.nav-collapse -->
          </div>
        </div>
      </div>


	<div class="container container-white">

	<!--- <br> --->

		<cfif #cgi.PATH_INFO# contains "/status/">

		<div class="navbar">
			<div class="navbar-inner">
					<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target="##inner-collapse">
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		            </button>
					<div class="nav-collapse collapse" id="inner-collapse">
					<ul class="nav">
						<li <cfif #cgi.PATH_INFO# eq "/status/index"> class="active"</cfif>>
							<a href="#event.buildLink('status/index')#">Review Pending</a>
						</li>
						<li><a href="#event.buildLink('status/cnPending')#"><i class="icon-arrow-right"></i></a></li>
						<li <cfif #cgi.PATH_INFO# eq "/status/cnPending"> class="active"</cfif>>
							<a href="#event.buildLink('status/cnPending')#">CN Pending</a>
						</li>
						<li><a href="#event.buildLink('status/mechanism')#"><i class="icon-arrow-right"></i></a></li>
						<li <cfif #cgi.PATH_INFO# eq "/status/mechanism"> class="active"</cfif>>
							<a href="#event.buildLink('status/mechanism')#">Funding Mechanism</a>
						</li>
						<li><a href="#event.buildLink('status/obStatus')#"><i class="icon-arrow-right"></i></a></li>
						<li <cfif #cgi.PATH_INFO# eq "/status/obStatus"> class="active"</cfif>>
							<a href="#event.buildLink('status/obStatus')#">Obligation Status</a>
						</li>
					</ul>
					</div>
				</div>
			</div>

		<cfelseif #cgi.PATH_INFO# contains "/summary/">

		<div class="navbar">
			<div class="navbar-inner">
					<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target="##inner-collapse">
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		            </button>
					<div class="nav-collapse collapse" id="inner-collapse">
					<ul class="nav">
						<li <cfif #cgi.PATH_INFO# contains "/summary/index"> class="active"</cfif>>
							<a href="#event.buildLink('summary/index')#">Workload List</a>
						</li>
						<cfif IsUserInRole("has workload dashboard") and not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>
							<li <cfif #cgi.PATH_INFO# eq "/summary/dashboard"> class="active"</cfif>>
								<a href="#event.buildLink('summary/dashboard')#">Workload Dashboard</a>
							</li>
						</cfif>
						<li <cfif #cgi.PATH_INFO# eq "/summary/myprojects"> class="active"</cfif>>
							<a href="#event.buildLink('summary/myprojects')#">My Projects</a>
						</li>
					</ul>
					</div>
				</div>
			</div>


		<cfelseif  #cgi.PATH_INFO# contains "/reports/">

			<div class="navbar">
				<div class="navbar-inner">
					<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target="##inner-collapse">
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		            </button>
					<div class="nav-collapse collapse" id="inner-collapse">
					<ul class="nav">
						<li <cfif #cgi.PATH_INFO# contains "index">class="active"</cfif>>
							<a href="#event.buildLink("reports.index")#?#getPlugin('SessionStorage').getVar('filtereportquerystring')#" title="Filtered Report"><span>Filtered Report</span></a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "fundsbycountrymap">class="active"</cfif>>
							<a href="#event.buildLink("reports.fundsbycountrymap")#?#getPlugin('SessionStorage').getVar('mapquerystring')#">Funding Map</a>
						</li>
						<li>
							<a href="#event.buildLink("reports.staffmap")#" target="_blank">Staff Map</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "filteredchartbyprogram">class="active"</cfif>>
							<a href="#event.buildLink("reports.filteredchartbyprogram")#?#getPlugin('SessionStorage').getVar('programchartquerystring')#">Programs</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "filteredchartbyregion">class="active"</cfif>>
							<a href="#event.buildLink("reports.filteredchartbyregion")#?#getPlugin('SessionStorage').getVar('regionchartquerystring')#">Regions</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "filteredchartbyCountry">class="active"</cfif>>
							<a href="#event.buildLink("reports.filteredchartbyCountry")#?#getPlugin('SessionStorage').getVar('countrychartquerystring')#">Countries</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "filteredchartbyorg">class="active"</cfif>>
							<a href="#event.buildLink("reports.filteredchartbyorg")#?#getPlugin('SessionStorage').getVar('orgchartquerystring')#">Organizations</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "filteredchartbyimplementer">class="active"</cfif>>
							<a href="#event.buildLink("reports.filteredchartbyimplementer")#">Implementers</a>
						</li>
						<!--- <li <cfif #cgi.PATH_INFO# contains "cannedreports">class="active"</cfif>>
							<a href="#event.buildLink("reports.cannedreports")#">Misc</a>
						</li> --->
					</ul>
					</div>
				</div>
			</div>
		<cfelseif  #cgi.PATH_INFO# contains "/proposal/" and not (#cgi.PATH_INFO# contains "/new" or #cgi.PATH_INFO# contains "/view"  or #cgi.PATH_INFO# contains "/saveProposal"  )>
			<div class="row">
				<div class="span1">
					&nbsp;
				</div>
				<div class="span10 container-white" style="padding: 5px 29px 5px;margin: 0">
					<fieldset>
						<legend>#uCase(rc.proposal.proposalnumber)#: #uCase(rc.projectTitle)# <cfif rc.proposal.reprogramfunds is 1 or rc.proposal.implementationstatus is 'CN Re-notification'><span class="text-error"> (Reprogrammed/Re-notified)</span></cfif></legend>
							<div class="row">
								<div class="span5">
									<dl class="dl-horizontal">
									  <dt>Funding Requested:</dt>
									  <dd>#dollarFormat(rc.proposal.budgetCeilingAmount)#</dd>
									  <dt>Status:</dt>
									  <dd><cfif rc.progressStatus is "CN Partial Hold"><strong class="text-error">#rc.progressStatus#</strong><cfelse>#rc.progressStatus#</cfif></dd>
									</dl>
								</div>
								<div class="span5">
									<dl class="dl-horizontal">
									  <dt>Age:</dt>
									  <dd>#rc.progressAge# day(s)</dd>
									  <dt>Submit Date:</dt>
									  <dd>#dateFormat(rc.proposal.proposalSubmitDate,'dd mmm yyyy')#</dd>
									</dl>
								</div>
							</div>

					</fieldset>
				</div>
				<div class="span1">
					&nbsp;
				</div>
			</div>

			<div class="navbar">
				<div class="navbar-inner">
					<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target="##inner-collapse">
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		            </button>
					<div class="nav-collapse collapse" id="inner-collapse">
					<ul class="nav">

						<li <cfif #cgi.PATH_INFO# contains "review">class="active"</cfif>>
							<a href="#event.buildLink("proposal.review.activityID." & rc.ActivityID)#">Review</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "cn">class="active"</cfif>>
							<a href="#event.buildLink("proposal.cn.activityID." & rc.ActivityID)#">CN</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "fundImpMechanism">class="active"</cfif>>
							<a href="#event.buildLink("proposal.fundImpMechanism.activityID." & rc.ActivityID)#">Funding</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "obStatus">class="active"</cfif>>
							<a href="#event.buildLink("proposal.obStatus.activityID." & rc.ActivityID)#">Obligation</a>
						</li>
						<li <cfif #cgi.PATH_INFO# contains "impStatus">class="active"</cfif>>
							<a href="#event.buildLink("proposal.impStatus.activityID." & rc.ActivityID)#">Implementation</a>
						</li>
						<!--- <li <cfif #cgi.PATH_INFO# contains "proposal/workplan">class="active"</cfif>>
							<a href="#event.buildLink("proposal.workplan.activityID." & rc.ActivityID)#">Workplan</a>
						</li> --->
						<li <cfif #cgi.PATH_INFO# contains "proposal/rmp">class="active"</cfif>>
							<a href="#event.buildLink("proposal.rmp.activityID." & rc.ActivityID)#">PMP</a>
						</li>

						<li <cfif #cgi.PATH_INFO# contains "proposal/activityreports">class="active"</cfif>>
							<a href="#event.buildLink("proposal.activityreports.activityID." & rc.ActivityID)#">Reports</a>
						</li>
						<cfif IsUserInRole("view edit log")>
						<li <cfif #cgi.PATH_INFO# contains "proposal/editlog">class="active"</cfif>>
							<a href="#event.buildLink("proposal.editlog.activityID." & rc.ActivityID)#">Log</a>
						</li>
						</cfif>
					</ul>

					</div>
				</div>
			</div>
		<cfelseif  #cgi.PATH_INFO# contains "/admin/" and IsUserInRole("administer users")>

			<div class="navbar">
			<div class="navbar-inner">
					<button type="button" class="btn btn-navbar" data-toggle="collapse" data-target="##inner-collapse">
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		              <span class="icon-bar"></span>
		            </button>
					<div class="nav-collapse collapse" id="inner-collapse">
					<ul class="nav">
						<li <cfif #cgi.PATH_INFO# eq "/admin/userlist"> class="active"</cfif>>
							<a href="#event.buildLink('admin/userlist')#">User List</a>
						</li>
						<li <cfif #cgi.PATH_INFO# eq "/admin/rolelist"> class="active"</cfif>>
							<a href="#event.buildLink('admin/rolelist')#">Role List</a>
						</li>
						<li <cfif #cgi.PATH_INFO# eq "/admin/viewuser"> class="active"</cfif>>
							<a href="#event.buildLink('admin/viewuser')#">Add New User</a>
						</li>
						<li <cfif #cgi.PATH_INFO# eq "/admin/viewrole"> class="active"</cfif>>
							<a href="#event.buildLink('admin/viewrole')#">Add New Role</a>
						</li>

					</ul>
					</div>
				</div>
			</div>


		</cfif>

		<cfif not getPlugin("MessageBox").isEmpty()>
			<p>#getPlugin("MessageBox").renderit()#</p>
		</cfif>

		<cfif StructKeyExists(rc,"arrErrors") and arrayLen(rc.arrErrors) >
			<cfloop array="#rc.arrErrors#" index="thisError">
				  <p>#thisError.message#</p>
			</cfloop>
		</cfif>
	</cfoutput>




		      <!------------------------------------------------------ Begin Page Content ------------------------------------------------------>
						<!--- Render The View. This is set wherever you want to render the view in your Layout. --->
						 <cfoutput>#renderView()#</cfoutput>
		      <!------------------------------------------------------ End Page Content ------------------------------------------------------>

	</div>

      <div id="push"></div>
    </div>

	<div id="footer">
      <div class="container"><p class="text-right">
			&copy; <cfoutput>#year(now())#</cfoutput> |
			<a href="mailto:pamshelp@state.gov">Support</a>
			</p>

		</div>
    </div>

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

		$(document).ready(function() {
		  $('.cbox_messagebox_info').delay(10000).fadeOut(1000);
		  $('.cbox_messagebox_warning').delay(8500).fadeOut(1000);
		  $('.cbox_messagebox_error').delay(8500).fadeOut(1000);
		  $('.ttip').tooltip({html: true});
		  $("#archivedTable").hide();
		// var searchurl = '<cfoutput>#event.buildLink("remote/searchtypeahead")#</cfoutput>';

		 //var searchterms = $.get(searchurl);

		  //document.getElementById('testterms').innerHTML = searchterms;

		//  $.get(searchurl)
			//	.done(function(data) {
				  //alert("Data Loaded: " + data);
				 // document.getElementById('testterms').innerHTML = data;
				//});


		});
		$('#viewArchived').click(function() {
			 $('#archivedTable').toggle('fast', function() {});
		});

		$(function(){
		  var hash = window.location.hash;
		  hash && $('ul.nav a[href="' + hash + '"]').tab('show');

		  $('.nav-tabs a').click(function (e) {
		    $(this).tab('show');
		    var scrollmem = $('body').scrollTop();
		    window.location.hash = this.hash;
		    $('html,body').scrollTop(scrollmem);
		  });
		});


	</script>


	</body>
</html>

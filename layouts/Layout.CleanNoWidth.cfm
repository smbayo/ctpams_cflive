	<cfset oSession = getPlugin("SessionStorage")>
<!DOCTYPE html>
<html lang="en">
<head>

	<title><cfif isdefined('rc.pageTitle')><cfoutput>#rc.pageTitle#</cfoutput> |</cfif> CT Project Management System</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
	
	<cfoutput>
		<base href="#getSetting('htmlBaseURL')#">
	</cfoutput>	
	
	<link rel="stylesheet" href="includes/styles/bootstrap.min.css" type="text/css">
	<link rel="stylesheet" href="includes/styles/bootstrap-responsive.min.css" type="text/css">
	<link rel="stylesheet" href="includes/styles/core.css" type="text/css">
	<link type="text/css" href="includes/styles/smoothness/jquery-ui-1.8.14.custom.css" rel="Stylesheet" />	
	
	<script type="text/javascript" src="includes/javascript/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="includes/javascript/jquery.cookie.js"></script>
	<script type="text/javascript" src="includes/javascript/jquery-ui-1.8.14.custom.min.js"></script>
	<script type="text/javascript" src="includes/javascript/jquery.tablesorter.min.js"></script>	
	<script type="text/javascript" src="includes/javascript/bootstrap.min.js"></script>
	<script type="text/javascript" src="includes/javascript/bootstrap-multiselect.js"></script>
	<script type="text/javascript" src="includes/javascript/bootstrap.file-input.js"></script>
	<cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE">
		<script type="text/javascript" src="includes/javascript/respond.min.js"></script>
	</cfif>

</head>
	<body style="background:white!important;">
	

		      <!------------------------------------------------------ Begin Page Content ------------------------------------------------------>
						<!--- Render The View. This is set wherever you want to render the view in your Layout. --->
						 <cfoutput>#renderView()#</cfoutput> 
		      <!------------------------------------------------------ End Page Content ------------------------------------------------------>



	</body>
</html>
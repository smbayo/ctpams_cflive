<cfset oSession = getPlugin("SessionStorage")>
<!DOCTYPE html>
<html lang="en">

	<head>

<title>CT Project Management System</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="Daniel Jordan">
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">

	<cfoutput>
	<base href="#getSetting('htmlBaseURL')#">
	</cfoutput>

	<link href="includes/styles/bootstrap.min.css" rel="stylesheet">
    <link href="includes/styles/metisMenu.min.css" rel="stylesheet">
    <link href="includes/styles/sb-admin-2.css" rel="stylesheet">
    <link href="includes/styles/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="includes/styles/custom.css" type="text/css"/>


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>

<body id="auth-body">

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading text-center">
                        <h5>Project Activity Management System (PAMS)</h5>
                    </div>
                    <div class="panel-body">
						<cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 6.0">
							<div class="text-danger">WARNING: Only core functionality is available when using Internet Explorer 8 or below.
							Please use Google Chrome best results.</div><hr>
						</cfif>



	      <!------------------------------------------------------ Begin Page Content ------------------------------------------------------>
					<!--- Render The View. This is set wherever you want to render the view in your Layout. --->

					<cfoutput>#renderView()#</cfoutput>

	      <!------------------------------------------------------ End Page Content ------------------------------------------------------>
	 <cfoutput>
		<cfif not getPlugin("MessageBox").isEmpty()>
			<p>#getPlugin("MessageBox").renderit()#</p>
		</cfif>

		<cfif StructKeyExists(rc,"arrErrors") and arrayLen(rc.arrErrors) >
			<cfloop array="#rc.arrErrors#" index="thisError">
				  <p>#thisError.message#</p>
			</cfloop>
		</cfif>
	</cfoutput>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="includes/javascript/jquery-2.1.3.min.js"></script>
	<script src="includes/javascript/bootstrap.min.js"></script>
	<script src="includes/javascript/metisMenu.min.js"></script>
    <script src="includes/javascript/sb-admin-2.js"></script>


<script>

$(document).ready(function($) {

	 $('.cbox_messagebox_info').delay(5000).fadeOut(1000);
		  $('.cbox_messagebox_warning').delay(5000).fadeOut(1000);
		  $('.cbox_messagebox_error').delay(5000).fadeOut(1000);

});
</script>
</body>

</html>

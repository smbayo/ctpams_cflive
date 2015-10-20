<!---<cfset oSession = getPlugin("SessionStorage")>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="application/json; charset=iso-8859-1" />
</head>
<body>--->
  <!------------------------------------------------------ Begin Page Content ------------------------------------------------------>
         <!--- Render The View. This is set wherever you want to render the view in your Layout. --->
            
			<cfsetting enablecfoutputonly="yes">
			<cfsetting showdebugoutput="no">
			<!--- Query the database and get all the records from the Images table --->

			<!--- Send the headers --->
            <cfheader name="Content-type" value="text/html">
            <cfheader name="Cache-control" value="private">
<!--- <cfheader name="Expires" value="-1"> --->

			<cfoutput>#renderView()#</cfoutput>
<cfsetting enablecfoutputonly="no">
  <!------------------------------------------------------ End Page Content ------------------------------------------------------>
<!---</body>
</html>
--->
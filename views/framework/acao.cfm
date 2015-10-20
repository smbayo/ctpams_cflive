<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<h3>cfheader Example</h3> 
 
<p>cfheader generates custom HTTP response headers to return to the client.  
<p>This example forces browser client to purge its cache of requested file.  
<cfheader name="Expires" value="#GetHttpTimeString(Now())#">
</body>
</html>
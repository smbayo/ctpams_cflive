<cfscript>
	// General Properties
	setExtensionDetection(false);
	setEnabled(true);
	setUniqueURLS(false);
	//setAutoReload(false);
	
	//setAutoReload(false);
    protocol = "http";
    if (isBoolean(cgi.server_port_secure) and cgi.server_port_secure)
       protocol = "https";
	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("#protocol#://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("#protocol#://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	} 	
	// Add Module Routing Here
	addModuleRoutes(pattern="/forgebox",module="forgebox");
	
	// Your Application Routes
	addRoute(pattern=":handler/:action?");
</cfscript>


<!-----------------------------------------------------------------------
********************************************************************************
Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	9/28/2007
Description :
	A simple security interceptor

	extends="coldbox.system.interceptor" by default because the framework
	knows its an interceptor by convension.
----------------------------------------------------------------------->
<cfcomponent name="securityInterceptor"
			 hint="This is a simple security interceptor"
			 output="false">

  <cfproperty name="activityService" inject="model" scope="instance" />
  <cfproperty name="orgService" inject="model" scope="instance" />
  <cfproperty name="locationService" inject="model" scope="instance">
	
<!------------------------------------------- CONSTRUCTOR ------------------------------------------->

	<cffunction name="Configure" access="public" returntype="void" hint="This is the configuration method for your interceptors" output="false" >
		<!--- Nothing --->

	</cffunction>

<!------------------------------------------- INTERCEPTION POINTS ------------------------------------------->

	<!--- Pre execution process --->
	<cffunction name="preProcess" access="public" returntype="void" hint="Executes before any event execution occurs" output="false" >
		<!--- ************************************************************* --->
		<cfargument name="event" required="true" type="any" hint="The event object.">
		<cfargument name="interceptData" required="true" type="struct" hint="interceptData of intercepted info.">
		<!--- ************************************************************* --->


		<cfscript>
			var rc = Event.getCollection();
			var loggingIn = false;
			
			// login not required
			var nologinRequired = false;
			
			var oSession = getPlugin("SessionStorage");
			// build lists of grant and org event handlers that should not receive the search form processing.
			var excludedGrantHandlers = "";
			var excludedOrgHandlers = "";

			//Are we logging In
			if ( event.getCurrentEvent() eq "General.doLogin")
				loggingIn = true;

			//... or logging out
			if ( event.getCurrentEvent() eq "General.doLogOut")
				loggingOut = true;	
				
			if ( (StructKeyExists(rc,"event") 
					and (rc.event EQ "proposal.new" or rc.event EQ "proposal.saveProposal" or rc.event EQ "proposal.view" or rc.event EQ "attachedFile.index") ) 
						and (StructKeyExists(rc,"prgm") and trim(len(rc.prgm)) and isNumeric(rc.prgm) ) 
						/* and (StructKeyExists(rc,"fsrc") and trim(len(rc.fsrc)) and isNumeric(rc.fsrc))*/ 
							 ) {
				nologinRequired  = true;
			}


			if ( nologinRequired and NOT isUserLoggedIn() ) {
				/* do nothing!!!  */
			}
			else if ( NOT isUserLoggedIn() AND NOT loggingIn){
				//Override the incoming event.
				//Event.overrideEvent("General.Login");	
				Event.overrideEvent("General.Login");	
				if (getPlugin("MessageBox").isEmpty()) {
  				getPlugin("MessageBox").setMessage("warning", "Please sign in");
				}						
			}
			

		</cfscript>
	</cffunction>

</cfcomponent>
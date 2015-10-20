<cfcomponent name="Report" output="false" extends="coldbox.system.EventHandler" autowire="true">

	<!--- Inject Dependencies --->

	<cfproperty name="ProposalGateway" inject="model" scope="instance">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<!--- ************************************************************* --->
	<cffunction name="onRequestStart" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">

		<cfscript>
			var rc = Event.getCollection();

			//Set xeh's
			rc.xehLogout = "General.doLogout";
			rc.xehHome = "General.Home";
			rc.xehSearchOrg = "Report.searchResults";
		</cfscript>
	</cffunction>

	<!------------------------------------------- PUBLIC EVENTS --------------------------------------->

	 <cffunction name="index" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfset rc.dashboard =  instance.proposalGateway.getDashboard() />
		<cfset jstring=''>
		<cfset jstring=(jstring & '[')>
		<cfloop query="rc.dashboard">
			<cfset jstring=jstring & '{budgetamount: ' & budgetamount>
			<cfset jstring=jstring & ', budgetitem: "' & budgetitem>
			<cfset jstring=jstring & '", country: "' & country>
			<cfset jstring=jstring & '", program: "' & program>
			<cfset jstring=jstring & '", region: "' & region>
			<cfset jstring=jstring & '", activityid: ' & activityid>
			<cfset jstring=jstring & ', proposalnumber: "' & proposalnumber>
			<cfset jstring=jstring & '", proposalname: "' & proposalname>
			<cfset jstring=jstring & '", startdate: "' & dateformat(StartDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", enddate: "' & dateformat(endDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", fundingmechanism: "' & fundingmechanism>
			<cfset jstring=jstring & '", fiscalyear: ' & fiscalyear>
			<cfset jstring=jstring & '}'>
			<cfif rc.dashboard.currentRow lt rc.dashboard.recordcount>
				<cfset jstring=jstring & ','>
			</cfif>
		</cfloop>
		<cfset jstring=jstring & '];'>
		<cfset rc.jstring=jstring>

		<cfset rc.PageTitle = "CT Programs" />
		<cfset event.setView("budgetdashboard/responsive") />

	</cffunction>


	<cffunction name="map" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfset rc.dashboard =  instance.proposalGateway.getDashboard() />
		<cfset jstring=''>
		<cfset jstring=(jstring & '[')>
		<cfloop query="rc.dashboard">
			<cfset jstring=jstring & '{budgetamount: ' & budgetamount>
			<cfset jstring=jstring & ', budgetitem: "' & budgetitem>
			<cfset jstring=jstring & '", country: "' & country>
			<cfset jstring=jstring & '", iso2: "' & externalcode>
			<cfset jstring=jstring & '", program: "' & program>
			<cfset jstring=jstring & '", region: "' & region>
			<cfset jstring=jstring & '", activityid: ' & activityid>
			<cfset jstring=jstring & ', proposalnumber: "' & proposalnumber>
			<cfset jstring=jstring & '", proposalname: "' & proposalname>
			<cfset jstring=jstring & '", startdate: "' & dateformat(StartDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", enddate: "' & dateformat(endDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", fundingmechanism: "' & fundingmechanism>
			<cfset jstring=jstring & '", fiscalyear: ' & fiscalyear>
			<cfset jstring=jstring & '}'>
			<cfif rc.dashboard.currentRow lt rc.dashboard.recordcount>
				<cfset jstring=jstring & ','>
			</cfif>
		</cfloop>
		<cfset jstring=jstring & '];'>
		<cfset rc.jstring=jstring>

		<cfset rc.PageTitle = "CT Programs" />
		<cfset event.setView("budgetdashboard/dashboard-map") />

	</cffunction>


	<cffunction name="dashboard2" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfset rc.dashboard =  instance.proposalGateway.getDashboard() />
		<cfset jstring=''>
		<cfset jstring=(jstring & '[')>
		<cfloop query="rc.dashboard">
			<cfset jstring=jstring & '{budgetamount: ' & budgetamount>
			<cfset jstring=jstring & ', budgetitem: "' & budgetitem>
			<cfset jstring=jstring & '", country: "' & country>
			<cfset jstring=jstring & '", program: "' & program>
			<cfset jstring=jstring & '", region: "' & region>
			<cfset jstring=jstring & '", activityid: ' & activityid>
			<cfset jstring=jstring & ', proposalnumber: "' & proposalnumber>
			<cfset jstring=jstring & '", proposalname: "' & proposalname>
			<cfset jstring=jstring & '", startdate: "' & dateformat(StartDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", enddate: "' & dateformat(endDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", fundingmechanism: "' & fundingmechanism>
			<cfset jstring=jstring & '", fiscalyear: ' & fiscalyear>
			<cfset jstring=jstring & '}'>
			<cfif rc.dashboard.currentRow lt rc.dashboard.recordcount>
				<cfset jstring=jstring & ','>
			</cfif>
		</cfloop>
		<cfset jstring=jstring & '];'>
		<cfset rc.jstring=jstring>

		<cfset rc.PageTitle = "CT Programs" />
		<cfset event.setView("budgetdashboard/dashboard2") />

	</cffunction>


	<cffunction name="dashboard3" output="false" hint="index">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection() />

		<cfset rc.dashboard =  instance.proposalGateway.getDashboard() />
		<cfset jstring=''>
		<cfset jstring=(jstring & '[')>
		<cfloop query="rc.dashboard">
			<cfset jstring=jstring & '{budgetamount: ' & budgetamount>
			<cfset jstring=jstring & ', budgetitem: "' & budgetitem>
			<cfset jstring=jstring & '", country: "' & country>
			<cfset jstring=jstring & '", program: "' & program>
			<cfset jstring=jstring & '", region: "' & region>
			<cfset jstring=jstring & '", activityid: ' & activityid>
			<cfset jstring=jstring & ', proposalnumber: "' & proposalnumber>
			<cfset jstring=jstring & '", proposalname: "' & proposalname>
			<cfset jstring=jstring & '", startdate: "' & dateformat(StartDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", enddate: "' & dateformat(endDate,"MM/DD/YYYY")>
			<cfset jstring=jstring & '", fundingmechanism: "' & fundingmechanism>
			<cfset jstring=jstring & '", fiscalyear: ' & fiscalyear>
			<cfset jstring=jstring & '}'>
			<cfif rc.dashboard.currentRow lt rc.dashboard.recordcount>
				<cfset jstring=jstring & ','>
			</cfif>
		</cfloop>
		<cfset jstring=jstring & '];'>
		<cfset rc.jstring=jstring>

		<cfset rc.PageTitle = "CT Programs" />
		<cfset event.setView("budgetdashboard/dashboard3") />

	</cffunction>

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

</cfcomponent>


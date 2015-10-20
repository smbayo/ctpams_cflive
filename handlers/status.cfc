<cfcomponent displayname="status" output="false">

	<!--- Inject Dependencies --->
	<cfproperty name="userService" inject="model" scope="instance" />
	<cfproperty name="ProposalGateway" inject="model" scope="instance" />
	<cfproperty name="ProposalService" inject="model" scope="instance" />

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" returntype="void" output="false">
		<cfargument name="event" required="true">

		<cfset var rc = event.getCollection() />
		<cfset rc.userProgramID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />
		<cfset rc.userRegionID = getPlugin("SessionStorage").getVar("curUserAuth.categoryID") />
		<cfset rc.implementingPartner = getPlugin("SessionStorage").getVar("curUserAuth.implementingPartner") />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />

			<cfset rc.review = instance.ProposalGateway.getWorkloadSummary(programID=rc.userProgramID,regionID=rc.userRegionID,statusReview="true",sysUserID=rc.sysuserID,implementingPartner=rc.implementingPartner) />
			<cfset rc.cnpending = instance.ProposalGateway.getWorkloadSummary(programID=rc.userProgramID,regionID=rc.userRegionID,statusCN="true",sysUserID=rc.sysuserID,implementingPartner=rc.implementingPartner) />

			<cfset rc.cnworkloadsummary = instance.ProposalGateway.getCNWorkloadSummary(sysUserID=rc.sysuserID,type="clearancepending") />
			<cfset rc.cncongressworkloadsummary = instance.ProposalGateway.getCNWorkloadSummary(sysUserID=rc.sysuserID,type="congresspending") />
			<cfset rc.cnholdwithdrawnworkloadsummary = instance.ProposalGateway.getCNWorkloadSummary(sysUserID=rc.sysuserID,type="holdwithdrawn") />

			<cfset rc.mechanism = instance.ProposalGateway.getWorkloadSummary(programID=rc.userProgramID,regionID=rc.userRegionID,statusFund="true",sysUserID=rc.sysuserID,implementingPartner=rc.implementingPartner) />
			<cfset rc.obstatus = instance.ProposalGateway.getWorkloadSummary(programID=rc.userProgramID,regionID=rc.userRegionID,statusOblig="true",sysUserID=rc.sysuserID,implementingPartner=rc.implementingPartner) />

		<cfset event.setView("status/index")>
	</cffunction>



<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>


</cfcomponent>
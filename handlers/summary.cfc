<cfcomponent displayname="summary" output="false">

	<!--- Inject Dependencies --->
	<cfproperty name="userService" inject="model" scope="instance" />
	<cfproperty name="ProposalGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityExtendedGrantGateway" inject="model" scope="instance" />
	<cfproperty name="activityGateway" inject="model" scope="instance" />
	<cfproperty name="cnGateway" inject="model" scope="instance" />
	<cfproperty name="ProposalService" inject="model" scope="instance" />
	<cfproperty name="MailService" inject="coldbox:plugin:MailService" scope="instance" />
	<cfproperty name="ActivityStatusLogService" inject="model" scope="instance" />
	<cfproperty name="programService" inject="model" scope="instance">

	<!--- <cfproperty name="SessionStorage" type="coldbox:plugin:sessionStorage" scope="instance" /> --->

<!------------------------------------------- PUBLIC EVENTS ------------------------------------------>

	<cffunction name="index" returntype="void" output="false">
		<cfargument name="event" required="true">

		<cfset var rc = event.getCollection() />
		<cfset rc.userProgramID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />
		<cfset rc.userRegionID = getPlugin("SessionStorage").getVar("curUserAuth.categoryID") />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.userRegionList = getPlugin("SessionStorage").getVar("curUserAuth.Categories") />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />


		<cfscript>
			rc.programs = instance.ProgramService.getProgramsQuery();
				if (isnumeric(getPlugin('SessionStorage').getVar('curUserAuth.programid'))) {
					rc.programid = getPlugin('SessionStorage').getVar('curUserAuth.programid');
				}

		</cfscript>

		<!--- get workload summary data --->
		<cfif isUserInRole('has workload')>
			<cfset rc.workloadsummary = instance.ProposalGateway.getWorkloadSummary(programID=rc.userProgramID,regionList=rc.userRegionList,workload="true",sysUserID=rc.sysuserID,rolename=rc.rolename) />
			<!--- <cfif isUserInRole('administer am/cn')> --->
				<cfset rc.cnworkloadsummary = instance.ProposalGateway.getCNWorkloadSummary(programID=rc.userProgramID,regionList=rc.userRegionList,sysUserID=rc.sysuserID,type="clearancepending") />
				<cfset rc.cncongressworkloadsummary = instance.ProposalGateway.getCNWorkloadSummary(programID=rc.userProgramID,regionList=rc.userRegionList,sysUserID=rc.sysuserID,type="congresspending") />
				<cfset rc.cnholdwithdrawnworkloadsummary = instance.ProposalGateway.getCNWorkloadSummary(programID=rc.userProgramID,regionList=rc.userRegionList,sysUserID=rc.sysuserID,type="holdwithdrawn") />
				<cfset rc.ownedprojectsummary = instance.ProposalGateway.getOwnedProjectSummary(sysUserID=rc.sysuserID) />


			<!--- </cfif> --->
		<cfelse>
			<cfset setNextEvent(event='status/index') />
		</cfif>


		<cfset event.setView("summary/index")>
	</cffunction>

	<cffunction name="myprojects" returntype="void" output="false">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection() />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />

		<!--- get workload summary data --->
		<cfif isUserInRole('has workload')>
				<cfset rc.ownedprojectsummary = instance.ProposalGateway.getOwnedProjectSummary(sysUserID=rc.sysuserID) />
		<cfelse>
			<cfset setNextEvent(event='status/index') />
		</cfif>
		<cfset event.setView("summary/myprojects")>
	</cffunction>

	<cffunction name="dashboard" returntype="void" output="false">
		<cfargument name="event" required="true">

		<cfset var rc = event.getCollection() />
		<cfset rc.userProgramID = getPlugin("SessionStorage").getVar("curUserAuth.programID") />
		<cfset rc.userRegionID = getPlugin("SessionStorage").getVar("curUserAuth.categoryID") />
		<cfset rc.sysUserID = getPlugin('SessionStorage').getVar('curUserAuth.sysUserID') />
		<cfset rc.userRegionList = getPlugin("SessionStorage").getVar("curUserAuth.Categories") />
		<cfset rc.roleName = getPlugin('SessionStorage').getVar('curUserAuth.roleName') />


		<cfscript>
			rc.programs = instance.ProgramService.getProgramsQuery();
				if (isnumeric(getPlugin('SessionStorage').getVar('curUserAuth.programid'))) {
					rc.programid = getPlugin('SessionStorage').getVar('curUserAuth.programid');
				}
		</cfscript>

		<!--- get workload summary data --->
		<cfif isUserInRole('has workload')>
			<cfset rc.workloadsummary = instance.ProposalGateway.getWorkloadSummary(programID=rc.userProgramID,regionList=rc.userRegionList,workload="true",sysUserID=rc.sysuserID,rolename=rc.rolename) />
			<cfset rc.cnworkloadsummary = instance.ProposalGateway.getCNWorkloadSummary(programID=rc.userProgramID,sysUserID=rc.sysuserID) />
			<cfset jstring=''>
			<cfset jstring=(jstring & '[')>
			<cfloop query="rc.workloadsummary">
				<cfif progress_status_code is not 0>
					<cfif daysInactive lt 2>
						<cfset inactivePeriod = "1 Day Ago or Less">
					<cfelseif daysInactive lt 8>
						<cfset inactivePeriod = "1 Week Ago or Less">
					<cfelseif daysInactive lt 15>
						<cfset inactivePeriod = "1 to 2 Weeks Ago">
					<cfelse>
						<cfset inactivePeriod = "Over 2 Weeks Ago">
					</cfif>
					<cfif not len(projectAmount)>
						<cfset pAmount = 0>
					<cfelse>
						<cfset pAmount = projectAmount>
					</cfif>
					<cfif not len(implementationStatus)>
						<cfset impStatus = "Not Set">
					<cfelse>
						<cfset impStatus = implementationStatus>
					</cfif>
					<cfif isUserInRole('review activity') and progress_status is 'Funding Fully Obligated'>
						<cfset sectionHead = "Set Implementation Status">
					<cfelseif progress_status is 'Funding Fully Obligated'>
						<cfset sectionHead = "MOU/IAA Modification Clearance Pending">
					<cfelse>
						<cfset sectionHead = progress_status>
					</cfif>
					<cfset jstring=jstring & '{"projectAmount":' & pAmount>
					<cfset jstring=jstring & ',"activityStatus":"' & sectionHead>
					<cfset jstring=jstring & '","program":"' & programName>
					<cfset jstring=jstring & '","activityid":' & activityid>
					<cfset jstring=jstring & ',"proposalnumber":"' & proposalnumber>
					<cfset jstring=jstring & '","projectTitle":"' & projectTitle>
					<cfset jstring=jstring & '","implementationStatus":"' & impStatus>
					<cfset jstring=jstring & '","fundMechName":"' & fundMechName>
					<cfset jstring=jstring & '","inactivePeriod":"' & inactivePeriod>
					<cfset jstring=jstring & '","daysInactive":' & daysInactive>
					<cfset jstring=jstring & '}'>
					<cfif rc.workloadsummary.currentRow lt rc.workloadsummary.recordcount>
						<cfset jstring=jstring & ','>
					</cfif>
				</cfif>
			</cfloop>
			<cfset jstring=jstring & '];'>
			<cfset rc.jstring=jstring>
		<cfelse>
			<cfset setNextEvent(event='status/index') />
		</cfif>

		<cfset event.setView(name='summary/dashboard-responsive')>
	</cffunction>

	<cffunction name="CNActivitylink" returntype="void" output="false">
		<cfargument name="event" required="true">

		<cfset var rc = event.getCollection() />

		<!--- get workload summary data --->
		<!--- <cfif rc.roleName IS "submitter"> --->
		<cfif  structKeyExists(rc,"CNID") and isnumeric(rc.cnid)>
			<cfset rc.getcn = instance.CNGateway.getByAttributesQuery(CNID=rc.CNID) />
	 		<cfset rc.getlinkedcnactivities = instance.CNGateway.getLinkedCNActivities(CNID=rc.CNID) />
			<cfset rc.getpotentialcnactivities = instance.CNGateway.getPotentialCNActivities() />  --->
		<cfelse>
			<cfset setNextEvent(event='summary/index') />
		</cfif>


		<cfset event.setView("summary/cnactivitylink")>
	</cffunction>

	<cffunction name="newCNActivitylink" returntype="void" output="false">
		<cfargument name="event" required="true">

		<cfset var rc = event.getCollection() />


		<!--- get workload summary data --->
		<!--- <cfif rc.roleName IS "submitter"> --->
		<cfset rc.getcn = querynew("cnid, cntitle, cnnumber")>
		<cfset temp = QueryAddRow(rc.getcn)>
		<cfset rc.cnid = 0>
	 	<cfset rc.getlinkedcnactivities  = querynew("activityid, proposalnumber, projecttitle") />
		<cfset rc.getpotentialcnactivities = instance.CNGateway.getPotentialCNActivities() />  --->



		<cfset event.setView("summary/cnactivitylink")>
	</cffunction>

	<cffunction name="saveCNActivityLink" displayname="Save CN Link" output="false" returntype="void">
		<cfargument name="event" required="false" />
		<cfset var rc = event.getCollection()>

		<cfif structKeyExists(rc,"cnID") and isnumeric(rc.cnid) and structKeyExists(rc,"setLinkedActivities")>

			<cfset instance.CNGateway.setLinkedCNs(cnID=rc.cnID,activityList=rc.linkedActivities,cnnumber=rc.cnnumber,cntitle=rc.cntitle) />

			<cfloop list="#rc.linkedActivities#" index="i">
				<cfset var oActivityStatusLog = instance.ActivityStatusLogService.new() />
				<cfset oActivityStatusLog.setActivityID(i) />
				<cfset oActivityStatusLog.setStatusDate(now()) />
				<cfset oActivityStatusLog.setSysUserID(getPlugin('SessionStorage').getVar('curUserAuth.sysUserID')) />
				<cfset oActivityStatusLog.setlogNote('Activities linked to CN ' & rc.cntitle & ': ' & rc.linkedActivities) />
				<cfset oActivityStatusLog.setActivityStatusID(281) />
				<cfset instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog) />
			</cfloop>
		</cfif>



		<cfset setNextEvent(event='summary/index') />


	</cffunction>

</cfcomponent>
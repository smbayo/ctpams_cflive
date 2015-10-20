
<cfcomponent name="ActivityService" output="false">

	<cfproperty name="activityGateway" inject="model" scope="instance" />
	<cfproperty name="activityDAO" inject="model" scope="instance" />
	<cfproperty name="activity" inject="model" scope="instance" />
	<cfproperty name="orgDAO" inject="model" scope="instance" />
	<cfproperty name="org" inject="model" scope="instance" />
	<cfproperty name="categoryDAO" inject="model" scope="instance" />
	<cfproperty name="categoryGateway" inject="model" scope="instance" />


	<cffunction name="init" access="public" output="false" returntype="ActivityService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="Activity">
		<cfset var Activity = instance.Activity.init()>
		<cfreturn Activity />
	</cffunction>

	<cffunction name="createActivity" access="public" output="false" returntype="Activity">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="ParentID" type="numeric" required="false" />
        <cfargument name="resultsFrameworkElementID" type="numeric" required="false" />

		<cfargument name="Name" type="string" required="false" />
    	<!--- <cfargument name="ImplementorOrgID" type="numeric" required="false" />
   		<cfargument name="OrgName" type="string" required="false" /> --->
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="BudgetCeilingAmount" type="numeric" required="false" />
		<cfargument name="Currency" type="string" required="false" />
		<!--- <cfargument name="ContactPersonID" type="numeric" required="false" />
		<cfargument name="ContactPersonFirstName" type="string" required="false" />
		<cfargument name="ContactPersonLastName" type="string" required="false" />
		<cfargument name="ContactPersonEmail" type="string" required="false" />
		<cfargument name="ContactPersonPhone" type="string" required="false" /> --->
		<cfargument name="TotalCostShare" type="numeric" required="false" />
    	<cfargument name="CostShareToDate" type="numeric" required="false" />
    	<cfargument name="lastUpdated" type="date" required="false"  default="#now()#"  />
		<!--- ////////////////////////////////////////////// --->
		<cfargument name="programID" type="numeric" required="false" />
		<cfargument name="programName" type="string" required="false" />
		<cfargument name="projectObjective" type="string" required="false" />
		<cfargument name="interestSpecification" type="string" required="false" />
		<cfargument name="lawEnforcementSpecification" type="string" required="false" />
		<cfargument name="coordinationSpecification" type="string" required="false" />
		<cfargument name="programAudience" type="string" required="false" />
		<cfargument name="fundImpMechanismID" type="numeric" required="false" />
		<cfargument name="fundImpMechanism" type="string" required="false" />
		<cfargument name="activityStatusID" type="numeric" required="false" />
		<cfargument name="ProposalNumber" type="string" required="false" />
		<cfargument name="AMCNnumber" type="string" required="false" />
		<cfargument name="proposalSubmitDate" type="date" required="false" />
		<cfargument name="clearedPrelegalDate" type="date" required="false" />
		<cfargument name="proposalApprovedDate" type="date" required="false" />
		<cfargument name="AMCNBudgetSubmitDate" type="date" required="false" />
		<cfargument name="AMCNCongressSubmitDate" type="date" required="false" />
		<cfargument name="AMCNApprovedDate" type="date" required="false" />
		<cfargument name="FundApprovedDate" type="date" required="false" />
		<cfargument name="BudgetFundRequestDate" type="date" required="false" />
		<cfargument name="BudgetFundApprovalDate" type="date" required="false" />
		<cfargument name="placeOfImplementation" type="string" required="false" />
		<cfargument name="activityStatus" type="string" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="reprogramFunds" type="boolean" required="false" />
		<cfargument name="reprogramComments" type="string" required="false" />
		<cfargument name="lessonsLearned" type="string" required="false" />
		<cfargument name="sustainability" type="string" required="false" />

		<cfset var Activity = createObject("component","Activity").init(argumentCollection=arguments) />
		<!--- <cfset var ActivityOrg = instance.Org.init() />

		<cfset structInsert(Activity,"ImplementerOrg",ActivityOrg)> --->

		<cfreturn Activity />
	</cffunction>

	<cffunction name="getActivity" access="public" output="false" returntype="Activity">
		<cfargument name="ActivityID" type="numeric" required="true" />

		<cfset var Activity = createActivity(argumentCollection=arguments) />

		<cfset instance.ActivityDAO.read(Activity) />

		<!--- <cfset Activity.ImplementerOrg = instance.Org.init(orgID=Activity.getImplementorOrgID())>
		<cfset instance.OrgDAO.read(Activity.ImplementerOrg)> --->

		<cfreturn Activity />
	</cffunction>

	<cffunction name="getParentActivity" access="public" output="false" returntype="Activity">
		<cfargument name="ActivityID" type="numeric" required="true" />

		<cfset var OrigActivity = createActivity(argumentCollection=arguments) />
		<cfset var Activity = createActivity(argumentCollection=arguments) />
		<cfset instance.ActivityDAO.read(OrigActivity) />
		<cfset Activity = OrigActivity.getParentID()>
		<cfset instance.ActivityDAO.read(Activity) />

		<cfreturn Activity />
	</cffunction>

	<cffunction name="getActivityNames" access="public" output="false" returntype="Query" hint="Returns activity IDs and names">
		<cfset var qActivityNamesandIDs = "">

		<cfset qActivityNamesandIDs = instance.ActivityGateway.getNamesandIDs()>
		<cfreturn qActivityNamesandIDs>
	</cffunction>


    <cffunction name="getResultActivityIDs" access="public" output="false" returntype="string">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />


		<cfreturn instance.ActivityGateway.getIDarray(resultsFrameworkElementID=arguments.resultsFrameworkElementID) />
        <cfreturn getResultActivityIDs />
	</cffunction>



    <cffunction name="getActivities" access="public" output="false" returntype="array" hint="Replacement for generated getActivitys method">

	   <cfreturn this.getActivitys(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getActivitys" access="public" output="false" returntype="array">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<!--- <cfargument name="ImplementorOrgID" type="numeric" required="false" /> --->
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="BudgetCeilingAmountDirection" type="string" required="false" />
		<cfargument name="BudgetCeilingAmount" type="numeric" required="false" />
		<cfargument name="Currency" type="string" required="false" />
		<!--- <cfargument name="ContactPersonID" type="numeric" required="false" />
		<cfargument name="ContactPersonName" type="string" required="false" />
		<cfargument name="ContactPersonFirstName" type="string" required="false" />
		<cfargument name="ContactPersonLastName" type="string" required="false" />
		<cfargument name="ContactPersonEmail" type="string" required="false" />
        <cfargument name="ContactPersonPhone" type="string" required="false" /> --->
        <cfargument name="TotalCostShare" type="numeric" required="false" />
		<cfargument name="CostShareToDate" type="numeric" required="false" />

		<cfargument name="programID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />

		<cfargument name="projectObjective" type="string" required="false" />
		<cfargument name="interestSpecification" type="string" required="false" />
		<cfargument name="lawEnforcementSpecification" type="string" required="false" />
		<cfargument name="coordinationSpecification" type="string" required="false" />
		<cfargument name="programAudience" type="string" required="false" />
		<cfargument name="fundImpMechanismID" type="numeric" required="false" />
		<cfargument name="fundImpMechanism" type="string" required="false" />
		<cfargument name="ActivityStatusID" type="numeric" required="false" />
		<cfargument name="ProposalNumber" type="string" required="false" />
		<cfargument name="AMCNnumber" type="string" required="false" />
		<cfargument name="proposalSubmitDate" type="date" required="false" />
		<cfargument name="clearedPrelegalDate" type="date" required="false" />
		<cfargument name="proposalApprovedDate" type="date" required="false" />
		<cfargument name="AMCNBudgetSubmitDate" type="date" required="false" />
		<cfargument name="AMCNCongressSubmitDate" type="date" required="false" />
		<cfargument name="AMCNApprovedDate" type="date" required="false" />
		<cfargument name="FundApprovedDate" type="date" required="false" />
		<cfargument name="BudgetFundRequestDate" type="date" required="false" />
		<cfargument name="BudgetFundApprovalDate" type="date" required="false" />
		<cfargument name="placeOfImplementation" type="string" required="false" />
		<cfargument name="orderBy" type="string" required="false" default="name" />
		<cfargument name="likeSearchTerms" type="string" required="false" />

		<cfreturn instance.ActivityGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getActivitysQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />

		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<!--- <cfargument name="ImplementorOrgID" type="numeric" required="false" /> --->
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
	    <cfargument name="StartMonthFrom" type="string" required="false" />
	    <cfargument name="StartYearFrom" type="string" required="false" />
	    <cfargument name="StartMonthTo" type="string" required="false" />
	    <cfargument name="StartYearTo" type="string" required="false" />
	    <cfargument name="EndMonthFrom" type="string" required="false" />
	    <cfargument name="EndYearFrom" type="string" required="false" />
	    <cfargument name="EndMonthTo" type="string" required="false" />
	    <cfargument name="EndYearTo" type="string" required="false" />
	    <cfargument name="StartDate" type="date" required="false" />
	    <cfargument name="EndDate" type="date" required="false" />
		<cfargument name="BudgetCeilingAmountDirection" type="string" required="false" />
		<cfargument name="BudgetCeilingAmount" type="numeric" required="false" />
		<cfargument name="Currency" type="string" required="false" />
		<!--- <cfargument name="ContactPersonID" type="numeric" required="false" />
		<cfargument name="ContactPersonName" type="string" required="false" />
		<cfargument name="ContactPersonFirstName" type="string" required="false" />
		<cfargument name="ContactPersonLastName" type="string" required="false" />
		<cfargument name="ContactPersonEmail" type="string" required="false" />
        <cfargument name="ContactPersonPhone" type="string" required="false" /> --->
        <cfargument name="TotalCostShare" type="numeric" required="false" />
	    <cfargument name="CostShareToDate" type="numeric" required="false" />
	    <cfargument name="Location" type="numeric" required="false" />
	    <cfargument name="Sector" type="numeric" required="false" />
	    <cfargument name="GrantType" type="string" required="false" />
	    <cfargument name="Status" type="string" required="false" />

		<cfargument name="programID" type="numeric" required="false" />
		<cfargument name="projectObjective" type="string" required="false" />
		<cfargument name="interestSpecification" type="string" required="false" />
		<cfargument name="lawEnforcementSpecification" type="string" required="false" />
		<cfargument name="coordinationSpecification" type="string" required="false" />
		<cfargument name="programAudience" type="string" required="false" />
		<cfargument name="fundImpMechanismID" type="numeric" required="false" />
		<cfargument name="fundImpMechanism" type="string" required="false" />
		<cfargument name="ActivityStatusID" type="numeric" required="false" />
		<cfargument name="ProposalNumber" type="string" required="false" />
		<cfargument name="AMCNnumber" type="string" required="false" />
		<cfargument name="proposalSubmitDate" type="date" required="false" />
		<cfargument name="clearedPrelegalDate" type="date" required="false" />
		<cfargument name="proposalApprovedDate" type="date" required="false" />
		<cfargument name="AMCNBudgetSubmitDate" type="date" required="false" />
		<cfargument name="AMCNCongressSubmitDate" type="date" required="false" />
		<cfargument name="AMCNApprovedDate" type="date" required="false" />
		<cfargument name="FundApprovedDate" type="date" required="false" />
		<cfargument name="BudgetFundRequestDate" type="date" required="false" />
		<cfargument name="BudgetFundApprovalDate" type="date" required="false" />
		<cfargument name="implementingPartner" type="numeric" required="false" />
		<cfargument name="reprogramFunds" type="boolean" required="false" />

		<cfargument name="reprogramComments" type="string" required="false" />
		<cfargument name="ctex" type="boolean" required="false" />

		<cfargument name="orderBy" type="string" required="false" default="name" />
		<cfargument name="likeSearchTerms" type="string" required="false" />
		<cfargument name="fiscalYear" type="numeric" required="false" />




		<cfreturn instance.ActivityGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivity" access="public" output="false" returntype="numeric">
		<cfargument name="Activity" type="Activity" required="true" />

		<cfreturn instance.ActivityDAO.save(Activity) />
	</cffunction>

	<cffunction name="deleteActivity" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />

		<cfset var Activity = createActivity(argumentCollection=arguments) />
		<cfreturn instance.ActivityDAO.delete(Activity) />
	</cffunction>

	<cffunction name="getAllSectors" access="public" output="false" returntype="query">

	    <cfset var qSectors = "" />
	    <cfset qSectors = instance.categoryGateway.getByAttributesQuery(parentid=1,orderby="name")>

	    <cfreturn qSectors />
	</cffunction>

	<cffunction name="getAllTypes" access="public" output="false" returntype="query">

	    <cfset var qTypes = "" />

	    <cfset qTypes = instance.categoryGateway.getByAttributesQuery(parentid=21,orderby="name")>

	    <cfreturn qTypes />
    </cffunction>

    <cffunction name="getAllCurrencies" access="public" output="false" returntype="query">

		<cfset var qCurrency = "" />
		<cfset qCurrency = instance.categoryGateway.getByAttributesQuery(parentid=24,orderby="name")>

		<cfreturn qCurrency />
    </cffunction>

    <cffunction name="getMeasurements" access="public" output="false" returntype="Query">
	   <cfargument name="activityid" type="numeric" required="true">

	   <cfset var qMeasurements = "" />
	   <cfset qMeasurements = instance.activityGateway.getMeasurements(activityid=arguments.activityid)>

	   <cfreturn qMeasurements>
    </cffunction>

  	<cffunction name="getLastUpdated" access="public" output="false" returntype="Query">
	   <cfargument name="toplimit" type="numeric" required="true">

	   <cfset var qGrants = "" />
	   <cfset qGrants = instance.activityGateway.getLastUpdated(toplimit=arguments.toplimit)>

	   <cfreturn qGrants>
  	</cffunction>

	<cffunction name="reportIndicatorsToDate" access="public" output="false" returntype="query" hint="Returns Report data for Indicators to Date">

		<cfreturn measurementRollupByGrant() />

	</cffunction>

	<cffunction name="getGrantsList" access="public" output="false" returntype="query" hint="Returns list of Grants for Measurement Rollup for a Grant">

		<cfset var qListGrants = "">

		<cfset qListGrants = instance.ActivityGateway.getGrantsList()>

		<cfreturn qListGrants>

	</cffunction>

	<cffunction name="getGrantName" access="public" output="false" returntype="query">

		<cfreturn instance.ActivityDAO.getGrantName() />

	</cffunction>

	<cffunction name="measurementRollupByGrant" access="public" output="false" returntype="query" hint="Returns Report data for Measurement Rollup for a Grant">

		<cfargument name="activityID" default="0" type="numeric" />

		<cfset qRollup = instance.ActivityGateway.measurementRollupByGrant(arguments.activityID)>

		<cfreturn qRollup>

	</cffunction>

	<cffunction name="getSectorBudgets" access="public" output="false" returntype="query" hint="Returns Report data for Sector budget report">
		<cfargument name="filter" hint="list of allowed values. Currently only 'active' is supported. If omitted or empty,'active' is applied." type="string" default="active" allowedValues="active" />
		<cfif not listfindnocase(getmetadata(this.getSectorBudgets).parameters[1].allowedvalues,arguments.filter)>
			<cfthrow type="IndexOutOfRange" message="The argument filter accepts only values in the list:" />
		</cfif>


		<cfreturn instance.ActivityGateway.getSectorBudgets(arguments.filter) />

	</cffunction>

    <cffunction name="getGranteesByOrgType" access="public" output="false" returntype="Query">

		<cfset var qGranteesByOrgType = "">

		<cfset qGranteesByOrgType = instance.ActivityGateway.getGranteesByOrgType()>

		<cfreturn qGranteesByOrgType>

	</cffunction>

    <cffunction name="getActiveGranteesByOrgType" access="public" output="false" returntype="Query">

		<cfset var qActiveGranteesByOrgType = "">

		<cfset qActiveGranteesByOrgType = instance.ActivityGateway.getActiveGranteesByOrgType()>

		<cfreturn qActiveGranteesByOrgType>

	</cffunction>

    <cffunction name="getPastGranteesByOrgType" access="public" output="false" returntype="Query">

		<cfset var qPastGranteesByOrgType = "">

		<cfset qPastGranteesByOrgType = instance.ActivityGateway.getPastGranteesByOrgType()>

		<cfreturn qPastGranteesByOrgType>

	</cffunction>

    <cffunction name="getFutureGranteesByOrgType" access="public" output="false" returntype="Query">

		<cfset var qFutureGranteesByOrgType = "">

		<cfset qFutureGranteesByOrgType = instance.ActivityGateway.getFutureGranteesByOrgType()>

		<cfreturn qFutureGranteesByOrgType>

	</cffunction>

    <cffunction name="getGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qGrantsByOrgType = "">

        <cfset qGrantsByOrgType = instance.ActivityGateway.getGrantsByOrgType()>

        <cfreturn qGrantsByOrgType>

    </cffunction>

    <cffunction name="getActiveGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qActiveGrantsByOrgType = "">

        <cfset qActiveGrantsByOrgType = instance.ActivityGateway.getActiveGrantsByOrgType()>

        <cfreturn qActiveGrantsByOrgType>

    </cffunction>

    <cffunction name="getPastGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qPastGrantsByOrgType = "">

        <cfset qPastGrantsByOrgType = instance.ActivityGateway.getPastGrantsByOrgType()>

        <cfreturn qPastGrantsByOrgType>

    </cffunction>

    <cffunction name="getFutureGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qFutureGrantsByOrgType = "">

        <cfset qFutureGrantsByOrgType = instance.ActivityGateway.getFutureGrantsByOrgType()>

        <cfreturn qFutureGrantsByOrgType>

    </cffunction>

    <cffunction name="getGrantsByType" access="public" output="false" returntype="Query">
		<cfargument name="LegalRegistrationStatus" required="yes" type="string">
		<cfargument name="GranteeType" required="yes" type="string">
		<cfargument name="Active" required="yes" type="string">

		<cfset var qGrantsList = "">

		<cfset qGrantsList = instance.ActivityGateway.getGrantsByType(LegalRegistrationStatus=arguments.LegalRegistrationStatus, GranteeType=arguments.GranteeType, Active=arguments.Active)>

		<cfreturn qGrantsList>

	</cffunction>

	<cffunction name="getActivityStatus" access="public" output="false" returntype="query">

		<cfargument name="activityStatusCode" default="0" type="numeric" />
		<cfargument name="isActive" default="0" type="numeric" />
		<cfargument name="proposalSubmitDate" type="string" />
		<cfargument name="proposalApprovedDate" type="string" />
		<cfargument name="AMCNCongressSubmitDate" type="string" />
		<cfargument name="AMCNApprovedDate" type="string" />
		<cfargument name="implementationStatus" type="string" />



		<cfset var progressStatus = "" />
		<cfset var progressAge = 0>
		<cfif arguments.implementationStatus is "CN Partial Hold" and not arguments.activityStatusCode is 220>
			<cfset progressStatus = "CN Partial Hold">
		<cfelseif arguments.implementationStatus is "CN Re-notification" and not arguments.activityStatusCode is 220>
			<cfset progressStatus = "CN Re-notification">
		<cfelseif arguments.implementationStatus is "MOU Modification" and not arguments.activityStatusCode is 220>
			<cfset progressStatus = "MOU Modification">
		<cfelse>
			<cfswitch expression="#arguments.activityStatusCode#">
					<cfcase value="100">
						<cfset progressStatus = "Proposal In-progress">
					</cfcase>
					<cfcase value="180">
						<cfset progressStatus = "Regional Review Pending">
					</cfcase>
					<cfcase value="200,201,202,203,205,206" delimiters=",">
						<cfset progressStatus = "Proposal Review Pending">
						<cfif len(arguments.proposalSubmitDate)>
							<cfset progressAge = DateDiff("d", arguments.proposalSubmitDate, now() ) />
						<cfelse>
							<cfset progressAge = 0 />
						</cfif>
					</cfcase>
					<cfcase value="210">
						<cfset progressStatus = "Proposal On-hold">
					</cfcase>
					<cfcase value="220">
						<cfset progressStatus = "Proposal Denied">
					</cfcase>
					<cfcase value="250">
						<cfset progressStatus = "Proposal Re-Activated">
					</cfcase>
					<cfcase value="300,301,302,303,305,306" delimiters=",">
						<cfset progressStatus = "CN Clearance Pending">
						<cfset progressAge = DateDiff("d", arguments.proposalApprovedDate, now() ) />
					</cfcase>
					<cfcase value="307,308" delimiters=",">
						<cfset progressStatus = "CN Congressional Approval Pending">
						<cfset progressAge = DateDiff("d", arguments.AMCNCongressSubmitDate, now() ) />
					</cfcase>
					<cfcase value="310">
						<cfset progressStatus = "CN On-hold" />
					</cfcase>
					<cfcase value="320">
						<cfset progressStatus = "CN Denied" />
					</cfcase>
					<cfcase value="330">
						<cfset progressStatus = "CN Withdrawn" />
					</cfcase>
					<cfcase value="350">
						<cfset progressStatus = "CN Re-Activated" />
					</cfcase>
					<cfcase value="400,401,402" delimiters=",">
						<cfset progressStatus = "Funding/Implementation Clearance Pending" />
						<cfset progressAge = DateDiff("d", arguments.AMCNApprovedDate, now() ) />
					</cfcase>
					<cfcase value="410">
						<cfset progressStatus = "Program Funding On-hold" />
					</cfcase>
					<cfcase value="420">
						<cfset progressStatus = "Program Funding Denied" />
					</cfcase>
					<cfcase value="500">
						<cfset progressStatus = "Program Funding Approved" />
					</cfcase>
					<cfcase value="510">
						<cfset progressStatus = "Program On-hold" />
					</cfcase>
					<cfcase value="550">
						<cfset progressStatus = "Program Reactivated" />
					</cfcase>
						<cfcase value="600">
						<cfset progressStatus = "Program Fully Obligated" />
					</cfcase>
					<cfdefaultcase>
						<cfset progressStatus = "Program Closed" />
					</cfdefaultcase>
				</cfswitch>
			</cfif>

			<cfif arguments.isactive is 0>
				<cfset progressStatus = "DELETED" />
			</cfif>

		<cfset progressStatusQ = queryNew("activityStatus,activityAge")>
		<cfset newRow = queryAddRow(progressStatusQ)>
		<cfset newCell = querySetCell(progressStatusQ,"activityStatus",#progressStatus#)>
		<cfset newCell = querySetCell(progressStatusQ,"activityAge",#progressAge#)>

		<cfreturn progressStatusQ>

	</cffunction>

</cfcomponent>

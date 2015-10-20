
<cfcomponent displayname="Activity" output="false">

		<cfproperty name="ActivityID" type="numeric" default="" />
		<cfproperty name="ParentID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
    	<!--- <cfproperty name="ImplementorOrgID" type="numeric" default="" />
   		<cfproperty name="OrgName" type="string" default="" /> --->
		<cfproperty name="Description" type="string" default="" />
		<cfproperty name="ExternalCode" type="string" default="" />
		<cfproperty name="ExternalCodeDescription" type="string" default="" />
		<cfproperty name="StartDate" type="date" default="" />
		<cfproperty name="EndDate" type="date" default="" />
		<cfproperty name="BudgetCeilingAmount" type="numeric" default="" />
		<cfproperty name="Currency" type="string" default="" />
		<!---
		<cfproperty name="ContactPersonID" type="numeric" default="" />
		<cfproperty name="ContactPersonFirstName" type="string" default="" />
		<cfproperty name="ContactPersonLastName" type="string" default="" />
		<cfproperty name="ContactPersonEmail" type="string" default="" />
        <cfproperty name="ContactPersonPhone" type="string" default="" />
		 --->
        <cfproperty name="TotalCostShare" type="numeric" default="" />
    	<cfproperty name="CostShareToDate" type="numeric" default="" />
    	<cfproperty name="lastUpdated" type="date" default="" />
		<!--- ////////////////////////////////////////////// --->
		<cfproperty name="programID" type="numeric" required="false" />
		<cfproperty name="programName" type="string" required="false" />
		<cfproperty name="projectObjective" type="string" required="false" />
		<cfproperty name="interestSpecification" type="string" required="false" />
		<cfproperty name="lawEnforcementSpecification" type="string" required="false" />
		<cfproperty name="coordinationSpecification" type="string" required="false" />
		<cfproperty name="programAudience" type="string" required="false" />
		<cfproperty name="fundImpMechanismID" type="numeric" required="false" />
		<cfproperty name="fundImpMechanism" type="string" required="false" />
		<cfproperty name="activityStatusID" type="numeric" required="false" />
		<cfproperty name="activityStatus" type="string" required="false" />
		<cfproperty name="ProposalNumber" type="string" default="" />
		<cfproperty name="AMCNnumber" type="string" default="" />
		<cfproperty name="proposalSubmitDate" type="date" default="" />
		<cfproperty name="clearedPrelegalDate" type="date" default="" />
		<cfproperty name="proposalApprovedDate" type="date" default="" />
		<cfproperty name="AMCNBudgetSubmitDate" type="date" default="" />
		<cfproperty name="AMCNCongressSubmitDate" type="date" default="" />
		<cfproperty name="AMCNApprovedDate" type="date" default="" />
		<cfproperty name="FundApprovedDate" type="date" default="" />
		<cfproperty name="BudgetFundRequestDate" type="date" default="" />
		<cfproperty name="BudgetFundApprovalDate" type="date" default="" />
		<cfproperty name="placeOfImplementation" type="string" default="" />
		<cfproperty name="projectCountries" type="string" default="" />
		<cfproperty name="projectRegions" type="string" default="" />
		<cfproperty name="projectOrganizations" type="string" default="" />
		<cfproperty name="projectFundingSources" type="string" default="" />
		<cfproperty name="isActive" type="boolean" required="false" />
		<cfproperty name="sysUserID" type="numeric" required="false" />
		<cfproperty name="fiscalYear" type="numeric" required="false" />
		<cfproperty name="implementingPartner" type="numeric" required="false" />
		<cfproperty name="reprogramFunds" type="boolean" required="false" default="0" />
		<cfproperty name="ctex" type="boolean" required="false" default="0" />
		<cfproperty name="reprogramComments" type="string" default="" />
		<cfproperty name="lessonsLearned" type="string" default="" />
		<cfproperty name="sustainability" type="string" default="" />
		<cfproperty name="cnID" type="numeric" default="" />
		<cfproperty name="cnTitle" type="string" default="" />
		<cfproperty name="cityProvince" type="string" default="" />
		<cfproperty name="relatedProjects" type="string" default="" />
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Activity" output="false">
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="ParentID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<!--- <cfargument name="ImplementorOrgID" type="string" required="false" default="" />
    	<cfargument name="OrgName" type="string" required="false" default="" /> --->
    	<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="ExternalCode" type="string" required="false" default="" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" default="" />
		<cfargument name="StartDate" type="string" required="false" default="" />
		<cfargument name="EndDate" type="string" required="false" default="" />
		<cfargument name="BudgetCeilingAmount" type="string" required="false" default="" />
		<cfargument name="Currency" type="string" required="false" default="" />
		<!--- <cfargument name="ContactPersonID" type="string" required="false" default="" />
		<cfargument name="ContactPersonFirstName" type="string" required="false" default="" />
		<cfargument name="ContactPersonLastName" type="string" required="false" default="" />
		<cfargument name="ContactPersonEmail" type="string" required="false" default="" />
        <cfargument name="ContactPersonPhone" type="string" required="false" default="" /> --->
        <cfargument name="TotalCostShare" type="string" required="false" default="" />
    	<cfargument name="CostShareToDate" type="string" required="false" default="" />
    	<cfargument name="lastUpdated" type="string" required="false" default="" />
		<!--- ////////////////////////////////////////////// --->
		<cfargument name="programID" type="string" required="false" default="" />
		<cfargument name="programName" type="string" required="false" default="" />
		<cfargument name="projectObjective" type="string" required="false" default="" />
		<cfargument name="interestSpecification" type="string" required="false" default="" />
		<cfargument name="lawEnforcementSpecification" type="string" required="false" default="" />
		<cfargument name="coordinationSpecification" type="string" required="false" default="" />
		<cfargument name="programAudience" type="string" required="false" default="" />
		<cfargument name="fundImpMechanismID" type="string" required="false" default="" />
		<cfargument name="fundImpMechanism" type="string" required="false" default="" />
		<cfargument name="activityStatusID" type="string" required="false" default="" />
		<cfargument name="aactivityStatus" type="string" required="false" default="" />
		<cfargument name="ProposalNumber" type="string" required="false" default="" />
		<cfargument name="AMCNnumber" type="string" required="false" default="" />
		<cfargument name="proposalSubmitDate" type="string" required="false" default="" />
		<cfargument name="clearedPrelegalDate" type="string" required="false" default="" />
		<cfargument name="proposalApprovedDate" type="string" required="false" default="" />
		<cfargument name="AMCNBudgetSubmitDate" type="string" required="false" default="" />
		<cfargument name="AMCNCongressSubmitDate" type="string" required="false" default="" />
		<cfargument name="AMCNApprovedDate" type="string" required="false" default="" />
		<cfargument name="FundApprovedDate" type="string" required="false" default="" />
		<cfargument name="BudgetFundRequestDate" type="string" required="false" default="" />
		<cfargument name="BudgetFundApprovalDate" type="string" required="false" default="" />
		<cfargument name="placeOfImplementation" type="string" required="false" default="" />
		<cfargument name="projectCountries" type="string" required="false" default="" />
		<cfargument name="projectRegions" type="string" required="false" default="" />
		<cfargument name="projectFundingSources" type="string" required="false" default="" />
		<cfargument name="isActive" type="string" required="false" default="" />
		<cfargument name="sysUserID" type="string" required="false" default="" />
		<cfargument name="fiscalYear" type="string" required="false" default="" />
		<cfargument name="implementingPartner" type="string" required="false" default="" />
		<cfargument name="reprogramFunds" type="string" required="false" default="0" />
		<cfargument name="ctex" type="string" required="false" default="0" />
		<cfargument name="reprogramComments" type="string" required="false" default="" />
		<cfargument name="lessonsLearned" type="string" required="false" default="" />
		<cfargument name="sustainability" type="string" required="false" default="" />
		<cfargument name="cnID" type="string" required="false" default="" />
		<cfargument name="cnTitle" type="string" required="false" default="" />
		<cfargument name="cityProvince" type="string" required="false" default="" />
		<cfargument name="relatedProjects" type="string" required="false" default="" />


		<!--- run setters --->
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setParentID(arguments.ParentID) />
		<cfset setName(arguments.Name) />
		<!--- <cfset setImplementorOrgID(arguments.ImplementorOrgID) />
    	<cfset setOrgName(arguments.OrgName) /> --->
    	<cfset setDescription(arguments.Description) />
		<cfset setExternalCode(arguments.ExternalCode) />
		<cfset setExternalCodeDescription(arguments.ExternalCodeDescription) />
		<cfset setStartDate(arguments.StartDate) />
		<cfset setEndDate(arguments.EndDate) />
		<cfset setBudgetCeilingAmount(arguments.BudgetCeilingAmount) />
		<cfset setCurrency(arguments.Currency) />
		<!--- <cfset setContactPersonID(arguments.ContactPersonID) />
		<cfset setContactPersonFirstName(arguments.ContactPersonFirstName) />
		<cfset setContactPersonLastName(arguments.ContactPersonLastName) />
		<cfset setContactPersonEmail(arguments.ContactPersonEmail) />
        <cfset setContactPersonPhone(arguments.ContactPersonPhone) /> --->
        <cfset setTotalCostShare(arguments.TotalCostShare) />
    	<cfset setCostShareToDate(arguments.CostShareToDate) />
    	<cfset setlastUpdated(arguments.lastUpdated) />
		<!--- ////////////////////////////////////////////// --->
		<cfset setprogramID(arguments.programID) />
		<cfset setprogramName(arguments.programName) />
		<cfset setprojectObjective(arguments.projectObjective) />
		<cfset setinterestSpecification(arguments.interestSpecification) />
		<cfset setlawEnforcementSpecification(arguments.lawEnforcementSpecification) />
		<cfset setcoordinationSpecification(arguments.coordinationSpecification) />
		<cfset setprogramAudience(arguments.programAudience) />
		<cfset setfundImpMechanismID(arguments.fundImpMechanismID) />
		<cfset setfundImpMechanism(arguments.fundImpMechanism) />
		<cfset setactivityStatusID(arguments.activityStatusID) />
		<cfset setaactivityStatus(arguments.aactivityStatus) />
		<cfset setProposalNumber(arguments.ProposalNumber) />
		<cfset setAMCNnumber(arguments.AMCNnumber) />
		<cfset setproposalSubmitDate(arguments.proposalSubmitDate) />
		<cfset setclearedPrelegalDate(arguments.clearedPrelegalDate) />
		<cfset setproposalApprovedDate(arguments.proposalApprovedDate) />
		<cfset setAMCNBudgetSubmitDate(arguments.AMCNBudgetSubmitDate) />
		<cfset setAMCNCongressSubmitDate(arguments.AMCNCongressSubmitDate) />
		<cfset setAMCNApprovedDate(arguments.AMCNApprovedDate) />
		<cfset setFundApprovedDate(arguments.FundApprovedDate) />
		<cfset setBudgetFundRequestDate(arguments.BudgetFundRequestDate) />
		<cfset setBudgetFundApprovalDate(arguments.BudgetFundApprovalDate) />
		<cfset setplaceOfImplementation(arguments.placeOfImplementation) />
		<cfset setprojectCountries(arguments.projectCountries) />
		<cfset setprojectRegions(arguments.projectRegions) />
		<cfset setprojectFundingSources(arguments.projectFundingSources) />
		<cfset setisActive(arguments.isActive) />
		<cfset setsysUserID(arguments.sysUserID) />
		<cfset setimplementingPartner(arguments.implementingPartner) />
 		<cfset setreprogramFunds(arguments.reprogramFunds) />
		<cfset setctex(arguments.ctex) />
		<cfset setreprogramComments(arguments.reprogramComments) />
		<cfset setfiscalYear(arguments.fiscalYear) />
		<cfset setlessonsLearned(arguments.lessonsLearned) />
		<cfset setsustainability(arguments.sustainability) />
		<cfset setcnID(arguments.cnID) />
		<cfset setcnTitle(arguments.cnTitle) />
		<cfset setcityProvince(arguments.cityProvince) />
		<cfset setrelatedProjects(arguments.relatedProjects) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Activity" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="array" output="true">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />

		<!--- Name --->
		<cfif (len(trim(getName())) AND NOT IsSimpleValue(trim(getName())))>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Title is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) GT 255)>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Title is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- Description --->
		<cfif (len(trim(getDescription())) AND NOT IsSimpleValue(trim(getDescription())))>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Description is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDescription())) GT 4000)>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Description is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- StartDate --->
		<cfif (len(trim(getStartDate())) AND NOT isDate(trim(getStartDate())))>
			<cfset thisError.field = "StartDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Start Date is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset startdatevalid = 0>
		<cfelseif (len(trim(getStartDate())) AND isDate(trim(getStartDate())))>
			<cfset startdatevalid = 1>
		<cfelseif NOT len(trim(getStartDate())) >
			<cfset startdatevalid = 0>
		</cfif>

		<!--- EndDate --->
		<cfif (len(trim(getEndDate())) AND NOT isDate(trim(getEndDate())))>
			<cfset thisError.field = "EndDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "End Date is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset enddatevalid = 0>
		<cfelseif (len(trim(getEndDate())) AND isDate(trim(getEndDate())))>
			<cfset enddatevalid = 1>
		<cfelseif NOT len(trim(getEndDate())) >
			<cfset enddatevalid = 0>
		</cfif>

		<!--- Enforce start date is equal or prior to end date --->
		<cfif startdatevalid gt 0 and enddatevalid gt 0>
			<cfif datecompare(getStartDate(),getEndDate()) gt 0>
				<cfset thisError.field = "StartDate" />
				<cfset thisError.type = "invalidType" />
				<cfset thisError.message = "Start Date has to be before End Date" />
				<cfset arrayAppend(errors,duplicate(thisError)) />
			</cfif>
		</cfif>

		<!--- BudgetCeilingAmount --->
		<!--- use rereplace here --->
		<!---Dollor amount = ^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$ --->
		<!--- REReplace(getBudgetCeilingAmount(),",","","all")  --->
		<cfset setBudgetCeilingAmount( REReplace(getBudgetCeilingAmount(),",","","all") ) />
		<cfif (len(trim(getBudgetCeilingAmount())) AND NOT isNumeric(trim(getBudgetCeilingAmount())))>
			<cfset thisError.field = "FundingAmount" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Funding Amount is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- /////////////////////////// --->
		<!--- programID --->
		<!--- <cfif (len(trim(getprogramID())) AND NOT isNumeric(trim(getprogramID())))>
			<cfset thisError.field = "programID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "programID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- projectObjective --->
		<cfif (len(trim(getprojectObjective())) AND NOT IsSimpleValue(trim(getprojectObjective())))>
			<cfset thisError.field = "projectObjective" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project objective is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getprojectObjective())) GT 1000)>
			<cfset thisError.field = "projectObjective" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project objective is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- interestSpecification --->
		<cfif (len(trim(getinterestSpecification())) AND NOT IsSimpleValue(trim(getinterestSpecification())))>
			<cfset thisError.field = "interestSpecification" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "US security interest specification is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getinterestSpecification())) GT 1000)>
			<cfset thisError.field = "interestSpecification" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "US security interest specification is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- lawEnforcementSpecification --->
		<cfif (len(trim(getlawEnforcementSpecification())) AND NOT IsSimpleValue(trim(getlawEnforcementSpecification())))>
			<cfset thisError.field = "lawEnforcementSpecification" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Law enforcement specification is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getlawEnforcementSpecification())) GT 1000)>
			<cfset thisError.field = "lawEnforcementSpecification" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Law enforcement specification is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- coordinationSpecification --->
		<cfif (len(trim(getcoordinationSpecification())) AND NOT IsSimpleValue(trim(getcoordinationSpecification())))>
			<cfset thisError.field = "coordinationSpecification" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Coordination specification is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getcoordinationSpecification())) GT 4000)>
			<cfset thisError.field = "coordinationSpecification" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Coordination specification is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- programAudience --->
		<cfif (len(trim(getprogramAudience())) AND NOT IsSimpleValue(trim(getprogramAudience())))>
			<cfset thisError.field = "programAudience" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Program audience is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getprogramAudience())) GT 255)>
			<cfset thisError.field = "programAudience" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Program audience is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- fundImpMechanismID --->
		<!--- <cfif (len(trim(getfundImpMechanismID())) AND NOT isNumeric(trim(getfundImpMechanismID())))>
			<cfset thisError.field = "fundImpMechanismID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Funding implementation mechanism is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- activityStatusID --->
		<!---
		<cfif (len(trim(getactivityStatusID())) AND NOT isNumeric(trim(getactivityStatusID())))>
			<cfset thisError.field = "activityStatusID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Activity StatusID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		 --->

		<!--- ProposalNumber --->
		<!--- <cfif (len(trim(getProposalNumber())) AND NOT IsSimpleValue(trim(getProposalNumber())))>
			<cfset thisError.field = "ProposalNumber" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ProposalNumber is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getProposalNumber())) GT 50)>
			<cfset thisError.field = "ProposalNumber" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ProposalNumber is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- Place of Implementation --->
<!--- 		<cfif (len(trim(getplaceOfImplementation())) AND NOT IsSimpleValue(trim(getplaceOfImplementation())))>
			<cfset thisError.field = "placeOfImplementation" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Place of implementation is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getplaceOfImplementation())) GT 25)>
			<cfset thisError.field = "placeOfImplementation" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Place of implementation is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getplaceOfImplementation())) AND trim(getplaceOfImplementation()) IS 'Country' )>
			<cfif NOT len(trim(getprojectCountries()))>
				<cfset thisError.type = "invalidType" />
				<cfset thisError.message = "Place of implementation selected is countries - no country selected." />
				<cfset arrayAppend(errors,duplicate(thisError)) />
				<cfset thisError.field = "placeOfImplementation" />
			</cfif>
		</cfif>
		<cfif (len(trim(getplaceOfImplementation())) AND trim(getplaceOfImplementation()) IS 'Region' )>
			<cfif NOT len(trim(getprojectRegions()))>
				<cfset thisError.type = "invalidType" />
				<cfset thisError.message = "Place of implementation selected is regions - no region selected." />
				<cfset arrayAppend(errors,duplicate(thisError)) />
				<cfset thisError.field = "placeOfImplementation" />
			</cfif>
		</cfif> --->



		<cfreturn errors />
	</cffunction>

	<cffunction name="validateSums" access="public" returntype="array" output="true">
		<cfargument name="budgetSum" type="string" required="true" />
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />



		<!--- BudgetCeilingAmount --->
		<!--- use rereplace here --->
		<!---Dollor amount = ^\$?(\d{1,3}(\,\d{3})*|(\d+))(\.\d{2})?$ --->
		<!--- REReplace(getBudgetCeilingAmount(),",","","all")  --->
		<cfset setBudgetCeilingAmount( REReplace(getBudgetCeilingAmount(),",","","all") ) />
		<cfif (len(trim(getBudgetCeilingAmount())) AND isNumeric(trim(getBudgetCeilingAmount())) and getBudgetCeilingAmount() lt arguments.budgetSum)>
			<cfset thisError.field = "FundingAmount" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Sum of funding breakdown items must not exceed Funding Amount Requested" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<cfreturn errors />
	</cffunction>

	<cffunction name="validateSubmit" access="public" returntype="array" output="true">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />

		<!--- ActivityID
		<cfif (NOT len(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ActivityID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getActivityID())) AND NOT isNumeric(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- ParentID --->
		<!--- <cfif (len(trim(getParentID())) AND NOT isNumeric(trim(getParentID())))>
			<cfset thisError.field = "ParentID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ParentID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- Name --->
		<cfif NOT len(trim(getName()))>
			<cfset thisError.field = "ProjectTitle" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project Title is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- ImplementorOrgID --->
		<!--- <cfif (len(trim(getImplementorOrgID())) AND NOT isNumeric(trim(getImplementorOrgID())))>
			<cfset thisError.field = "ImplementorOrgID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ImplementorOrgID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- Description --->
		<cfif NOT len(trim(getDescription()))>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Description is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDescription())) LT 300)>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "tooShort" />
			<cfset thisError.message = "Description is too short - must be at least 300 characters" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- ExternalCode --->
		<!--- <cfif (len(trim(getExternalCode())) AND NOT IsSimpleValue(trim(getExternalCode())))>
			<cfset thisError.field = "ExternalCode" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ExternalCode is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getExternalCode())) GT 255)>
			<cfset thisError.field = "ExternalCode" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ExternalCode is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- ExternalCodeDescription --->
		<!--- <cfif (len(trim(getExternalCodeDescription())) AND NOT IsSimpleValue(trim(getExternalCodeDescription())))>
			<cfset thisError.field = "ExternalCodeDescription" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ExternalCodeDescription is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getExternalCodeDescription())) GT 255)>
			<cfset thisError.field = "ExternalCodeDescription" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ExternalCodeDescription is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- StartDate --->
		<cfif NOT len(trim(getStartDate()))>
			<cfset thisError.field = "StartDate" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Start Date is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset startdatevalid = 0>
		</cfif>
		<cfif (len(trim(getStartDate())) AND NOT isDate(trim(getStartDate())))>
			<cfset thisError.field = "StartDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Start Date is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset startdatevalid = 0>
		<cfelseif (len(trim(getStartDate())) AND isDate(trim(getStartDate())))>
			<cfset startdatevalid = 1>
		</cfif>

		<!--- EndDate --->
		<cfif NOT len(trim(getEndDate()))>
			<cfset thisError.field = "EndDate" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "End Date is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset enddatevalid = 0>
		</cfif>
		<cfif (len(trim(getEndDate())) AND NOT isDate(trim(getEndDate())))>
			<cfset thisError.field = "EndDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "End Date is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
			<cfset enddatevalid = 0>
		<cfelseif (len(trim(getEndDate())) AND isDate(trim(getEndDate())))>
			<cfset enddatevalid = 1>
		</cfif>

		<!--- Enforce start date is equal or prior to end date --->
		<cfif startdatevalid gt 0 and enddatevalid gt 0>
			<cfif datecompare(getStartDate(),getEndDate()) gt 0>
				<cfset thisError.field = "StartDate" />
				<cfset thisError.type = "invalidType" />
				<cfset thisError.message = "Start Date has to be before End Date" />
				<cfset arrayAppend(errors,duplicate(thisError)) />
			</cfif>
		</cfif>

		<!--- BudgetCeilingAmount --->
		<cfif NOT len(trim(getBudgetCeilingAmount()))>
			<cfset thisError.field = "BudgetCeilingAmount" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Funding Amount is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<!---
		<cfif (len(trim(getBudgetCeilingAmount())) AND NOT isNumeric(trim(getBudgetCeilingAmount())))>
			<cfset thisError.field = "BudgetCeilingAmount" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Funding Amount is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		 --->

		<!--- Currency --->
		<cfif (len(trim(getCurrency())) AND NOT IsSimpleValue(trim(getCurrency())))>
			<cfset thisError.field = "Currency" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Currency is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCurrency())) GT 255)>
			<cfset thisError.field = "Currency" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Currency is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- ContactPersonID --->
		<!--- <cfif (len(trim(getContactPersonID())) AND NOT isNumeric(trim(getContactPersonID())))>
			<cfset thisError.field = "ContactPersonID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ContactPersonID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

        <!--- ContactPersonEmail --->
        <!--- <cfif (len(trim(getContactPersonEmail())) AND NOT isValid("email",trim(getContactPersonEmail())))>
            <cfset thisError.field = "ContactPersonEmail" />
            <cfset thisError.type = "invalidType" />
            <cfset thisError.message = "ContactPersonEmail is not an email" />
            <cfset arrayAppend(errors,duplicate(thisError)) />
        </cfif> --->

        <!--- ContactPersonEmail --->


    	<!--- TotalCostShare --->
		<cfif (len(trim(getTotalCostShare())) AND NOT isNumeric(trim(getTotalCostShare())))>
			<cfset thisError.field = "TotalCostShare" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "TotalCostShare is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- CostShareToDate --->
		<!--- <cfif (len(trim(getCostShareToDate())) AND NOT isNumeric(trim(getCostShareToDate())))>
			<cfset thisError.field = "CostShareToDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CostShareToDate is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- /////////////////////////// --->
		<!--- programID --->
		<!--- <cfif (len(trim(getprogramID())) AND NOT isNumeric(trim(getprogramID())))>
			<cfset thisError.field = "programID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "programID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<!--- projectObjective --->
		<cfif NOT len(trim(getprojectObjective()))>
			<cfset thisError.field = "projectObjective" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project objective is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getprojectObjective())) AND NOT IsSimpleValue(trim(getprojectObjective())))>
			<cfset thisError.field = "projectObjective" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project objective is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getprojectObjective())) GT 1000)>
			<cfset thisError.field = "projectObjective" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project objective is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- interestSpecification --->
		<cfif NOT len(trim(getinterestSpecification()))>
			<cfset thisError.field = "interestSpecification" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "US security interest specification is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getinterestSpecification())) AND NOT IsSimpleValue(trim(getinterestSpecification())))>
			<cfset thisError.field = "interestSpecification" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "US security interest specification is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getinterestSpecification())) GT 1000)>
			<cfset thisError.field = "interestSpecification" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "US security interest specification is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- lawEnforcementSpecification --->
		<cfif NOT len(trim(getlawEnforcementSpecification()))>
			<cfset thisError.field = "lawEnforcementSpecification" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Law enforcement specification is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- coordinationSpecification --->
		<cfif NOT len(trim(getcoordinationSpecification()))>
			<cfset thisError.field = "coordinationSpecification" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Coordination specification is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- programAudience --->
		<cfif NOT len(trim(getprogramAudience())) >
			<cfset thisError.field = "programAudience" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Program audience is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- fundImpMechanismID --->
		<cfif NOT len(trim(getfundImpMechanismID()))>
			<cfset thisError.field = "fundImpMechanismID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Funding implementation mechanism is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- placeOfImplementation --->
	<!--- 	<cfif NOT len(trim(getplaceOfImplementation()))>
			<cfset thisError.field = "placeOfImplementation" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Place of implementation is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif> --->

		<cfif IsUserInRole("create activity,review activity")>
			<!--- Project Funding Sources --->
			<cfif NOT (len(trim(getprojectFundingSources())))>
				<cfset thisError.field = "projectFundingSources" />
				<cfset thisError.type = "required" />
				<cfset thisError.message = "Project funding source(s) required" />
				<cfset arrayAppend(errors,duplicate(thisError)) />
			</cfif>
		</cfif>

		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>

	<cffunction name="setParentID" access="public" returntype="void" output="false">
		<cfargument name="ParentID" type="string" required="true" />
		<cfset variables.instance.ParentID = arguments.ParentID />
	</cffunction>
	<cffunction name="getParentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<!---
	<cffunction name="setImplementorOrgID" access="public" returntype="void" output="false">
		<cfargument name="ImplementorOrgID" type="string" required="true" />
		<cfset variables.instance.ImplementorOrgID = arguments.ImplementorOrgID />
	</cffunction>
    <cffunction name="getImplementorOrgID" access="public" returntype="string" output="false">
    	<cfreturn variables.instance.ImplementorOrgID />
    </cffunction>
	 --->

    <!---
	<cffunction name="setOrgName" access="public" returntype="void" output="false">
    	<cfargument name="OrgName" type="string" required="true" />
    <cfset variables.instance.OrgName = arguments.OrgName />
  	</cffunction>
  	<cffunction name="getOrgName" access="public" returntype="string" output="false">
    	<cfreturn variables.instance.OrgName />
  	</cffunction>
	 --->

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setExternalCode" access="public" returntype="void" output="false">
		<cfargument name="ExternalCode" type="string" required="true" />
		<cfset variables.instance.ExternalCode = arguments.ExternalCode />
	</cffunction>
	<cffunction name="getExternalCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ExternalCode />
	</cffunction>

	<cffunction name="setExternalCodeDescription" access="public" returntype="void" output="false">
		<cfargument name="ExternalCodeDescription" type="string" required="true" />
		<cfset variables.instance.ExternalCodeDescription = arguments.ExternalCodeDescription />
	</cffunction>
	<cffunction name="getExternalCodeDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ExternalCodeDescription />
	</cffunction>

	<cffunction name="setStartDate" access="public" returntype="void" output="false">
		<cfargument name="StartDate" type="string" required="true" />
		<cfset variables.instance.StartDate = arguments.StartDate />
	</cffunction>
	<cffunction name="getStartDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.StartDate />
	</cffunction>

	<cffunction name="setEndDate" access="public" returntype="void" output="false">
		<cfargument name="EndDate" type="string" required="true" />
		<cfset variables.instance.EndDate = arguments.EndDate />
	</cffunction>
	<cffunction name="getEndDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.EndDate />
	</cffunction>

	<cffunction name="setBudgetCeilingAmount" access="public" returntype="void" output="false">
		<cfargument name="BudgetCeilingAmount" type="string" required="true" />
		<cfset variables.instance.BudgetCeilingAmount = arguments.BudgetCeilingAmount />
	</cffunction>
	<cffunction name="getBudgetCeilingAmount" access="public" returntype="string" output="false">
		<cfreturn variables.instance.BudgetCeilingAmount />
	</cffunction>

	<cffunction name="setCurrency" access="public" returntype="void" output="false">
		<cfargument name="Currency" type="string" required="true" />
		<cfset variables.instance.Currency = arguments.Currency />
	</cffunction>
	<cffunction name="getCurrency" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Currency />
	</cffunction>

	<!--- <cffunction name="setContactPersonID" access="public" returntype="void" output="false">
		<cfargument name="ContactPersonID" type="string" required="true" />
		<cfset variables.instance.ContactPersonID = arguments.ContactPersonID />
	</cffunction>
	<cffunction name="getContactPersonID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ContactPersonID />
	</cffunction>

	<cffunction name="setContactPersonFirstName" access="public" returntype="void" output="false">
		<cfargument name="ContactPersonFirstName" type="string" required="true" />
		<cfset variables.instance.ContactPersonFirstName = arguments.ContactPersonFirstName />
	</cffunction>
	<cffunction name="getContactPersonFirstName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ContactPersonFirstName />
	</cffunction>

	<cffunction name="setContactPersonLastName" access="public" returntype="void" output="false">
		<cfargument name="ContactPersonLastName" type="string" required="true" />
		<cfset variables.instance.ContactPersonLastName = arguments.ContactPersonLastName />
	</cffunction>
	<cffunction name="getContactPersonLastName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ContactPersonLastName />
	</cffunction>

    <cffunction name="setContactPersonEmail" access="public" returntype="void" output="false">
        <cfargument name="ContactPersonEmail" type="string" required="true" />
        <cfset variables.instance.ContactPersonEmail = arguments.ContactPersonEmail />
    </cffunction>
    <cffunction name="getContactPersonEmail" access="public" returntype="string" output="false">
        <cfreturn variables.instance.ContactPersonEmail />
    </cffunction>

	<cffunction name="setContactPersonPhone" access="public" returntype="void" output="false">
		<cfargument name="ContactPersonPhone" type="string" required="true" />
		<cfset variables.instance.ContactPersonphone = arguments.ContactPersonPhone />
	</cffunction>
	<cffunction name="getContactPersonPhone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ContactPersonPhone />
	</cffunction> --->

	<cffunction name="setTotalCostShare" access="public" returntype="void" output="false">
		<cfargument name="TotalCostShare" type="string" required="true" />
		<cfset variables.instance.TotalCostShare = arguments.TotalCostShare />
	</cffunction>
	<cffunction name="getTotalCostShare" access="public" returntype="string" output="false">
		<cfreturn variables.instance.TotalCostShare />
	</cffunction>

	<cffunction name="setCostShareToDate" access="public" returntype="void" output="false">
		<cfargument name="CostShareToDate" type="string" required="true" />
		<cfset variables.instance.CostShareToDate = arguments.CostShareToDate />
	</cffunction>
	<cffunction name="getCostShareToDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CostShareToDate />
	</cffunction>

  	<cffunction name="setLastUpdated" access="public" returntype="void" output="false">
    	<cfargument name="LastUpdated" type="string" required="true" />
    	<cfset variables.instance.LastUpdated = arguments.LastUpdated />
  	</cffunction>

	<!--- ////////////////////////////////////////////// --->
	<cffunction name="setprogramID" access="public" returntype="void" output="false">
		<cfargument name="programID" type="string" required="true" />
		<cfset variables.instance.programID = arguments.programID />
	</cffunction>
	<cffunction name="getprogramID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.programID />
	</cffunction>

	<cffunction name="setProgramName" access="public" returntype="void" output="false">
    	<cfargument name="programName" type="string" required="true" />
    	<cfset variables.instance.programName = arguments.programName />
  	</cffunction>
  	<cffunction name="getProgramName" access="public" returntype="string" output="false">
    	<cfreturn variables.instance.programName />
  	</cffunction>

	<cffunction name="setprojectObjective" access="public" returntype="void" output="false">
		<cfargument name="projectObjective" type="string" required="true" />
		<cfset variables.instance.projectObjective = arguments.projectObjective />
	</cffunction>
	<cffunction name="getprojectObjective" access="public" returntype="string" output="false">
		<cfreturn variables.instance.projectObjective />
	</cffunction>

	<cffunction name="setinterestSpecification" access="public" returntype="void" output="false">
		<cfargument name="interestSpecification" type="string" required="true" />
		<cfset variables.instance.interestSpecification = arguments.interestSpecification />
	</cffunction>
	<cffunction name="getinterestSpecification" access="public" returntype="string" output="false">
		<cfreturn variables.instance.interestSpecification />
	</cffunction>

	<cffunction name="setlawEnforcementSpecification" access="public" returntype="void" output="false">
		<cfargument name="lawEnforcementSpecification" type="string" required="true" />
		<cfset variables.instance.lawEnforcementSpecification = arguments.lawEnforcementSpecification />
	</cffunction>
	<cffunction name="getlawEnforcementSpecification" access="public" returntype="string" output="false">
		<cfreturn variables.instance.lawEnforcementSpecification />
	</cffunction>

	<cffunction name="setcoordinationSpecification" access="public" returntype="void" output="false">
		<cfargument name="coordinationSpecification" type="string" required="true" />
		<cfset variables.instance.coordinationSpecification = arguments.coordinationSpecification />
	</cffunction>
	<cffunction name="getcoordinationSpecification" access="public" returntype="string" output="false">
		<cfreturn variables.instance.coordinationSpecification />
	</cffunction>

	<cffunction name="setprogramAudience" access="public" returntype="void" output="false">
		<cfargument name="programAudience" type="string" required="true" />
		<cfset variables.instance.programAudience = arguments.programAudience />
	</cffunction>
	<cffunction name="getprogramAudience" access="public" returntype="string" output="false">
		<cfreturn variables.instance.programAudience />
	</cffunction>

	<cffunction name="setfundImpMechanismID" access="public" returntype="void" output="false">
		<cfargument name="fundImpMechanismID" type="string" required="true" />
		<cfset variables.instance.fundImpMechanismID = arguments.fundImpMechanismID />
	</cffunction>
	<cffunction name="getfundImpMechanismID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.fundImpMechanismID />
	</cffunction>

	<cffunction name="setfundImpMechanism" access="public" returntype="void" output="false">
    	<cfargument name="fundImpMechanism" type="string" required="true" />
    	<cfset variables.instance.fundImpMechanism = arguments.fundImpMechanism />
  	</cffunction>
  	<cffunction name="getfundImpMechanism" access="public" returntype="string" output="false">
    	<cfreturn variables.instance.fundImpMechanism />
  	</cffunction>

	<cffunction name="setactivityStatusID" access="public" returntype="void" output="false">
		<cfargument name="activityStatusID" type="string" required="true" />
		<cfset variables.instance.activityStatusID = arguments.activityStatusID />
	</cffunction>
	<cffunction name="getactivityStatusID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.activityStatusID />
	</cffunction>

	<cffunction name="setaActivityStatus" access="public" returntype="void" output="false">
    	<cfargument name="aActivityStatus" type="string" required="true" />
    	<cfset variables.instance.aActivityStatus = arguments.aActivityStatus />
  	</cffunction>
  	<cffunction name="getaActivityStatus" access="public" returntype="string" output="false">
    	<cfreturn variables.instance.aActivityStatus />
  	</cffunction>

	<cffunction name="setProposalNumber" access="public" returntype="void" output="false">
		<cfargument name="ProposalNumber" type="string" required="true" />
		<cfset variables.instance.ProposalNumber = arguments.ProposalNumber />
	</cffunction>
	<cffunction name="getProposalNumber" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ProposalNumber />
	</cffunction>

	<cffunction name="setAMCNnumber" access="public" returntype="void" output="false">
		<cfargument name="AMCNnumber" type="string" required="true" />
		<cfset variables.instance.AMCNnumber = arguments.AMCNnumber />
	</cffunction>
	<cffunction name="getAMCNnumber" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AMCNnumber />
	</cffunction>

	<cffunction name="setproposalSubmitDate" access="public" returntype="void" output="false">
		<cfargument name="proposalSubmitDate" type="string" required="true" />
		<cfset variables.instance.proposalSubmitDate = arguments.proposalSubmitDate />
	</cffunction>
	<cffunction name="getproposalSubmitDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.proposalSubmitDate />
	</cffunction>

	<cffunction name="setclearedPrelegalDate" access="public" returntype="void" output="false">
		<cfargument name="clearedPrelegalDate" type="string" required="true" />
		<cfset variables.instance.clearedPrelegalDate = arguments.clearedPrelegalDate />
	</cffunction>
	<cffunction name="getclearedPrelegalDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.clearedPrelegalDate />
	</cffunction>

	<cffunction name="setproposalApprovedDate" access="public" returntype="void" output="false">
		<cfargument name="proposalApprovedDate" type="string" required="true" />
		<cfset variables.instance.proposalApprovedDate = arguments.proposalApprovedDate />
	</cffunction>
	<cffunction name="getproposalApprovedDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.proposalApprovedDate />
	</cffunction>

	<cffunction name="setAMCNBudgetSubmitDate" access="public" returntype="void" output="false">
		<cfargument name="AMCNBudgetSubmitDate" type="string" required="true" />
		<cfset variables.instance.AMCNBudgetSubmitDate = arguments.AMCNBudgetSubmitDate />
	</cffunction>
	<cffunction name="getAMCNBudgetSubmitDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AMCNBudgetSubmitDate />
	</cffunction>

	<cffunction name="setAMCNCongressSubmitDate" access="public" returntype="void" output="false">
		<cfargument name="AMCNCongressSubmitDate" type="string" required="true" />
		<cfset variables.instance.AMCNCongressSubmitDate = arguments.AMCNCongressSubmitDate />
	</cffunction>
	<cffunction name="getAMCNCongressSubmitDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AMCNCongressSubmitDate />
	</cffunction>

	<cffunction name="setAMCNApprovedDate" access="public" returntype="void" output="false">
		<cfargument name="AMCNApprovedDate" type="string" required="true" />
		<cfset variables.instance.AMCNApprovedDate = arguments.AMCNApprovedDate />
	</cffunction>
	<cffunction name="getAMCNApprovedDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AMCNApprovedDate />
	</cffunction>

	<cffunction name="setFundApprovedDate" access="public" returntype="void" output="false">
		<cfargument name="FundApprovedDate" type="string" required="true" />
		<cfset variables.instance.FundApprovedDate = arguments.FundApprovedDate />
	</cffunction>
	<cffunction name="getFundApprovedDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FundApprovedDate />
	</cffunction>

	<cffunction name="setBudgetFundRequestDate" access="public" returntype="void" output="false">
		<cfargument name="BudgetFundRequestDate" type="string" required="true" />
		<cfset variables.instance.BudgetFundRequestDate = arguments.BudgetFundRequestDate />
	</cffunction>
	<cffunction name="getBudgetFundRequestDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.BudgetFundRequestDate />
	</cffunction>

	<cffunction name="setBudgetFundApprovalDate" access="public" returntype="void" output="false">
		<cfargument name="BudgetFundApprovalDate" type="string" required="true" />
		<cfset variables.instance.BudgetFundApprovalDate = arguments.BudgetFundApprovalDate />
	</cffunction>
	<cffunction name="getBudgetFundApprovalDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.BudgetFundApprovalDate />
	</cffunction>

	<cffunction name="setplaceOfImplementation" access="public" returntype="void" output="false">
		<cfargument name="placeOfImplementation" type="string" required="true" />
		<cfset variables.instance.placeOfImplementation = arguments.placeOfImplementation />
	</cffunction>
	<cffunction name="getplaceOfImplementation" access="public" returntype="string" output="false">
		<cfreturn variables.instance.placeOfImplementation />
	</cffunction>

	<cffunction name="setprojectCountries" access="public" returntype="void" output="false">
		<cfargument name="projectCountries" type="string" required="true" />
		<cfset variables.instance.projectCountries = arguments.projectCountries />
	</cffunction>
	<cffunction name="getprojectCountries" access="public" returntype="string" output="false">
		<cfreturn variables.instance.projectCountries />
	</cffunction>

	<cffunction name="setprojectRegions" access="public" returntype="void" output="false">
		<cfargument name="projectRegions" type="string" required="true" />
		<cfset variables.instance.projectRegions = arguments.projectRegions />
	</cffunction>
	<cffunction name="getprojectRegions" access="public" returntype="string" output="false">
		<cfreturn variables.instance.projectRegions />
	</cffunction>

	<cffunction name="setprojectOrganizations" access="public" returntype="void" output="false">
		<cfargument name="projectOrganizations" type="string" required="true" />
		<cfset variables.instance.projectOrganizations = arguments.projectOrganizations />
	</cffunction>
	<cffunction name="getprojectOrganizations" access="public" returntype="string" output="false">
		<cfreturn variables.instance.projectOrganizations />
	</cffunction>

	<cffunction name="setprojectFundingSources" access="public" returntype="void" output="false">
		<cfargument name="projectFundingSources" type="string" required="true" />
		<cfset variables.instance.projectFundingSources = arguments.projectFundingSources />
	</cffunction>
	<cffunction name="getprojectFundingSources" access="public" returntype="string" output="false">
		<cfreturn variables.instance.projectFundingSources />
	</cffunction>

	<cffunction name="setisActive" access="public" returntype="void" output="false">
		<cfargument name="isActive" type="string" required="true" />
		<cfset variables.instance.isActive = arguments.isActive />
	</cffunction>
	<cffunction name="getisActive" access="public" returntype="string" output="false">
		<cfreturn variables.instance.isActive />
	</cffunction>

	<cffunction name="setsysUserID" access="public" returntype="void" output="false">
		<cfargument name="sysUserID" type="string" required="true" />
		<cfset variables.instance.sysUserID = arguments.sysUserID />
	</cffunction>
	<cffunction name="getsysUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sysUserID />
	</cffunction>

	<cffunction name="setimplementingPartner" access="public" returntype="void" output="false">
		<cfargument name="implementingPartner" type="string" required="true" />
		<cfset variables.instance.implementingPartner = arguments.implementingPartner />
	</cffunction>
	<cffunction name="getimplementingPartner" access="public" returntype="string" output="false">
		<cfreturn variables.instance.implementingPartner />
	</cffunction>


 	<cffunction name="setreprogramFunds" access="public" returntype="void" output="false">
		<cfargument name="reprogramFunds" type="string" required="true" />
		<cfset variables.instance.reprogramFunds = arguments.reprogramFunds />
	</cffunction>
	<cffunction name="getreprogramFunds" access="public" returntype="string" output="false">
		<cfreturn variables.instance.reprogramFunds />
	</cffunction>

	<cffunction name="setctex" access="public" returntype="void" output="false">
		<cfargument name="ctex" type="string" required="true" />
		<cfset variables.instance.ctex = arguments.ctex />
	</cffunction>
	<cffunction name="getctex" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ctex />
	</cffunction>

	<cffunction name="setreprogramComments" access="public" returntype="void" output="false">
		<cfargument name="reprogramComments" type="string" required="true" />
		<cfset variables.instance.reprogramComments = arguments.reprogramComments />
	</cffunction>
	<cffunction name="getreprogramComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.reprogramComments />
	</cffunction>


	<cffunction name="setfiscalYear" access="public" returntype="void" output="false">
		<cfargument name="fiscalYear" type="string" required="true" />
		<cfset variables.instance.fiscalYear = arguments.fiscalYear />
	</cffunction>
	<cffunction name="getfiscalYear" access="public" returntype="string" output="false">
		<cfreturn variables.instance.fiscalYear />
	</cffunction>


	<cffunction name="setlessonsLearned" access="public" returntype="void" output="false">
		<cfargument name="lessonsLearned" type="string" required="true" />
		<cfset variables.instance.lessonsLearned = arguments.lessonsLearned />
	</cffunction>
	<cffunction name="getlessonsLearned" access="public" returntype="string" output="false">
		<cfreturn variables.instance.lessonsLearned />
	</cffunction>

	<cffunction name="setsustainability" access="public" returntype="void" output="false">
		<cfargument name="sustainability" type="string" required="true" />
		<cfset variables.instance.sustainability = arguments.sustainability />
	</cffunction>
	<cffunction name="getsustainability" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sustainability />
	</cffunction>


	<cffunction name="setcnID" access="public" returntype="void" output="false">
		<cfargument name="cnID" type="string" required="true" />
		<cfset variables.instance.cnID = arguments.cnID />
	</cffunction>
	<cffunction name="getcnID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cnID />
	</cffunction>

	<cffunction name="setcnTitle" access="public" returntype="void" output="false">
		<cfargument name="cnTitle" type="string" required="true" />
		<cfset variables.instance.cnTitle = arguments.cnTitle />
	</cffunction>
	<cffunction name="getcnTitle" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cnTitle />
	</cffunction>


	<cffunction name="setcityProvince" access="public" returntype="void" output="false">
		<cfargument name="cityProvince" type="string" required="true" />
		<cfset variables.instance.cityProvince = arguments.cityProvince />
	</cffunction>
	<cffunction name="getcityProvince" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cityProvince />
	</cffunction>

	<cffunction name="setrelatedProjects" access="public" returntype="void" output="false">
		<cfargument name="relatedProjects" type="string" required="true" />
		<cfset variables.instance.relatedProjects = arguments.relatedProjects />
	</cffunction>
	<cffunction name="getrelatedProjects" access="public" returntype="string" output="false">
		<cfreturn variables.instance.relatedProjects />
	</cffunction>

	<!---
	DUMP
	--->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

</cfcomponent>

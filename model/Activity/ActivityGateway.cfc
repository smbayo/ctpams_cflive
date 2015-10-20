
<cfcomponent displayname="ActivityGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<cffunction name="init" access="public" output="false" returntype="ActivityGateway">
		<cfreturn this />
	</cffunction>

	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="rolename" type="string" required="false" default="guest" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />

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

		<cfargument name="TotalCostShare" type="numeric" required="false" />
	    <cfargument name="CostShareToDate" type="numeric" required="false" />
	    <cfargument name="Location" type="numeric" required="false" />
	    <cfargument name="Sector" type="numeric" required="false" />
	    <cfargument name="GrantType" type="string" required="false" />
	    <cfargument name="Status" type="string" required="false" />
	    <cfargument name="lastUpdated" type="date" required="false" />
		<cfargument name="programID" type="numeric" required="false" />
		<cfargument name="projectObjective" type="string" required="false" />
		<cfargument name="interestSpecification" type="string" required="false" />
		<cfargument name="lawEnforcementSpecification" type="string" required="false" />
		<cfargument name="coordinationSpecification" type="string" required="false" />
		<cfargument name="programAudience" type="string" required="false" />
		<cfargument name="fundImpMechanismID" type="numeric" required="false" />
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
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="likeSearchTerms" type="string" required="false" />
		<cfargument name="implementingPartner" type="numeric" required="false" />
		<cfargument name="reprogramFunds" type="boolean" required="false" />
		<cfargument name="reprogramComments" type="string" required="false" />
		<cfargument name="ctex" type="boolean" required="false" />
		<cfargument name="fiscalYear" type="numeric" required="false" />
		<cfargument name="cnID" type="numeric" required="false" />
		<cfargument name="cnTitle" type="string" required="false" />
		<cfargument name="cityProvince" type="string" required="false" />
		<cfargument name="relatedProjects" type="string" required="false" />

		<cfset var qList = "" />
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				Activity.ActivityID,
				Activity.ParentID,
				Activity.resultsFrameworkElementID,
				Activity.Name,
				<!--- Activity.ImplementorOrgID, --->
				<!--- Org.Name as OrgName, --->
				Activity.Description,
				Activity.ExternalCode,
				Activity.ExternalCodeDescription,
			 	Activity.StartDate,
				Activity.EndDate,
				Activity.BudgetCeilingAmount,
				Activity.Currency,
				<!--- Activity.ContactPersonID, --->
				<!--- Activity.ContactPersonFirstName, --->
				<!--- Activity.ContactPersonLastName, --->
				<!--- Activity.ContactPersonEmail, --->
        		Activity.lastUpdated,
				ActivityExtendedGrant.TotalCostShare,
				ActivityExtendedGrant.SectorID,
        		ActivityExtendedGrant.CostShareToDate,
				ActivityExtendedGrant.programID,
				Program.Name as ProgramName,
				ActivityExtendedGrant.projectObjective,
				ActivityExtendedGrant.implementingPartner,
				ActivityExtendedGrant.interestSpecification,
				ActivityExtendedGrant.lawEnforcementSpecification,
				ActivityExtendedGrant.coordinationSpecification,
				ActivityExtendedGrant.programAudience,
				ActivityExtendedGrant.fundImpMechanismID,
				CategoryFund.name as fundImpMechanism,
				ActivityExtendedGrant.activityStatusID,
				CategoryStatus.name as activityStatus,
				CategoryStatus.ExternalCode as activityStatusCode,
				ActivityExtendedGrant.ProposalNumber,
				ActivityExtendedGrant.AMCNnumber,
				ActivityExtendedGrant.proposalSubmitDate,
				ActivityExtendedGrant.clearedPrelegalDate,
				ActivityExtendedGrant.proposalApprovedDate,
				ActivityExtendedGrant.AMCNBudgetSubmitDate,
				ActivityExtendedGrant.AMCNCongressSubmitDate,
				ActivityExtendedGrant.AMCNApprovedDate,
				ActivityExtendedGrant.FundApprovedDate,
				ActivityExtendedGrant.BudgetFundRequestDate,
				ActivityExtendedGrant.BudgetFundApprovalDate,
				ActivityExtendedGrant.placeOfImplementation,
				ActivityExtendedGrant.isActive,
				ActivityExtendedGrant.reprogramFunds,
				ActivityExtendedGrant.reprogramComments,
				ActivityExtendedGrant.ctex,
				ActivityExtendedGrant.lessonsLearned,
				ActivityExtendedGrant.sustainability,
				ActivityExtendedGrant.cityProvince,
				ActivityExtendedGrant.sysUserID,
				ActivityExtendedGrant.fiscalYear,
				ActivityExtendedGrant.cnID,
				ActivityExtendedGrant.cnTitle,
				ActivityExtendedGrant.implementationStatus,
				ActivityExtendedGrant.bureauTransferPOC,
				ActivityExtendedGrant.previousFClearances,
				ActivityExtendedGrant.relatedProjects
			FROM Activity
			LEFT OUTER JOIN ActivityExtendedGrant ON Activity.ActivityID = ActivityExtendedGrant.ActivityID
			<!--- LEFT OUTER JOIN Org ON Activity.ImplementorOrgID = Org.OrgID --->
			LEFT OUTER JOIN Program ON (Program.programID=ActivityExtendedGrant.programID)
			LEFT OUTER JOIN Category CategoryStatus ON (CategoryStatus.CategoryID = ActivityExtendedGrant.activityStatusID)
			LEFT OUTER JOIN Category CategoryFund ON (CategoryFund.CategoryID = ActivityExtendedGrant.fundImpMechanismID)
			WHERE	<!--- ActivityExtendedGrant.isActive = 1 --->0=0
		<cfif arguments.rolename is not 'admin'>
		 	  and isActive = 1
		 	</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	Activity.ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"resultsFrameworkElementID") and len(arguments.resultsFrameworkElementID)>
			AND	Activity.resultsFrameworkElementID = <cfqueryparam value="#arguments.resultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ParentID") and len(arguments.ParentID)>
			AND	Activity.ParentID = <cfqueryparam value="#arguments.ParentID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			<cfif isDefined("arguments.likeSearchTerms") and listFind(arguments.likeSearchTerms,"Name")>
				AND	Activity.Name LIKE <cfqueryparam value="%#arguments.Name#%" CFSQLType="cf_sql_varchar" />
			<cfelse>
				AND	Activity.Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
			</cfif>
		</cfif>
		<cfif structKeyExists(arguments,"ImplementorOrgID") and len(arguments.ImplementorOrgID)>
			AND	Activity.ImplementorOrgID = <cfqueryparam value="#arguments.ImplementorOrgID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
			AND	Activity.Description like <cfqueryparam value="%#arguments.Description#%" CFSQLType="cf_sql_longvarchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ExternalCode") and len(arguments.ExternalCode)>
			AND	Activity.ExternalCode = <cfqueryparam value="#arguments.ExternalCode#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ExternalCodeDescription") and len(arguments.ExternalCodeDescription)>
			AND	Activity.ExternalCodeDescription = <cfqueryparam value="#arguments.ExternalCodeDescription#" CFSQLType="cf_sql_varchar" />
		</cfif>
	    <cfif structKeyExists(arguments,"StartMonthFrom") and len(arguments.StartMonthFrom)>
	      	AND DATEPART(month,Activity.StartDate) >= <cfqueryparam value="#arguments.StartMonthFrom#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"StartYearFrom") and len(arguments.StartYearFrom)>
	      	AND DATEPART(year,Activity.StartDate) >= <cfqueryparam value="#arguments.StartYearFrom#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"StartMonthTo") and len(arguments.StartMonthTo)>
	      	AND DATEPART(month,Activity.StartDate) <= <cfqueryparam value="#arguments.StartMonthTo#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"StartYearTo") and len(arguments.StartYearTo)>
	      	AND DATEPART(year,Activity.StartDate) <= <cfqueryparam value="#arguments.StartYearTo#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"EndMonthFrom") and len(arguments.EndMonthFrom)>
	      	AND DATEPART(month,Activity.EndDate) >= <cfqueryparam value="#arguments.EndMonthFrom#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"EndYearFrom") and len(arguments.EndYearFrom)>
	      	AND DATEPART(year,Activity.EndDate) >= <cfqueryparam value="#arguments.EndYearFrom#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"EndMonthTo") and len(arguments.EndMonthTo)>
	      	AND DATEPART(month,Activity.EndDate) <= <cfqueryparam value="#arguments.EndMonthTo#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"EndYearTo") and len(arguments.EndYearTo)>
	      	AND DATEPART(year,Activity.EndDate) <= <cfqueryparam value="#arguments.EndYearTo#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"StartDate") and len(arguments.StartDate)>
	      	AND Activity.StartDate = <cfqueryparam value="#arguments.StartDate#" CFSQLType="cf_sql_timestamp" />
	    </cfif>
		<cfif structKeyExists(arguments,"EndDate") and len(arguments.EndDate)>
			AND	Activity.EndDate = <cfqueryparam value="#arguments.EndDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetCeilingAmount") and len(arguments.BudgetCeilingAmount)>
			AND Activity.BudgetCeilingAmount is not null
			AND Activity.BudgetCeilingAmount <> ''
			AND	Activity.BudgetCeilingAmount <cfif structKeyExists(arguments,"BudgetCeilingAmountDirection") and len(arguments.BudgetCeilingAmountDirection)>#arguments.BudgetCeilingAmountDirection#<cfelse>=</cfif> <cfqueryparam value="#arguments.BudgetCeilingAmount#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Currency") and len(arguments.Currency)>
			AND	Activity.Currency = <cfqueryparam value="#arguments.Currency#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<!--- <cfif structKeyExists(arguments,"ContactPersonID") and len(arguments.ContactPersonID)>
			AND	Activity.ContactPersonID = <cfqueryparam value="#arguments.ContactPersonID#" CFSQLType="cf_sql_integer" />
		</cfif> --->
		<!--- <cfif structKeyExists(arguments,"ContactPersonFirstName") and len(arguments.ContactPersonFirstName)>
			<cfif isDefined("arguments.likeSearchTerms") and listFind(arguments.likeSearchTerms,"ContactPersonFirstName")>
				AND	Activity.ContactPersonFirstName like <cfqueryparam value="%#arguments.ContactPersonFirstName#%" CFSQLType="cf_sql_varchar" />
			<cfelse>
				AND	Activity.ContactPersonFirstName = <cfqueryparam value="#arguments.ContactPersonFirstName#" CFSQLType="cf_sql_varchar" />
			</cfif>
		</cfif> --->
		<!--- <cfif structKeyExists(arguments,"ContactPersonLastName") and len(arguments.ContactPersonLastName)>
			<cfif isDefined("arguments.likeSearchTerms") and listFind(arguments.likeSearchTerms,"ContactPersonLastName")>
				AND	Activity.ContactPersonLastName like <cfqueryparam value="%#arguments.ContactPersonLastName#%" CFSQLType="cf_sql_varchar" />
			<cfelse>
				AND	Activity.ContactPersonLastName = <cfqueryparam value="#arguments.ContactPersonLastName#" CFSQLType="cf_sql_varchar" />
			</cfif>
		</cfif> --->
		<!--- <cfif structKeyExists(arguments,"ContactPersonEmail") and len(arguments.ContactPersonEmail)>
			<cfif isDefined("arguments.likeSearchTerms") and listFind(arguments.likeSearchTerms,"ContactPersonEmail")>
				AND	Activity.ContactPersonEmail like <cfqueryparam value="%#arguments.ContactPersonEmail#%" CFSQLType="cf_sql_varchar" />
			<cfelse>
				AND	Activity.ContactPersonEmail = <cfqueryparam value="#arguments.ContactPersonEmail#" CFSQLType="cf_sql_varchar" />
			</cfif>
		</cfif> --->
		<cfif structKeyExists(arguments,"TotalCostShare") and len(arguments.TotalCostShare)>
			AND	ActivityExtendedGrant.TotalCostShare = <cfqueryparam value="#arguments.TotalCostShare#" CFSQLType="cf_sql_integer" />
		</cfif>
	    <cfif structKeyExists(arguments,"CostShareToDate") and len(arguments.CostShareToDate)>
	      	AND ActivityExtendedGrant.CostShareToDate = <cfqueryparam value="#arguments.CostShareToDate#" CFSQLType="cf_sql_integer" />
	    </cfif>
	    <cfif structKeyExists(arguments,"Location") and len(arguments.Location)>
	      	AND Activity.ActivityID in (
				       SELECT ActivityID
							 FROM ActivityLocation
							 WHERE LocationID = <cfqueryparam value="#arguments.Location#" CFSQLType="cf_sql_integer" />
				)
	    </cfif>
	    <cfif structKeyExists(arguments,"Sector") and len(arguments.Sector)>
	      	AND Activity.ActivityID in (
				       SELECT ObjectID
							 FROM ObjectCategory
							 WHERE CategoryID = <cfqueryparam value="#arguments.Sector#" CFSQLType="cf_sql_integer" /> and ClassName = 'Activity'
				)
	    </cfif>
	    <cfif structKeyExists(arguments,"GrantType") and len(arguments.GrantType)>
	      	AND ImplementorOrgID in (
				     SELECT OrgID FROM Org WHERE LegalRegistrationStatus = <cfqueryparam value="#arguments.GrantType#" CFSQLType="cf_sql_varchar" />
				)
	    </cfif>
	    <cfif structKeyExists(arguments,"status") and len(arguments.status)>
	      <cfif arguments.status is "inactive">
	       	AND Activity.EndDate < <cfqueryparam value="#Now()#" CFSQLType="cf_sql_timestamp" />
		  <cfelse>
		   	AND Activity.EndDate >= <cfqueryparam value="#Now()#" CFSQLType="cf_sql_timestamp" />
		  </cfif>
	    </cfif>
		<cfif structKeyExists(arguments,"programID") and len(arguments.programID)>
			AND	ActivityExtendedGrant.programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"projectObjective") and len(arguments.projectObjective)>
			AND	projectObjective = <cfqueryparam value="#arguments.projectObjective#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"interestSpecification") and len(arguments.interestSpecification)>
			AND	interestSpecification = <cfqueryparam value="#arguments.interestSpecification#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"lawEnforcementSpecification") and len(arguments.lawEnforcementSpecification)>
			AND	lawEnforcementSpecification = <cfqueryparam value="#arguments.lawEnforcementSpecification#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"coordinationSpecification") and len(arguments.coordinationSpecification)>
			AND	coordinationSpecification = <cfqueryparam value="#arguments.coordinationSpecification#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"programAudience") and len(arguments.programAudience)>
			AND	ActivityExtendedGrant.programAudience = <cfqueryparam value="#arguments.programAudience#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"fundImpMechanismID") and len(arguments.fundImpMechanismID)>
			AND	ActivityExtendedGrant.fundImpMechanismID = <cfqueryparam value="#arguments.fundImpMechanismID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityStatusID") and len(arguments.ActivityStatusID)>
			AND	ActivityExtendedGrant.ActivityStatusID = <cfqueryparam value="#arguments.ActivityStatusID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ProposalNumber") and len(arguments.ProposalNumber)>
			AND	ActivityExtendedGrant.ProposalNumber = <cfqueryparam value="#arguments.ProposalNumber#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNnumber") and len(arguments.AMCNnumber)>
			AND	ActivityExtendedGrant.AMCNnumber = <cfqueryparam value="#arguments.AMCNnumber#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"proposalSubmitDate") and len(arguments.proposalSubmitDate)>
			AND	ActivityExtendedGrant.proposalSubmitDate = <cfqueryparam value="#arguments.proposalSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"clearedPrelegalDate") and len(arguments.clearedPrelegalDate)>
			AND	ActivityExtendedGrant.clearedPrelegalDate = <cfqueryparam value="#arguments.clearedPrelegalDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"proposalApprovedDate") and len(arguments.proposalApprovedDate)>
			AND	ActivityExtendedGrant.proposalApprovedDate = <cfqueryparam value="#arguments.proposalApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNBudgetSubmitDate") and len(arguments.AMCNBudgetSubmitDate)>
			AND	ActivityExtendedGrant.AMCNBudgetSubmitDate = <cfqueryparam value="#arguments.AMCNBudgetSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNCongressSubmitDate") and len(arguments.AMCNCongressSubmitDate)>
			AND	ActivityExtendedGrant.AMCNCongressSubmitDate = <cfqueryparam value="#arguments.AMCNCongressSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNApprovedDate") and len(arguments.AMCNApprovedDate)>
			AND	ActivityExtendedGrant.AMCNApprovedDate = <cfqueryparam value="#arguments.AMCNApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"FundApprovedDate") and len(arguments.FundApprovedDate)>
			AND	FundApprovedDate = <cfqueryparam value="#arguments.FundApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetFundRequestDate") and len(arguments.BudgetFundRequestDate)>
			AND	ActivityExtendedGrant.BudgetFundRequestDate = <cfqueryparam value="#arguments.BudgetFundRequestDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetFundApprovalDate") and len(arguments.BudgetFundApprovalDate)>
			AND	ActivityExtendedGrant.BudgetFundApprovalDate = <cfqueryparam value="#arguments.BudgetFundApprovalDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"placeOfImplementation") and len(arguments.placeOfImplementation)>
			AND	ActivityExtendedGrant.placeOfImplementation = <cfqueryparam value="#arguments.placeOfImplementation#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"fiscalYear") and len(arguments.fiscalYear)>
			AND	ActivityExtendedGrant.fiscalYear = <cfqueryparam value="#arguments.fiscalYear#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"cnID") and len(arguments.cnID)>
			AND	ActivityExtendedGrant.cnID = <cfqueryparam value="#arguments.cnID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"cnTitle") and len(arguments.cnTitle)>
			AND	ActivityExtendedGrant.cnTitle = <cfqueryparam value="#arguments.cnTitle#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"cityProvince") and len(arguments.cityProvince)>
			AND	ActivityExtendedGrant.cityProvince = <cfqueryparam value="#arguments.cityProvince#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"reprogramFunds") and len(arguments.reprogramFunds)>
			AND	ActivityExtendedGrant.reprogramFunds = <cfqueryparam value="#arguments.reprogramFunds#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments,"ctex") and len(arguments.ctex)>
			AND	ActivityExtendedGrant.ctex = <cfqueryparam value="#arguments.ctex#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>

		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<!--- <cfargument name="ImplementorOrgID" type="numeric" required="false" /> --->
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" />
    	<cfargument name="StartMonth" type="string" required="false" />
    	<cfargument name="StartYear" type="string" required="false" />
    	<cfargument name="EndMonth" type="string" required="false" />
    	<cfargument name="EndYear" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="BudgetCeilingAmount" type="numeric" required="false" />
		<cfargument name="Currency" type="string" required="false" />
		<!--- <cfargument name="ContactPersonID" type="numeric" required="false" />
		<cfargument name="ContactPersonFirstName" type="string" required="false" />
		<cfargument name="ContactPersonLastName" type="string" required="false" />
		<cfargument name="ContactPersonEmail" type="string" required="false" /> --->
		<cfargument name="TotalCostShare" type="numeric" required="false" />
	    <cfargument name="CostShareToDate" type="numeric" required="false" />
	    <cfargument name="Location" type="numeric" required="false" />
	    <cfargument name="LastUpdated" type="date" required="false" />
	    <cfargument name="programID" type="numeric" required="false" />
		<cfargument name="programAudience" type="string" required="false" />
		<cfargument name="fundImpMechanism" type="numeric" required="false" />
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
		<cfargument name="orderby" type="string" required="false" />

		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","Activity").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>

		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="updateByAttributes" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="StartDate" type="date" required="false" />
		<cfargument name="EndDate" type="date" required="false" />
		<cfargument name="BudgetCeilingAmount" type="numeric" required="false" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Activity
				SET
				lastUpdated = <cfqueryparam value="#now()#" CFSQLType="cf_sql_timestamp"  />
				<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
					,Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Name)#" />
				</cfif>
				<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
					,Description = <cfqueryparam value="#arguments.Description#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Description)#" />
				</cfif>
				<cfif structKeyExists(arguments,"StartDate") and len(arguments.StartDate)>
					,StartDate = <cfqueryparam value="#arguments.StartDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.StartDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"EndDate") and len(arguments.EndDate)>
					,EndDate = <cfqueryparam value="#arguments.EndDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.EndDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"BudgetCeilingAmount") and len(arguments.BudgetCeilingAmount)>
					,BudgetCeilingAmount = <cfqueryparam value="#arguments.BudgetCeilingAmount#" CFSQLType="cf_sql_integer" null="#not len(arguments.BudgetCeilingAmount)#" />
				</cfif>

				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="getNamesandIDs" access="public" output="false" returntype="Query">
		<cfset var qReturn = "">

		<cfquery name="qReturn" datasource="#dsn.getName()#">
			SELECT activityID, Name
			FROM Activity
			ORDER BY Name
		</cfquery>

		<cfreturn qReturn>
	</cffunction>

	<cffunction name="getActivityIDarray" access="public" output="false" returntype="array">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />

		<cfset var qList = getIDs(argumentCollection=arguments) />
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","Activity").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>

		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="getIDarray" access="public" output="false" returntype="string">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfset var qReturn = "">
		<cfset getIDs=getIDs(resultsFrameworkElementID=arguments.resultsFrameworkElementID)>
        <cfset myArray = ArrayNew(1)>

<!--- Loop through the query, append names successively to the last element. --->
        <cfloop query = "getIDs">
    		<cfset temp = ArrayAppend(myArray, "#activityID#")>
		</cfloop>

<!--- Show the resulting array as a list. --->
		<cfset getIDarray = ArrayToList(myArray, ",")>

		<cfreturn getIDarray>
	</cffunction>

	<cffunction name="getIDs" access="public" output="false" returntype="Query">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfset var qReturn = "">

		<cfquery name="qReturn" datasource="#dsn.getName()#">
			SELECT activityID
			FROM Activity
			where resultsframeworkElementID=<cfqueryparam value="#arguments.resultsframeworkelementID#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfreturn qReturn>
	</cffunction>

	<cffunction name="getLastUpdated" access="public" output="false" returntype="Query">
    <cfargument name="topLimit" type="numeric" required="true" />

		<cfset var qGrants = "">

		<cfquery name="qGrants" datasource="#dsn.getName()#">
			SELECT
			 <cfif arguments.topLimit is not "" and isNumeric(arguments.topLimit)>TOP #arguments.topLimit#</cfif>
			 A.activityID,
			 A.name,
			 A.lastUpdated,
			 Org.name as OrgName,
			 Org.OrgID
			FROM Activity A inner join Org on A.implementorOrgID= Org.OrgID
			WHERE (A.lastUpdated is not null)
			ORDER BY A.lastUpdated desc
		</cfquery>

	  <cfreturn qGrants>
	</cffunction>

    <cffunction name="getMeasurements" access="public" output="false" returntype="Query">
	    <cfargument name="activityid" type="numeric" required="true" />

	    <cfset var qMeasurements = "">

	    <cfquery name="qMeasurements" datasource="#dsn.getName()#">
	      SELECT IndicatorName, IntendedChangeDirection, DisaggSetName, DisaggName, ActivityID, IndicatorID, DisaggID, isBaseline, Actual, ActualNotes, Target, TargetNotes, StartDate, EndDate, ReportDate, ReviewedBy, ReviewDate, ReviewType, ReviewNotes, MeasurementID, DisaggSetID
	      FROM vw_ActivityMeasurement
	      WHERE (ActivityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.activityid#">)
	    </cfquery>

	    <cfreturn qMeasurements>
    </cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">

		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 *
			 * @param query 	 The query to work with.
			 * @param row 	 Row number to check. Defaults to row 1.
			 * @return Returns a structure.
			 * @author Nathan Dintenfass (nathan@changemedia.com)
			 * @version 1, December 11, 2001
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>

	<cffunction name="getGrantsList" access="public" output="false" returntype="query">

		<cfset var qListGrants = "">

		<cfquery name="qListGrants" datasource="#dsn.getName()#">
			SELECT ActivityID, Name
			FROM Activity
			ORDER BY activityid asc;
		</cfquery>

		<cfreturn qListGrants>

	</cffunction>

	<cffunction name="getGrantName" access="public" output="false" returntype="query">

		<cfset var qGrantName = "" />

		<cfquery name="qGrantName" datasource="#dsn.getName()#" maxrows="1">
			SELECT Name
			FROM Activity
			WHERE ActivityID = <cfqueryparam value="#form.grantID#" maxlength="6">;
		</cfquery>

		<cfreturn qGrantName>

	</cffunction>

    <cffunction name="measurementRollupByGrant" access="public" output="false" returntype="query" hint="Pulls measurement info across all indicators for an Activity. If no Acitivity is defined, pull info for all indicators across all activities.">

        <cfargument name="activityID" default="0" type="numeric" hint="the ID of the Activity to pull info for. If undefined, will pull info across all activities"  >

        <cfquery name="qRollup" datasource="#dsn.getName()#">

            SELECT
                  [IndicatorName]
                  ,[DisaggSetName]
                  ,[DisaggName]
                  ,activityid

                  ,(--Get the ACTUAL value from the Baseline row for this indicator & disagg
                        select SUM(m.ACTUAL)
                        from Measurement m
                        where
                              m.ActivityID=vam.activityID
                              and m.IndicatorID=vam.Indicatorid
                              and m.DisaggID=vam.disaggid
                              and isBaseline=1
                  ) as BaselineActual
                  ,(--Get the TARGET value from the Baseline row for this indicator & disagg
                        select SUM(m.TARGET)
                        from Measurement m
                        where
                              m.ActivityID=vam.activityID
                              and m.IndicatorID=vam.Indicatorid
                              and m.DisaggID=vam.disaggid
                              and isBaseline=1
                  ) as BaselineTarget

                  ,coalesce(SUM([Actual]),0) as SUMACTUAL  --includes baseline value
                  ,(coalesce(
                        (--Get the TARGET value from the nonBaseline rows for this indicator & disagg
                              select SUM(m.TARGET)
                              from Measurement m
                              where
                                    m.ActivityID=vam.activityID
                                    and m.IndicatorID=vam.Indicatorid
                                    and m.DisaggID=vam.disaggid
                                    and isBaseline=0
                        ) +
                        (--Get the ACTUAL value from the Baseline row for this indicator & disagg
                              select SUM(m.ACTUAL)
                              from Measurement m
                              where
                                    m.ActivityID=vam.activityID
                                    and m.IndicatorID=vam.Indicatorid
                                    and m.DisaggID=vam.disaggid
                                    and isBaseline=1
                        )
                      ,0)

                  )as SUMTARGET --excludes baseline target but assumes that the current target is the baselinevalue + all quarterly targets
                  ,IntendedChangeDirection
                  ,SIGN(--determine whether change is positive or negative
                        SUM(ACTUAL)-(
                              --Get the ACTUAL value from the Baseline row for this indicator & disagg
                              select SUM(m.ACTUAL)
                              from Measurement m
                              where
                                    m.ActivityID=vam.activityID
                                    and m.IndicatorID=vam.Indicatorid
                                    and m.DisaggID=vam.disaggid
                                    and isBaseline=1
                        )
                  ) as ActualChangeDirection
                  ,MAX([ReportDate]) as MAXREPORTDATE

            FROM [vw_ActivityMeasurement] vam
            where
                  enddate <= getdate()/****INSERT YOUR DATE VARIABLE HERE ***/
                 <cfif arguments.activityID>and activityID =  #arguments.activityID#</cfif>

            GROUP BY
                  [IndicatorName]
                  ,[DisaggSetName]
                  ,[DisaggName]
                  ,activityID
                  ,disaggid
                  ,indicatorid
                  ,IntendedChangeDirection
            --    ,enddate
            ORDER BY
                  [IndicatorName]
                  ,[DisaggSetName]
                  ,[DisaggName]
        </cfquery>


        <cfreturn qRollup>

    </cffunction>

    <cffunction name="getSectorBudgets" access="public" output="false" returntype="query" hint="Returns Report data for Sector budget report">
        <cfargument name="filter" hint="list of allowed values. Currently only 'active' is supported. If omitted or empty,'active' is applied." type="string" default="active" allowedValues="active" />
        <cfif not listfindnocase(getmetadata(this.getSectorBudgets).parameters[1].allowedvalues,arguments.filter)>
            <cfthrow type="IndexOutOfRange" message="The argument filter accepts only values in the list:" />
        </cfif>
        <cfquery name="qSectorBudgets" datasource="#dsn.getName()#">
			SELECT
			     SUM(dbo.Activity.BudgetCeilingAmount) AS sumbudget,
			     dbo.Category.Name AS sector
			FROM  dbo.ObjectCategory
			     INNER JOIN dbo.Category ON dbo.ObjectCategory.CategoryID = dbo.Category.CategoryID
			     INNER JOIN dbo.Activity ON dbo.ObjectCategory.ObjectID = dbo.Activity.ActivityID
			     INNER JOIN dbo.Category AS ParentCategory ON dbo.Category.ParentID = ParentCategory.CategoryID
			WHERE (ParentCategory.Name = N'USAID Egypt Sectors')
			     AND (dbo.ObjectCategory.isPrimary = 1)
			     AND (dbo.ObjectCategory.ClassName = N'Activity')
			     AND Activity.ParentID is null --assume subgrants have a portion of the parent's funding
			     <cfif listfindnocase(arguments.filter,'active')>
				    AND getDate() BETWEEN ACTIVITY.startDate AND ACTIVITY.endDate
				</cfif>
			GROUP BY dbo.Category.Name
        </cfquery>
        <cfreturn qSectorBudgets />

    </cffunction>

    <cffunction name="getGranteesByOrgType" access="public" output="false" returntype="Query">

	    <cfset var qGranteesByOrgType = "">

	    <cfquery name="qGranteesByOrgType" datasource="#dsn.getName()#">
	      SELECT type, count_distinct_allgrantees, count_distinct_subgrantees, count_distinct_toplevel_grantees
	      FROM vw_grantee_crosstab_by_org_type
		  ORDER BY type DESC;
	    </cfquery>

	    <cfreturn qGranteesByOrgType>
    </cffunction>

    <cffunction name="getActiveGranteesByOrgType" access="public" output="false" returntype="Query">

	    <cfset var qActiveGranteesByOrgType = "">

	    <cfquery name="qActiveGranteesByOrgType" datasource="#dsn.getName()#">
	      SELECT type, count_distinct_allgrantees, count_distinct_subgrantees, count_distinct_toplevel_grantees
	      FROM vw_active_grantee_crosstab_by_org_type
		  ORDER BY type DESC;
	    </cfquery>

	    <cfreturn qActiveGranteesByOrgType>
    </cffunction>

    <cffunction name="getPastGranteesByOrgType" access="public" output="false" returntype="Query">

	    <cfset var qPastGranteesByOrgType = "">

	    <cfquery name="qPastGranteesByOrgType" datasource="#dsn.getName()#">
	      SELECT type, count_distinct_allgrantees, count_distinct_subgrantees, count_distinct_toplevel_grantees
	      FROM vw_past_grantee_crosstab_by_org_type
		  ORDER BY type DESC;
	    </cfquery>

	    <cfreturn qPastGranteesByOrgType>
    </cffunction>

    <cffunction name="getFutureGranteesByOrgType" access="public" output="false" returntype="Query">

	    <cfset var qFutureGranteesByOrgType = "">

	    <cfquery name="qFutureGranteesByOrgType" datasource="#dsn.getName()#">
	      SELECT type, count_distinct_allgrantees, count_distinct_subgrantees, count_distinct_toplevel_grantees
	      FROM vw_future_grantee_crosstab_by_org_type
		  ORDER BY type DESC;
	    </cfquery>

	    <cfreturn qFutureGranteesByOrgType>
    </cffunction>

    <cffunction name="getGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qGrantsByOrgType = "">

        <cfquery name="qGrantsByOrgType" datasource="#dsn.getName()#">
          SELECT type, count_distinct_allGrants, count_distinct_subGrants, count_distinct_toplevel_Grants
          FROM vw_Grant_crosstab_by_org_type
          ORDER BY type DESC;
        </cfquery>

        <cfreturn qGrantsByOrgType>
    </cffunction>

    <cffunction name="getActiveGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qActiveGrantsByOrgType = "">

        <cfquery name="qActiveGrantsByOrgType" datasource="#dsn.getName()#">
          SELECT type, count_distinct_allGrants, count_distinct_subGrants, count_distinct_toplevel_Grants
          FROM vw_active_Grant_crosstab_by_org_type
          ORDER BY type DESC;
        </cfquery>

        <cfreturn qActiveGrantsByOrgType>
    </cffunction>

    <cffunction name="getPastGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qPastGrantsByOrgType = "">

        <cfquery name="qPastGrantsByOrgType" datasource="#dsn.getName()#">
          SELECT type, count_distinct_allGrants, count_distinct_subGrants, count_distinct_toplevel_Grants
          FROM vw_past_Grant_crosstab_by_org_type
          ORDER BY type DESC;
        </cfquery>

        <cfreturn qPastGrantsByOrgType>
    </cffunction>

    <cffunction name="getFutureGrantsByOrgType" access="public" output="false" returntype="Query">

        <cfset var qFutureGrantsByOrgType = "">

        <cfquery name="qFutureGrantsByOrgType" datasource="#dsn.getName()#">
          SELECT type, count_distinct_allGrants, count_distinct_subGrants, count_distinct_toplevel_Grants
          FROM vw_future_Grant_crosstab_by_org_type
          ORDER BY type DESC;
        </cfquery>

        <cfreturn qFutureGrantsByOrgType>
    </cffunction>
<!---TODO: Refactor the eight get*Grant*ByOrgType methods down to one with paramaters --->
    <cffunction name="getGrantsByType" access="public" output="false" returntype="Query">
	    <cfargument name="LegalRegistrationStatus" required="yes" type="string">
		<cfargument name="GranteeType" required="yes" type="string">
		<cfargument name="Active" required="yes" type="string">

	    <cfset var qGrantsList = "">

	    <cfquery name="qGrantsList" datasource="#dsn.getName()#">
	      SELECT activityid, name, startdate, enddate, lastupdated
	      FROM Activity
	      WHERE 1=1
	        <cfif LegalRegistrationStatus neq 'ALL'><!---No need to filter if we want all --->
	           AND ImplementorOrgID IN (SELECT OrgID FROM Org WHERE LegalRegistrationStatus = '#arguments.LegalRegistrationStatus#')
		  	</cfif>
			<cfif arguments.GranteeType EQ 'Grantees'>
		  		AND ParentID IS NULL
			<cfelseif arguments.GranteeType EQ 'Subs'>
		  		AND ParentID IS NOT NULL
			</cfif>

			<cfif arguments.Active EQ 'Current'>
		  		AND (startdate <= '#dateformat(now(), "mm/dd/yyyy")#' AND enddate >= '#dateformat(now(), "mm/dd/yyyy")#')
			<cfelseif arguments.Active EQ 'Past'>
		  		AND enddate < '#dateformat(now(), "mm/dd/yyyy")#'
			<cfelseif arguments.Active EQ 'Future'>
		  		AND startdate > '#dateformat(now(), "mm/dd/yyyy")#'
			</cfif>

		  ORDER BY name ASC;
	    </cfquery>

	    <cfreturn qGrantsList>
    </cffunction>

	<cffunction name="getLinkedCNActivities" access="public" output="false" returntype="Query">
	    <cfargument name="ActivityID" type="numeric" required="true" />

	    <cfset var qGrantsList = "">

	    <cfquery name="qGrantsList" datasource="#dsn.getName()#">
	      SELECT activityid, proposalnumber, projectTitle
	      FROM vw_fullActivities
	      WHERE
	      cnID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
	    </cfquery>

	    <cfreturn qGrantsList>
    </cffunction>

	<cffunction name="getPotentialCNActivities" access="public" output="false" returntype="Query">
	    <cfargument name="ActivityStatusID" type="numeric" required="true" />
	    <cfargument name="ActivityID" type="numeric" required="true" />

	    <cfset var qGrantsList = "">

	    <cfquery name="qGrantsList" datasource="#dsn.getName()#">
	      SELECT activityid, proposalnumber, projectTitle
	      FROM vw_fullActivities a
	      WHERE
	      (a.activityStatusID = <cfqueryparam value="#arguments.ActivityStatusID#" CFSQLType="cf_sql_integer" /> or (a.activityStatusID > 276 and a.activityStatusID < 282))
	      and a.cnid = a.activityid
	      and isactive = 1
	      and proposalapproveddate is not null
	      and (select count(*) from activityextendedgrant where cnid = a.activityid) < 2
	      and activityid <> <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
	    </cfquery>

	    <cfreturn qGrantsList>
    </cffunction>

	<cffunction name="getActivityObjectives" access="public" output="false" returntype="Query">
	    <cfargument name="ActivityID" type="numeric" required="true" />

	    <cfset var qObjectivesList = "">

	    <cfquery name="qObjectivesList" datasource="#dsn.getName()#">
	      SELECT activityid, proposalnumber, projectTitle
	      FROM vw_fullActivities a
	      WHERE
	      (a.activityStatusID = <cfqueryparam value="#arguments.ActivityStatusID#" CFSQLType="cf_sql_integer" /> or (a.activityStatusID > 276 and a.activityStatusID < 282))
	      and a.cnid = a.activityid
	      and isactive = 1
	      and proposalapproveddate is not null
	      and (select count(*) from activityextendedgrant where cnid = a.activityid) < 2
	      and activityid <> <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
	    </cfquery>

	    <cfreturn qObjectivesList>
    </cffunction>

	<cffunction name="setLinkedCNs" access="public" output="false" returntype="boolean">
		<cfargument name="activityID" type="numeric" required="true" />
		<cfargument name="activityList" type="string" required="true" />
		<cfargument name="amcnnumber" type="string" required="true" />
		<cfargument name="cntitle" type="string" required="true" />

		<cfset var setOriginal = "" />
		<cfset var setNew = "" />
		<cfset var setParent = "" />
		<cfset var getFirst = ListFirst(arguments.activityList)>
		<!--- <cftry> --->
		<cfquery name="setOriginal" datasource="#dsn.getName()#">
			update activityextendedgrant
			set
			cnID = activityID,
			amcnnumber = NULL,
			cntitle = NULL
			where
			cnID = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
		</cfquery>



		<cfloop list="#arguments.activityList#" index="i">
   			<cfquery datasource="#dsn.getName()#" name="setNew">
				update activityextendedgrant
				set
				cnID = <cfqueryparam value="#getFirst#" CFSQLType="cf_sql_integer" />,
				amcnnumber = <cfqueryparam value="#arguments.amcnnumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.amcnnumber)#" />,
				cntitle = <cfqueryparam value="#arguments.cntitle#" CFSQLType="cf_sql_varchar" null="#not len(arguments.cntitle)#" />
				where
				activityID = <cfqueryparam value="#i#" CFSQLType="cf_sql_integer" />
			</cfquery>
  		</cfloop>


		<cfreturn true />
	</cffunction>
</cfcomponent>

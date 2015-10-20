
<cfcomponent displayname="ActivityDAO" hint="table ID column = ActivityID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="ActivityDAO">
		<cfreturn this>
	</cffunction>

	<cffunction name="create" access="public" output="false" returntype="Numeric">
		<cfargument name="Activity" type="Activity" required="true" />

		<cfset var qCreate = "" />
		<!--- <cftry> --->
		<cfif not arguments.Activity.getctex() is 1>
			<cfset ctexparam = 0>
		<cfelse>
			<cfset ctexparam = 1>
		</cfif>

			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Activity
					(
					ParentID,
					Name,
					<!--- ImplementorOrgID, --->
					Description,
					ExternalCode,
					ExternalCodeDescription,
					StartDate,
					EndDate,
					BudgetCeilingAmount,
					Currency,
					<!--- ContactPersonID,
					ContactPersonFirstName,
					ContactPersonLastName,
					ContactPersonEmail,
                    ContactPersonPhone, --->

					lastUpdated
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Activity.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getParentID())#" />,
					<cfqueryparam value="#arguments.Activity.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getName())#" />,
					<!--- <cfqueryparam value="#arguments.Activity.getImplementorOrgID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getImplementorOrgID())#" />, --->
					<cfqueryparam value="#left(arguments.Activity.getDescription(),4000)#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Activity.getDescription())#" />,
					<cfqueryparam value="#arguments.Activity.getExternalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getExternalCode())#" />,
					<cfqueryparam value="#arguments.Activity.getExternalCodeDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getExternalCodeDescription())#" />,
					<cfqueryparam value="#arguments.Activity.getStartDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getStartDate())#" />,
					<cfqueryparam value="#arguments.Activity.getEndDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getEndDate())#" />,
					<cfqueryparam value="#arguments.Activity.getBudgetCeilingAmount()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getBudgetCeilingAmount())#" />,
					<cfqueryparam value="#arguments.Activity.getCurrency()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getCurrency())#" />,
					<!--- <cfqueryparam value="#arguments.Activity.getContactPersonID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getContactPersonID())#" />,
					<cfqueryparam value="#arguments.Activity.getContactPersonFirstName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonFirstName())#" />,
					<cfqueryparam value="#arguments.Activity.getContactPersonLastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonLastName())#" />,
					<cfqueryparam value="#arguments.Activity.getContactPersonEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonEmail())#" />,
                    <cfqueryparam value="#arguments.Activity.getContactPersonPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonphone())#" />, --->
                    getDate()
					)
				SELECT @@Identity as ActivityID
			</cfquery>
			<cfquery name="qCreateExtended" datasource="#dsn.getName()#">
				INSERT INTO ActivityExtendedGrant
					(
					ActivityID,
					TotalCostShare,
					CostShareToDate,
					programID,
					projectObjective,
					interestSpecification,
					lawEnforcementSpecification,
					coordinationSpecification,
					programAudience,
					fundImpMechanismID,
					activityStatusID,
					ProposalNumber,
					AMCNnumber,
					proposalSubmitDate,
					clearedPrelegalDate,
					proposalApprovedDate,
					AMCNBudgetSubmitDate,
					AMCNCongressSubmitDate,
					AMCNApprovedDate,
					FundApprovedDate,
					BudgetFundRequestDate,
					BudgetFundApprovalDate,
					placeOfImplementation,
					isActive,
					implementingPartner,
					fiscalYear,
					lessonsLearned,
					sustainability,
					cityProvince,
					cnid,
					sysUserID,
					ctex,
					relatedProjects
					)
				VALUES
					(
					<cfqueryparam value="#qCreate.ActivityID#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Activity.getTotalCostShare()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getTotalCostShare())#" />,
					<cfqueryparam value="#arguments.Activity.getCostShareToDate()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getCostShareToDate())#" />,
					<cfqueryparam value="#arguments.Activity.getprogramID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getprogramID())#" />,
					<cfqueryparam value="#left(arguments.Activity.getprojectObjective(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getprojectObjective())#" />,
					<cfqueryparam value="#left(arguments.Activity.getinterestSpecification(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getinterestSpecification())#" />,
					<cfqueryparam value="#left(arguments.Activity.getlawEnforcementSpecification(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getlawEnforcementSpecification())#" />,
					<cfqueryparam value="#left(arguments.Activity.getcoordinationSpecification(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getcoordinationSpecification())#" />,
					<cfqueryparam value="#left(arguments.Activity.getprogramAudience(),255)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getprogramAudience())#" />,
					<cfqueryparam value="#arguments.Activity.getfundImpMechanismID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getfundImpMechanismID())#" />,
					<cfqueryparam value="#arguments.Activity.getactivityStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getactivityStatusID())#" />,
					<cfqueryparam value="#arguments.Activity.getProposalNumber()#-#qCreate.ActivityID#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getProposalNumber())#" />,
					<cfqueryparam value="#arguments.Activity.getAMCNnumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getAMCNnumber())#" />,
					<cfqueryparam value="#arguments.Activity.getproposalSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getproposalSubmitDate())#" />,
					<cfqueryparam value="#arguments.Activity.getclearedPrelegalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getclearedPrelegalDate())#" />,
					<cfqueryparam value="#arguments.Activity.getproposalApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getproposalApprovedDate())#" />,
					<cfqueryparam value="#arguments.Activity.getAMCNBudgetSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNBudgetSubmitDate())#" />,
					<cfqueryparam value="#arguments.Activity.getAMCNCongressSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNCongressSubmitDate())#" />,
					<cfqueryparam value="#arguments.Activity.getAMCNApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNApprovedDate())#" />,
					<cfqueryparam value="#arguments.Activity.getFundApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getFundApprovedDate())#" />,
					<cfqueryparam value="#arguments.Activity.getBudgetFundRequestDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getBudgetFundRequestDate())#" />,
					<cfqueryparam value="#arguments.Activity.getBudgetFundApprovalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getBudgetFundApprovalDate())#" />,
					<cfqueryparam value="#arguments.Activity.getplaceOfImplementation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getplaceOfImplementation())#" />,
					1,
					<cfqueryparam value="#arguments.Activity.getimplementingPartner()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getimplementingPartner())#" />,
					<cfqueryparam value="#arguments.Activity.getfiscalYear()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getfiscalYear())#" />,
					<cfqueryparam value="#left(arguments.Activity.getlessonsLearned(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getlessonsLearned())#" />,
					<cfqueryparam value="#left(arguments.Activity.getsustainability(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getsustainability())#" />,
					<cfqueryparam value="#arguments.Activity.getcityProvince()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getcityProvince())#" />,
					<cfqueryparam value="#qCreate.ActivityID#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Activity.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getsysUserID())#" />,
					<cfqueryparam value="#ctexparam#" CFSQLType="cf_sql_bit"  />,
					<cfqueryparam value="#left(arguments.Activity.getrelatedProjects(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getrelatedProjects())#" />
					)
			</cfquery>

			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn qCreate.ActivityID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Activity" type="Activity" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />

			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					Activity.ActivityID,
					Activity.ParentID,
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
					<!--- Activity.ContactPersonID,
					Activity.ContactPersonFirstName,
					Activity.ContactPersonLastName,
					Activity.ContactPersonEmail,
					Activity.ContactPersonPhone, --->
					ActivityExtendedGrant.TotalCostShare,
					ActivityExtendedGrant.SectorID,
					ActivityExtendedGrant.CostShareToDate,
					ActivityExtendedGrant.programID,
					Program.Name as ProgramName,
					ActivityExtendedGrant.projectObjective,
					ActivityExtendedGrant.interestSpecification,
					ActivityExtendedGrant.lawEnforcementSpecification,
					ActivityExtendedGrant.coordinationSpecification,
					ActivityExtendedGrant.programAudience,
					ActivityExtendedGrant.fundImpMechanismID,
					CategoryFund.name as fundImpMechanism,
					ActivityExtendedGrant.activityStatusID,
					CategoryStatus1.name as aactivityStatus,
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
					ActivityExtendedGrant.lessonsLearned,
					ActivityExtendedGrant.sustainability,
					ActivityExtendedGrant.sysUserID
				FROM Activity
            LEFT OUTER JOIN ActivityExtendedGrant ON Activity.ActivityID = ActivityExtendedGrant.ActivityID
            <!--- LEFT OUTER JOIN Org ON Activity.ImplementorOrgID = Org.OrgID --->
			LEFT OUTER JOIN Program ON (Program.programID=ActivityExtendedGrant.programID)
			LEFT OUTER JOIN Category CategoryStatus1 ON (CategoryStatus1.CategoryID = ActivityExtendedGrant.activityStatusID)
			LEFT OUTER JOIN Category CategoryFund ON (CategoryFund.CategoryID = ActivityExtendedGrant.fundImpMechanismID)
				WHERE	Activity.ActivityID = <cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Activity.init(argumentCollection=strReturn)>
		<cfelse>
		  <cfthrow type="IndexOutOfRangeException" message="No Activity found matching the request criteria (arguments.Activity.getActivityID()=#arguments.Activity.getActivityID()#)." />
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="Numeric">
		<cfargument name="Activity" type="Activity" required="true" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<!---TODO: wrap the multiple database calls here in a TRANSACTION
				so that if one fails, all get rolled back. Partial success here
				would be dangerous and hard to debug later.
			--->
				<cfquery name="qUpdate" datasource="#dsn.getName()#">
					UPDATE	Activity
					SET
						ParentID = <cfqueryparam value="#arguments.Activity.getParentID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getParentID())#" />,
						Name = <cfqueryparam value="#left(arguments.Activity.getName(),255)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getName())#" />,
						<!--- ImplementorOrgID = <cfqueryparam value="#arguments.Activity.getImplementorOrgID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getImplementorOrgID())#" />, --->
						Description = <cfqueryparam value="#left(arguments.Activity.getDescription(),4000)#" CFSQLType="cf_sql_longvarchar" null="#not len(arguments.Activity.getDescription())#" />,
						ExternalCode = <cfqueryparam value="#arguments.Activity.getExternalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getExternalCode())#" />,
						ExternalCodeDescription = <cfqueryparam value="#arguments.Activity.getExternalCodeDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getExternalCodeDescription())#" />,
						StartDate = <cfqueryparam value="#arguments.Activity.getStartDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getStartDate())#" />,
						EndDate = <cfqueryparam value="#arguments.Activity.getEndDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getEndDate())#" />,
						BudgetCeilingAmount = <cfqueryparam value="#arguments.Activity.getBudgetCeilingAmount()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getBudgetCeilingAmount())#" />,
						Currency = <cfqueryparam value="#arguments.Activity.getCurrency()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getCurrency())#" />,
						<!--- ContactPersonID = <cfqueryparam value="#arguments.Activity.getContactPersonID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getContactPersonID())#" />,
						ContactPersonFirstName = <cfqueryparam value="#arguments.Activity.getContactPersonFirstName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonFirstName())#" />,
						ContactPersonLastName = <cfqueryparam value="#arguments.Activity.getContactPersonLastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonLastName())#" />,
						ContactPersonEmail = <cfqueryparam value="#arguments.Activity.getContactPersonEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonEmail())#" />,
	                    ContactPersonPhone = <cfqueryparam value="#arguments.Activity.getContactPersonPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getContactPersonEmail())#" />, --->
	                    lastUpdated = getdate()
					WHERE	ActivityID = <cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />
				</cfquery>
				<cfquery name="qCheckExtended" datasource="#dsn.getName()#">
					SELECT count(activityid) as number
					FROM ActivityExtendedGrant
					WHERE ActivityExtendedGrant.activityID = <cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />
				</cfquery>

				<cfif qCheckExtended.number gt 0>
					<cfquery name="qUpdateExtended" datasource="#dsn.getName()#">
						UPDATE	ActivityExtendedGrant
						SET
							TotalCostShare = <cfqueryparam value="#arguments.Activity.getTotalCostShare()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getTotalCostShare())#" />,
							CostShareToDate = <cfqueryparam value="#arguments.Activity.getCostShareToDate()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getCostShareToDate())#" />,
							programID = <cfqueryparam value="#arguments.Activity.getprogramID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getprogramID())#" />,
							projectObjective = <cfqueryparam value="#left(arguments.Activity.getprojectObjective(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getprojectObjective())#" />,
							interestSpecification = <cfqueryparam value="#left(arguments.Activity.getinterestSpecification(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getinterestSpecification())#" />,
							lawEnforcementSpecification = <cfqueryparam value="#left(arguments.Activity.getlawEnforcementSpecification(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getlawEnforcementSpecification())#" />,
							coordinationSpecification = <cfqueryparam value="#left(arguments.Activity.getcoordinationSpecification(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getcoordinationSpecification())#" />,
							programAudience = <cfqueryparam value="#left(arguments.Activity.getprogramAudience(),255)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getprogramAudience())#" />,
							fundImpMechanismID = <cfqueryparam value="#arguments.Activity.getfundImpMechanismID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getfundImpMechanismID())#" />,
							activityStatusID = <cfqueryparam value="#arguments.Activity.getactivityStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getactivityStatusID())#" />,
							<!--- ProposalNumber = <cfqueryparam value="#arguments.Activity.getProposalNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getProposalNumber())#" />, --->
							AMCNnumber = <cfqueryparam value="#arguments.Activity.getAMCNnumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getAMCNnumber())#" />,
							proposalSubmitDate = <cfqueryparam value="#arguments.Activity.getproposalSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getproposalSubmitDate())#" />,
							clearedPrelegalDate = <cfqueryparam value="#arguments.Activity.getclearedPrelegalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getclearedPrelegalDate())#" />,
							proposalApprovedDate = <cfqueryparam value="#arguments.Activity.getproposalApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getproposalApprovedDate())#" />,
							AMCNBudgetSubmitDate = <cfqueryparam value="#arguments.Activity.getAMCNBudgetSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNBudgetSubmitDate())#" />,
							AMCNCongressSubmitDate = <cfqueryparam value="#arguments.Activity.getAMCNCongressSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNCongressSubmitDate())#" />,
							AMCNApprovedDate = <cfqueryparam value="#arguments.Activity.getAMCNApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNApprovedDate())#" />,
							FundApprovedDate = <cfqueryparam value="#arguments.Activity.getFundApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getFundApprovedDate())#" />,
							BudgetFundRequestDate = <cfqueryparam value="#arguments.Activity.getBudgetFundRequestDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getBudgetFundRequestDate())#" />,
							BudgetFundApprovalDate = <cfqueryparam value="#arguments.Activity.getBudgetFundApprovalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getBudgetFundApprovalDate())#" />,
							placeOfImplementation = <cfqueryparam value="#arguments.Activity.getplaceOfImplementation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getplaceOfImplementation())#" />,
							implementingPartner = <cfqueryparam value="#arguments.Activity.getimplementingPartner()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getimplementingPartner())#" />,
							 reprogramFunds = <cfqueryparam value="#arguments.Activity.getreprogramFunds()#" CFSQLType="cf_sql_bit" null="#not len(arguments.Activity.getreprogramFunds())#" />,
							 ctex = <cfqueryparam value="#arguments.Activity.getctex()#" CFSQLType="cf_sql_bit" null="#not len(arguments.Activity.getctex())#" />,
							reprogramComments = <cfqueryparam value="#left(arguments.Activity.getreprogramComments(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getreprogramComments())#" />,
							lessonsLearned = <cfqueryparam value="#left(arguments.Activity.getlessonsLearned(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getlessonsLearned())#" />,
							sustainability = <cfqueryparam value="#left(arguments.Activity.getsustainability(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getsustainability())#" />,
							cityProvince = <cfqueryparam value="#arguments.Activity.getcityProvince()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getcityProvince())#" />,
							sysUserID = <cfqueryparam value="#arguments.Activity.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getsysUserID())#" />,
							fiscalYear = <cfqueryparam value="#arguments.Activity.getfiscalYear()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getfiscalYear())#" />,
							cnID = <cfqueryparam value="#arguments.Activity.getcnID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getcnID())#" />,
							cnTitle = <cfqueryparam value="#arguments.Activity.getcnTitle()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getcnTitle())#" />,
							relatedProjects = <cfqueryparam value="#left(arguments.Activity.getrelatedProjects(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getrelatedProjects())#" />
						WHERE	ActivityID = <cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />
					</cfquery>
				<cfelse>
					<cfquery name="qCreateExtended" datasource="#dsn.getName()#">
						INSERT INTO ActivityExtendedGrant
							(
							ActivityID,
							TotalCostShare,
							CostShareToDate,
							programID,
							projectObjective,
							interestSpecification,
							lawEnforcementSpecification,
							coordinationSpecification,
							programAudience,
							fundImpMechanismID,
							activityStatusID,
							ProposalNumber,
							AMCNnumber,
							proposalSubmitDate,
							clearedPrelegalDate,
							proposalApprovedDate,
							AMCNBudgetSubmitDate,
							AMCNCongressSubmitDate,
							AMCNApprovedDate,
							FundApprovedDate,
							BudgetFundRequestDate,
							BudgetFundApprovalDate,
							placeOfImplementation,
							isActive,
							implementingPartner,
							fiscalYear,
							lessonsLearned,
							sustainability,
							cityProvince,
							sysUserID,
							relatedProjects
							)
						VALUES
							(
							<cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />,
							<cfqueryparam value="#arguments.Activity.getTotalCostShare()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getTotalCostShare())#" />,
							<cfqueryparam value="#arguments.Activity.getCostShareToDate()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getCostShareToDate())#" />,
							<cfqueryparam value="#arguments.Activity.getprogramID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getprogramID())#" />,
							<cfqueryparam value="#left(arguments.Activity.getprojectObjective(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getprojectObjective())#" />,
							<cfqueryparam value="#left(arguments.Activity.getinterestSpecification(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getinterestSpecification())#" />,
							<cfqueryparam value="#left(arguments.Activity.getlawEnforcementSpecification(),1000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getlawEnforcementSpecification())#" />,
							<cfqueryparam value="#left(arguments.Activity.getcoordinationSpecification(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getcoordinationSpecification())#" />,
							<cfqueryparam value="#left(arguments.Activity.getprogramAudience(),255)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getprogramAudience())#" />,
							<cfqueryparam value="#arguments.Activity.getfundImpMechanismID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getfundImpMechanismID())#" />,
							<cfqueryparam value="#arguments.Activity.getactivityStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getactivityStatusID())#" />,
							<cfqueryparam value="#arguments.Activity.getProposalNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getProposalNumber())#" />,
							<cfqueryparam value="#arguments.Activity.getAMCNnumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getAMCNnumber())#" />,
							<cfqueryparam value="#arguments.Activity.getproposalSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getproposalSubmitDate())#" />,
							<cfqueryparam value="#arguments.Activity.getclearedPrelegalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getclearedPrelegalDate())#" />,
							<cfqueryparam value="#arguments.Activity.getproposalApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getproposalApprovedDate())#" />,
							<cfqueryparam value="#arguments.Activity.getAMCNBudgetSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNBudgetSubmitDate())#" />,
							<cfqueryparam value="#arguments.Activity.getAMCNCongressSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNCongressSubmitDate())#" />,
							<cfqueryparam value="#arguments.Activity.getAMCNApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getAMCNApprovedDate())#" />,
							<cfqueryparam value="#arguments.Activity.getFundApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getFundApprovedDate())#" />,
							<cfqueryparam value="#arguments.Activity.getBudgetFundRequestDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getBudgetFundRequestDate())#" />,
							<cfqueryparam value="#arguments.Activity.getBudgetFundApprovalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.Activity.getBudgetFundApprovalDate())#" />,
							<cfqueryparam value="#arguments.Activity.getplaceOfImplementation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getplaceOfImplementation())#" />,
							<cfqueryparam value="#arguments.Activity.getisActive()#" CFSQLType="cf_sql_bit" null="#not len(arguments.Activity.getisActive())#" />,
							<cfqueryparam value="#arguments.Activity.getimplementingPartner()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getimplementingPartner())#" />,
							<cfqueryparam value="#arguments.Activity.getfiscalYear()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getfiscalYear())#" />,
							<cfqueryparam value="#left(arguments.Activity.getlessonsLearned(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getlessonsLearned())#" />,
							<cfqueryparam value="#left(arguments.Activity.getsustainability(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getsustainability())#" />,
							<cfqueryparam value="#arguments.Activity.getcityProvince()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getcityProvince())#" />,
							<cfqueryparam value="#arguments.Activity.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Activity.getsysUserID())#" />,
							<cfqueryparam value="#left(arguments.Activity.getrelatedProjects(),4000)#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Activity.getrelatedProjects())#" />
							)
					</cfquery>
				</cfif>

			<!--- <cfcatch type="database"> --->
				<!---TODO: Remove catches that don't do anything.
					This pattern is not healthy. Methods that change an object
					passed as an input parameter (in this case the Activity
					passed in) should return the changed object. This is less
					magical than the caller knowing that this new info is
					accessible by reference.

					What would the caller do with a -1 returned from this
					method? It would be hard to know what to do as the Catch
					here is around so many query calls. You end up having to
					test for success on every call, but not being able to do
					anything for the user if the call fails.

					It is better to fail here then fail higher up the call
					stack. Therefore, remove the try/catch altogether and
					refactor to return either VOID or the changed Activity object.

					This advice is general and should be applied to all cases
					where returns are 'codes' that require interpretation (which
					applies in this case because the caller needs to know that
					-1 is out-of-range for ActivityIDs) or Booleans to indicate
					that a method successfully completed.
					--->
				<!--- <cfreturn -1 />
			</cfcatch>
		</cftry> --->
		<cfreturn arguments.Activity.getActivityID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Activity" type="Activity" required="true" />

		<cfset var qDelete = "">
		<cftry>

			<cfquery name="qDelete1" datasource="#dsn.getName()#">
				DELETE FROM	Activity
				WHERE	ActivityID = <cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<cfquery name="qDelete2" datasource="#dsn.getName()#">
				DELETE FROM	ActivityExtendedGrant
				WHERE	ActivityID = <cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Activity" type="Activity" required="true" />

		<cfset var qExists = "">
		<cfif arguments.Activity.getActivityID() is not "">
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	Activity
				WHERE	ActivityID = <cfqueryparam value="#arguments.Activity.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<cfif qExists.idexists>
				<cfreturn true />
			<cfelse>
				<cfreturn false />
			</cfif>
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Activity" type="Activity" required="true" />

		<cfset var success = false />
		<cfif exists(arguments.Activity)>
			<cfset success = update(arguments.Activity) />
		<cfelse>
			<cfset success = create(arguments.Activity) />
		</cfif>

		<cfreturn success />
	</cffunction>

	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<!---TODO: Refactor this method and move it into an application scoped utility library.
		There are about 30 declarations of this method throughout the app.
		--->
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

	<cffunction name="getGrantName" access="public" output="false" returntype="query">
		<cfset var qGrantName = "">

		<cfquery name="qGrantName" datasource="#dsn.getName()#" maxrows="1">
			SELECT Name
			FROM Activity
			WHERE ActivityID = <cfqueryparam value="#form.activityID#" maxlength="6">;
		</cfquery>

		<cfreturn qGrantName />
	</cffunction>

</cfcomponent>

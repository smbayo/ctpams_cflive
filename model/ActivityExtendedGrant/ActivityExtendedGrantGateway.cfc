<cfcomponent displayname="ActivityExtendedGrantGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityExtendedGrantGateway">
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="TotalCostShare" type="numeric" required="false" />
		<cfargument name="SectorID" type="numeric" required="false" />
		<cfargument name="CostShareToDate" type="numeric" required="false" />
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
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="regionalApprovedDate" type="date" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ActivityID,
				TotalCostShare,
				SectorID,
				CostShareToDate,
				programID,
				projectObjective,
				interestSpecification,
				lawEnforcementSpecification,
				coordinationSpecification,
				programAudience,
				fundImpMechanismID,
				ActivityStatusID,
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
				sysUserID,
				cntitle,
				cnid,
				proposalApprovedDate
			FROM	ActivityExtendedGrant
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"TotalCostShare") and len(arguments.TotalCostShare)>
			AND	TotalCostShare = <cfqueryparam value="#arguments.TotalCostShare#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"SectorID") and len(arguments.SectorID)>
			AND	SectorID = <cfqueryparam value="#arguments.SectorID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CostShareToDate") and len(arguments.CostShareToDate)>
			AND	CostShareToDate = <cfqueryparam value="#arguments.CostShareToDate#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"programID") and len(arguments.programID)>
			AND	programID = <cfqueryparam value="#arguments.programID#" CFSQLType="cf_sql_integer" />
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
			AND	programAudience = <cfqueryparam value="#arguments.programAudience#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"fundImpMechanismID") and len(arguments.fundImpMechanismID)>
			AND	fundImpMechanismID = <cfqueryparam value="#arguments.fundImpMechanismID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityStatusID") and len(arguments.ActivityStatusID)>
			AND	ActivityStatusID = <cfqueryparam value="#arguments.ActivityStatusID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ProposalNumber") and len(arguments.ProposalNumber)>
			AND	ProposalNumber = <cfqueryparam value="#arguments.ProposalNumber#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNnumber") and len(arguments.AMCNnumber)>
			AND	AMCNnumber = <cfqueryparam value="#arguments.AMCNnumber#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"proposalSubmitDate") and len(arguments.proposalSubmitDate)>
			AND	proposalSubmitDate = <cfqueryparam value="#arguments.proposalSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"clearedPrelegalDate") and len(arguments.clearedPrelegalDate)>
			AND	clearedPrelegalDate = <cfqueryparam value="#arguments.clearedPrelegalDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"proposalApprovedDate") and len(arguments.proposalApprovedDate)>
			AND	proposalApprovedDate = <cfqueryparam value="#arguments.proposalApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNBudgetSubmitDate") and len(arguments.AMCNBudgetSubmitDate)>
			AND	AMCNBudgetSubmitDate = <cfqueryparam value="#arguments.AMCNBudgetSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNCongressSubmitDate") and len(arguments.AMCNCongressSubmitDate)>
			AND	AMCNCongressSubmitDate = <cfqueryparam value="#arguments.AMCNCongressSubmitDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"AMCNApprovedDate") and len(arguments.AMCNApprovedDate)>
			AND	AMCNApprovedDate = <cfqueryparam value="#arguments.AMCNApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"FundApprovedDate") and len(arguments.FundApprovedDate)>
			AND	FundApprovedDate = <cfqueryparam value="#arguments.FundApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetFundRequestDate") and len(arguments.BudgetFundRequestDate)>
			AND	BudgetFundRequestDate = <cfqueryparam value="#arguments.BudgetFundRequestDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetFundApprovalDate") and len(arguments.BudgetFundApprovalDate)>
			AND	BudgetFundApprovalDate = <cfqueryparam value="#arguments.BudgetFundApprovalDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"placeOfImplementation") and len(arguments.placeOfImplementation)>
			AND	placeOfImplementation = <cfqueryparam value="#arguments.placeOfImplementation#" CFSQLType="cf_sql_varchar" />
		</cfif>		
		<cfif structKeyExists(arguments,"isActive") and len(arguments.isActive)>
			AND	isActive = <cfqueryparam value="#arguments.isActive#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments,"sysUserID") and len(arguments.sysUserID)>
			AND	sysUserID = <cfqueryparam value="#arguments.sysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"regionalApprovedDate") and len(arguments.regionalApprovedDate)>
			AND	regionalApprovedDate = <cfqueryparam value="#arguments.regionalApprovedDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="TotalCostShare" type="numeric" required="false" />
		<cfargument name="SectorID" type="numeric" required="false" />
		<cfargument name="CostShareToDate" type="numeric" required="false" />
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
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="regionalApprovedDate" type="date" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ActivityExtendedGrant").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
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

	<cffunction name="updateByAttributes" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="ActivityStatusID" type="numeric" required="false" />
		<cfargument name="ProposalNumber" type="string" required="false" />
		<cfargument name="proposalSubmitDate" type="string" required="false" />
		<cfargument name="clearedPrelegalDate" type="string" required="false" />
		<cfargument name="proposalApprovedDate" type="date" required="false" />
		<cfargument name="AMCNBudgetSubmitDate" type="date" required="false" />
		<cfargument name="AMCNCongressSubmitDate" type="date" required="false" />
		<cfargument name="AMCNnumber" type="string" required="false" />
		<cfargument name="AMCNApprovedDate" type="date" required="false" />
		<cfargument name="fundImpMechanismID" type="numeric" required="false" />
		<cfargument name="BudgetFundRequestDate" type="date" required="false" />
		<cfargument name="BudgetFundApprovalDate" type="date" required="false" />		
		<cfargument name="FundApprovedDate" type="date" required="false" />
		<cfargument name="placeOfImplementation" type="string" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="regionalApprovedDate" type="date" required="false" />
		<cfargument name="reprogramFunds" type="boolean" required="false" />
		<cfargument name="reprogramComments" type="string" required="false" />
		<cfargument name="implementationStatus" type="string" required="false" />
		<cfargument name="bureauTransferPOC" type="string" required="false" />
		
		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityExtendedGrant
				SET
				ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
				<cfif structKeyExists(arguments,"ActivityStatusID") and len(arguments.ActivityStatusID)>
					,ActivityStatusID = <cfqueryparam value="#arguments.ActivityStatusID#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityStatusID)#" />
				</cfif>
				<cfif structKeyExists(arguments,"ProposalNumber") and len(arguments.ProposalNumber)>
					,ProposalNumber = <cfqueryparam value="#arguments.ProposalNumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ProposalNumber)#" />
				</cfif>
				<cfif structKeyExists(arguments,"proposalSubmitDate") and len(arguments.proposalSubmitDate)>
					,proposalSubmitDate = <cfqueryparam value="#arguments.proposalSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.proposalSubmitDate)#" />
				</cfif>	
				<cfif structKeyExists(arguments,"clearedPrelegalDate") and len(arguments.clearedPrelegalDate)>
					,clearedPrelegalDate = <cfqueryparam value="#arguments.clearedPrelegalDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.clearedPrelegalDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"proposalApprovedDate") and len(arguments.proposalApprovedDate)>
					,proposalApprovedDate = <cfqueryparam value="#arguments.proposalApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.proposalApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"regionalApprovedDate") and len(arguments.regionalApprovedDate)>
					,regionalApprovedDate = <cfqueryparam value="#arguments.regionalApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.regionalApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNBudgetSubmitDate") and len(arguments.AMCNBudgetSubmitDate)>
					,AMCNBudgetSubmitDate = <cfqueryparam value="#arguments.AMCNBudgetSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AMCNBudgetSubmitDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNCongressSubmitDate") and len(arguments.AMCNCongressSubmitDate)>
					,AMCNCongressSubmitDate = <cfqueryparam value="#arguments.AMCNCongressSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AMCNCongressSubmitDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNnumber") and len(arguments.AMCNnumber)>
					,AMCNnumber = <cfqueryparam value="#arguments.AMCNnumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AMCNnumber)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNApprovedDate") and len(arguments.AMCNApprovedDate)>
					,AMCNApprovedDate = <cfqueryparam value="#arguments.AMCNApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AMCNApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"fundImpMechanismID") and len(arguments.fundImpMechanismID)>
					,fundImpMechanismID = <cfqueryparam value="#arguments.fundImpMechanismID#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"BudgetFundRequestDate") and len(arguments.BudgetFundRequestDate)>
					,BudgetFundRequestDate = <cfqueryparam value="#arguments.BudgetFundRequestDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.BudgetFundRequestDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"BudgetFundApprovalDate") and len(arguments.BudgetFundApprovalDate)>
					,BudgetFundApprovalDate = <cfqueryparam value="#arguments.BudgetFundApprovalDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.BudgetFundApprovalDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"FundApprovedDate") and len(arguments.FundApprovedDate)>
					,FundApprovedDate = <cfqueryparam value="#arguments.FundApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.FundApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"placeOfImplementation") and len(arguments.placeOfImplementation)>
					,placeOfImplementation = <cfqueryparam value="#arguments.placeOfImplementation#" CFSQLType="cf_sql_varchar" null="#not len(arguments.placeOfImplementation)#" />
				</cfif>
				<cfif structKeyExists(arguments,"isActive") and len(arguments.isActive)>
					,isActive = <cfqueryparam value="#arguments.isActive#" CFSQLType="cf_sql_integer" null="#not len(arguments.isActive)#" />
				</cfif>
				<cfif structKeyExists(arguments,"reprogramFunds") and len(arguments.reprogramFunds)>
					,reprogramFunds = <cfqueryparam value="#arguments.reprogramFunds#" CFSQLType="cf_sql_integer" null="#not len(arguments.reprogramFunds)#" />
				</cfif>		
				<cfif structKeyExists(arguments,"reprogramComments") and len(arguments.reprogramComments)>
					,reprogramComments = <cfqueryparam value="#arguments.reprogramComments#" CFSQLType="cf_sql_varchar" null="#not len(arguments.reprogramComments)#" />
				</cfif>	
				<cfif structKeyExists(arguments,"implementationStatus") and len(arguments.implementationStatus)>
					,implementationStatus = <cfqueryparam value="#arguments.implementationStatus#" CFSQLType="cf_sql_varchar" null="#not len(arguments.implementationStatus)#" />
				</cfif>	
				<cfif structKeyExists(arguments,"bureauTransferPOC") and len(arguments.bureauTransferPOC)>
					,bureauTransferPOC = <cfqueryparam value="#arguments.bureauTransferPOC#" CFSQLType="cf_sql_varchar" null="#not len(arguments.bureauTransferPOC)#" />
				</cfif>					
				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>	


	<cffunction name="updateByCN" access="public" output="false" returntype="boolean">
		<cfargument name="cnID" type="numeric" required="true" />
		<cfargument name="ActivityStatusID" type="numeric" required="false" />
		<cfargument name="ProposalNumber" type="string" required="false" />
		<cfargument name="proposalSubmitDate" type="string" required="false" />
		<cfargument name="clearedPrelegalDate" type="string" required="false" />
		<cfargument name="proposalApprovedDate" type="date" required="false" />
		<cfargument name="AMCNBudgetSubmitDate" type="date" required="false" />
		<cfargument name="AMCNCongressSubmitDate" type="date" required="false" />
		<cfargument name="AMCNnumber" type="string" required="false" />
		<cfargument name="AMCNApprovedDate" type="date" required="false" />
		<cfargument name="fundImpMechanismID" type="numeric" required="false" />
		<cfargument name="BudgetFundRequestDate" type="date" required="false" />
		<cfargument name="BudgetFundApprovalDate" type="date" required="false" />		
		<cfargument name="FundApprovedDate" type="date" required="false" />
		<cfargument name="placeOfImplementation" type="string" required="false" />
		<cfargument name="isActive" type="boolean" required="false" />
		<cfargument name="regionalApprovedDate" type="date" required="false" />
		<cfargument name="reprogramFunds" type="boolean" required="false" />
		<cfargument name="reprogramComments" type="string" required="false" />
		<cfargument name="cntitle" type="string" required="false" />

		
		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityExtendedGrant
				SET
				cnID = <cfqueryparam value="#arguments.cnID#" CFSQLType="cf_sql_integer" />
				<cfif structKeyExists(arguments,"ActivityStatusID") and len(arguments.ActivityStatusID)>
					,ActivityStatusID = <cfqueryparam value="#arguments.ActivityStatusID#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityStatusID)#" />
				</cfif>
				<cfif structKeyExists(arguments,"ProposalNumber") and len(arguments.ProposalNumber)>
					,ProposalNumber = <cfqueryparam value="#arguments.ProposalNumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ProposalNumber)#" />
				</cfif>
				<cfif structKeyExists(arguments,"proposalSubmitDate") and len(arguments.proposalSubmitDate)>
					,proposalSubmitDate = <cfqueryparam value="#arguments.proposalSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.proposalSubmitDate)#" />
				</cfif>	
				<cfif structKeyExists(arguments,"clearedPrelegalDate") and len(arguments.clearedPrelegalDate)>
					,clearedPrelegalDate = <cfqueryparam value="#arguments.clearedPrelegalDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.clearedPrelegalDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"proposalApprovedDate") and len(arguments.proposalApprovedDate)>
					,proposalApprovedDate = <cfqueryparam value="#arguments.proposalApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.proposalApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"regionalApprovedDate") and len(arguments.regionalApprovedDate)>
					,regionalApprovedDate = <cfqueryparam value="#arguments.regionalApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.regionalApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNBudgetSubmitDate") and len(arguments.AMCNBudgetSubmitDate)>
					,AMCNBudgetSubmitDate = <cfqueryparam value="#arguments.AMCNBudgetSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AMCNBudgetSubmitDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNCongressSubmitDate") and len(arguments.AMCNCongressSubmitDate)>
					,AMCNCongressSubmitDate = <cfqueryparam value="#arguments.AMCNCongressSubmitDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AMCNCongressSubmitDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNnumber") and len(arguments.AMCNnumber)>
					,AMCNnumber = <cfqueryparam value="#arguments.AMCNnumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AMCNnumber)#" />
				</cfif>
				<cfif structKeyExists(arguments,"AMCNApprovedDate") and len(arguments.AMCNApprovedDate)>
					,AMCNApprovedDate = <cfqueryparam value="#arguments.AMCNApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.AMCNApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"fundImpMechanismID") and len(arguments.fundImpMechanismID)>
					,fundImpMechanismID = <cfqueryparam value="#arguments.fundImpMechanismID#" CFSQLType="cf_sql_integer" />
				</cfif>
				<cfif structKeyExists(arguments,"BudgetFundRequestDate") and len(arguments.BudgetFundRequestDate)>
					,BudgetFundRequestDate = <cfqueryparam value="#arguments.BudgetFundRequestDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.BudgetFundRequestDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"BudgetFundApprovalDate") and len(arguments.BudgetFundApprovalDate)>
					,BudgetFundApprovalDate = <cfqueryparam value="#arguments.BudgetFundApprovalDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.BudgetFundApprovalDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"FundApprovedDate") and len(arguments.FundApprovedDate)>
					,FundApprovedDate = <cfqueryparam value="#arguments.FundApprovedDate#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.FundApprovedDate)#" />
				</cfif>
				<cfif structKeyExists(arguments,"placeOfImplementation") and len(arguments.placeOfImplementation)>
					,placeOfImplementation = <cfqueryparam value="#arguments.placeOfImplementation#" CFSQLType="cf_sql_varchar" null="#not len(arguments.placeOfImplementation)#" />
				</cfif>
				<cfif structKeyExists(arguments,"isActive") and len(arguments.isActive)>
					,isActive = <cfqueryparam value="#arguments.isActive#" CFSQLType="cf_sql_integer" null="#not len(arguments.isActive)#" />
				</cfif>
				<cfif structKeyExists(arguments,"reprogramFunds") and len(arguments.reprogramFunds)>
					,reprogramFunds = <cfqueryparam value="#arguments.reprogramFunds#" CFSQLType="cf_sql_integer" null="#not len(arguments.reprogramFunds)#" />
				</cfif>		
				<cfif structKeyExists(arguments,"reprogramComments") and len(arguments.reprogramComments)>
					,reprogramComments = <cfqueryparam value="#arguments.reprogramComments#" CFSQLType="cf_sql_varchar" null="#not len(arguments.reprogramComments)#" />
				</cfif>	
				<cfif structKeyExists(arguments,"cntitle") and len(arguments.cntitle)>
					,cntitle = <cfqueryparam value="#arguments.cntitle#" CFSQLType="cf_sql_varchar" null="#not len(arguments.cntitle)#" />
				</cfif>		
				WHERE	activityid in (select activityid from activitycn where cnid = <cfqueryparam value="#arguments.cnID#" CFSQLType="cf_sql_integer" />) 
			</cfquery>

		<cfreturn true />
	</cffunction>
	
	<cffunction name="getActivityStatus" access="public" output="false" returntype="string">
		<cfargument name="ActivityID" type="numeric" required="false" />
		
		<cfset var qstatus = getByAttributesQuery(argumentCollection=arguments) />	
		<cfset var theStatusID = qstatus.ActivityStatusID />
		
		<cfreturn theStatusID />
	</cffunction>
	
	<!--- <cffunction name="updateActivityCNNumber" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="AMCNnumber" type="string" required="true" />
		
		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityExtendedGrant
				SET
				<cfif structKeyExists(arguments,"AMCNnumber") and len(arguments.AMCNnumber)>
					AMCNnumber = <cfqueryparam value="#arguments.AMCNnumber#" CFSQLType="cf_sql_varchar" null="#not len(arguments.AMCNnumber)#" />
				</cfif>
				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction> --->
		
	<cffunction name="getActivityCNNumber" access="public" output="false" returntype="string">
		<cfargument name="ActivityID" type="numeric" required="false" />
		
		<cfset var qstatus = getByAttributesQuery(argumentCollection=arguments) />	
		<cfset var theCNNumber = qstatus.AMCNnumber />
		
		<cfreturn theCNNumber  />
	</cffunction>	
	
	<!--- <cffunction name="updateBudgetFundRequestDate" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="BudgetFundRequestDate" type="date" required="true" />
		
		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityExtendedGrant
				SET
				<cfif structKeyExists(arguments,"BudgetFundRequestDate") and len(arguments.BudgetFundRequestDate)>
					BudgetFundRequestDate = <cfqueryparam value="#arguments.BudgetFundRequestDate#" CFSQLType="cf_sql_timestamp" />
				</cfif>				
				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction> --->	

	<!--- <cffunction name="updateBudgetFundApprovalDate" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="BudgetFundApprovalDate" type="date" required="true" />
		
		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityExtendedGrant
				SET
				<cfif structKeyExists(arguments,"BudgetFundApprovalDate") and len(arguments.BudgetFundApprovalDate)>
					BudgetFundApprovalDate = <cfqueryparam value="#arguments.BudgetFundApprovalDate#" CFSQLType="cf_sql_timestamp" />
				</cfif>			
				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction >--->	
	
	
</cfcomponent>

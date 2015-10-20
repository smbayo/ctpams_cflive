<cfcomponent displayname="ActivityExtendedGrantDAO" hint="table ID column = ActivityID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityExtendedGrantDAO">
		
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityExtendedGrant" type="ActivityExtendedGrant" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ActivityExtendedGrant
					(
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
					regionalApprovedDate
					)
				VALUES
					(
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getActivityID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getTotalCostShare()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getTotalCostShare())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getSectorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getSectorID())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getCostShareToDate()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getCostShareToDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getprogramID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getprogramID())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getprojectObjective()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getprojectObjective())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getinterestSpecification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getinterestSpecification())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getlawEnforcementSpecification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getlawEnforcementSpecification())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getcoordinationSpecification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getcoordinationSpecification())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getprogramAudience()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getprogramAudience())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getfundImpMechanismID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getfundImpMechanismID())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getActivityStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getActivityStatusID())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getProposalNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getProposalNumber())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNnumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getAMCNnumber())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getproposalSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getproposalSubmitDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getclearedPrelegalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getclearedPrelegalDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getproposalApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getproposalApprovedDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNBudgetSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getAMCNBudgetSubmitDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNCongressSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getAMCNCongressSubmitDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getAMCNApprovedDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getFundApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getFundApprovedDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getBudgetFundRequestDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getBudgetFundRequestDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getBudgetFundApprovalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getBudgetFundApprovalDate())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getplaceOfImplementation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getplaceOfImplementation())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getisActive()#" CFSQLType="cf_sql_bit" null="#not len(arguments.ActivityExtendedGrant.getisActive())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getsysUserID())#" />,
					<cfqueryparam value="#arguments.ActivityExtendedGrant.getregionalApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getregionalApprovedDate())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ActivityExtendedGrant" type="ActivityExtendedGrant" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
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
					regionalApprovedDate
				FROM	ActivityExtendedGrant
				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ActivityExtendedGrant.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityExtendedGrant" type="ActivityExtendedGrant" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityExtendedGrant
				SET
					TotalCostShare = <cfqueryparam value="#arguments.ActivityExtendedGrant.getTotalCostShare()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getTotalCostShare())#" />,
					SectorID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getSectorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getSectorID())#" />,
					CostShareToDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getCostShareToDate()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getCostShareToDate())#" />,
					programID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getprogramID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getprogramID())#" />,
					projectObjective = <cfqueryparam value="#arguments.ActivityExtendedGrant.getprojectObjective()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getprojectObjective())#" />,
					interestSpecification = <cfqueryparam value="#arguments.ActivityExtendedGrant.getinterestSpecification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getinterestSpecification())#" />,
					lawEnforcementSpecification = <cfqueryparam value="#arguments.ActivityExtendedGrant.getlawEnforcementSpecification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getlawEnforcementSpecification())#" />,
					coordinationSpecification = <cfqueryparam value="#arguments.ActivityExtendedGrant.getcoordinationSpecification()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getcoordinationSpecification())#" />,
					programAudience = <cfqueryparam value="#arguments.ActivityExtendedGrant.getprogramAudience()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getprogramAudience())#" />,
					fundImpMechanismID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getfundImpMechanismID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getfundImpMechanismID())#" />,
					ActivityStatusID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getActivityStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getActivityStatusID())#" />,
					ProposalNumber = <cfqueryparam value="#arguments.ActivityExtendedGrant.getProposalNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getProposalNumber())#" />,
					AMCNnumber = <cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNnumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getAMCNnumber())#" />,
					proposalSubmitDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getproposalSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getproposalSubmitDate())#" />,
					clearedPrelegalDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getclearedPrelegalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getclearedPrelegalDate())#" />,
					proposalApprovedDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getproposalApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getproposalApprovedDate())#" />,
					AMCNBudgetSubmitDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNBudgetSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getAMCNBudgetSubmitDate())#" />,
					AMCNCongressSubmitDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNCongressSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getAMCNCongressSubmitDate())#" />,
					AMCNApprovedDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getAMCNApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getAMCNApprovedDate())#" />,
					FundApprovedDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getFundApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getFundApprovedDate())#" />,
					BudgetFundRequestDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getBudgetFundRequestDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getBudgetFundRequestDate())#" />,
					BudgetFundApprovalDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getBudgetFundApprovalDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getBudgetFundApprovalDate())#" />,
					placeOfImplementation = <cfqueryparam value="#arguments.ActivityExtendedGrant.getplaceOfImplementation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityExtendedGrant.getplaceOfImplementation())#" />,
					isActive = <cfqueryparam value="#arguments.ActivityExtendedGrant.getisActive()#" CFSQLType="cf_sql_bit" null="#not len(arguments.ActivityExtendedGrant.getisActive())#" />,
					sysUserID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityExtendedGrant.getsysUserID())#" />,
					regionalApprovedDate = <cfqueryparam value="#arguments.ActivityExtendedGrant.getregionalApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityExtendedGrant.getregionalApprovedDate())#" />
				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityExtendedGrant" type="ActivityExtendedGrant" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ActivityExtendedGrant 
				WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getActivityID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityExtendedGrant" type="ActivityExtendedGrant" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ActivityExtendedGrant
			WHERE	ActivityID = <cfqueryparam value="#arguments.ActivityExtendedGrant.getActivityID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityExtendedGrant" type="ActivityExtendedGrant" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.ActivityExtendedGrant)>
			<cfset success = update(arguments.ActivityExtendedGrant) />
		<cfelse>
			<cfset success = create(arguments.ActivityExtendedGrant) />
		</cfif>
		
		<cfreturn success />
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

</cfcomponent>

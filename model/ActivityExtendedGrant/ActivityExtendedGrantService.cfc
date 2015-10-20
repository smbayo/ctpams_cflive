<cfcomponent name="ActivityExtendedGrantService" output="false">

	<cfproperty name="activityExtendedGrantGateway" inject="model" scope="instance" />
	<cfproperty name="activityExtendedGrantDAO" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ActivityExtendedGrantService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createActivityExtendedGrant" access="public" output="false" returntype="ActivityExtendedGrant">
		<cfargument name="ActivityID" type="numeric" required="true" />
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
		<cfargument name="regionalApprovedDate" type="date" required="false" />
		
			
		<cfset var ActivityExtendedGrant = createObject("component","ActivityExtendedGrant").init(argumentCollection=arguments) />
		<cfreturn ActivityExtendedGrant />
	</cffunction>

	<cffunction name="getActivityExtendedGrant" access="public" output="false" returntype="ActivityExtendedGrant">
		<cfargument name="ActivityID" type="numeric" required="true" />
		
		<cfset var ActivityExtendedGrant = createActivityExtendedGrant(argumentCollection=arguments) />
		<cfset instance.ActivityExtendedGrantDAO.read(ActivityExtendedGrant) />
		<cfreturn ActivityExtendedGrant />
	</cffunction>

	<cffunction name="getActivityExtendedGrants" access="public" output="false" returntype="array">
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
		<cfargument name="regionalApprovedDate" type="date" required="false" />
		
		<cfreturn instance.ActivityExtendedGrantGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityExtendedGrant" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityExtendedGrant" type="ActivityExtendedGrant" required="true" />

		<cfreturn instance.ActivityExtendedGrantDAO.save(ActivityExtendedGrant) />
	</cffunction>

	<cffunction name="deleteActivityExtendedGrant" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		
		<cfset var ActivityExtendedGrant = createActivityExtendedGrant(argumentCollection=arguments) />
		<cfreturn instance.ActivityExtendedGrantDAO.delete(ActivityExtendedGrant) />
	</cffunction>
</cfcomponent>

<cfcomponent name="ActivityBudgetService" output="false">
	<cfproperty name="ActivityBudget" inject="model" scope="instance" />
	<cfproperty name="ActivityBudgetDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityBudgetGateway" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ActivityBudgetService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="ActivityBudget">
		<cfreturn instance.ActivityBudget.init() />
	</cffunction>

	<cffunction name="createActivityBudget" access="public" output="false" returntype="ActivityBudget">
		<cfargument name="ActivityBudgetID" type="numeric" required="true" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="categoryToCategoryID" type="numeric" required="false" />
		<cfargument name="countryID" type="numeric" required="false" />
		<cfargument name="BudgetItem" type="numeric" required="false" />
		<cfargument name="BudgetAmount" type="numeric" required="false" />


		<cfset var ActivityBudget = createObject("component","ActivityBudget").init(argumentCollection=arguments) />
		<cfreturn ActivityBudget />
	</cffunction>

	<cffunction name="getActivityBudget" access="public" output="false" returntype="ActivityBudget">
		<cfargument name="ActivityBudgetID" type="numeric" required="true" />

		<cfset var ActivityBudget = createActivityBudget(argumentCollection=arguments) />
		<cfset instance.ActivityBudgetDAO.read(ActivityBudget) />
		<cfreturn ActivityBudget />
	</cffunction>

	<cffunction name="getActivityBudgets" access="public" output="false" returntype="array">
		<cfargument name="ActivityBudgetID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="categoryToCategoryID" type="numeric" required="false" />
		<cfargument name="countryID" type="numeric" required="false" />
		<cfargument name="BudgetItem" type="numeric" required="false" />
		<cfargument name="BudgetAmount" type="numeric" required="false" />

		<cfreturn instance.ActivityBudgetGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityBudget" access="public" output="false" returntype="numeric">
		<cfargument name="ActivityBudget" type="ActivityBudget" required="true" />

		<cfreturn instance.ActivityBudgetDAO.save(ActivityBudget) />
	</cffunction>

	<cffunction name="deleteActivityBudget" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityBudgetID" type="numeric" required="true" />

		<cfset var ActivityBudget = createActivityBudget(argumentCollection=arguments) />
		<cfreturn instance.ActivityBudgetDAO.delete(ActivityBudget) />
	</cffunction>
</cfcomponent>

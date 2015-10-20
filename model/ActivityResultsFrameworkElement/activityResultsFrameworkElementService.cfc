
<cfcomponent name="activityResultsFrameworkElementService" output="false">
	<cfproperty name="activityResultsFrameworkElementGateway" inject="model" scope="instance" />
	<cfproperty name="activityResultsFrameworkElementDAO" inject="model" scope="instance" />
	<cfproperty name="activityResultsFrameworkElement" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="activityResultsFrameworkElementService">
		<cfreturn this/>
	</cffunction>
	<cffunction name="new" access="public" output="false" returntype="activityResultsFrameworkElement">
		<cfreturn instance.activityResultsFrameworkElement.init() />
	</cffunction>

	<cffunction name="createactivityResultsFrameworkElement" access="public" output="false" returntype="activityResultsFrameworkElement">
		<cfargument name="activityResultID" type="numeric" required="true" />
		<cfargument name="activityID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="isPrimary" type="boolean" required="false" />
		
			
		<cfset var activityResultsFrameworkElement = createObject("component","activityResultsFrameworkElement").init(argumentCollection=arguments) />
		<cfreturn activityResultsFrameworkElement />
	</cffunction>

	<cffunction name="getactivityResultsFrameworkElement" access="public" output="false" returntype="activityResultsFrameworkElement">
		<cfargument name="activityResultID" type="numeric" required="false" />
		
		<cfset var activityResultsFrameworkElement = createactivityResultsFrameworkElement(argumentCollection=arguments) />
		<cfset variables.activityResultsFrameworkElementDAO.read(activityResultsFrameworkElement) />
		<cfreturn activityResultsFrameworkElement />
	</cffunction>

	<cffunction name="getactivityResultsFrameworkElements" access="public" output="false" returntype="array">
		<cfargument name="activityResultID" type="numeric" required="false" />
		<cfargument name="activityID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="isPrimary" type="boolean" required="false" />
		
		<cfreturn variables.activityResultsFrameworkElementGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>
    
	<cffunction name="getactivityResultsQuery" access="public" output="false" returntype="query">
		<cfargument name="activityResultID" type="numeric" required="false" />
		<cfargument name="activityID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="isPrimary" type="boolean" required="true" />
		
		<cfreturn instance.activityResultsFrameworkElementGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveactivityResultsFrameworkElement" access="public" output="false" returntype="boolean">
		<cfargument name="activityResultsFrameworkElement" type="activityResultsFrameworkElement" required="true" />

		<cfreturn instance.activityResultsFrameworkElementDAO.save(activityResultsFrameworkElement) />
	</cffunction>

	<cffunction name="deleteactivityResultsFrameworkElement" access="public" output="false" returntype="boolean">
		<cfargument name="activityResultID" type="numeric" required="true" />
		
		<cfset var activityResultsFrameworkElement = createactivityResultsFrameworkElement(argumentCollection=arguments) />
		<cfreturn variables.activityResultsFrameworkElementDAO.delete(activityResultsFrameworkElement) />
	</cffunction>
    
	<cffunction name="deleteActivityResults" access="public" output="false" returntype="any">
		<cfargument name="activityID" type="numeric" required="true" />
		<cfargument name="isPrimary" type="numeric" required="true" />
		<cfreturn instance.activityResultsFrameworkElementGateway.deleteActivityResults(activityID=arguments.ActivityID,isPrimary=arguments.isPrimary) />
	</cffunction>
    
    
</cfcomponent>

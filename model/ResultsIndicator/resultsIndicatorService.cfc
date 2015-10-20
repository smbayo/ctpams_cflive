
<cfcomponent name="resultsIndicatorService" output="false">
	<cfproperty name="ResultsIndicatorGateway" inject="model" scope="instance" />
	<cfproperty name="ResultsIndicatorDAO" inject="model" scope="instance" />
	<cfproperty name="ResultsIndicator" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="resultsIndicatorService">
		<!---<cfargument name="resultsIndicatorDAO" type="model.resultsIndicatorDAO" required="true" />
		<cfargument name="resultsIndicatorGateway" type="model.resultsIndicatorGateway" required="true" />

		<cfset variables.resultsIndicatorDAO = arguments.resultsIndicatorDAO />
		<cfset variables.resultsIndicatorGateway = arguments.resultsIndicatorGateway />
--->
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="ResultsIndicator">
		<cfset var ResultsIndicator = createObject("component","ResultsIndicator").init() />
		<cfreturn ResultsIndicator />
	</cffunction>
	
	<cffunction name="createResultsIndicator" access="public" output="false" returntype="resultsIndicator">
		<cfargument name="indicatorResultID" type="numeric" required="false" />
		<cfargument name="indicatorID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		
			
		<cfset var resultsIndicator = createObject("component","resultsIndicator").init(argumentCollection=arguments) />
        		

		<cfreturn resultsIndicator />
	</cffunction>

	<cffunction name="getresultsIndicator" access="public" output="false" returntype="resultsIndicator">
		<cfargument name="indicatorResultID" type="numeric" required="true" />

		<cfset var resultsIndicator = createresultsIndicator(argumentCollection=arguments) />
		<cfset variables.resultsIndicatorDAO.read(resultsIndicator) />
		<cfreturn resultsIndicator />
	</cffunction>

	<cffunction name="getresultsIndicators" access="public" output="false" returntype="array">
		<cfargument name="indicatorResultID" type="numeric" required="false" />
		<cfargument name="indicatorID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfreturn instance.resultsIndicatorGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>
	<cffunction name="getresultsIndicatorsByIndicatorID" access="public" output="false" returntype="query">
		<cfargument name="indicatorID" type="numeric" required="true" />
		<cfreturn instance.resultsIndicatorGateway.getByIndicatorIDQuery(indicatorID=arguments.indicatorID) />
	</cffunction>
	<cffunction name="saveresultsIndicator" access="public" output="false" returntype="boolean">
		<cfargument name="resultsIndicator" type="resultsIndicator" required="true" />
		<cfreturn instance.resultsIndicatorDAO.save(resultsIndicator) />
	</cffunction>

	<cffunction name="deleteresultsIndicator" access="public" output="false" returntype="boolean">
		<cfargument name="indicatorID" type="numeric" required="true" />
		
		<cfset var resultsIndicator = createresultsIndicator(argumentCollection=arguments) />
		<cfreturn instance.resultsIndicatorDAO.delete(resultsIndicator) />
	</cffunction>
    
	<cffunction name="deleteAllResultsIndicators" access="public" output="false" returntype="boolean">
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfreturn instance.resultsIndicatorGateway.deleteAllResultsIndicators(resultsFrameworkElementID=arguments.resultsFrameworkElementID) />
	</cffunction>
    
    
    
    
</cfcomponent>

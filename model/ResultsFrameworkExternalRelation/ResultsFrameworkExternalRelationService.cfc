
<cfcomponent name="ResultsFrameworkExternalRelationService" output="false">

	<cfproperty name="orgGateway" inject="model" scope="instance" />
	<cfproperty name="orgDAO" inject="model" scope="instance" />
	<cfproperty name="resultsFrameworkExternalRelationGateway" inject="model" scope="instance" />
	<cfproperty name="resultsFrameworkExternalRelationDAO" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ResultsFrameworkExternalRelationService">
		<cfreturn this/>
	</cffunction>

    <cffunction name="new" access="public" output="false"  returntype="ResultsFrameworkExternalRelation">
		<cfset var ResultsFrameworkExternalRelation = createObject("component","ResultsFrameworkExternalRelation").init() />
        <cfreturn resultsFrameworkExternalRelation>
	</cffunction>







	<cffunction name="createResultsFrameworkExternalRelation" access="public" output="false" returntype="ResultsFrameworkExternalRelation">
		<cfargument name="ParentResultsFrameworkElementID" type="numeric" required="true" />
		<cfargument name="ChildResultsFrameworkElementID" type="numeric" required="true" />
		
			
		<cfset var ResultsFrameworkExternalRelation = createObject("component","ResultsFrameworkExternalRelation").init(argumentCollection=arguments) />
		<cfreturn ResultsFrameworkExternalRelation />
	</cffunction>

	<cffunction name="getResultsFrameworkExternalRelation" access="public" output="false" returntype="ResultsFrameworkExternalRelation">
		<cfargument name="ParentResultsFrameworkElementID" type="numeric" required="true" />
		<cfargument name="ChildResultsFrameworkElementID" type="numeric" required="true" />
		
		<cfset var ResultsFrameworkExternalRelation = createResultsFrameworkExternalRelation(argumentCollection=arguments) />
		<cfset instance.ResultsFrameworkExternalRelationDAO.read(ResultsFrameworkExternalRelation) />
		<cfreturn ResultsFrameworkExternalRelation />
	</cffunction>

	<cffunction name="getResultsFrameworkExternalRelations" access="public" output="false" returntype="array">
		<cfargument name="ParentResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ChildResultsFrameworkElementID" type="numeric" required="false" />
		
		<cfreturn instance.ResultsFrameworkExternalRelationGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getResultRelations" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
	
		<cfreturn instance.ResultsFrameworkExternalRelationGateway.getResultRelationQuery(resultsFrameworkelementID=arguments.resultsFrameworkElementID) />
	</cffunction>

	<cffunction name="saveResultsFrameworkExternalRelation" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkExternalRelation" type="ResultsFrameworkExternalRelation" required="true" />
		<cfreturn instance.ResultsFrameworkExternalRelationDAO.save(ResultsFrameworkExternalRelation) />
	</cffunction>

	<cffunction name="deleteResultsFrameworkExternalRelation" access="public" output="false" returntype="boolean">
		<cfargument name="ParentResultsFrameworkElementID" type="numeric" required="true" />
		<cfargument name="ChildResultsFrameworkElementID" type="numeric" required="true" />
		
		<cfset var ResultsFrameworkExternalRelation = createResultsFrameworkExternalRelation(argumentCollection=arguments) />
		<cfreturn instance.ResultsFrameworkExternalRelationDAO.delete(ResultsFrameworkExternalRelation) />
	</cffunction>
 	<cffunction name="deleteResultRelations" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />
		<cfreturn instance.ResultsFrameworkExternalRelationGateway.deleteResultRelations(resultsFrameworkElementID=arguments.resultsFrameworkElementID) />
	</cffunction>
   
	<cffunction name="deleteParents" access="public" output="false" returntype="boolean">
		<cfargument name="ChildResultsFrameworkElementID" type="numeric" required="true" />
		<cfreturn instance.ResultsFrameworkExternalRelationGateway.deleteParents(ChildResultsFrameworkElementID=arguments.ChildResultsFrameworkElementID) />
	</cffunction>    
    
    
    
    
</cfcomponent>

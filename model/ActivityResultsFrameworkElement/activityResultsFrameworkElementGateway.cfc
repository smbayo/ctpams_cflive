
<cfcomponent displayname="activityResultsFrameworkElementGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />	

	<cffunction name="init" access="public" output="false" returntype="activityResultsFrameworkElementGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="activityResultID" type="numeric" required="false" />
		<cfargument name="activityID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="isPrimary" type="boolean" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT *
			FROM	vw_activityResults
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"activityResultID") and len(arguments.activityResultID)>
			AND	activityResultID = <cfqueryparam value="#arguments.activityResultID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"activityID") and len(arguments.activityID)>
			AND	activityID = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"resultsFrameworkElementID") and len(arguments.resultsFrameworkElementID)>
			AND	resultsFrameworkElementID = <cfqueryparam value="#arguments.resultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"isPrimary") and len(arguments.isPrimary)>
			AND	isPrimary = <cfqueryparam value="#arguments.isPrimary#" CFSQLType="cf_sql_bit" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="activityResultID" type="numeric" required="false" />
		<cfargument name="activityID" type="numeric" required="false" />
		<cfargument name="resultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="isPrimary" type="boolean" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","activityResultsFrameworkElement").init(argumentCollection=queryRowToStruct(qList,i)) />
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


	<cffunction name="deleteActivityResults" access="public" output="false" returntype="any">
		<cfargument name="activityID" type="numeric" required="true" />
		<cfargument name="isPrimary" type="boolean" required="true" />
		
		<cfset var dList = "" />		
		<cfquery name="dList" datasource="#dsn.getName()#">
			delete from activityResultsFrameworkElement where
				activityID = <cfqueryparam value="#arguments.activityID#" CFSQLType="cf_sql_integer" />
				AND	isPrimary = <cfqueryparam value="#arguments.isPrimary#" CFSQLType="cf_sql_bit" />
		</cfquery>
		
		<cfreturn deleteActivityResults />
	</cffunction>




</cfcomponent>

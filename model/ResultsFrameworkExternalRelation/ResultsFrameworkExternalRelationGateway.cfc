
<cfcomponent displayname="ResultsFrameworkExternalRelationGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ResultsFrameworkExternalRelationGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getResultRelationQuery" access="public" output="false" returntype="query">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT * 
			FROM	vw_ParentChild
			WHERE	0=0
		
			and 
            (ParentResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
			OR	
            ChildResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />)

			ORDER BY ParentResultsFrameworkElementID, childResultsFrameworkElementID
		</cfquery>
		
		<cfreturn qList />
	</cffunction>
    
    <cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ParentResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ChildResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ParentResultsFrameworkElementID,
				ChildResultsFrameworkElementID
			FROM	ResultsFrameworkExternalRelation
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ParentResultsFrameworkElementID") and len(arguments.ParentResultsFrameworkElementID)>
			AND	ParentResultsFrameworkElementID = <cfqueryparam value="#arguments.ParentResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ChildResultsFrameworkElementID") and len(arguments.ChildResultsFrameworkElementID)>
			AND	ChildResultsFrameworkElementID = <cfqueryparam value="#arguments.ChildResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ParentResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="ChildResultsFrameworkElementID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ResultsFrameworkExternalRelation").init(argumentCollection=queryRowToStruct(qList,i)) />
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
	
    <cffunction name="deleteParents" access="public" output="false" returntype="boolean">
		<cfargument name="childResultsFrameworkElementID" type="numeric" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ResultsFrameworkExternalRelation 
                WHERE	
                ChildResultsFrameworkElementID = <cfqueryparam value="#arguments.childResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

    <cffunction name="deleteResultRelations" access="public" output="false" returntype="boolean">
		<cfargument name="ResultsFrameworkElementID" type="numeric" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ResultsFrameworkExternalRelation 
                WHERE
                (	
                ChildResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" /> OR
			    ParentResultsFrameworkElementID = <cfqueryparam value="#arguments.ResultsFrameworkElementID#" CFSQLType="cf_sql_integer" />
                )
            </cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

















</cfcomponent>

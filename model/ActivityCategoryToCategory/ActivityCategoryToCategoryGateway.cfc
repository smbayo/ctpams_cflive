<cfcomponent displayname="ActivityCategoryToCategoryGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityCategoryToCategoryGateway">
		
		<cfreturn this />
	</cffunction>

	<cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="CategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
			
		<cfquery name="qList" datasource="#dsn.getName()#">
			DELETE
			FROM	ActivityCategoryToCategory
			WHERE	0=0
	
		<cfif structKeyExists(arguments,"ActivityCategoryToCategoryID") and len(arguments.ActivityCategoryToCategoryID)>
			AND	ActivityCategoryToCategoryID = <cfqueryparam value="#arguments.ActivityCategoryToCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CategoryToCategoryID") and len(arguments.CategoryToCategoryID)>
			AND	CategoryToCategoryID = <cfqueryparam value="#arguments.CategoryToCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		</cfquery>
		
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="CategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ActivityCategoryToCategoryID,
				CategoryToCategoryID,
				ActivityID
			FROM	ActivityCategoryToCategory
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ActivityCategoryToCategoryID") and len(arguments.ActivityCategoryToCategoryID)>
			AND	ActivityCategoryToCategoryID = <cfqueryparam value="#arguments.ActivityCategoryToCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CategoryToCategoryID") and len(arguments.CategoryToCategoryID)>
			AND	CategoryToCategoryID = <cfqueryparam value="#arguments.CategoryToCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="CategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ActivityCategoryToCategory").init(argumentCollection=queryRowToStruct(qList,i)) />
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

</cfcomponent>

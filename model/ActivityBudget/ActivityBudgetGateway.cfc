<cfcomponent displayname="ActivityBudgetGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityBudgetGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
		<cfargument name="ActivityBudgetID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="categoryToCategoryID" type="numeric" required="false" />
		<cfargument name="countryID" type="numeric" required="false" />
		<cfargument name="BudgetItem" type="string" required="false" />
		<cfargument name="BudgetAmount" type="numeric" required="false" />
				
		<cfquery name="qList" datasource="#dsn.getName()#">
			DELETE
			FROM	ActivityBudget
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ActivityBudgetID") and len(arguments.ActivityBudgetID)>
			AND	ActivityBudgetID = <cfqueryparam value="#arguments.ActivityBudgetID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"categoryToCategoryID") and len(arguments.categoryToCategoryID)>
			AND	categoryToCategoryID = <cfqueryparam value="#arguments.categoryToCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"countryID") and len(arguments.countryID)>
			AND	countryID = <cfqueryparam value="#arguments.countryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetItem") and len(arguments.BudgetItem)>
			AND	BudgetItem = <cfqueryparam value="#arguments.BudgetItem#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetAmount") and len(arguments.BudgetAmount)>
			AND	BudgetAmount = <cfqueryparam value="#arguments.BudgetAmount#" CFSQLType="cf_sql_integer" />
		</cfif>
		</cfquery>
		
		<cfreturn />
	</cffunction>
	
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityBudgetID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="categoryToCategoryID" type="numeric" required="false" />
		<cfargument name="countryID" type="numeric" required="false" />
		<cfargument name="BudgetItem" type="string" required="false" />
		<cfargument name="BudgetAmount" type="numeric" required="false" />
		<cfargument name="Region" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			<!--- SELECT
				ActivityBudget.ActivityBudgetID,
				ActivityBudget.ActivityID,
				ActivityBudget.categoryToCategoryID,
				ActivityBudget.countryID,
				ActivityBudget.BudgetItem,
				ActivityBudget.BudgetAmount,
				C1.Name Region,
				C2.Name Country
			FROM	ActivityBudget
			JOIN CategoryToCategory on (CategoryToCategory.categoryToCategoryID = ActivityBudget.categoryToCategoryID)
			JOIN Category C1 on (C1.CategoryID = CategoryToCategory.SuperCategoryID)
			JOIN Category C2 on (C2.CategoryID = CategoryToCategory.SubCategoryID)
			WHERE	0=0 --->
			SELECT 
				ActivityBudget.ActivityBudgetID, ActivityBudget.ActivityID, 
				ActivityBudget.categoryToCategoryID, ActivityBudget.countryID, 
				ActivityBudget.BudgetItem, ActivityBudget.BudgetAmount, 
				C2.Name Country 
			FROM ActivityBudget
			JOIN Category C2 on (C2.CategoryID = ActivityBudget.countryID)
			WHERE 0=0	
		<cfif structKeyExists(arguments,"ActivityBudgetID") and len(arguments.ActivityBudgetID)>
			AND	ActivityBudgetID = <cfqueryparam value="#arguments.ActivityBudgetID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<!--- 
		<cfif structKeyExists(arguments,"categoryToCategoryID") and len(arguments.categoryToCategoryID)>
			AND	categoryToCategoryID = <cfqueryparam value="#arguments.categoryToCategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		 --->
		<cfif structKeyExists(arguments,"countryID") and len(arguments.countryID)>
			AND	countryID = <cfqueryparam value="#arguments.countryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetItem") and len(arguments.BudgetItem)>
			AND	BudgetItem = <cfqueryparam value="#arguments.BudgetItem#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"BudgetAmount") and len(arguments.BudgetAmount)>
			AND	BudgetAmount = <cfqueryparam value="#arguments.BudgetAmount#" CFSQLType="cf_sql_integer" />
		</cfif>
		<!--- 
		<cfif structKeyExists(arguments,"Region") and len(arguments.Region)>
			AND	C1.Name = <cfqueryparam value="#arguments.Region#" CFSQLType="cf_sql_varchar" />
		</cfif>
		 --->	
		<cfif structKeyExists(arguments,"Country") and len(arguments.Country)>
			AND	C2.Name = <cfqueryparam value="#arguments.Country#" CFSQLType="cf_sql_varchar" />
		</cfif>	
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ActivityBudgetID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="categoryToCategoryID" type="numeric" required="false" />
		<cfargument name="countryID" type="numeric" required="false" />
		<cfargument name="BudgetItem" type="string" required="false" />
		<cfargument name="BudgetAmount" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ActivityBudget").init(argumentCollection=queryRowToStruct(qList,i)) />
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

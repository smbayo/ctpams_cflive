<cfcomponent displayname="ActivityBudgetDAO" hint="table ID column = ActivityBudgetID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="ActivityBudgetDAO">
		<cfreturn this>
	</cffunction>

	<cffunction name="create" access="public" output="false" returntype="numeric">
		<cfargument name="ActivityBudget" type="ActivityBudget" required="true" />

		<cfset var qCreate = "" />
		<!--- <cftry> --->
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ActivityBudget
					(
					<!--- ActivityBudgetID, --->
					ActivityID,
					categoryToCategoryID,
					countryID,
					BudgetItem,
					BudgetAmount
					)
				VALUES
					(
					<!--- <cfqueryparam value="#arguments.ActivityBudget.getActivityBudgetID()#" CFSQLType="cf_sql_integer" />, --->
					<cfqueryparam value="#arguments.ActivityBudget.getActivityID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.ActivityBudget.getcategoryToCategoryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityBudget.getcategoryToCategoryID())#" />,
					<cfqueryparam value="#arguments.ActivityBudget.getcountryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityBudget.getcountryID())#" />,
					<cfqueryparam value="#arguments.ActivityBudget.getBudgetItem()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityBudget.getBudgetItem())#" />,
					<cfqueryparam value="#arguments.ActivityBudget.getBudgetAmount()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityBudget.getBudgetAmount())#" />
					)
					SELECT @@Identity as ActivityBudgetID
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn qCreate.ActivityBudgetID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ActivityBudget" type="ActivityBudget" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					ActivityBudgetID,
					ActivityID,
					categoryToCategoryID,
					countryID,
					BudgetItem,
					BudgetAmount
				FROM	ActivityBudget
				WHERE	ActivityBudgetID = <cfqueryparam value="#arguments.ActivityBudget.getActivityBudgetID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ActivityBudget.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="numeric">
		<cfargument name="ActivityBudget" type="ActivityBudget" required="true" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityBudget
				SET
					ActivityID = <cfqueryparam value="#arguments.ActivityBudget.getActivityID()#" CFSQLType="cf_sql_integer" />,
					categoryToCategoryID = <cfqueryparam value="#arguments.ActivityBudget.getcategoryToCategoryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityBudget.getcategoryToCategoryID())#" />,
					countryID = <cfqueryparam value="#arguments.ActivityBudget.getcountryID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityBudget.getcountryID())#" />,
					BudgetItem = <cfqueryparam value="#arguments.ActivityBudget.getBudgetItem()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityBudget.getBudgetItem())#" />,
					BudgetAmount = <cfqueryparam value="#arguments.ActivityBudget.getBudgetAmount()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityBudget.getBudgetAmount())#" />
				WHERE	ActivityBudgetID = <cfqueryparam value="#arguments.ActivityBudget.getActivityBudgetID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn arguments.ActivityBudget.getActivityBudgetID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityBudget" type="ActivityBudget" required="true" />

		<cfset var qDelete = "">
		<!--- <cftry> --->
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ActivityBudget
				WHERE	ActivityBudgetID = <cfqueryparam value="#arguments.ActivityBudget.getActivityBudgetID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityBudget" type="ActivityBudget" required="true" />

		<cfset var qExists = "">
		<cfif arguments.ActivityBudget.getActivityBudgetID() is not "">
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	ActivityBudget
				WHERE	ActivityBudgetID = <cfqueryparam value="#arguments.ActivityBudget.getActivityBudgetID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<cfif qExists.idexists>
				<cfreturn true />
			<cfelse>
				<cfreturn false />
			</cfif>
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="numeric">
		<cfargument name="ActivityBudget" type="ActivityBudget" required="true" />

		<cfset var success = false />
		<cfif exists(arguments.ActivityBudget)>
			<cfset success = update(arguments.ActivityBudget) />
		<cfelse>
			<cfset success = create(arguments.ActivityBudget) />
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

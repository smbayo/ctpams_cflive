
<cfcomponent displayname="ActivityIndicatorDAO" hint="table ID column = ActivityIndicatorID">

	<cfproperty name="ActivityIndicator" inject="model" scope="instance" />
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityIndicatorDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="new" access="public" output="false" returntype="ActivityIndicator">
		<cfreturn instance.ActivityIndicator.init()>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityIndicator" type="ActivityIndicator" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ActivityIndicator
					(
					ActivityID,
					IndicatorID
					)
				VALUES
					(
					<cfqueryparam value="#arguments.ActivityIndicator.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityIndicator.getActivityID())#" />,
					<cfqueryparam value="#arguments.ActivityIndicator.getIndicatorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityIndicator.getIndicatorID())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ActivityIndicator" type="ActivityIndicator" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					ActivityIndicatorID,
					ActivityID,
					IndicatorID
				FROM	ActivityIndicator
				WHERE	ActivityIndicatorID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ActivityIndicator.getActivityIndicatorID()#">
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ActivityIndicator.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityIndicator" type="ActivityIndicator" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityIndicator
				SET
					ActivityID = <cfqueryparam value="#arguments.ActivityIndicator.getActivityID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityIndicator.getActivityID())#" />,
					IndicatorID = <cfqueryparam value="#arguments.ActivityIndicator.getIndicatorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityIndicator.getIndicatorID())#" />
				WHERE	ActivityIndicatorID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ActivityIndicator.getActivityIndicatorID()#">
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityIndicator" type="ActivityIndicator" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ActivityIndicator 
				WHERE ActivityIndicatorID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ActivityIndicator.getActivityIndicatorID()#">
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityIndicator" type="ActivityIndicator" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(activityID) as idexists
			FROM	ActivityIndicator
			WHERE	activityID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ActivityIndicator.getActivityID()#"> and IndicatorID = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.ActivityIndicator.getIndicatorID()#">
		</cfquery>
		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityIndicator" type="ActivityIndicator" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.ActivityIndicator)>
			<cfset success = update(arguments.ActivityIndicator) />
		<cfelse>
			<cfset success = create(arguments.ActivityIndicator) />
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

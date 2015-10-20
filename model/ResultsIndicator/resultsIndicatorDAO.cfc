
<cfcomponent displayname="resultsIndicatorDAO" hint="table ID column = indicatorResultID">
	<cfproperty name="resultsIndicator" inject="model" scope="instance" />
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

    
	<cffunction name="init" access="public" output="false" returntype="resultsIndicatorDAO">
		<cfreturn this>
	</cffunction>
	<cffunction name="new" access="public" output="false" returntype="resultsIndicator">
		<cfreturn instance.resultsIndicator.init()>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="resultsIndicator" type="resultsIndicator" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ResultsIndicator
					(
					indicatorID,
					resultsFrameworkElementID
					)
				VALUES
					(
					<cfqueryparam value="#arguments.resultsIndicator.getindicatorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.resultsIndicator.getindicatorID())#" />,
					<cfqueryparam value="#arguments.resultsIndicator.getresultsFrameworkElementID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.resultsIndicator.getresultsFrameworkElementID())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="resultsIndicator" type="resultsIndicator" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					indicatorResultID,
					indicatorID,
					resultsFrameworkElementID
				FROM	ResultsIndicator
				WHERE	indicatorResultID = <cfqueryparam value="#arguments.resultsIndicator.getindicatorResultID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.resultsIndicator.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="resultsIndicator" type="resultsIndicator" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ResultsIndicator
				SET
					indicatorID = <cfqueryparam value="#arguments.resultsIndicator.getindicatorID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.resultsIndicator.getindicatorID())#" />,
					resultsFrameworkElementID = <cfqueryparam value="#arguments.resultsIndicator.getresultsFrameworkElementID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.resultsIndicator.getresultsFrameworkElementID())#" />
				WHERE	indicatorResultID = <cfqueryparam value="#arguments.resultsIndicator.getindicatorResultID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="resultsIndicator" type="resultsIndicator" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ResultsIndicator 
				WHERE	indicatorID = <cfqueryparam value="#arguments.resultsIndicator.getindicatorID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="resultsIndicator" type="resultsIndicator" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ResultsIndicator
			WHERE	resultsFrameworkElementID = <cfqueryparam value="#arguments.resultsIndicator.getResultsFrameworkelementID()#" CFSQLType="cf_sql_integer" />
            AND indicatorID = <cfqueryparam value="#arguments.resultsIndicator.getIndicatorID()#" CFSQLType="cf_sql_integer" />

		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="resultsIndicator" type="resultsIndicator" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.resultsIndicator)>
			<cfset success = update(arguments.resultsIndicator) />
		<cfelse>
			<cfset success = create(arguments.resultsIndicator) />
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

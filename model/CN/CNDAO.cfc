
<cfcomponent displayname="CNDAO" hint="table ID column = CNID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="CNDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="numeric">
		<cfargument name="CN" type="CN" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO CN
					(
					Name,
					CNNumber,
					BudgetSubmitDate,
					CongressSubmitDate,
					ApprovedDate,
					CNType
					)
				VALUES
					(
					<cfqueryparam value="#arguments.CN.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CN.getName())#" />,
					<cfqueryparam value="#arguments.CN.getCNNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CN.getCNNumber())#" />,
					<cfqueryparam value="#arguments.CN.getBudgetSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CN.getBudgetSubmitDate())#" />,
					<cfqueryparam value="#arguments.CN.getCongressSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CN.getCongressSubmitDate())#" />,
					<cfqueryparam value="#arguments.CN.getApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CN.getApprovedDate())#" />,
					<cfqueryparam value="#arguments.CN.getCNType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CN.getCNType())#" />,

					)

					SELECT @@Identity as cnid
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn qCreate.cnid />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="CN" type="CN" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					CNID,
					Name,
					CNNumber,
					BudgetSubmitDate,
					CongressSubmitDate,
					ApprovedDate,
					CNType
				FROM	CN
				WHERE	CNID = <cfqueryparam value="#arguments.CN.getCNID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.CN.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="CN" type="CN" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	CN
				SET
					Name = <cfqueryparam value="#arguments.CN.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CN.getName())#" />,
					CNNumber = <cfqueryparam value="#arguments.CN.getCNNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CN.getCNNumber())#" />,
					BudgetSubmitDate = <cfqueryparam value="#arguments.CN.getBudgetSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CN.getBudgetSubmitDate())#" />,
					CongressSubmitDate = <cfqueryparam value="#arguments.CN.getCongressSubmitDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CN.getCongressSubmitDate())#" />,
					ApprovedDate = <cfqueryparam value="#arguments.CN.getApprovedDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CN.getApprovedDate())#" />,
					CNType = <cfqueryparam value="#arguments.CN.getCNType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CN.getCNType())#" />
				WHERE	CNID = <cfqueryparam value="#arguments.CN.getCNID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn arguments.CN.getCNID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="CN" type="CN" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	CN 
				WHERE	CNID = <cfqueryparam value="#arguments.CN.getCNID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="CN" type="CN" required="true" />

		<cfset var qExists = "">
		<cfif arguments.cn.getCNID() is not "">
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	CN
				WHERE	CNID = <cfqueryparam value="#arguments.CN.getCNID()#" CFSQLType="cf_sql_integer" />
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
		<cfargument name="CN" type="CN" required="true" />
		
		<cfset var success = "" />
		<cfif exists(arguments.CN)>
			<cfset success = update(arguments.CN) />
		<cfelse>
			<cfset success = create(arguments.CN) />
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
<cfcomponent displayname="CNClearanceDAO" hint="table ID column = CNClearanceID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
		
	<cffunction name="init" access="public" output="false" returntype="CNClearanceDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="CNClearance" type="CNClearance" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO CNClearance
					(
					CNID,
					CNStatusID,
					ClearanceStatus,
					ClearanceAgencyName,
					Comments,
					cstatusDate,
					ClearanceType,
					sysUserID
					)
				VALUES
					(
					<cfqueryparam value="#arguments.CNClearance.getCNID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.CNClearance.getCNStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.CNClearance.getCNStatusID())#" />,
					<cfqueryparam value="#arguments.CNClearance.getClearanceStatus()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getClearanceStatus())#" />,
					<cfqueryparam value="#arguments.CNClearance.getClearanceAgencyName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getClearanceAgencyName())#" />,
					<cfqueryparam value="#arguments.CNClearance.getComments()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getComments())#" />,
					<cfqueryparam value="#arguments.CNClearance.getcstatusDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CNClearance.getcstatusDate())#" />,
					<cfqueryparam value="#arguments.CNClearance.getClearanceType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getClearanceType())#" />,
					<cfqueryparam value="#arguments.CNClearance.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.CNClearance.getsysUserID())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="CNClearance" type="CNClearance" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					CNClearanceID,
					CNID,
					CNStatusID,
					ClearanceStatus,
					ClearanceAgencyName,
					Comments,
					cstatusDate,
					ClearanceType,
					sysUserID
				FROM	CNClearance
				WHERE	CNClearanceID = <cfqueryparam value="#arguments.CNClearance.getCNClearanceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.CNClearance.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="CNClearance" type="CNClearance" required="true" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	CNClearance
				SET
					CNID = <cfqueryparam value="#arguments.CNClearance.getCNID()#" CFSQLType="cf_sql_integer" />,
					CNStatusID = <cfqueryparam value="#arguments.CNClearance.getCNStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.CNClearance.getCNStatusID())#" />,
					ClearanceStatus = <cfqueryparam value="#arguments.CNClearance.getClearanceStatus()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getClearanceStatus())#" />,
					ClearanceAgencyName = <cfqueryparam value="#arguments.CNClearance.getClearanceAgencyName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getClearanceAgencyName())#" />,
					Comments = <cfqueryparam value="#arguments.CNClearance.getComments()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getComments())#" />,
					cstatusDate = <cfqueryparam value="#arguments.CNClearance.getcstatusDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.CNClearance.getcstatusDate())#" />,
					ClearanceType = <cfqueryparam value="#arguments.CNClearance.getClearanceType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.CNClearance.getClearanceType())#" />,
					sysUserID = <cfqueryparam value="#arguments.CNClearance.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.CNClearance.getsysUserID())#" />
				WHERE	CNClearanceID = <cfqueryparam value="#arguments.CNClearance.getCNClearanceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="CNClearance" type="CNClearance" required="true" />

		<cfset var qDelete = "">
		<!--- <cftry> --->
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	CNClearance 
				WHERE	CNClearanceID = <cfqueryparam value="#arguments.CNClearance.getCNClearanceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="CNClearance" type="CNClearance" required="true" />

		<cfset var qExists = "">
		<cfif len(arguments.CNClearance.getCNClearanceID())>
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	CNClearance
				WHERE	CNClearanceID = <cfqueryparam value="#arguments.CNClearance.getCNClearanceID()#" CFSQLType="cf_sql_integer" />
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

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="CNClearance" type="CNClearance" required="true" />

		<cfset var success = false />
		<cfif exists(arguments.CNClearance)>
			<cfset success = update(arguments.CNClearance) />
		<cfelse>
			<cfset success = create(arguments.CNClearance) />
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
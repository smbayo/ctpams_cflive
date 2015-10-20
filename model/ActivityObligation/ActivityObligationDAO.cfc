<cfcomponent displayname="ActivityObligationDAO" hint="table ID column = ActivityObligateID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityObligationDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityObligation" type="ActivityObligation" required="true" />

		<cfset var qCreate = "" />
		<!--- <cftry> --->
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ActivityObligation
					(
					ActivityID,
					Amount,
					obligationDate,
					ObligationFYyearSource,
					Comments,
					isActive,
					sysUserID,
					ObligationNumber
					)
				VALUES
					(
					<cfqueryparam value="#arguments.ActivityObligation.getActivityID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.ActivityObligation.getAmount()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityObligation.getAmount())#" />,
					<cfqueryparam value="#arguments.ActivityObligation.getobligationDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityObligation.getobligationDate())#" />,
					<cfqueryparam value="#arguments.ActivityObligation.getObligationFYyearSource()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityObligation.getObligationFYyearSource())#" />,
					<cfqueryparam value="#arguments.ActivityObligation.getComments()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityObligation.getComments())#" />,
					<cfqueryparam value="#arguments.ActivityObligation.getisActive()#" CFSQLType="cf_sql_bit" null="#not len(arguments.ActivityObligation.getisActive())#" />,
					<cfqueryparam value="#arguments.ActivityObligation.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityObligation.getsysUserID())#" />,
					<cfqueryparam value="#arguments.ActivityObligation.getObligationNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityObligation.getObligationNumber())#" />
					)
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ActivityObligation" type="ActivityObligation" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<!--- <cftry> --->
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					ActivityObligateID,
					ActivityID,
					Amount,
					obligationDate,
					ObligationFYyearSource,
					Comments,
					isActive,
					sysUserID,
					ObligationNumber
				FROM	ActivityObligation
				WHERE	ActivityObligateID = <cfqueryparam value="#arguments.ActivityObligation.getActivityObligateID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database"> --->
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<!--- <cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry> --->
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ActivityObligation.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityObligation" type="ActivityObligation" required="true" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityObligation
				SET
					ActivityID = <cfqueryparam value="#arguments.ActivityObligation.getActivityID()#" CFSQLType="cf_sql_integer" />,
					Amount = <cfqueryparam value="#arguments.ActivityObligation.getAmount()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityObligation.getAmount())#" />,
					obligationDate = <cfqueryparam value="#arguments.ActivityObligation.getobligationDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityObligation.getobligationDate())#" />,
					ObligationFYyearSource = <cfqueryparam value="#arguments.ActivityObligation.getObligationFYyearSource()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityObligation.getObligationFYyearSource())#" />,
					Comments = <cfqueryparam value="#arguments.ActivityObligation.getComments()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityObligation.getComments())#" />,
					isActive = <cfqueryparam value="#arguments.ActivityObligation.getisActive()#" CFSQLType="cf_sql_bit" null="#not len(arguments.ActivityObligation.getisActive())#" />,
					sysUserID = <cfqueryparam value="#arguments.ActivityObligation.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityObligation.getsysUserID())#" />,
					ObligationNumber = <cfqueryparam value="#arguments.ActivityObligation.getObligationNumber()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityObligation.getObligationNumber())#" />
				WHERE	ActivityObligateID = <cfqueryparam value="#arguments.ActivityObligation.getActivityObligateID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityObligation" type="ActivityObligation" required="true" />

		<cfset var qDelete = "">
		<!--- <cftry> --->
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ActivityObligation 
				WHERE	ActivityObligateID = <cfqueryparam value="#arguments.ActivityObligation.getActivityObligateID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityObligation" type="ActivityObligation" required="true" />

		<cfset var qExists = "">
		<cfif arguments.ActivityObligation.getActivityObligateID() is not "">
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	ActivityObligation
				WHERE	ActivityObligateID = <cfqueryparam value="#arguments.ActivityObligation.getActivityObligateID()#" CFSQLType="cf_sql_integer" />
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
		<cfargument name="ActivityObligation" type="ActivityObligation" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.ActivityObligation)>
			<cfset success = update(arguments.ActivityObligation) />
		<cfelse>
			<cfset success = create(arguments.ActivityObligation) />
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

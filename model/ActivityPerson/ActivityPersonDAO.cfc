<cfcomponent displayname="ActivityPersonDAO" hint="table ID column = ActivityPersonID">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="ActivityPersonDAO">

		<cfreturn this>
	</cffunction>

	<cffunction name="create" access="public" output="false" returntype="numeric">
		<cfargument name="ActivityPerson" type="ActivityPerson" required="true" />

		<cfset var qCreate = "" />
		<!--- <cftry> --->
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ActivityPerson
					(
					ActivityID,
					LastName,
					FirstName,
					Email,
					Phone,
					Office
					)
				VALUES
					(
					<cfqueryparam value="#arguments.ActivityPerson.getActivityID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.ActivityPerson.getLastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getLastName())#" />,
					<cfqueryparam value="#arguments.ActivityPerson.getFirstName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getFirstName())#" />,
					<cfqueryparam value="#arguments.ActivityPerson.getEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getEmail())#" />,
					<cfqueryparam value="#arguments.ActivityPerson.getPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getPhone())#" />,
					<cfqueryparam value="#arguments.ActivityPerson.getOffice()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getOffice())#" />
					)
					SELECT @@Identity as ActivityPersonID
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn qCreate.ActivityPersonID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ActivityPerson" type="ActivityPerson" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					ActivityPersonID,
					ActivityID,
					LastName,
					FirstName,
					Email,
					Phone,
					Office
				FROM	ActivityPerson
				WHERE	ActivityPersonID = <cfqueryparam value="#arguments.ActivityPerson.getActivityPersonID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ActivityPerson.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="numeric">
		<cfargument name="ActivityPerson" type="ActivityPerson" required="true" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityPerson
				SET
					ActivityID = <cfqueryparam value="#arguments.ActivityPerson.getActivityID()#" CFSQLType="cf_sql_integer" />,
					LastName = <cfqueryparam value="#arguments.ActivityPerson.getLastName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getLastName())#" />,
					FirstName = <cfqueryparam value="#arguments.ActivityPerson.getFirstName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getFirstName())#" />,
					Email = <cfqueryparam value="#arguments.ActivityPerson.getEmail()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getEmail())#" />,
					Phone = <cfqueryparam value="#arguments.ActivityPerson.getPhone()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getPhone())#" />,
					Office = <cfqueryparam value="#arguments.ActivityPerson.getOffice()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityPerson.getOffice())#" />
				WHERE	ActivityPersonID = <cfqueryparam value="#arguments.ActivityPerson.getActivityPersonID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn arguments.ActivityPerson.getActivityPersonID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityPerson" type="ActivityPerson" required="true" />

		<cfset var qDelete = "">
		<!--- <cftry> --->
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ActivityPerson
				WHERE	ActivityPersonID = <cfqueryparam value="#arguments.ActivityPerson.getActivityPersonID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		 </cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityPerson" type="ActivityPerson" required="true" />

		<cfset var qExists = "">
		<cfif arguments.ActivityPerson.getActivityPersonID() is not "">
			<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
				SELECT count(1) as idexists
				FROM	ActivityPerson
				WHERE	ActivityPersonID = <cfqueryparam value="#arguments.ActivityPerson.getActivityPersonID()#" CFSQLType="cf_sql_integer" />
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
		<cfargument name="ActivityPerson" type="ActivityPerson" required="true" />

		<cfset var success = false />
		<cfif exists(arguments.ActivityPerson)>
			<cfset success = update(arguments.ActivityPerson) />
		<cfelse>
			<cfset success = create(arguments.ActivityPerson) />
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

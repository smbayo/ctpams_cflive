<cfcomponent displayname="ActivityLegalRecommendationDAO" hint="table ID column = ActivityRecommID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="ActivityLegalRecommendationDAO">
		<cfreturn this>
	</cffunction>

	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityLegalRecommendation" type="ActivityLegalRecommendation" required="true" />

		<cfset var qCreate = "" />
		<!--- <cftry> --->
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO ActivityLegalRecommendation
					(
					ActivityID,
					CNID,
					ActivityStatusID,
					Sender,
					Comments,
					commentType,
					commentDate,
					isActive,
					sysUserID
					)
				VALUES
					(
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getCNID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityLegalRecommendation.getCNID())#" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityLegalRecommendation.getActivityStatusID())#" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getSender()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityLegalRecommendation.getSender())#" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getComments()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityLegalRecommendation.getComments())#" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getcommentType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityLegalRecommendation.getcommentType())#" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getcommentDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityLegalRecommendation.getcommentDate())#" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getisActive()#" CFSQLType="cf_sql_bit" null="#not len(arguments.ActivityLegalRecommendation.getisActive())#" />,
					<cfqueryparam value="#arguments.ActivityLegalRecommendation.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityLegalRecommendation.getsysUserID())#" />
					)
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch> --->
		<!--- </cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="ActivityLegalRecommendation" type="ActivityLegalRecommendation" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					ActivityRecommID,
					ActivityID,
					CNID,
					ActivityStatusID,
					Sender,
					Comments,
					commentType,
					commentDate,
					isActive,
					sysUserID
				FROM	ActivityLegalRecommendation
				WHERE	ActivityRecommID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityRecommID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ActivityLegalRecommendation.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityLegalRecommendation" type="ActivityLegalRecommendation" required="true" />

		<cfset var qUpdate = "" />
		<!--- <cftry> --->
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	ActivityLegalRecommendation
				SET
					ActivityID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityID()#" CFSQLType="cf_sql_integer" />,
					CNID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getCNID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityLegalRecommendation.getCNID())#" />,
					ActivityStatusID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityStatusID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityLegalRecommendation.getActivityStatusID())#" />,
					Sender = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getSender()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityLegalRecommendation.getSender())#" />,
					Comments = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getComments()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityLegalRecommendation.getComments())#" />,
					commentType = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getcommentType()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.ActivityLegalRecommendation.getcommentType())#" />,
					commentDate = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getcommentDate()#" CFSQLType="cf_sql_timestamp" null="#not len(arguments.ActivityLegalRecommendation.getcommentDate())#" />,
					isActive = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getisActive()#" CFSQLType="cf_sql_bit" null="#not len(arguments.ActivityLegalRecommendation.getisActive())#" />,
					sysUserID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getsysUserID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ActivityLegalRecommendation.getsysUserID())#" />
				WHERE	ActivityRecommID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityRecommID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityLegalRecommendation" type="ActivityLegalRecommendation" required="true" />

		<cfset var qDelete = "">
		<!--- <cftry> --->
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	ActivityLegalRecommendation
				WHERE	ActivityRecommID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityRecommID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<!--- <cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry> --->
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityLegalRecommendation" type="ActivityLegalRecommendation" required="true" />

		<cfset var qExists = "">
		<cfif arguments.ActivityLegalRecommendation.getActivityRecommID() IS NOT "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	ActivityLegalRecommendation
			WHERE	ActivityRecommID = <cfqueryparam value="#arguments.ActivityLegalRecommendation.getActivityRecommID()#" CFSQLType="cf_sql_integer" />
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
		<cfargument name="ActivityLegalRecommendation" type="ActivityLegalRecommendation" required="true" />

		<cfset var success = false />
		<cfif exists(arguments.ActivityLegalRecommendation)>
			<cfset success = update(arguments.ActivityLegalRecommendation) />
		<cfelse>
			<cfset success = create(arguments.ActivityLegalRecommendation) />
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

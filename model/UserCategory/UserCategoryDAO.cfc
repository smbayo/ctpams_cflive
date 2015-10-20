
<cfcomponent displayname="userCategoryDAO" hint="table ID column = SysUserID,CategoryID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />
  	<cfproperty name="UserCategory" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="UserCategoryDAO">
		<cfreturn this />
	</cffunction>
	
  	<cffunction name="new" access="public" output="false" returntype="userCategory">
    	<cfreturn instance.UserCategory.init()>
  	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="userCategory" type="userCategory" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO SysUserCategory
					(
					SysUserID,
					CategoryID
					)
				VALUES
					(
					<cfqueryparam value="#arguments.userCategory.getSysUserID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.userCategory.getCategoryID()#" CFSQLType="cf_sql_integer" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="userCategory" type="userCategory" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					SysUserID,
					CategoryID
				FROM	SysUserCategory
				WHERE	SysUserID = <cfqueryparam value="#arguments.userCategory.getSysUserID()#" CFSQLType="cf_sql_integer" />
				AND	CategoryID = <cfqueryparam value="#arguments.userCategory.getCategoryID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.userCategory.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="userCategory" type="userCategory" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	SysUserCategory
				SET
					
				WHERE	SysUserID = <cfqueryparam value="#arguments.userCategory.getSysUserID()#" CFSQLType="cf_sql_integer" />
				AND	CategoryID = <cfqueryparam value="#arguments.userCategory.getCategoryID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="userCategory" type="userCategory" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	SysUserCategory 
				WHERE	SysUserID = <cfqueryparam value="#arguments.userCategory.getSysUserID()#" CFSQLType="cf_sql_integer" />
				AND	CategoryID = <cfqueryparam value="#arguments.userCategory.getCategoryID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="userCategory" type="userCategory" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	SysUserCategory
			WHERE	SysUserID = <cfqueryparam value="#arguments.userCategory.getSysUserID()#" CFSQLType="cf_sql_integer" />
			AND	CategoryID = <cfqueryparam value="#arguments.userCategory.getCategoryID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="userCategory" type="userCategory" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.userCategory)>
			<cfset success = update(arguments.userCategory) />
		<cfelse>
			<cfset success = create(arguments.userCategory) />
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

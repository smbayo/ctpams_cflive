
<cfcomponent displayname="RoleDAO" hint="table ID column = SysRoleID">


	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="RoleDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="numeric">
		<cfargument name="Role" type="Role" required="true" />

		<cfset var qCreate = "" />
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO SysRole
					(
					Name,
					Description
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Role.getName()#" CFSQLType="cf_sql_varchar" />,
					<cfqueryparam value="#arguments.Role.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Role.getDescription())#" />

					)
                    SELECT @@Identity as RoleID
			</cfquery>
		<cfreturn  qCreate.RoleID />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Role" type="Role" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cfquery name="qRead" datasource="#dsn.getName()#">
			SELECT
				SysRoleID,
				Name,
				Description
			FROM	SysRole
			WHERE	SysRoleID = <cfqueryparam value="#arguments.Role.getSysRoleID()#" CFSQLType="cf_sql_integer" />
		</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Role.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="numeric">
		<cfargument name="Role" type="Role" required="true" />

		<cfset var qUpdate = "" />
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	SysRole
				SET
					Name = <cfqueryparam value="#arguments.Role.getName()#" CFSQLType="cf_sql_varchar" />,
					Description = <cfqueryparam value="#arguments.Role.getDescription()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Role.getDescription())#" />

				WHERE	SysRoleID = <cfqueryparam value="#arguments.Role.getSysRoleID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
           		<cfreturn arguments.role.getsysRoleID() />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Role" type="Role" required="true" />

		<cfset var qDelete = "">
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	SysRole 
				WHERE	SysRoleID = <cfqueryparam value="#arguments.Role.getSysRoleID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Role" type="Role" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	SysRole
			WHERE	SysRoleID = <cfqueryparam value="#arguments.Role.getSysRoleID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Role" type="Role" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Role)>
			<cfset success = update(arguments.Role) />
		<cfelse>
			<cfset success = create(arguments.Role) />
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


<cfcomponent displayname="UserRoleGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />


	<cffunction name="init" access="public" output="false" returntype="UserRoleGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="SysRoleID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				SysUserID,
				SysRoleID,
                Name,
                Description,
                Email,
                rolename, 
                roledesc
                <!--- ,AuthName --->
			FROM	View_usersRoles
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"SysUserID") and len(arguments.SysUserID)>
			AND	SysUserID = <cfqueryparam value="#arguments.SysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"SysRoleID") and len(arguments.SysRoleID)>
			AND	SysRoleID = <cfqueryparam value="#arguments.SysRoleID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="SysRoleID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","SysUserRole").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="SysRoleID" type="numeric" required="false" />
		
		<cfset var qList = "" />    
		<cfquery name="qList" datasource="#dsn.getName()#">
			DELETE
			  FROM  SysUserRole
			 WHERE 0=0
			<cfif structKeyExists(arguments,"SysUserID") and len(arguments.sysuserID)>
			   AND SysUserID = <cfqueryparam value="#arguments.sysUserID#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments,"sysRoleID") and len(arguments.sysRoleID)>
			   AND sysRoleID = <cfqueryparam value="#arguments.sysRoleID#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
	
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

  	<cffunction name="getAvailableUserRoleQuery" access="public" output="false" returntype="query">
   		<cfargument name="sysuserid" type="numeric" required="true">
   
   		<cfset var availableUserRole = "">
   
   		<cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableUserRoles">
     		<cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.sysuserid#">
     		<cfprocresult name="availableUserRole" resultset="1">
   		</cfstoredproc>
   
   	  <cfreturn availableUserRole>
  	</cffunction>

  	<cffunction name="getAttachedUserRoleQuery" access="public" output="false" returntype="query">
   		<cfargument name="sysuserid" type="numeric" required="true">
   
   		<cfset var AttachedUserRole = "">
   
   		<cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableUserRoles">
     		<cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.sysuserid#">
     		<cfprocresult name="AttachedUserRole" resultset="2">
   		</cfstoredproc>
   
   	  <cfreturn AttachedUserRole>
  	</cffunction>

	<cffunction name="getQuickUserRoles" access="public" output="false" returntype="query">
		<cfargument name="SysUserID" type="numeric" required="false" />
	
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT DISTINCT
				SysUserID,
				rolename,
				roledesc
			FROM	View_usersroles
			WHERE	0=0
       		<cfif structKeyExists(arguments,"SysUserID") and len(arguments.SysUserID)>
			AND	SysUserID = <cfqueryparam value="#arguments.SysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>

		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getQuickUserPermissions" access="public" output="false" returntype="query">
		<cfargument name="SysUserID" type="numeric" required="false" />
	
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT DISTINCT
				SysUserID, PermissionName
			 FROM	View_syslogin
			WHERE	0=0
       		<cfif structKeyExists(arguments,"SysUserID") and len(arguments.SysUserID)>
			  AND	SysUserID = <cfqueryparam value="#arguments.SysUserID#" CFSQLType="cf_sql_integer" />
			</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

</cfcomponent>

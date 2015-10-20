
<cfcomponent displayname="RolePermissionGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<cffunction name="init" access="public" output="false" returntype="RolePermissionGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="SysRoleID" type="numeric" required="false" />
		<cfargument name="SysPermissionID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				SysRoleID,
				SysPermissionID,
                Name,
                Description,
                PermissionName,
                PermissionDesc
            FROM	View_UserRolePermission
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"SysRoleID") and len(arguments.SysRoleID)>
			AND	SysRoleID = <cfqueryparam value="#arguments.SysRoleID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"SysPermissionID") and len(arguments.SysPermissionID)>
			AND	SysPermissionID = <cfqueryparam value="#arguments.SysPermissionID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="SysRoleID" type="numeric" required="false" />
		<cfargument name="SysPermissionID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","RolePermission").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
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


  <cffunction name="getAvailableRolePermissionQuery" access="public" output="false" returntype="query">
   <cfargument name="sysroleid" type="numeric" required="true">
   
   <cfset var availableRolePermission = "">
   
   <cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableRolePermissions">
     <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.sysroleid#">
     <cfprocresult name="availableRolePermission" resultset="1">
   </cfstoredproc>
   
   <cfreturn availableRolePermission>
  </cffunction>

	<cffunction name="getRolePermissionQuery" access="public" output="false" returntype="query">
		<cfargument name="sysroleid" type="numeric" required="true">

		<cfquery name="qRolePermission" datasource="#dsn.getName()#">
			SELECT SysRolePermission.SysRoleID
				  ,SysRolePermission.SysPermissionID
			      ,SysRole.Name roleName
			      ,SysPermission.Name permissionName
			  FROM SysRolePermission
			  JOIN SysPermission ON (SysRolePermission.SysPermissionID = SysPermission.SysPermissionID)
			  JOIN SysRole ON (SysRolePermission.SysRoleID = SysRole.SysRoleID)
			 WHERE SysRolePermission.SysRoleID = <cfqueryparam value="#arguments.sysRoleID#" CFSQLType="cf_sql_integer" />		
		</cfquery>
		
   		<cfreturn qRolePermission>
	</cffunction>

  <cffunction name="getAttachedRolePermissionQuery" access="public" output="false" returntype="query">
   <cfargument name="sysroleid" type="numeric" required="true">
   
   <cfset var AttachedRolePermission = "">
   
   <cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableRolePermissions">
     <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.sysroleid#">
     <cfprocresult name="AttachedRolePermission" resultset="2">
   </cfstoredproc>
   
   <cfreturn AttachedRolePermission>
  </cffunction>

  <cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
    <cfargument name="SysRoleID" type="numeric" required="false" />
    <cfargument name="SysPermissionID" type="numeric" required="false" />
    
    <cfset var qList = "" />    
    <cfquery name="qList" datasource="#dsn.getName()#">
      DELETE
      FROM  SysRolePermission
      WHERE 0=0
    <cfif structKeyExists(arguments,"SysRoleID") and len(arguments.sysroleID)>
      AND SysRoleID = <cfqueryparam value="#arguments.sysRoleID#" CFSQLType="cf_sql_integer" />
    </cfif>
    <cfif structKeyExists(arguments,"sysPermissionID") and len(arguments.sysPermissionID)>
      AND sysPermissionID = <cfqueryparam value="#arguments.sysPermissionID#" CFSQLType="cf_sql_integer" />
    </cfif>
    </cfquery>
    
  </cffunction>




</cfcomponent>


<cfcomponent displayname="UserCategoryGateway" output="false">

	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />


	<cffunction name="init" access="public" output="false" returntype="UserCategoryGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				SysUserID,
				CategoryID,
                Name,
                Description,
                Email,
                Categoryname, 
                Categorydesc
                <!--- ,AuthName --->
			FROM	View_usersCategories
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"SysUserID") and len(arguments.SysUserID)>
			AND	SysUserID = <cfqueryparam value="#arguments.SysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CategoryID") and len(arguments.CategoryID)>
			AND	CategoryID = <cfqueryparam value="#arguments.CategoryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","SysUserCategory").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>

	<cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="CategoryID" type="numeric" required="false" />
		
		<cfset var qList = "" />    
		<cfquery name="qList" datasource="#dsn.getName()#">
			DELETE
			  FROM  SysUserCategory
			 WHERE 0=0
			<cfif structKeyExists(arguments,"SysUserID") and len(arguments.sysuserID)>
			   AND SysUserID = <cfqueryparam value="#arguments.sysUserID#" CFSQLType="cf_sql_integer" />
			</cfif>
			<cfif structKeyExists(arguments,"CategoryID") and len(arguments.CategoryID)>
			   AND CategoryID = <cfqueryparam value="#arguments.CategoryID#" CFSQLType="cf_sql_integer" />
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

  	<cffunction name="getAvailableUserCategoryQuery" access="public" output="false" returntype="query">
   		<cfargument name="sysuserid" type="numeric" required="true">
   
   		<cfset var availableUserCategory = "">
   
   		<cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableUserCategories">
     		<cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.sysuserid#">
     		<cfprocresult name="availableUserCategory" resultset="1">
   		</cfstoredproc>
   
   	  <cfreturn availableUserCategory>
  	</cffunction>

  	<cffunction name="getAttachedUserCategoryQuery" access="public" output="false" returntype="query">
   		<cfargument name="sysuserid" type="numeric" required="true">
   
   		<cfset var AttachedUserCategory = "">
   
   		<cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableUserCategories">
     		<cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.sysuserid#">
     		<cfprocresult name="AttachedUserCategory" resultset="2">
   		</cfstoredproc>
   
   	  <cfreturn AttachedUserCategory>
  	</cffunction>

	<cffunction name="getQuickUserCategories" access="public" output="false" returntype="query">
		<cfargument name="SysUserID" type="numeric" required="false" />
	
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT DISTINCT
				SysUserID,
				Categoryname,
				Categorydesc
			FROM	View_usersCategories
			WHERE	0=0
       		<cfif structKeyExists(arguments,"SysUserID") and len(arguments.SysUserID)>
			AND	SysUserID = <cfqueryparam value="#arguments.SysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>

		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	

</cfcomponent>

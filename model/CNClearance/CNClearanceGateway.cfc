<cfcomponent displayname="CNClearanceGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
		
	<cffunction name="init" access="public" output="false" returntype="CNClearanceGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="CNClearanceID" type="numeric" required="false" />
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="CNStatusID" type="numeric" required="false" />
		<cfargument name="ClearanceStatus" type="string" required="false" />
		<cfargument name="ClearanceAgencyName" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="cstatusDate" type="date" required="false" />
		<cfargument name="ClearanceType" type="string" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
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
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"CNClearanceID") and len(arguments.CNClearanceID)>
			AND	CNClearanceID = <cfqueryparam value="#arguments.CNClearanceID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CNID") and len(arguments.CNID)>
			AND	CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CNStatusID") and len(arguments.CNStatusID)>
			AND	CNStatusID = <cfqueryparam value="#arguments.CNStatusID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ClearanceStatus") and len(arguments.ClearanceStatus)>
			AND	ClearanceStatus = <cfqueryparam value="#arguments.ClearanceStatus#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ClearanceAgencyName") and len(arguments.ClearanceAgencyName)>
			AND	ClearanceAgencyName = <cfqueryparam value="#arguments.ClearanceAgencyName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Comments") and len(arguments.Comments)>
			AND	Comments = <cfqueryparam value="#arguments.Comments#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"cstatusDate") and len(arguments.cstatusDate)>
			AND	cstatusDate = <cfqueryparam value="#arguments.cstatusDate#" CFSQLType="cf_sql_timestamp" />
		</cfif>
		<cfif structKeyExists(arguments,"ClearanceType") and len(arguments.ClearanceType)>
			AND	ClearanceType = <cfqueryparam value="#arguments.ClearanceType#" CFSQLType="cf_sql_varchar" />
		</cfif>		
		<cfif structKeyExists(arguments,"sysUserID") and len(arguments.sysUserID)>
			AND	sysUserID = <cfqueryparam value="#arguments.sysUserID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="CNClearanceID" type="numeric" required="false" />
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="CNStatusID" type="numeric" required="false" />
		<cfargument name="ClearanceStatus" type="string" required="false" />
		<cfargument name="ClearanceAgencyName" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="cstatusDate" type="date" required="false" />
		<cfargument name="ClearanceType" type="string" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />		
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","CNClearance").init(argumentCollection=queryRowToStruct(qList,i)) />
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

	<cffunction name="resetMOUClearances" access="public" output="false" returntype="string">
		<cfargument name="CNID" type="numeric" required="true" />

		<cfset var flegal = "" />	
		<cfquery name="flegal" datasource="#dsn.getName()#">
			delete from CNclearance
			where CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
			and ClearanceAgencyName = 'f-Legal'
		</cfquery>
			
		<cfset var budget = "" />	
		<cfquery name="flegal" datasource="#dsn.getName()#">
			delete from CNclearance
			where CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
			and ClearanceAgencyName = 'Budget'
		</cfquery>
			
		<cfset var fo = "" />	
		<cfquery name="fo" datasource="#dsn.getName()#">
			delete from CNclearance
			where CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
			and ClearanceAgencyName = 'Front Office'
		</cfquery>
			
		<cfset var agency = "" />	
		<cfquery name="agency" datasource="#dsn.getName()#">
			delete from CNclearance
			where CNID = <cfqueryparam value="#arguments.CNID#" CFSQLType="cf_sql_integer" />
			and ClearanceAgencyName = 'Agency'
		</cfquery>
				
		<cfreturn "true" />
	</cffunction>
		
</cfcomponent>
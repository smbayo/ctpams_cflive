<cfcomponent displayname="ActivityPersonGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityPersonGateway">
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="deleteByAttributesQuery" access="public" output="false" returntype="void">
		<cfargument name="ActivityPersonID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="LastName" type="string" required="false" />
		<cfargument name="FirstName" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />		
		<cfargument name="Office" type="string" required="false" />	
			
		<cfquery name="qList" datasource="#dsn.getName()#">
			DELETE
			FROM	ActivityPerson
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ActivityPersonID") and len(arguments.ActivityPersonID)>
			AND	ActivityPersonID = <cfqueryparam value="#arguments.ActivityPersonID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"LastName") and len(arguments.LastName)>
			AND	LastName = <cfqueryparam value="#arguments.LastName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"FirstName") and len(arguments.FirstName)>
			AND	FirstName = <cfqueryparam value="#arguments.FirstName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Email") and len(arguments.Email)>
			AND	Email = <cfqueryparam value="#arguments.Email#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Phone") and len(arguments.Phone)>
			AND	Phone = <cfqueryparam value="#arguments.Phone#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Office") and len(arguments.Office)>
			AND	Office = <cfqueryparam value="#arguments.Office#" CFSQLType="cf_sql_varchar" />
		</cfif>
		</cfquery>
		
		<cfreturn />
	</cffunction>	
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ActivityPersonID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="LastName" type="string" required="false" />
		<cfargument name="FirstName" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		<cfargument name="Office" type="string" required="false" />	
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ActivityPersonID,
				ActivityID,
				LastName,
				FirstName,
				Email,
				Phone,
				Office,
				CASE 
					WHEN exists (select sysuserid from sysUser where email = ap.Email) THEN
						1	
				   ELSE
					0
				   END isSystemUser
			FROM	ActivityPerson ap
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ActivityPersonID") and len(arguments.ActivityPersonID)>
			AND	ActivityPersonID = <cfqueryparam value="#arguments.ActivityPersonID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ActivityID") and len(arguments.ActivityID)>
			AND	ActivityID = <cfqueryparam value="#arguments.ActivityID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"LastName") and len(arguments.LastName)>
			AND	LastName = <cfqueryparam value="#arguments.LastName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"FirstName") and len(arguments.FirstName)>
			AND	FirstName = <cfqueryparam value="#arguments.FirstName#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Email") and len(arguments.Email)>
			AND	Email = <cfqueryparam value="#arguments.Email#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Phone") and len(arguments.Phone)>
			AND	Phone = <cfqueryparam value="#arguments.Phone#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Office") and len(arguments.Office)>
			AND	Office = <cfqueryparam value="#arguments.Office#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ActivityPersonID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="LastName" type="string" required="false" />
		<cfargument name="FirstName" type="string" required="false" />
		<cfargument name="Email" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Office" type="string" required="false" />	
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","ActivityPerson").init(argumentCollection=queryRowToStruct(qList,i)) />
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

</cfcomponent>

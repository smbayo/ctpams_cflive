<cfcomponent displayname="ProgramGateway" output="false">
	<!--- Dependencies --->
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />
	
	<cffunction name="init" access="public" output="false" returntype="ProgramGateway">
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="ProgramID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Address1" type="string" required="false" />
		<cfargument name="Address2" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="PostalCode" type="numeric" required="false" />
		<cfargument name="CountryID" type="numeric" required="false" />
		<cfargument name="Telephone" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				ProgramID,
				ParentID,
				Name,
				Description,
				Address1,
				Address2,
				City,
				PostalCode,
				CountryID,
				Telephone
			FROM	Program
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"ProgramID") and len(arguments.ProgramID)>
			AND	ProgramID = <cfqueryparam value="#arguments.ProgramID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"ParentID") and len(arguments.ParentID)>
			AND	ParentID = <cfqueryparam value="#arguments.ParentID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Description") and len(arguments.Description)>
			AND	Description = <cfqueryparam value="#arguments.Description#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Address1") and len(arguments.Address1)>
			AND	Address1 = <cfqueryparam value="#arguments.Address1#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Address2") and len(arguments.Address2)>
			AND	Address2 = <cfqueryparam value="#arguments.Address2#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"City") and len(arguments.City)>
			AND	City = <cfqueryparam value="#arguments.City#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"PostalCode") and len(arguments.PostalCode)>
			AND	PostalCode = <cfqueryparam value="#arguments.PostalCode#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"CountryID") and len(arguments.CountryID)>
			AND	CountryID = <cfqueryparam value="#arguments.CountryID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Telephone") and len(arguments.Telephone)>
			AND	Telephone = <cfqueryparam value="#arguments.Telephone#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="ProgramID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="Address1" type="string" required="false" />
		<cfargument name="Address2" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="PostalCode" type="numeric" required="false" />
		<cfargument name="CountryID" type="numeric" required="false" />
		<cfargument name="Telephone" type="numeric" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","Program").init(argumentCollection=queryRowToStruct(qList,i)) />
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

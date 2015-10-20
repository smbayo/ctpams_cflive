
<cfcomponent displayname="LocationGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<cffunction name="init" access="public" output="false" returntype="LocationGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="LocationID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Longitude" type="numeric" required="false" />
		<cfargument name="Latitude" type="numeric" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
			SELECT
				LocationID,
				Name,
				Longitude,
				Latitude,
				Address,
				Province,
				Country,
				PostalCode
			FROM	Location
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"LocationID") and len(arguments.LocationID)>
			AND	LocationID = <cfqueryparam value="#arguments.LocationID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Longitude") and len(arguments.Longitude)>
			AND	Longitude = <cfqueryparam value="#arguments.Longitude#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Latitude") and len(arguments.Latitude)>
			AND	Latitude = <cfqueryparam value="#arguments.Latitude#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Address") and len(arguments.Address)>
			AND	Address = <cfqueryparam value="#arguments.Address#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Province") and len(arguments.Province)>
			AND	Province = <cfqueryparam value="#arguments.Province#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"Country") and len(arguments.Country)>
			AND	Country = <cfqueryparam value="#arguments.Country#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"PostalCode") and len(arguments.PostalCode)>
			AND	PostalCode = <cfqueryparam value="#arguments.PostalCode#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="LocationID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Longitude" type="numeric" required="false" />
		<cfargument name="Latitude" type="numeric" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","Location").init(argumentCollection=queryRowToStruct(qList,i)) />
			<cfset arrayAppend(arrObjects,tmpObj) />
		</cfloop>
				
		<cfreturn arrObjects />
	</cffunction>
	
  <cffunction name="getAvailableLocationsQuery" access="public" output="false" returntype="query">
   <cfargument name="activityid" type="numeric" required="true">
   
   <cfset var availableLocations = "">
   
   <cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableLocations">
     <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.activityid#">
     <cfprocresult name="availableLocations" resultset="1">
   </cfstoredproc>
   
   <cfreturn availableLocations>
  </cffunction>

  <cffunction name="getAttachedLocationsQuery" access="public" output="false" returntype="query">
   <cfargument name="activityid" type="numeric" required="true">
   
   <cfset var AttachedLocations = "">
   
   <cfstoredproc datasource="#dsn.getName()#" procedure="getAvailableLocations">
     <cfprocparam cfsqltype="CF_SQL_INTEGER" value="#arguments.activityid#">
     <cfprocresult name="AttachedLocations" resultset="2">
   </cfstoredproc>
   
   <cfreturn AttachedLocations>
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

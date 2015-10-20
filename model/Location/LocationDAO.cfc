
<cfcomponent displayname="LocationDAO" hint="table ID column = LocationID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" scope="variables" />

	<cffunction name="init" access="public" output="false" returntype="LocationDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="Location" type="Location" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO Location
					(
					LocationID,
					Name,
					Longitude,
					Latitude,
					Address,
					Province,
					Country,
					PostalCode
					)
				VALUES
					(
					<cfqueryparam value="#arguments.Location.getLocationID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.Location.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getName())#" />,
					<cfqueryparam value="#arguments.Location.getLongitude()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Location.getLongitude())#" />,
					<cfqueryparam value="#arguments.Location.getLatitude()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Location.getLatitude())#" />,
					<cfqueryparam value="#arguments.Location.getAddress()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getAddress())#" />,
					<cfqueryparam value="#arguments.Location.getProvince()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getProvince())#" />,
					<cfqueryparam value="#arguments.Location.getCountry()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getCountry())#" />,
					<cfqueryparam value="#arguments.Location.getPostalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getPostalCode())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="Location" type="Location" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
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
				WHERE	LocationID = <cfqueryparam value="#arguments.Location.getLocationID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Location.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="Location" type="Location" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	Location
				SET
					Name = <cfqueryparam value="#arguments.Location.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getName())#" />,
					Longitude = <cfqueryparam value="#arguments.Location.getLongitude()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Location.getLongitude())#" />,
					Latitude = <cfqueryparam value="#arguments.Location.getLatitude()#" CFSQLType="cf_sql_integer" null="#not len(arguments.Location.getLatitude())#" />,
					Address = <cfqueryparam value="#arguments.Location.getAddress()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getAddress())#" />,
					Province = <cfqueryparam value="#arguments.Location.getProvince()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getProvince())#" />,
					Country = <cfqueryparam value="#arguments.Location.getCountry()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getCountry())#" />,
					PostalCode = <cfqueryparam value="#arguments.Location.getPostalCode()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.Location.getPostalCode())#" />
				WHERE	LocationID = <cfqueryparam value="#arguments.Location.getLocationID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="Location" type="Location" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	Location 
				WHERE	LocationID = <cfqueryparam value="#arguments.Location.getLocationID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="Location" type="Location" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	Location
			WHERE	LocationID = <cfqueryparam value="#arguments.Location.getLocationID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="Location" type="Location" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.Location)>
			<cfset success = update(arguments.Location) />
		<cfelse>
			<cfset success = create(arguments.Location) />
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

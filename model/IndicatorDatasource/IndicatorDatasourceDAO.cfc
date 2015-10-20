
<cfcomponent displayname="IndicatorDatasourceDAO" hint="table ID column = sourceID">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="IndicatorDatasourceDAO">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="create" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorDatasource" type="IndicatorDatasource" required="true" />

		<cfset var qCreate = "" />
		<cftry>
			<cfquery name="qCreate" datasource="#dsn.getName()#">
				INSERT INTO IndicatorDatasource
					(
					IndicatorID,
					Name,
					CollectionMethod,
					CollectionFrequencyInWeeks,
					FundingSource,
					ProviderOrgID,
					DataStorageLocation,
					URL,
					DataLimitations,
					DataLimitationMitigation
					)
				VALUES
					(
					<cfqueryparam value="#arguments.IndicatorDatasource.getIndicatorID()#" CFSQLType="cf_sql_integer" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getName())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getCollectionMethod()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getCollectionMethod())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getCollectionFrequencyInWeeks()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getCollectionFrequencyInWeeks())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getFundingSource()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getFundingSource())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getProviderOrgID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.IndicatorDatasource.getProviderOrgID())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getDataStorageLocation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getDataStorageLocation())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getURL()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getURL())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getDataLimitations()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getDataLimitations())#" />,
					<cfqueryparam value="#arguments.IndicatorDatasource.getDataLimitationMitigation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getDataLimitationMitigation())#" />
					)
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="read" access="public" output="false" returntype="void">
		<cfargument name="IndicatorDatasource" type="IndicatorDatasource" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
		<cftry>
			<cfquery name="qRead" datasource="#dsn.getName()#">
				SELECT
					sourceID,
					IndicatorID,
					Name,
					CollectionMethod,
					CollectionFrequencyInWeeks,
					FundingSource,
					ProviderOrgID,
					DataStorageLocation,
					URL,
					DataLimitations,
					DataLimitationMitigation
				FROM	IndicatorDatasource
				WHERE	sourceID = <cfqueryparam value="#arguments.IndicatorDatasource.getsourceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<!--- leave the bean as is and set an empty query for the conditional logic below --->
				<cfset qRead = queryNew("id") />
			</cfcatch>
		</cftry>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.IndicatorDatasource.init(argumentCollection=strReturn)>
		</cfif>
	</cffunction>

	<cffunction name="update" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorDatasource" type="IndicatorDatasource" required="true" />

		<cfset var qUpdate = "" />
		<cftry>
			<cfquery name="qUpdate" datasource="#dsn.getName()#">
				UPDATE	IndicatorDatasource
				SET
					IndicatorID = <cfqueryparam value="#arguments.IndicatorDatasource.getIndicatorID()#" CFSQLType="cf_sql_integer" />,
					Name = <cfqueryparam value="#arguments.IndicatorDatasource.getName()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getName())#" />,
					CollectionMethod = <cfqueryparam value="#arguments.IndicatorDatasource.getCollectionMethod()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getCollectionMethod())#" />,
					CollectionFrequencyInWeeks = <cfqueryparam value="#arguments.IndicatorDatasource.getCollectionFrequencyInWeeks()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getCollectionFrequencyInWeeks())#" />,
					FundingSource = <cfqueryparam value="#arguments.IndicatorDatasource.getFundingSource()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getFundingSource())#" />,
					ProviderOrgID = <cfqueryparam value="#arguments.IndicatorDatasource.getProviderOrgID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.IndicatorDatasource.getProviderOrgID())#" />,
					DataStorageLocation = <cfqueryparam value="#arguments.IndicatorDatasource.getDataStorageLocation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getDataStorageLocation())#" />,
					URL = <cfqueryparam value="#arguments.IndicatorDatasource.getURL()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getURL())#" />,
					DataLimitations = <cfqueryparam value="#arguments.IndicatorDatasource.getDataLimitations()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getDataLimitations())#" />,
					DataLimitationMitigation = <cfqueryparam value="#arguments.IndicatorDatasource.getDataLimitationMitigation()#" CFSQLType="cf_sql_varchar" null="#not len(arguments.IndicatorDatasource.getDataLimitationMitigation())#" />
				WHERE	sourceID = <cfqueryparam value="#arguments.IndicatorDatasource.getsourceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="delete" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorDatasource" type="IndicatorDatasource" required="true" />

		<cfset var qDelete = "">
		<cftry>
			<cfquery name="qDelete" datasource="#dsn.getName()#">
				DELETE FROM	IndicatorDatasource 
				WHERE	sourceID = <cfqueryparam value="#arguments.IndicatorDatasource.getsourceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			<cfcatch type="database">
				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

	<cffunction name="exists" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorDatasource" type="IndicatorDatasource" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="#dsn.getName()#" maxrows="1">
			SELECT count(1) as idexists
			FROM	IndicatorDatasource
			WHERE	sourceID = <cfqueryparam value="#arguments.IndicatorDatasource.getsourceID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

	<cffunction name="save" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorDatasource" type="IndicatorDatasource" required="true" />
		
		<cfset var success = false />
		<cfif exists(arguments.IndicatorDatasource)>
			<cfset success = update(arguments.IndicatorDatasource) />
		<cfelse>
			<cfset success = create(arguments.IndicatorDatasource) />
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

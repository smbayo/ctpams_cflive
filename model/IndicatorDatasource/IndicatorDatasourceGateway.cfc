
<cfcomponent displayname="IndicatorDatasourceGateway" output="false">
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />

	<cffunction name="init" access="public" output="false" returntype="IndicatorDatasourceGateway">
		<cfreturn this />
	</cffunction>
	
	<cffunction name="getByAttributesQuery" access="public" output="false" returntype="query">
		<cfargument name="sourceID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="CollectionMethod" type="string" required="false" />
		<cfargument name="CollectionFrequencyInWeeks" type="string" required="false" />
		<cfargument name="FundingSource" type="string" required="false" />
		<cfargument name="ProviderOrgID" type="numeric" required="false" />
		<cfargument name="DataStorageLocation" type="string" required="false" />
		<cfargument name="URL" type="string" required="false" />
		<cfargument name="DataLimitations" type="string" required="false" />
		<cfargument name="DataLimitationMitigation" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = "" />		
		<cfquery name="qList" datasource="#dsn.getName()#">
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
			WHERE	0=0
		
		<cfif structKeyExists(arguments,"sourceID") and len(arguments.sourceID)>
			AND	sourceID = <cfqueryparam value="#arguments.sourceID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"IndicatorID") and len(arguments.IndicatorID)>
			AND	IndicatorID = <cfqueryparam value="#arguments.IndicatorID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"Name") and len(arguments.Name)>
			AND	Name = <cfqueryparam value="#arguments.Name#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"CollectionMethod") and len(arguments.CollectionMethod)>
			AND	CollectionMethod = <cfqueryparam value="#arguments.CollectionMethod#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"CollectionFrequencyInWeeks") and len(arguments.CollectionFrequencyInWeeks)>
			AND	CollectionFrequencyInWeeks = <cfqueryparam value="#arguments.CollectionFrequencyInWeeks#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"FundingSource") and len(arguments.FundingSource)>
			AND	FundingSource = <cfqueryparam value="#arguments.FundingSource#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"ProviderOrgID") and len(arguments.ProviderOrgID)>
			AND	ProviderOrgID = <cfqueryparam value="#arguments.ProviderOrgID#" CFSQLType="cf_sql_integer" />
		</cfif>
		<cfif structKeyExists(arguments,"DataStorageLocation") and len(arguments.DataStorageLocation)>
			AND	DataStorageLocation = <cfqueryparam value="#arguments.DataStorageLocation#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"URL") and len(arguments.URL)>
			AND	URL = <cfqueryparam value="#arguments.URL#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"DataLimitations") and len(arguments.DataLimitations)>
			AND	DataLimitations = <cfqueryparam value="#arguments.DataLimitations#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments,"DataLimitationMitigation") and len(arguments.DataLimitationMitigation)>
			AND	DataLimitationMitigation = <cfqueryparam value="#arguments.DataLimitationMitigation#" CFSQLType="cf_sql_varchar" />
		</cfif>
		<cfif structKeyExists(arguments, "orderby") and len(arguments.orderBy)>
			ORDER BY #arguments.orderby#
		</cfif>
		</cfquery>
		
		<cfreturn qList />
	</cffunction>

	<cffunction name="getByAttributes" access="public" output="false" returntype="array">
		<cfargument name="sourceID" type="numeric" required="false" />
		<cfargument name="IndicatorID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="CollectionMethod" type="string" required="false" />
		<cfargument name="CollectionFrequencyInWeeks" type="string" required="false" />
		<cfargument name="FundingSource" type="string" required="false" />
		<cfargument name="ProviderOrgID" type="numeric" required="false" />
		<cfargument name="DataStorageLocation" type="string" required="false" />
		<cfargument name="URL" type="string" required="false" />
		<cfargument name="DataLimitations" type="string" required="false" />
		<cfargument name="DataLimitationMitigation" type="string" required="false" />
		<cfargument name="orderby" type="string" required="false" />
		
		<cfset var qList = getByAttributesQuery(argumentCollection=arguments) />		
		<cfset var arrObjects = arrayNew(1) />
		<cfset var tmpObj = "" />
		<cfset var i = 0 />
		<cfloop from="1" to="#qList.recordCount#" index="i">
			<cfset tmpObj = createObject("component","IndicatorDatasource").init(argumentCollection=queryRowToStruct(qList,i)) />
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

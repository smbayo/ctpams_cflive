
<cfcomponent name="IndicatorDatasourceService" output="false">
	<cfproperty name="IndicatorDatasourceGateway" inject="model" scope="instance" />
	<cfproperty name="IndicatorDatasoureDAO" inject="model" scope="instance" />
	<cfproperty name="IndicatorDatasource" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="IndicatorDatasourceService">
		<cfreturn this/>
	</cffunction>
	<cffunction name="new" access="public" output="false" returntype="IndicatorDatasource">
		<cfreturn instance.indicatorDatasource.init() />
	</cffunction>

	<cffunction name="createIndicatorDatasource" access="public" output="false" returntype="IndicatorDatasource">
		<cfargument name="sourceID" type="numeric" required="true" />
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
		
			
		<cfset var IndicatorDatasource = createObject("component","IndicatorDatasource").init(argumentCollection=arguments) />
		<cfreturn IndicatorDatasource />
	</cffunction>

	<cffunction name="getIndicatorDatasource" access="public" output="false" returntype="IndicatorDatasource">
		<cfargument name="sourceID" type="numeric" required="true" />
		
		<cfset var IndicatorDatasource = createIndicatorDatasource(argumentCollection=arguments) />
		<cfset variables.IndicatorDatasourceDAO.read(IndicatorDatasource) />
		<cfreturn IndicatorDatasource />
	</cffunction>

	<cffunction name="getIndicatorDatasources" access="public" output="false" returntype="array">
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
		
		<cfreturn variables.IndicatorDatasourceGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveIndicatorDatasource" access="public" output="false" returntype="boolean">
		<cfargument name="IndicatorDatasource" type="IndicatorDatasource" required="true" />

		<cfreturn variables.IndicatorDatasourceDAO.save(IndicatorDatasource) />
	</cffunction>

	<cffunction name="deleteIndicatorDatasource" access="public" output="false" returntype="boolean">
		<cfargument name="sourceID" type="numeric" required="true" />
		
		<cfset var IndicatorDatasource = createIndicatorDatasource(argumentCollection=arguments) />
		<cfreturn variables.IndicatorDatasourceDAO.delete(IndicatorDatasource) />
	</cffunction>
</cfcomponent>

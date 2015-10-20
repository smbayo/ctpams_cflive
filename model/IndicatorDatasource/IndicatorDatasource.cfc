
<cfcomponent displayname="IndicatorDatasource" output="false">
		<cfproperty name="sourceID" type="numeric" default="" />
		<cfproperty name="IndicatorID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="CollectionMethod" type="string" default="" />
		<cfproperty name="CollectionFrequencyInWeeks" type="string" default="" />
		<cfproperty name="FundingSource" type="string" default="" />
		<cfproperty name="ProviderOrgID" type="numeric" default="" />
		<cfproperty name="DataStorageLocation" type="string" default="" />
		<cfproperty name="URL" type="string" default="" />
		<cfproperty name="DataLimitations" type="string" default="" />
		<cfproperty name="DataLimitationMitigation" type="string" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="IndicatorDatasource" output="false">
		<cfargument name="sourceID" type="string" required="false" default="" />
		<cfargument name="IndicatorID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="CollectionMethod" type="string" required="false" default="" />
		<cfargument name="CollectionFrequencyInWeeks" type="string" required="false" default="" />
		<cfargument name="FundingSource" type="string" required="false" default="" />
		<cfargument name="ProviderOrgID" type="string" required="false" default="" />
		<cfargument name="DataStorageLocation" type="string" required="false" default="" />
		<cfargument name="URL" type="string" required="false" default="" />
		<cfargument name="DataLimitations" type="string" required="false" default="" />
		<cfargument name="DataLimitationMitigation" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setsourceID(arguments.sourceID) />
		<cfset setIndicatorID(arguments.IndicatorID) />
		<cfset setName(arguments.Name) />
		<cfset setCollectionMethod(arguments.CollectionMethod) />
		<cfset setCollectionFrequencyInWeeks(arguments.CollectionFrequencyInWeeks) />
		<cfset setFundingSource(arguments.FundingSource) />
		<cfset setProviderOrgID(arguments.ProviderOrgID) />
		<cfset setDataStorageLocation(arguments.DataStorageLocation) />
		<cfset setURL(arguments.URL) />
		<cfset setDataLimitations(arguments.DataLimitations) />
		<cfset setDataLimitationMitigation(arguments.DataLimitationMitigation) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="IndicatorDatasource" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validate" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		
		<!--- sourceID --->
		<cfif (len(trim(getsourceID())) AND NOT isNumeric(trim(getsourceID())))>
			<cfset thisError.field = "sourceID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "sourceID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IndicatorID --->
		<cfif (NOT len(trim(getIndicatorID())))>
			<cfset thisError.field = "IndicatorID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "IndicatorID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getIndicatorID())) AND NOT isNumeric(trim(getIndicatorID())))>
			<cfset thisError.field = "IndicatorID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IndicatorID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Name --->
		<cfif (len(trim(getName())) AND NOT IsSimpleValue(trim(getName())))>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Name is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) GT 255)>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Name is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- CollectionMethod --->
		<cfif (len(trim(getCollectionMethod())) AND NOT IsSimpleValue(trim(getCollectionMethod())))>
			<cfset thisError.field = "CollectionMethod" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CollectionMethod is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCollectionMethod())) GT 255)>
			<cfset thisError.field = "CollectionMethod" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "CollectionMethod is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- CollectionFrequencyInWeeks --->
		<cfif (len(trim(getCollectionFrequencyInWeeks())) AND NOT IsSimpleValue(trim(getCollectionFrequencyInWeeks())))>
			<cfset thisError.field = "CollectionFrequencyInWeeks" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CollectionFrequencyInWeeks is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCollectionFrequencyInWeeks())) GT 255)>
			<cfset thisError.field = "CollectionFrequencyInWeeks" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "CollectionFrequencyInWeeks is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- FundingSource --->
		<cfif (len(trim(getFundingSource())) AND NOT IsSimpleValue(trim(getFundingSource())))>
			<cfset thisError.field = "FundingSource" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "FundingSource is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getFundingSource())) GT 255)>
			<cfset thisError.field = "FundingSource" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "FundingSource is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ProviderOrgID --->
		<cfif (len(trim(getProviderOrgID())) AND NOT isNumeric(trim(getProviderOrgID())))>
			<cfset thisError.field = "ProviderOrgID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ProviderOrgID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- DataStorageLocation --->
		<cfif (len(trim(getDataStorageLocation())) AND NOT IsSimpleValue(trim(getDataStorageLocation())))>
			<cfset thisError.field = "DataStorageLocation" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DataStorageLocation is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDataStorageLocation())) GT 255)>
			<cfset thisError.field = "DataStorageLocation" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "DataStorageLocation is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- URL --->
		<cfif (len(trim(getURL())) AND NOT IsSimpleValue(trim(getURL())))>
			<cfset thisError.field = "URL" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "URL is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getURL())) GT 255)>
			<cfset thisError.field = "URL" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "URL is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- DataLimitations --->
		<cfif (len(trim(getDataLimitations())) AND NOT IsSimpleValue(trim(getDataLimitations())))>
			<cfset thisError.field = "DataLimitations" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DataLimitations is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDataLimitations())) GT 1000)>
			<cfset thisError.field = "DataLimitations" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "DataLimitations is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- DataLimitationMitigation --->
		<cfif (len(trim(getDataLimitationMitigation())) AND NOT IsSimpleValue(trim(getDataLimitationMitigation())))>
			<cfset thisError.field = "DataLimitationMitigation" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DataLimitationMitigation is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDataLimitationMitigation())) GT 255)>
			<cfset thisError.field = "DataLimitationMitigation" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "DataLimitationMitigation is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setsourceID" access="public" returntype="void" output="false">
		<cfargument name="sourceID" type="string" required="true" />
		<cfset variables.instance.sourceID = arguments.sourceID />
	</cffunction>
	<cffunction name="getsourceID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sourceID />
	</cffunction>

	<cffunction name="setIndicatorID" access="public" returntype="void" output="false">
		<cfargument name="IndicatorID" type="string" required="true" />
		<cfset variables.instance.IndicatorID = arguments.IndicatorID />
	</cffunction>
	<cffunction name="getIndicatorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IndicatorID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setCollectionMethod" access="public" returntype="void" output="false">
		<cfargument name="CollectionMethod" type="string" required="true" />
		<cfset variables.instance.CollectionMethod = arguments.CollectionMethod />
	</cffunction>
	<cffunction name="getCollectionMethod" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CollectionMethod />
	</cffunction>

	<cffunction name="setCollectionFrequencyInWeeks" access="public" returntype="void" output="false">
		<cfargument name="CollectionFrequencyInWeeks" type="string" required="true" />
		<cfset variables.instance.CollectionFrequencyInWeeks = arguments.CollectionFrequencyInWeeks />
	</cffunction>
	<cffunction name="getCollectionFrequencyInWeeks" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CollectionFrequencyInWeeks />
	</cffunction>

	<cffunction name="setFundingSource" access="public" returntype="void" output="false">
		<cfargument name="FundingSource" type="string" required="true" />
		<cfset variables.instance.FundingSource = arguments.FundingSource />
	</cffunction>
	<cffunction name="getFundingSource" access="public" returntype="string" output="false">
		<cfreturn variables.instance.FundingSource />
	</cffunction>

	<cffunction name="setProviderOrgID" access="public" returntype="void" output="false">
		<cfargument name="ProviderOrgID" type="string" required="true" />
		<cfset variables.instance.ProviderOrgID = arguments.ProviderOrgID />
	</cffunction>
	<cffunction name="getProviderOrgID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ProviderOrgID />
	</cffunction>

	<cffunction name="setDataStorageLocation" access="public" returntype="void" output="false">
		<cfargument name="DataStorageLocation" type="string" required="true" />
		<cfset variables.instance.DataStorageLocation = arguments.DataStorageLocation />
	</cffunction>
	<cffunction name="getDataStorageLocation" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DataStorageLocation />
	</cffunction>

	<cffunction name="setURL" access="public" returntype="void" output="false">
		<cfargument name="URL" type="string" required="true" />
		<cfset variables.instance.URL = arguments.URL />
	</cffunction>
	<cffunction name="getURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.URL />
	</cffunction>

	<cffunction name="setDataLimitations" access="public" returntype="void" output="false">
		<cfargument name="DataLimitations" type="string" required="true" />
		<cfset variables.instance.DataLimitations = arguments.DataLimitations />
	</cffunction>
	<cffunction name="getDataLimitations" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DataLimitations />
	</cffunction>

	<cffunction name="setDataLimitationMitigation" access="public" returntype="void" output="false">
		<cfargument name="DataLimitationMitigation" type="string" required="true" />
		<cfset variables.instance.DataLimitationMitigation = arguments.DataLimitationMitigation />
	</cffunction>
	<cffunction name="getDataLimitationMitigation" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DataLimitationMitigation />
	</cffunction>


	<!---
	DUMP
	--->
	<cffunction name="dump" access="public" output="true" return="void">
		<cfargument name="abort" type="boolean" default="false" />
		<cfdump var="#variables.instance#" />
		<cfif arguments.abort>
			<cfabort />
		</cfif>
	</cffunction>

</cfcomponent>

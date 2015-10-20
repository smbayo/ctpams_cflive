
<cfcomponent displayname="ActivityIndicator" output="false">
		<cfproperty name="ActivityIndicatorID" type="numeric" default="" />
		<cfproperty name="ActivityID" type="numeric" default="" />
		<cfproperty name="IndicatorID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ActivityIndicator" output="false">
		<cfargument name="ActivityIndicatorID" type="string" required="false" default="" />
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="IndicatorID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setActivityIndicatorID(arguments.ActivityIndicatorID) />
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setIndicatorID(arguments.IndicatorID) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ActivityIndicator" output="false">
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
		
		<!--- ActivityIndicatorID --->
		<cfif (NOT len(trim(getActivityIndicatorID())))>
			<cfset thisError.field = "ActivityIndicatorID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ActivityIndicatorID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getActivityIndicatorID())) AND NOT isNumeric(trim(getActivityIndicatorID())))>
			<cfset thisError.field = "ActivityIndicatorID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityIndicatorID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ActivityID --->
		<cfif (len(trim(getActivityID())) AND NOT isNumeric(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- IndicatorID --->
		<cfif (len(trim(getIndicatorID())) AND NOT isNumeric(trim(getIndicatorID())))>
			<cfset thisError.field = "IndicatorID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "IndicatorID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setActivityIndicatorID" access="public" returntype="void" output="false">
		<cfargument name="ActivityIndicatorID" type="string" required="true" />
		<cfset variables.instance.ActivityIndicatorID = arguments.ActivityIndicatorID />
	</cffunction>
	<cffunction name="getActivityIndicatorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityIndicatorID />
	</cffunction>

	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>

	<cffunction name="setIndicatorID" access="public" returntype="void" output="false">
		<cfargument name="IndicatorID" type="string" required="true" />
		<cfset variables.instance.IndicatorID = arguments.IndicatorID />
	</cffunction>
	<cffunction name="getIndicatorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.IndicatorID />
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


<cfcomponent displayname="activityResultsFrameworkElement" output="false">
		<cfproperty name="activityResultID" type="numeric" default="" />
		<cfproperty name="activityID" type="numeric" default="" />
		<cfproperty name="resultsFrameworkElementID" type="numeric" default="" />
		<cfproperty name="isPrimary" type="boolean" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="activityResultsFrameworkElement" output="false">
		<cfargument name="activityResultID" type="string" required="false" default="" />
		<cfargument name="activityID" type="string" required="false" default="" />
		<cfargument name="resultsFrameworkElementID" type="string" required="false" default="" />
		<cfargument name="isPrimary" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setactivityResultID(arguments.activityResultID) />
		<cfset setactivityID(arguments.activityID) />
		<cfset setresultsFrameworkElementID(arguments.resultsFrameworkElementID) />
		<cfset setisPrimary(arguments.isPrimary) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="activityResultsFrameworkElement" output="false">
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
		
		<!--- activityResultID --->
		<cfif (len(trim(getactivityResultID())) AND NOT isNumeric(trim(getactivityResultID())))>
			<cfset thisError.field = "activityResultID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "activityResultID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- activityID --->
		<cfif (len(trim(getactivityID())) AND NOT isNumeric(trim(getactivityID())))>
			<cfset thisError.field = "activityID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "activityID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- resultsFrameworkElementID --->
		<cfif (len(trim(getresultsFrameworkElementID())) AND NOT isNumeric(trim(getresultsFrameworkElementID())))>
			<cfset thisError.field = "resultsFrameworkElementID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "resultsFrameworkElementID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- isPrimary --->
		<cfif (len(trim(getisPrimary())) AND NOT isBoolean(trim(getisPrimary())))>
			<cfset thisError.field = "isPrimary" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "isPrimary is not boolean" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setactivityResultID" access="public" returntype="void" output="false">
		<cfargument name="activityResultID" type="string" required="true" />
		<cfset variables.instance.activityResultID = arguments.activityResultID />
	</cffunction>
	<cffunction name="getactivityResultID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.activityResultID />
	</cffunction>

	<cffunction name="setactivityID" access="public" returntype="void" output="false">
		<cfargument name="activityID" type="string" required="true" />
		<cfset variables.instance.activityID = arguments.activityID />
	</cffunction>
	<cffunction name="getactivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.activityID />
	</cffunction>

	<cffunction name="setresultsFrameworkElementID" access="public" returntype="void" output="false">
		<cfargument name="resultsFrameworkElementID" type="string" required="true" />
		<cfset variables.instance.resultsFrameworkElementID = arguments.resultsFrameworkElementID />
	</cffunction>
	<cffunction name="getresultsFrameworkElementID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.resultsFrameworkElementID />
	</cffunction>

	<cffunction name="setisPrimary" access="public" returntype="void" output="false">
		<cfargument name="isPrimary" type="string" required="true" />
		<cfset variables.instance.isPrimary = arguments.isPrimary />
	</cffunction>
	<cffunction name="getisPrimary" access="public" returntype="string" output="false">
		<cfreturn variables.instance.isPrimary />
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

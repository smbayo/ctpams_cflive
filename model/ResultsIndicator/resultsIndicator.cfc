
<cfcomponent displayname="resultsIndicator" output="false">
		<cfproperty name="indicatorResultID" type="numeric" default="" />
		<cfproperty name="indicatorID" type="numeric" default="" />
		<cfproperty name="resultsFrameworkElementID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="resultsIndicator" output="false">
		<cfargument name="indicatorResultID" type="string" required="false" default="" />
		<cfargument name="indicatorID" type="string" required="false" default="" />
		<cfargument name="resultsFrameworkElementID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setindicatorResultID(arguments.indicatorResultID) />
		<cfset setindicatorID(arguments.indicatorID) />
		<cfset setresultsFrameworkElementID(arguments.resultsFrameworkElementID) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="model.resultsIndicator" output="false">
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
		
		<!--- indicatorResultID --->
		<cfif (len(trim(getindicatorResultID())) AND NOT isNumeric(trim(getindicatorResultID())))>
			<cfset thisError.field = "indicatorResultID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "indicatorResultID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- indicatorID --->
		<cfif (len(trim(getindicatorID())) AND NOT isNumeric(trim(getindicatorID())))>
			<cfset thisError.field = "indicatorID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "indicatorID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- resultsFrameworkElementID --->
		<cfif (len(trim(getresultsFrameworkElementID())) AND NOT isNumeric(trim(getresultsFrameworkElementID())))>
			<cfset thisError.field = "resultsFrameworkElementID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "resultsFrameworkElementID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setindicatorResultID" access="public" returntype="void" output="false">
		<cfargument name="indicatorResultID" type="string" required="true" />
		<cfset variables.instance.indicatorResultID = arguments.indicatorResultID />
	</cffunction>
	<cffunction name="getindicatorResultID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.indicatorResultID />
	</cffunction>

	<cffunction name="setindicatorID" access="public" returntype="void" output="false">
		<cfargument name="indicatorID" type="string" required="true" />
		<cfset variables.instance.indicatorID = arguments.indicatorID />
	</cffunction>
	<cffunction name="getindicatorID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.indicatorID />
	</cffunction>

	<cffunction name="setresultsFrameworkElementID" access="public" returntype="void" output="false">
		<cfargument name="resultsFrameworkElementID" type="string" required="true" />
		<cfset variables.instance.resultsFrameworkElementID = arguments.resultsFrameworkElementID />
	</cffunction>
	<cffunction name="getresultsFrameworkElementID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.resultsFrameworkElementID />
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

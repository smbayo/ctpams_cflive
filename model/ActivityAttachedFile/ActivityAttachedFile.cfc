
<cfcomponent displayname="ActivityAttachedFile" output="false">
		<cfproperty name="ActivityID" type="numeric" default="" />
		<cfproperty name="AttachedFileID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ActivityAttachedFile" output="false">
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="AttachedFileID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setAttachedFileID(arguments.AttachedFileID) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ActivityAttachedFile" output="false">
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
		
		<!--- ActivityID --->
		<cfif (NOT len(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ActivityID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getActivityID())) AND NOT isNumeric(trim(getActivityID())))>
			<cfset thisError.field = "ActivityID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- AttachedFileID --->
		<cfif (NOT len(trim(getAttachedFileID())))>
			<cfset thisError.field = "AttachedFileID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "AttachedFileID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAttachedFileID())) AND NOT isNumeric(trim(getAttachedFileID())))>
			<cfset thisError.field = "AttachedFileID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "AttachedFileID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>

	<cffunction name="setAttachedFileID" access="public" returntype="void" output="false">
		<cfargument name="AttachedFileID" type="string" required="true" />
		<cfset variables.instance.AttachedFileID = arguments.AttachedFileID />
	</cffunction>
	<cffunction name="getAttachedFileID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AttachedFileID />
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

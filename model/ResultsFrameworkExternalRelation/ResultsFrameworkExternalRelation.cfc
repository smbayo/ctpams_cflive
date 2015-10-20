
<cfcomponent displayname="ResultsFrameworkExternalRelation" output="false">
		<cfproperty name="ParentResultsFrameworkElementID" type="numeric" default="" />
		<cfproperty name="ChildResultsFrameworkElementID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ResultsFrameworkExternalRelation" output="false">
		<cfargument name="ParentResultsFrameworkElementID" type="string" required="false" default="" />
		<cfargument name="ChildResultsFrameworkElementID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setParentResultsFrameworkElementID(arguments.ParentResultsFrameworkElementID) />
		<cfset setChildResultsFrameworkElementID(arguments.ChildResultsFrameworkElementID) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ResultsFrameworkExternalRelation" output="false">
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
		
		<!--- ParentResultsFrameworkElementID --->
		<cfif (NOT len(trim(getParentResultsFrameworkElementID())))>
			<cfset thisError.field = "ParentResultsFrameworkElementID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ParentResultsFrameworkElementID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getParentResultsFrameworkElementID())) AND NOT isNumeric(trim(getParentResultsFrameworkElementID())))>
			<cfset thisError.field = "ParentResultsFrameworkElementID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ParentResultsFrameworkElementID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ChildResultsFrameworkElementID --->
		<cfif (NOT len(trim(getChildResultsFrameworkElementID())))>
			<cfset thisError.field = "ChildResultsFrameworkElementID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ChildResultsFrameworkElementID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getChildResultsFrameworkElementID())) AND NOT isNumeric(trim(getChildResultsFrameworkElementID())))>
			<cfset thisError.field = "ChildResultsFrameworkElementID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ChildResultsFrameworkElementID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setParentResultsFrameworkElementID" access="public" returntype="void" output="false">
		<cfargument name="ParentResultsFrameworkElementID" type="string" required="true" />
		<cfset variables.instance.ParentResultsFrameworkElementID = arguments.ParentResultsFrameworkElementID />
	</cffunction>
	<cffunction name="getParentResultsFrameworkElementID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentResultsFrameworkElementID />
	</cffunction>

	<cffunction name="setChildResultsFrameworkElementID" access="public" returntype="void" output="false">
		<cfargument name="ChildResultsFrameworkElementID" type="string" required="true" />
		<cfset variables.instance.ChildResultsFrameworkElementID = arguments.ChildResultsFrameworkElementID />
	</cffunction>
	<cffunction name="getChildResultsFrameworkElementID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ChildResultsFrameworkElementID />
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

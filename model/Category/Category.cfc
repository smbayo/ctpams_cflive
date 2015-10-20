
<cfcomponent displayname="Category" output="false">
		<cfproperty name="CategoryID" type="numeric" default="" />
		<cfproperty name="ParentID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="Description" type="string" default="" />
		<cfproperty name="ExternalCode" type="string" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Category" output="false">
		<cfargument name="CategoryID" type="string" required="false" default="" />
		<cfargument name="ParentID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="ExternalCode" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setCategoryID(arguments.CategoryID) />
		<cfset setParentID(arguments.ParentID) />
		<cfset setName(arguments.Name) />
		<cfset setDescription(arguments.Description) />
		<cfset setExternalCode(arguments.ExternalCode) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Category" output="false">
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
		
		<!--- CategoryID --->
		<cfif (NOT len(trim(getCategoryID())))>
			<cfset thisError.field = "CategoryID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "CategoryID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCategoryID())) AND NOT isNumeric(trim(getCategoryID())))>
			<cfset thisError.field = "CategoryID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CategoryID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ParentID --->
		<cfif (len(trim(getParentID())) AND NOT isNumeric(trim(getParentID())))>
			<cfset thisError.field = "ParentID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ParentID is not numeric" />
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
		
		<!--- Description --->
		<cfif (len(trim(getDescription())) AND NOT IsSimpleValue(trim(getDescription())))>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Description is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDescription())) GT 255)>
			<cfset thisError.field = "Description" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Description is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ExternalCode --->
		<cfif (len(trim(getExternalCode())) AND NOT IsSimpleValue(trim(getExternalCode())))>
			<cfset thisError.field = "ExternalCode" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ExternalCode is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getExternalCode())) GT 255)>
			<cfset thisError.field = "ExternalCode" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ExternalCode is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setCategoryID" access="public" returntype="void" output="false">
		<cfargument name="CategoryID" type="string" required="true" />
		<cfset variables.instance.CategoryID = arguments.CategoryID />
	</cffunction>
	<cffunction name="getCategoryID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CategoryID />
	</cffunction>

	<cffunction name="setParentID" access="public" returntype="void" output="false">
		<cfargument name="ParentID" type="string" required="true" />
		<cfset variables.instance.ParentID = arguments.ParentID />
	</cffunction>
	<cffunction name="getParentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setDescription" access="public" returntype="void" output="false">
		<cfargument name="Description" type="string" required="true" />
		<cfset variables.instance.Description = arguments.Description />
	</cffunction>
	<cffunction name="getDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Description />
	</cffunction>

	<cffunction name="setExternalCode" access="public" returntype="void" output="false">
		<cfargument name="ExternalCode" type="string" required="true" />
		<cfset variables.instance.ExternalCode = arguments.ExternalCode />
	</cffunction>
	<cffunction name="getExternalCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ExternalCode />
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

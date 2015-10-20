
<cfcomponent displayname="ObjectCategory" output="false">
		<cfproperty name="ClassName" type="string" default="" />
		<cfproperty name="ObjectID" type="numeric" default="" />
		<cfproperty name="CategoryID" type="numeric" default="" />
		<cfproperty name="isPrimary" type="boolean" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ObjectCategory" output="false">
		<cfargument name="ClassName" type="string" required="false" default="" />
		<cfargument name="ObjectID" type="string" required="false" default="" />
		<cfargument name="CategoryID" type="string" required="false" default="" />
		<cfargument name="isPrimary" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setClassName(arguments.ClassName) />
		<cfset setObjectID(arguments.ObjectID) />
		<cfset setCategoryID(arguments.CategoryID) />
		<cfset setisPrimary(arguments.isPrimary) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ObjectCategory" output="false">
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
		
		<!--- ClassName --->
		<cfif (NOT len(trim(getClassName())))>
			<cfset thisError.field = "ClassName" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ClassName is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getClassName())) AND NOT IsSimpleValue(trim(getClassName())))>
			<cfset thisError.field = "ClassName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ClassName is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getClassName())) GT 25)>
			<cfset thisError.field = "ClassName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ClassName is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ObjectID --->
		<cfif (NOT len(trim(getObjectID())))>
			<cfset thisError.field = "ObjectID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ObjectID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getObjectID())) AND NOT isNumeric(trim(getObjectID())))>
			<cfset thisError.field = "ObjectID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ObjectID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
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
	<cffunction name="setClassName" access="public" returntype="void" output="false">
		<cfargument name="ClassName" type="string" required="true" />
		<cfset variables.instance.ClassName = arguments.ClassName />
	</cffunction>
	<cffunction name="getClassName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ClassName />
	</cffunction>

	<cffunction name="setObjectID" access="public" returntype="void" output="false">
		<cfargument name="ObjectID" type="string" required="true" />
		<cfset variables.instance.ObjectID = arguments.ObjectID />
	</cffunction>
	<cffunction name="getObjectID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ObjectID />
	</cffunction>

	<cffunction name="setCategoryID" access="public" returntype="void" output="false">
		<cfargument name="CategoryID" type="string" required="true" />
		<cfset variables.instance.CategoryID = arguments.CategoryID />
	</cffunction>
	<cffunction name="getCategoryID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CategoryID />
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

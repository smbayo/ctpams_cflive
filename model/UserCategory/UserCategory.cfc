
<cfcomponent displayname="UserCategory" output="false">
		<cfproperty name="SysUserID" type="numeric" default="" />
		<cfproperty name="CategoryID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="usercategory" output="false">
		<cfargument name="SysUserID" type="string" required="false" default="" />
		<cfargument name="CategoryID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setSysUserID(arguments.SysUserID) />
		<cfset setCategoryID(arguments.CategoryID) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="userCategory" output="false">
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
		
		<!--- SysUserID --->
		<cfif (NOT len(trim(getSysUserID())))>
			<cfset thisError.field = "SysUserID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "SysUserID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getSysUserID())) AND NOT isNumeric(trim(getSysUserID())))>
			<cfset thisError.field = "SysUserID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "SysUserID is not numeric" />
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
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setSysUserID" access="public" returntype="void" output="false">
		<cfargument name="SysUserID" type="string" required="true" />
		<cfset variables.instance.SysUserID = arguments.SysUserID />
	</cffunction>
	<cffunction name="getSysUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SysUserID />
	</cffunction>

	<cffunction name="setCategoryID" access="public" returntype="void" output="false">
		<cfargument name="CategoryID" type="string" required="true" />
		<cfset variables.instance.CategoryID = arguments.CategoryID />
	</cffunction>
	<cffunction name="getCategoryID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CategoryID />
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

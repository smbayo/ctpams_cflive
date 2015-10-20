
<cfcomponent displayname="RolePermission" output="false">
		<cfproperty name="SysRoleID" type="numeric" default="" />
		<cfproperty name="SysPermissionID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="RolePermission" output="false">
		<cfargument name="SysRoleID" type="string" required="false" default="" />
		<cfargument name="SysPermissionID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setSysRoleID(arguments.SysRoleID) />
		<cfset setSysPermissionID(arguments.SysPermissionID) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="RolePermission" output="false">
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
		
		<!--- SysRoleID --->
		<cfif (NOT len(trim(getSysRoleID())))>
			<cfset thisError.field = "SysRoleID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "SysRoleID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getSysRoleID())) AND NOT isNumeric(trim(getSysRoleID())))>
			<cfset thisError.field = "SysRoleID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "SysRoleID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- SysPermissionID --->
		<cfif (NOT len(trim(getSysPermissionID())))>
			<cfset thisError.field = "SysPermissionID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "SysPermissionID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getSysPermissionID())) AND NOT isNumeric(trim(getSysPermissionID())))>
			<cfset thisError.field = "SysPermissionID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "SysPermissionID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setSysRoleID" access="public" returntype="void" output="false">
		<cfargument name="SysRoleID" type="string" required="true" />
		<cfset variables.instance.SysRoleID = arguments.SysRoleID />
	</cffunction>
	<cffunction name="getSysRoleID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SysRoleID />
	</cffunction>

	<cffunction name="setSysPermissionID" access="public" returntype="void" output="false">
		<cfargument name="SysPermissionID" type="string" required="true" />
		<cfset variables.instance.SysPermissionID = arguments.SysPermissionID />
	</cffunction>
	<cffunction name="getSysPermissionID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.SysPermissionID />
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

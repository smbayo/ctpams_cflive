<!---
Admin Handler for User, Role and Permission Events
DEPENDSON: view_usersroles.sql; viewUserRolePermission.sql

ALSO: no script for this but following design changes required:

Table: SysUser
     SysUserId is now PK with Identity Specification=YES increment=1
 
Table: SysRole
     SysRoleID is now PK with Identity Specification=YES increment=1
	ADDED authName nchar(10)
 
Table: SysPermission
     SysPermissionID is now PK with Identity Specification=YES increment=1
 
Table: SysUserRole
     SysUserID and SysRoleID  PK REMOVED
 
Table: SysRolePermission
     SysRoleID and SysPermissionID  PK REMOVED
 
created by steve metzger 04/06/11 
--->



<cfcomponent name="Help" extends="coldbox.system.EventHandler" autowire="true">

	<!--- Inject Dependencies --->


	<!--- ************************************************************* --->
	<cffunction name="onRequestStart" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<!---
		Security Check
		You need to check for the doLogin method, beacuse, if not, the doLogin method
		will never get a chance to be called.
		So check if the session.loggedin flag exists or not true, and if we
		are not logging in.
		--->
		
		<cfscript>
			var rc = Event.getCollection();

			//Set xeh's
			rc.xehLogout = "General.doLogout";
			rc.xehHome = "General.Home";
		</cfscript>
	</cffunction>
	<!--- ************************************************************* --->
	
	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="Help Page">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		
		<cfset rc.PageTitle = "Help Page">
		<!---<cfset rc.qGrants = instance.ActivityService.getLastUpdated(toplimit=5)>--->
		
		<cfset event.setView("help/index")>
	</cffunction>
	




<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>

	
</cfcomponent>
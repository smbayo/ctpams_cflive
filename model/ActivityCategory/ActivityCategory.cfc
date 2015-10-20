
<cfcomponent displayname="ActivityCategory" output="false">
		<cfproperty name="ActivityCategoryID" type="numeric" default="" />
		<cfproperty name="activityid" type="numeric" default="" />
		<cfproperty name="categoryid" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ActivityCategory" output="false">
		<cfargument name="ActivityCategoryID" type="string" required="false" default="" />
		<cfargument name="activityid" type="string" required="false" default="" />
		<cfargument name="categoryid" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setActivityCategoryID(arguments.ActivityCategoryID) />
		<cfset setactivityid(arguments.activityid) />
		<cfset setcategoryid(arguments.categoryid) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ActivityCategory" output="false">
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
		
		<!--- ActivityCategoryID --->
		<cfif (len(trim(getActivityCategoryID())) AND NOT isNumeric(trim(getActivityCategoryID())))>
			<cfset thisError.field = "ActivityCategoryID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityCategoryID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- activityid --->
		<cfif (NOT len(trim(getactivityid())))>
			<cfset thisError.field = "activityid" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "activityid is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getactivityid())) AND NOT isNumeric(trim(getactivityid())))>
			<cfset thisError.field = "activityid" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "activityid is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- categoryid --->
		<cfif (NOT len(trim(getcategoryid())))>
			<cfset thisError.field = "categoryid" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "categoryid is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getcategoryid())) AND NOT isNumeric(trim(getcategoryid())))>
			<cfset thisError.field = "categoryid" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "categoryid is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setActivityCategoryID" access="public" returntype="void" output="false">
		<cfargument name="ActivityCategoryID" type="string" required="true" />
		<cfset variables.instance.ActivityCategoryID = arguments.ActivityCategoryID />
	</cffunction>
	<cffunction name="getActivityCategoryID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityCategoryID />
	</cffunction>

	<cffunction name="setactivityid" access="public" returntype="void" output="false">
		<cfargument name="activityid" type="string" required="true" />
		<cfset variables.instance.activityid = arguments.activityid />
	</cffunction>
	<cffunction name="getactivityid" access="public" returntype="string" output="false">
		<cfreturn variables.instance.activityid />
	</cffunction>

	<cffunction name="setcategoryid" access="public" returntype="void" output="false">
		<cfargument name="categoryid" type="string" required="true" />
		<cfset variables.instance.categoryid = arguments.categoryid />
	</cffunction>
	<cffunction name="getcategoryid" access="public" returntype="string" output="false">
		<cfreturn variables.instance.categoryid />
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

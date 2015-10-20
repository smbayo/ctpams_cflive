<cfcomponent displayname="CNClearance" output="false">
		<cfproperty name="CNClearanceID" type="numeric" default="" />
		<cfproperty name="CNID" type="numeric" default="" />
		<cfproperty name="CNStatusID" type="numeric" default="" />
		<cfproperty name="ClearanceStatus" type="string" default="" />
		<cfproperty name="ClearanceAgencyName" type="string" default="" />
		<cfproperty name="Comments" type="string" default="" />
		<cfproperty name="cstatusDate" type="date" default="" />
		<cfproperty name="ClearanceType" type="string" default="" />
		<cfproperty name="sysUserID" type="numeric" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="CNClearance" output="false">
		<cfargument name="CNClearanceID" type="string" required="false" default="" />
		<cfargument name="CNID" type="string" required="false" default="" />
		<cfargument name="CNStatusID" type="string" required="false" default="" />
		<cfargument name="ClearanceStatus" type="string" required="false" default="" />
		<cfargument name="ClearanceAgencyName" type="string" required="false" default="" />
		<cfargument name="Comments" type="string" required="false" default="" />
		<cfargument name="cstatusDate" type="string" required="false" default="" />
		<cfargument name="ClearanceType" type="string" required="false" default="" />
		<cfargument name="sysUserID" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setCNClearanceID(arguments.CNClearanceID) />
		<cfset setCNID(arguments.CNID) />
		<cfset setCNStatusID(arguments.CNStatusID) />
		<cfset setClearanceStatus(arguments.ClearanceStatus) />
		<cfset setClearanceAgencyName(arguments.ClearanceAgencyName) />
		<cfset setComments(arguments.Comments) />
		<cfset setcstatusDate(arguments.cstatusDate) />
		<cfset setClearanceType(arguments.ClearanceType) />
		<cfset setsysUserID(arguments.sysUserID) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="CNClearance" output="false">
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
		
		<!--- CNClearanceID --->
		<cfif (len(trim(getCNClearanceID())) AND NOT isNumeric(trim(getCNClearanceID())))>
			<cfset thisError.field = "CNClearanceID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CNClearanceID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- CNID --->
		<cfif (NOT len(trim(getCNID())))>
			<cfset thisError.field = "CNID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "CNID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCNID())) AND NOT isNumeric(trim(getCNID())))>
			<cfset thisError.field = "CNID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CNID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- CNStatusID --->
		<cfif (len(trim(getCNStatusID())) AND NOT isNumeric(trim(getCNStatusID())))>
			<cfset thisError.field = "CNStatusID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CNStatusID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ClearanceStatus --->
		<cfif (len(trim(getClearanceStatus())) AND NOT IsSimpleValue(trim(getClearanceStatus())))>
			<cfset thisError.field = "ClearanceStatus" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ClearanceStatus is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getClearanceStatus())) GT 255)>
			<cfset thisError.field = "ClearanceStatus" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ClearanceStatus is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ClearanceAgencyName --->
		<cfif (len(trim(getClearanceAgencyName())) AND NOT IsSimpleValue(trim(getClearanceAgencyName())))>
			<cfset thisError.field = "ClearanceAgencyName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ClearanceAgencyName is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getClearanceAgencyName())) GT 255)>
			<cfset thisError.field = "ClearanceAgencyName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ClearanceAgencyName is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Comments --->
		<cfif (len(trim(getComments())) AND NOT IsSimpleValue(trim(getComments())))>
			<cfset thisError.field = "Comments" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Comments is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getComments())) GT 255)>
			<cfset thisError.field = "Comments" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Comments is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- cstatusDate --->
		<cfif (len(trim(getcstatusDate())) AND NOT isDate(trim(getcstatusDate())))>
			<cfset thisError.field = "cstatusDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "cstatusDate is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- ClearanceType --->
		<cfif (len(trim(getClearanceType())) AND NOT IsSimpleValue(trim(getClearanceType())))>
			<cfset thisError.field = "ClearanceType" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ClearanceType is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getClearanceType())) GT 50)>
			<cfset thisError.field = "ClearanceType" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ClearanceType is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>		
		
		<!--- sysUserID --->
		<cfif (len(trim(getsysUserID())) AND NOT isNumeric(trim(getsysUserID())))>
			<cfset thisError.field = "sysUserID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "sysUserID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setCNClearanceID" access="public" returntype="void" output="false">
		<cfargument name="CNClearanceID" type="string" required="true" />
		<cfset variables.instance.CNClearanceID = arguments.CNClearanceID />
	</cffunction>
	<cffunction name="getCNClearanceID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CNClearanceID />
	</cffunction>

	<cffunction name="setCNID" access="public" returntype="void" output="false">
		<cfargument name="CNID" type="string" required="true" />
		<cfset variables.instance.CNID = arguments.CNID />
	</cffunction>
	<cffunction name="getCNID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CNID />
	</cffunction>

	<cffunction name="setCNStatusID" access="public" returntype="void" output="false">
		<cfargument name="CNStatusID" type="string" required="true" />
		<cfset variables.instance.CNStatusID = arguments.CNStatusID />
	</cffunction>
	<cffunction name="getCNStatusID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CNStatusID />
	</cffunction>

	<cffunction name="setClearanceStatus" access="public" returntype="void" output="false">
		<cfargument name="ClearanceStatus" type="string" required="true" />
		<cfset variables.instance.ClearanceStatus = arguments.ClearanceStatus />
	</cffunction>
	<cffunction name="getClearanceStatus" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ClearanceStatus />
	</cffunction>

	<cffunction name="setClearanceAgencyName" access="public" returntype="void" output="false">
		<cfargument name="ClearanceAgencyName" type="string" required="true" />
		<cfset variables.instance.ClearanceAgencyName = arguments.ClearanceAgencyName />
	</cffunction>
	<cffunction name="getClearanceAgencyName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ClearanceAgencyName />
	</cffunction>

	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="Comments" type="string" required="true" />
		<cfset variables.instance.Comments = arguments.Comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Comments />
	</cffunction>

	<cffunction name="setcstatusDate" access="public" returntype="void" output="false">
		<cfargument name="cstatusDate" type="string" required="true" />
		<cfset variables.instance.cstatusDate = arguments.cstatusDate />
	</cffunction>
	<cffunction name="getcstatusDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.cstatusDate />
	</cffunction>

	<cffunction name="setClearanceType" access="public" returntype="void" output="false">
		<cfargument name="ClearanceType" type="string" required="true" />
		<cfset variables.instance.ClearanceType = arguments.ClearanceType />
	</cffunction>
	<cffunction name="getClearanceType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ClearanceType />
	</cffunction>

	<cffunction name="setsysUserID" access="public" returntype="void" output="false">
		<cfargument name="sysUserID" type="string" required="true" />
		<cfset variables.instance.sysUserID = arguments.sysUserID />
	</cffunction>
	<cffunction name="getsysUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sysUserID />
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

<cfcomponent displayname="ActivityObligation" output="false">
		<cfproperty name="ActivityObligateID" type="numeric" default="" />
		<cfproperty name="ActivityID" type="numeric" default="" />
		<cfproperty name="Amount" type="numeric" default="" />
		<cfproperty name="obligationDate" type="date" default="" />
		<cfproperty name="ObligationFYyearSource" type="string" default="" />
		<cfproperty name="Comments" type="string" default="" />
		<cfproperty name="isActive" type="boolean" default="" />
		<cfproperty name="sysUserID" type="numeric" default="" />
		<cfproperty name="ObligationNumber" type="string" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ActivityObligation" output="false">
		<cfargument name="ActivityObligateID" type="string" required="false" default="" />
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="Amount" type="string" required="false" default="" />
		<cfargument name="obligationDate" type="string" required="false" default="" />
		<cfargument name="ObligationFYyearSource" type="string" required="false" default="" />
		<cfargument name="Comments" type="string" required="false" default="" />
		<cfargument name="isActive" type="string" required="false" default="" />
		<cfargument name="sysUserID" type="string" required="false" default="" />
		<cfargument name="ObligationNumber" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setActivityObligateID(arguments.ActivityObligateID) />
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setAmount(arguments.Amount) />
		<cfset setobligationDate(arguments.obligationDate) />
		<cfset setObligationFYyearSource(arguments.ObligationFYyearSource) />
		<cfset setComments(arguments.Comments) />
		<cfset setisActive(arguments.isActive) />
		<cfset setsysUserID(arguments.sysUserID) />
		<cfset setObligationNumber(arguments.ObligationNumber) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ActivityObligation" output="false">
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
		
		<!--- ActivityObligateID --->
		<cfif (len(trim(getActivityObligateID())) AND NOT isNumeric(trim(getActivityObligateID())))>
			<cfset thisError.field = "ActivityObligateID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityObligateID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
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
		
		<!--- Amount --->
		<cfset setAmount( REReplace(getAmount(),",","","all") ) />
		<cfif (len(trim(getAmount())) AND NOT isNumeric(trim(getAmount())))>
			<cfset thisError.field = "Amount" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Amount is not valid" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- obligationDate --->
		<cfif (len(trim(getobligationDate())) AND NOT isDate(trim(getobligationDate())))>
			<cfset thisError.field = "obligationDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "obligationDate is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>	
		
		<!--- ObligationFYyearSource --->
		<cfif (len(trim(getObligationFYyearSource())) AND NOT IsSimpleValue(trim(getObligationFYyearSource())))>
			<cfset thisError.field = "ObligationFYyearSource" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ObligationFYyearSource is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getObligationFYyearSource())) GT 255)>
			<cfset thisError.field = "ObligationFYyearSource" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ObligationFYyearSource is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Comments --->
		<cfif (len(trim(getComments())) AND NOT IsSimpleValue(trim(getComments())))>
			<cfset thisError.field = "Comments" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Comments is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getComments())) GT 1000)>
			<cfset thisError.field = "Comments" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Comments is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- isActive --->
		<cfif (len(trim(getisActive())) AND NOT isBoolean(trim(getisActive())))>
			<cfset thisError.field = "isActive" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "isActive is not boolean" />
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
	<cffunction name="setActivityObligateID" access="public" returntype="void" output="false">
		<cfargument name="ActivityObligateID" type="string" required="true" />
		<cfset variables.instance.ActivityObligateID = arguments.ActivityObligateID />
	</cffunction>
	<cffunction name="getActivityObligateID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityObligateID />
	</cffunction>

	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>

	<cffunction name="setAmount" access="public" returntype="void" output="false">
		<cfargument name="Amount" type="string" required="true" />
		<cfset variables.instance.Amount = arguments.Amount />
	</cffunction>
	<cffunction name="getAmount" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Amount />
	</cffunction>

	<cffunction name="setobligationDate" access="public" returntype="void" output="false">
		<cfargument name="obligationDate" type="string" required="true" />
		<cfset variables.instance.obligationDate = arguments.obligationDate />
	</cffunction>
	<cffunction name="getobligationDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.obligationDate />
	</cffunction>

	<cffunction name="setObligationFYyearSource" access="public" returntype="void" output="false">
		<cfargument name="ObligationFYyearSource" type="string" required="true" />
		<cfset variables.instance.ObligationFYyearSource = arguments.ObligationFYyearSource />
	</cffunction>
	<cffunction name="getObligationFYyearSource" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ObligationFYyearSource />
	</cffunction>

	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="Comments" type="string" required="true" />
		<cfset variables.instance.Comments = arguments.Comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Comments />
	</cffunction>

	<cffunction name="setisActive" access="public" returntype="void" output="false">
		<cfargument name="isActive" type="string" required="true" />
		<cfset variables.instance.isActive = arguments.isActive />
	</cffunction>
	<cffunction name="getisActive" access="public" returntype="string" output="false">
		<cfreturn variables.instance.isActive />
	</cffunction>

	<cffunction name="setsysUserID" access="public" returntype="void" output="false">
		<cfargument name="sysUserID" type="string" required="true" />
		<cfset variables.instance.sysUserID = arguments.sysUserID />
	</cffunction>
	<cffunction name="getsysUserID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.sysUserID />
	</cffunction>

	<cffunction name="setObligationNumber" access="public" returntype="void" output="false">
		<cfargument name="ObligationNumber" type="string" required="true" />
		<cfset variables.instance.ObligationNumber = arguments.ObligationNumber />
	</cffunction>
	<cffunction name="getObligationNumber" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ObligationNumber />
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

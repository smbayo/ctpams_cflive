<cfcomponent displayname="ActivityLegalRecommendation" output="false">
		<cfproperty name="ActivityRecommID" type="numeric" default="" />
		<cfproperty name="ActivityID" type="numeric" default="" />
		<cfproperty name="CNID" type="numeric" default="" />
		<cfproperty name="ActivityStatusID" type="numeric" default="" />
		<cfproperty name="Sender" type="string" default="" />
		<cfproperty name="Comments" type="string" default="" />
		<cfproperty name="commentType" type="string" default="" />
		<cfproperty name="commentDate" type="date" default="" />
		<cfproperty name="isActive" type="boolean" default="" />
		<cfproperty name="sysUserID" type="numeric" default="" />

	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ActivityLegalRecommendation" output="false">
		<cfargument name="ActivityRecommID" type="string" required="false" default="" />
		<cfargument name="ActivityID" type="string" required="false" default="" />
		<cfargument name="CNID" type="string" required="false" default="" />
		<cfargument name="ActivityStatusID" type="string" required="false" default="" />
		<cfargument name="Sender" type="string" required="false" default="" />
		<cfargument name="Comments" type="string" required="false" default="" />
		<cfargument name="commentType" type="string" required="false" default="" />
		<cfargument name="commentDate" type="string" required="false" default="" />
		<cfargument name="isActive" type="string" required="false" default="" />
		<cfargument name="sysUserID" type="string" required="false" default="" />

		<!--- run setters --->
		<cfset setActivityRecommID(arguments.ActivityRecommID) />
		<cfset setActivityID(arguments.ActivityID) />
		<cfset setCNID(arguments.CNID) />
		<cfset setActivityStatusID(arguments.ActivityStatusID) />
		<cfset setSender(arguments.Sender) />
		<cfset setComments(arguments.Comments) />
		<cfset setcommentType(arguments.commentType) />
		<cfset setcommentDate(arguments.commentDate) />
		<cfset setisActive(arguments.isActive) />
		<cfset setsysUserID(arguments.sysUserID) />

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ActivityLegalRecommendation" output="false">
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

		<!--- ActivityRecommID --->
		<cfif (len(trim(getActivityRecommID())) AND NOT isNumeric(trim(getActivityRecommID())))>
			<cfset thisError.field = "ActivityRecommID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityRecommID is not numeric" />
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

		<!--- ActivityStatusID --->
		<cfif (len(trim(getActivityStatusID())) AND NOT isNumeric(trim(getActivityStatusID())))>
			<cfset thisError.field = "ActivityStatusID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ActivityStatusID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- Sender --->
		<cfif (len(trim(getSender())) AND NOT IsSimpleValue(trim(getSender())))>
			<cfset thisError.field = "Sender" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Sender is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getSender())) GT 50)>
			<cfset thisError.field = "Sender" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Sender is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- Comments --->
		<cfif (len(trim(getComments())) AND NOT IsSimpleValue(trim(getComments())))>
			<cfset thisError.field = "Comments" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Comments is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getComments())) GT 2000)>
			<cfset thisError.field = "Comments" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Comments is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<!--- commentDate --->
		<cfif (len(trim(getcommentDate())) AND NOT isDate(trim(getcommentDate())))>
			<cfset thisError.field = "commentDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "commentDate is not a date" />
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
	<cffunction name="setActivityRecommID" access="public" returntype="void" output="false">
		<cfargument name="ActivityRecommID" type="string" required="true" />
		<cfset variables.instance.ActivityRecommID = arguments.ActivityRecommID />
	</cffunction>
	<cffunction name="getActivityRecommID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityRecommID />
	</cffunction>

	<cffunction name="setActivityID" access="public" returntype="void" output="false">
		<cfargument name="ActivityID" type="string" required="true" />
		<cfset variables.instance.ActivityID = arguments.ActivityID />
	</cffunction>
	<cffunction name="getActivityID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityID />
	</cffunction>


	<cffunction name="setCNID" access="public" returntype="void" output="false">
		<cfargument name="CNID" type="string" required="true" />
		<cfset variables.instance.CNID = arguments.CNID />
	</cffunction>
	<cffunction name="getCNID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CNID />
	</cffunction>

	<cffunction name="setActivityStatusID" access="public" returntype="void" output="false">
		<cfargument name="ActivityStatusID" type="string" required="true" />
		<cfset variables.instance.ActivityStatusID = arguments.ActivityStatusID />
	</cffunction>
	<cffunction name="getActivityStatusID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ActivityStatusID />
	</cffunction>

	<cffunction name="setSender" access="public" returntype="void" output="false">
		<cfargument name="Sender" type="string" required="true" />
		<cfset variables.instance.Sender = arguments.Sender />
	</cffunction>
	<cffunction name="getSender" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Sender />
	</cffunction>

	<cffunction name="setComments" access="public" returntype="void" output="false">
		<cfargument name="Comments" type="string" required="true" />
		<cfset variables.instance.Comments = arguments.Comments />
	</cffunction>
	<cffunction name="getComments" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Comments />
	</cffunction>

	<cffunction name="setcommentType" access="public" returntype="void" output="false">
		<cfargument name="commentType" type="string" required="true" />
		<cfset variables.instance.commentType = arguments.commentType />
	</cffunction>
	<cffunction name="getcommentType" access="public" returntype="string" output="false">
		<cfreturn variables.instance.commentType />
	</cffunction>

	<cffunction name="setcommentDate" access="public" returntype="void" output="false">
		<cfargument name="commentDate" type="string" required="true" />
		<cfset variables.instance.commentDate = arguments.commentDate />
	</cffunction>
	<cffunction name="getcommentDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.commentDate />
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

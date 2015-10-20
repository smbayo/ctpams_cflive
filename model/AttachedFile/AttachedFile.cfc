
<cfcomponent displayname="AttachedFile" output="false">
		<cfproperty name="AttachedFileID" type="numeric" default="" />
		<cfproperty name="objectTableName" type="string" default="" />
		<cfproperty name="objectTableID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="LongDescription" type="string" default="" />
		<cfproperty name="AttachedFileName" type="string" default="" />
		<cfproperty name="UploadedFileName" type="string" default="" />
		<cfproperty name="AttachedFileDate" type="date" default="" />
		<cfproperty name="isArchived" type="boolean" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="AttachedFile" output="false">
		<cfargument name="AttachedFileID" type="string" required="false" default="" />
		<cfargument name="objectTableName" type="string" required="false" default="" />
		<cfargument name="objectTableID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="LongDescription" type="string" required="false" default="" />
		<cfargument name="AttachedFileName" type="string" required="false" default="" />
		<cfargument name="UploadedFileName" type="string" required="false" default="" />
		<cfargument name="AttachedFileDate" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setAttachedFileID(arguments.AttachedFileID) />
		<cfset setobjectTableName(arguments.objectTableName) />
		<cfset setobjectTableID(arguments.objectTableID) />
		<cfset setName(arguments.Name) />
		<cfset setLongDescription(arguments.LongDescription) />
		<cfset setAttachedFileName(arguments.AttachedFileName) />
		<cfset setUploadedFileName(arguments.UploadedFileName) />
		<cfset setAttachedFileDate(arguments.AttachedFileDate) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="AttachedFile" output="false">
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
		
		<!--- AttachedFileID --->
		<cfif (NOT len(trim(getAttachedFileID())))>
			<cfset thisError.field = "AttachedFileID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "AttachedFileID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAttachedFileID())) AND NOT isNumeric(trim(getAttachedFileID())))>
			<cfset thisError.field = "AttachedFileID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "AttachedFileID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<!---objectTableName --->
		<cfif (len(trim(getobjectTableName())) AND NOT IsSimpleValue(trim(getobjectTableName())))>
			<cfset thisError.field = "objectTableName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "objectTableName is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getobjectTableName())) GT 12)>
			<cfset thisError.field = "objectTableName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "objectTableName is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<!---objectTableName --->
		<cfif (NOT len(trim(getobjectTableID())))>
			<cfset thisError.field = "objectTableID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "objectTableID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getobjectTableID())) AND NOT isNumeric(trim(getobjectTableID())))>
			<cfset thisError.field = "objectTableID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "objectTableID is not numeric" />
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
		
		<!--- LongDescription --->
		<cfif (len(trim(getLongDescription())) AND NOT IsSimpleValue(trim(getLongDescription())))>
			<cfset thisError.field = "LongDescription" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "LongDescription is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getLongDescription())) GT 1073741823)>
			<cfset thisError.field = "LongDescription" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "LongDescription is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- AttachedFileName --->
		<cfif (len(trim(getAttachedFileName())) AND NOT IsSimpleValue(trim(getAttachedFileName())))>
			<cfset thisError.field = "AttachedFileName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "AttachedFileName is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAttachedFileName())) GT 250)>
			<cfset thisError.field = "AttachedFileName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "AttachedFileName is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- UploadedFileName --->
		<cfif (len(trim(getUploadedFileName())) AND NOT IsSimpleValue(trim(getUploadedFileName())))>
			<cfset thisError.field = "UploadedFileName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "UploadedFileName is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getUploadedFileName())) GT 250)>
			<cfset thisError.field = "UploadedFileName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "UploadedFileName is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>		
		
		<!--- AttachedFileDate --->
		<cfif (len(trim(getAttachedFileDate())) AND NOT isDate(trim(getAttachedFileDate())))>
			<cfset thisError.field = "AttachedFileDate" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "AttachedFileDate is not a date" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setAttachedFileID" access="public" returntype="void" output="false">
		<cfargument name="AttachedFileID" type="string" required="true" />
		<cfset variables.instance.AttachedFileID = arguments.AttachedFileID />
	</cffunction>
	<cffunction name="getAttachedFileID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AttachedFileID />
	</cffunction>
	
	<cffunction name="setisArchived" access="public" returntype="void" output="false">
		<cfargument name="isArchived" type="string" required="true" />
		<cfset variables.instance.isArchived = arguments.isArchived />
	</cffunction>
	<cffunction name="getisArchived" access="public" returntype="string" output="false">
		<cfreturn variables.instance.isArchived />
	</cffunction>
	
	<cffunction name="setobjectTableName" access="public" returntype="void" output="false">
		<cfargument name="objectTableName" type="string" required="true" />
		<cfset variables.instance.objectTableName = arguments.objectTableName />
	</cffunction>
	<cffunction name="getobjectTableName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.objectTableName />
	</cffunction>
	<cffunction name="setobjectTableID" access="public" returntype="void" output="false">
		<cfargument name="objectTableID" type="string" required="true" />
		<cfset variables.instance.objectTableID = arguments.objectTableID />
	</cffunction>
	<cffunction name="getobjectTableID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.objectTableID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setLongDescription" access="public" returntype="void" output="false">
		<cfargument name="LongDescription" type="string" required="true" />
		<cfset variables.instance.LongDescription = arguments.LongDescription />
	</cffunction>
	<cffunction name="getLongDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LongDescription />
	</cffunction>

	<cffunction name="setAttachedFileName" access="public" returntype="void" output="false">
		<cfargument name="AttachedFileName" type="string" required="true" />
		<cfset variables.instance.AttachedFileName = arguments.AttachedFileName />
	</cffunction>
	<cffunction name="getAttachedFileName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AttachedFileName />
	</cffunction>

	<cffunction name="setUploadedFileName" access="public" returntype="void" output="false">
		<cfargument name="UploadedFileName" type="string" required="true" />
		<cfset variables.instance.UploadedFileName = arguments.UploadedFileName />
	</cffunction>
	<cffunction name="getUploadedFileName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.UploadedFileName />
	</cffunction>
	
	<cffunction name="setAttachedFileDate" access="public" returntype="void" output="false">
		<cfargument name="AttachedFileDate" type="string" required="true" />
		<cfset variables.instance.AttachedFileDate = arguments.AttachedFileDate />
	</cffunction>
	<cffunction name="getAttachedFileDate" access="public" returntype="string" output="false">
		<cfreturn variables.instance.AttachedFileDate />
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

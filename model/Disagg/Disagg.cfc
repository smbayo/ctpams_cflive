
<cfcomponent displayname="Disagg" output="false">
		<cfproperty name="DisaggID" type="numeric" default="" />
		<cfproperty name="DisaggSetID" type="numeric" default="" />
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
	<cffunction name="init" access="public" returntype="Disagg" output="false">
		<cfargument name="DisaggID" type="string" required="false" default="" />
		<cfargument name="DisaggSetID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="ExternalCode" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setDisaggID(arguments.DisaggID) />
		<cfset setDisaggSetID(arguments.DisaggSetID) />
		<cfset setName(arguments.Name) />
		<cfset setDescription(arguments.Description) />
		<cfset setExternalCode(arguments.ExternalCode) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Disagg" output="false">
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
		
		<!--- DisaggID --->
		<cfif (NOT len(trim(getDisaggID())))>
			<cfset thisError.field = "DisaggID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "DisaggID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDisaggID())) AND NOT isNumeric(trim(getDisaggID())))>
			<cfset thisError.field = "DisaggID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DisaggID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- DisaggSetID --->
		<cfif (len(trim(getDisaggSetID())) AND NOT isNumeric(trim(getDisaggSetID())))>
			<cfset thisError.field = "DisaggSetID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DisaggSetID is not numeric" />
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
	<cffunction name="setDisaggID" access="public" returntype="void" output="false">
		<cfargument name="DisaggID" type="string" required="true" />
		<cfset variables.instance.DisaggID = arguments.DisaggID />
	</cffunction>
	<cffunction name="getDisaggID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DisaggID />
	</cffunction>

	<cffunction name="setDisaggSetID" access="public" returntype="void" output="false">
		<cfargument name="DisaggSetID" type="string" required="true" />
		<cfset variables.instance.DisaggSetID = arguments.DisaggSetID />
	</cffunction>
	<cffunction name="getDisaggSetID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DisaggSetID />
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


<cfcomponent displayname="ResultsFrameworkElement" output="false">
		<cfproperty name="ResultsFrameworkElementID" type="numeric" default="" />
		<cfproperty name="ParentID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="Description" type="string" default="" />
		<cfproperty name="DisplayNumber" type="string" default="" />
		<cfproperty name="Abbreviation" type="string" default="" />
		<cfproperty name="LevelDescription" type="string" default="" />
		<cfproperty name="ExternalCode" type="string" default="" />
		<cfproperty name="ExternalCodeDescription" type="string" default="" />
		<cfproperty name="programID" type="numeric" default="" />	
     
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="ResultsFrameworkElement" output="false">
		<cfargument name="ResultsFrameworkElementID" type="string" required="false" default="" />
		<cfargument name="ParentID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="DisplayNumber" type="string" required="false" default="" />
		<cfargument name="Abbreviation" type="string" required="false" default="" />
		<cfargument name="LevelDescription" type="string" required="false" default="" />
		<cfargument name="ExternalCode" type="string" required="false" default="" />
		<cfargument name="ExternalCodeDescription" type="string" required="false" default="" />
		<cfargument name="programID" type="string"  required="false" default=""  />
		
		<!--- run setters --->
		<cfset setResultsFrameworkElementID(arguments.ResultsFrameworkElementID) />
		<cfset setParentID(arguments.ParentID) />
		<cfset setName(arguments.Name) />
		<cfset setDescription(arguments.Description) />
		<cfset setDisplayNumber(arguments.DisplayNumber) />
		<cfset setAbbreviation(arguments.Abbreviation) />
		<cfset setLevelDescription(arguments.LevelDescription) />
		<cfset setExternalCode(arguments.ExternalCode) />
		<cfset setExternalCodeDescription(arguments.ExternalCodeDescription) />
		<cfset setProgramID(arguments.programID) />
      

		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="ResultsFrameworkElement" output="false">
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
		
		<!--- ResultsFrameworkElementID --->
		<cfif (NOT len(trim(getResultsFrameworkElementID())))>
			<cfset thisError.field = "ResultsFrameworkElementID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "ResultsFrameworkElementID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getResultsFrameworkElementID())) AND NOT isNumeric(trim(getResultsFrameworkElementID())))>
			<cfset thisError.field = "ResultsFrameworkElementID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ResultsFrameworkElementID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- ParentID --->
		<cfif (len(trim(getParentID())) AND NOT isNumeric(trim(getParentID())))>
			<cfset thisError.field = "ParentID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ParentID is not numeric" />
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
		
		<!--- DisplayNumber --->
		<cfif (len(trim(getDisplayNumber())) AND NOT IsSimpleValue(trim(getDisplayNumber())))>
			<cfset thisError.field = "DisplayNumber" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DisplayNumber is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDisplayNumber())) GT 255)>
			<cfset thisError.field = "DisplayNumber" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "DisplayNumber is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Abbreviation --->
		<cfif (len(trim(getAbbreviation())) AND NOT IsSimpleValue(trim(getAbbreviation())))>
			<cfset thisError.field = "Abbreviation" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Abbreviation is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAbbreviation())) GT 255)>
			<cfset thisError.field = "Abbreviation" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Abbreviation is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- LevelDescription --->
		<cfif (len(trim(getLevelDescription())) AND NOT IsSimpleValue(trim(getLevelDescription())))>
			<cfset thisError.field = "LevelDescription" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "LevelDescription is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getLevelDescription())) GT 255)>
			<cfset thisError.field = "LevelDescription" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "LevelDescription is too long" />
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
		
		<!--- ExternalCodeDescription --->
		<cfif (len(trim(getExternalCodeDescription())) AND NOT IsSimpleValue(trim(getExternalCodeDescription())))>
			<cfset thisError.field = "ExternalCodeDescription" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ExternalCodeDescription is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getExternalCodeDescription())) GT 255)>
			<cfset thisError.field = "ExternalCodeDescription" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "ExternalCodeDescription is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
			<!--- ProgramID--->
		<cfif (len(trim(getProgramID())) AND NOT isNumeric(trim(getProgramID())))>
			<cfset thisError.field = "ProgramID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ProgramID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>

		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setResultsFrameworkElementID" access="public" returntype="void" output="false">
		<cfargument name="ResultsFrameworkElementID" type="string" required="true" />
		<cfset variables.instance.ResultsFrameworkElementID = arguments.ResultsFrameworkElementID />
	</cffunction>
	<cffunction name="getResultsFrameworkElementID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ResultsFrameworkElementID />
	</cffunction>

	<cffunction name="setParentID" access="public" returntype="void" output="false">
		<cfargument name="ParentID" type="string" required="true" />
		<cfset variables.instance.ParentID = arguments.ParentID />
	</cffunction>
	<cffunction name="getParentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentID />
	</cffunction>
    
	<cffunction name="setProgramID" access="public" returntype="void" output="false">
		<cfargument name="ProgramID" type="string" required="true" />
		<cfset variables.instance.ProgramID = arguments.ProgramID />
	</cffunction>    
	<cffunction name="getProgramID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ProgramID />
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

	<cffunction name="setDisplayNumber" access="public" returntype="void" output="false">
		<cfargument name="DisplayNumber" type="string" required="true" />
		<cfset variables.instance.DisplayNumber = arguments.DisplayNumber />
	</cffunction>
	<cffunction name="getDisplayNumber" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DisplayNumber />
	</cffunction>

	<cffunction name="setAbbreviation" access="public" returntype="void" output="false">
		<cfargument name="Abbreviation" type="string" required="true" />
		<cfset variables.instance.Abbreviation = arguments.Abbreviation />
	</cffunction>
	<cffunction name="getAbbreviation" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Abbreviation />
	</cffunction>

	<cffunction name="setLevelDescription" access="public" returntype="void" output="false">
		<cfargument name="LevelDescription" type="string" required="true" />
		<cfset variables.instance.LevelDescription = arguments.LevelDescription />
	</cffunction>
	<cffunction name="getLevelDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LevelDescription />
	</cffunction>

	<cffunction name="setExternalCode" access="public" returntype="void" output="false">
		<cfargument name="ExternalCode" type="string" required="true" />
		<cfset variables.instance.ExternalCode = arguments.ExternalCode />
	</cffunction>
	<cffunction name="getExternalCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ExternalCode />
	</cffunction>

	<cffunction name="setExternalCodeDescription" access="public" returntype="void" output="false">
		<cfargument name="ExternalCodeDescription" type="string" required="true" />
		<cfset variables.instance.ExternalCodeDescription = arguments.ExternalCodeDescription />
	</cffunction>
	<cffunction name="getExternalCodeDescription" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ExternalCodeDescription />
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

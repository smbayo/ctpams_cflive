<cfcomponent displayname="Program" output="false">
		<cfproperty name="ProgramID" type="numeric" default="" />
		<cfproperty name="ParentID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="Description" type="string" default="" />
		<cfproperty name="Address1" type="string" default="" />
		<cfproperty name="Address2" type="string" default="" />
		<cfproperty name="City" type="string" default="" />
		<cfproperty name="PostalCode" type="numeric" default="" />
		<cfproperty name="CountryID" type="numeric" default="" />
		<cfproperty name="Telephone" type="numeric" default="" />
		        
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Program" output="false">
		<cfargument name="ProgramID" type="string" required="false" default="" />
		<cfargument name="ParentID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Description" type="string" required="false" default="" />
		<cfargument name="Address1" type="string" required="false" default="" />
		<cfargument name="Address2" type="string" required="false" default="" />
		<cfargument name="City" type="string" required="false" default="" />
		<cfargument name="PostalCode" type="string" required="false" default="" />
		<cfargument name="CountryID" type="string" required="false" default="" />
		<cfargument name="Telephone" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setProgramID(arguments.ProgramID) />
		<cfset setParentID(arguments.ParentID) />
		<cfset setName(arguments.Name) />
		<cfset setDescription(arguments.Description) />
		<cfset setAddress1(arguments.Address1) />
		<cfset setAddress2(arguments.Address2) />
		<cfset setCity(arguments.City) />
		<cfset setPostalCode(arguments.PostalCode) />
		<cfset setCountryID(arguments.CountryID) />
		<cfset setTelephone(arguments.Telephone) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Program" output="false">
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
		
		<!--- ProgramID --->
		<cfif (len(trim(getProgramID())) AND NOT isNumeric(trim(getProgramID())))>
			<cfset thisError.field = "ProgramID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "ProgramID is not numeric" />
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
		
		<!--- Address1 --->
		<cfif (len(trim(getAddress1())) AND NOT IsSimpleValue(trim(getAddress1())))>
			<cfset thisError.field = "Address1" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Address1 is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAddress1())) GT 100)>
			<cfset thisError.field = "Address1" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Address1 is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Address2 --->
		<cfif (len(trim(getAddress2())) AND NOT IsSimpleValue(trim(getAddress2())))>
			<cfset thisError.field = "Address2" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Address2 is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAddress2())) GT 100)>
			<cfset thisError.field = "Address2" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Address2 is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- City --->
		<cfif (len(trim(getCity())) AND NOT IsSimpleValue(trim(getCity())))>
			<cfset thisError.field = "City" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "City is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCity())) GT 100)>
			<cfset thisError.field = "City" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "City is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- PostalCode --->
		<cfif (len(trim(getPostalCode())) AND NOT isNumeric(trim(getPostalCode())))>
			<cfset thisError.field = "PostalCode" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "PostalCode is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- CountryID --->
		<cfif (len(trim(getCountryID())) AND NOT isNumeric(trim(getCountryID())))>
			<cfset thisError.field = "CountryID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "CountryID is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Telephone --->
		<cfif (len(trim(getTelephone())) AND NOT isNumeric(trim(getTelephone())))>
			<cfset thisError.field = "Telephone" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Telephone is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>


		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setProgramID" access="public" returntype="void" output="false">
		<cfargument name="ProgramID" type="string" required="true" />
		<cfset variables.instance.ProgramID = arguments.ProgramID />
	</cffunction>
	<cffunction name="getProgramID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ProgramID />
	</cffunction>

	<cffunction name="setParentID" access="public" returntype="void" output="false">
		<cfargument name="ParentID" type="string" required="true" />
		<cfset variables.instance.ParentID = arguments.ParentID />
	</cffunction>
	<cffunction name="getParentID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.ParentID />
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

	<cffunction name="setAddress1" access="public" returntype="void" output="false">
		<cfargument name="Address1" type="string" required="true" />
		<cfset variables.instance.Address1 = arguments.Address1 />
	</cffunction>
	<cffunction name="getAddress1" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Address1 />
	</cffunction>

	<cffunction name="setAddress2" access="public" returntype="void" output="false">
		<cfargument name="Address2" type="string" required="true" />
		<cfset variables.instance.Address2 = arguments.Address2 />
	</cffunction>
	<cffunction name="getAddress2" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Address2 />
	</cffunction>

	<cffunction name="setCity" access="public" returntype="void" output="false">
		<cfargument name="City" type="string" required="true" />
		<cfset variables.instance.City = arguments.City />
	</cffunction>
	<cffunction name="getCity" access="public" returntype="string" output="false">
		<cfreturn variables.instance.City />
	</cffunction>

	<cffunction name="setPostalCode" access="public" returntype="void" output="false">
		<cfargument name="PostalCode" type="string" required="true" />
		<cfset variables.instance.PostalCode = arguments.PostalCode />
	</cffunction>
	<cffunction name="getPostalCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PostalCode />
	</cffunction>

	<cffunction name="setCountryID" access="public" returntype="void" output="false">
		<cfargument name="CountryID" type="string" required="true" />
		<cfset variables.instance.CountryID = arguments.CountryID />
	</cffunction>
	<cffunction name="getCountryID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.CountryID />
	</cffunction>

	<cffunction name="setTelephone" access="public" returntype="void" output="false">
		<cfargument name="Telephone" type="string" required="true" />
		<cfset variables.instance.Telephone = arguments.Telephone />
	</cffunction>
	<cffunction name="getTelephone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Telephone />
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

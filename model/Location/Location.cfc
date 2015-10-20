
<cfcomponent displayname="Location" output="false">
		<cfproperty name="LocationID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="Longitude" type="numeric" default="" />
		<cfproperty name="Latitude" type="numeric" default="" />
		<cfproperty name="Address" type="string" default="" />
		<cfproperty name="Province" type="string" default="" />
		<cfproperty name="Country" type="string" default="" />
		<cfproperty name="PostalCode" type="string" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Location" output="false">
		<cfargument name="LocationID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Longitude" type="string" required="false" default="" />
		<cfargument name="Latitude" type="string" required="false" default="" />
		<cfargument name="Address" type="string" required="false" default="" />
		<cfargument name="Province" type="string" required="false" default="" />
		<cfargument name="Country" type="string" required="false" default="" />
		<cfargument name="PostalCode" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setLocationID(arguments.LocationID) />
		<cfset setName(arguments.Name) />
		<cfset setLongitude(arguments.Longitude) />
		<cfset setLatitude(arguments.Latitude) />
		<cfset setAddress(arguments.Address) />
		<cfset setProvince(arguments.Province) />
		<cfset setCountry(arguments.Country) />
		<cfset setPostalCode(arguments.PostalCode) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Location" output="false">
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
		
		<!--- LocationID --->
		<cfif (NOT len(trim(getLocationID())))>
			<cfset thisError.field = "LocationID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "LocationID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getLocationID())) AND NOT isNumeric(trim(getLocationID())))>
			<cfset thisError.field = "LocationID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "LocationID is not numeric" />
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
		
		<!--- Longitude --->
		<cfif (len(trim(getLongitude())) AND NOT isNumeric(trim(getLongitude())))>
			<cfset thisError.field = "Longitude" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Longitude is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Latitude --->
		<cfif (len(trim(getLatitude())) AND NOT isNumeric(trim(getLatitude())))>
			<cfset thisError.field = "Latitude" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Latitude is not numeric" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Address --->
		<cfif (len(trim(getAddress())) AND NOT IsSimpleValue(trim(getAddress())))>
			<cfset thisError.field = "Address" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Address is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAddress())) GT 255)>
			<cfset thisError.field = "Address" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Address is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Province --->
		<cfif (len(trim(getProvince())) AND NOT IsSimpleValue(trim(getProvince())))>
			<cfset thisError.field = "Province" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Province is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getProvince())) GT 255)>
			<cfset thisError.field = "Province" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Province is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Country --->
		<cfif (len(trim(getCountry())) AND NOT IsSimpleValue(trim(getCountry())))>
			<cfset thisError.field = "Country" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Country is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCountry())) GT 255)>
			<cfset thisError.field = "Country" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Country is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- PostalCode --->
		<cfif (len(trim(getPostalCode())) AND NOT IsSimpleValue(trim(getPostalCode())))>
			<cfset thisError.field = "PostalCode" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "PostalCode is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getPostalCode())) GT 255)>
			<cfset thisError.field = "PostalCode" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "PostalCode is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setLocationID" access="public" returntype="void" output="false">
		<cfargument name="LocationID" type="string" required="true" />
		<cfset variables.instance.LocationID = arguments.LocationID />
	</cffunction>
	<cffunction name="getLocationID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LocationID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setLongitude" access="public" returntype="void" output="false">
		<cfargument name="Longitude" type="string" required="true" />
		<cfset variables.instance.Longitude = arguments.Longitude />
	</cffunction>
	<cffunction name="getLongitude" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Longitude />
	</cffunction>

	<cffunction name="setLatitude" access="public" returntype="void" output="false">
		<cfargument name="Latitude" type="string" required="true" />
		<cfset variables.instance.Latitude = arguments.Latitude />
	</cffunction>
	<cffunction name="getLatitude" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Latitude />
	</cffunction>

	<cffunction name="setAddress" access="public" returntype="void" output="false">
		<cfargument name="Address" type="string" required="true" />
		<cfset variables.instance.Address = arguments.Address />
	</cffunction>
	<cffunction name="getAddress" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Address />
	</cffunction>

	<cffunction name="setProvince" access="public" returntype="void" output="false">
		<cfargument name="Province" type="string" required="true" />
		<cfset variables.instance.Province = arguments.Province />
	</cffunction>
	<cffunction name="getProvince" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Province />
	</cffunction>

	<cffunction name="setCountry" access="public" returntype="void" output="false">
		<cfargument name="Country" type="string" required="true" />
		<cfset variables.instance.Country = arguments.Country />
	</cffunction>
	<cffunction name="getCountry" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Country />
	</cffunction>

	<cffunction name="setPostalCode" access="public" returntype="void" output="false">
		<cfargument name="PostalCode" type="string" required="true" />
		<cfset variables.instance.PostalCode = arguments.PostalCode />
	</cffunction>
	<cffunction name="getPostalCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PostalCode />
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

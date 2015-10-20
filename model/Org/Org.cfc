
<cfcomponent displayname="Org" output="false">
		<cfproperty name="OrgID" type="numeric" default="" />
		<cfproperty name="Name" type="string" default="" />
		<cfproperty name="Abbreviation" type="string" default="" />
		<cfproperty name="Email" type="string" default="" />
		<cfproperty name="Phone" type="string" default="" />
		<cfproperty name="Fax" type="string" default="" />
		<cfproperty name="Address" type="string" default="" />
		<cfproperty name="City" type="string" default="" />
		<cfproperty name="Province" type="string" default="" />
		<cfproperty name="PostalCode" type="string" default="" />
		<cfproperty name="Country" type="string" default="" />
		<cfproperty name="URL" type="string" default="" />
		<cfproperty name="Notes" type="string" default="" />
		<cfproperty name="LegalRegistrationStatus" type="string" default="" />
		<cfproperty name="DUNSCode" type="string" default="" />
		<cfproperty name="implementingPartner" type="string" default="" />
		<cfproperty name="pocFirstname" type="string" default="" />
		<cfproperty name="pocLastName" type="string" default="" />
		<cfproperty name="pocEmail" type="string" default="" />
		<cfproperty name="pocPhone" type="string" default="" />
		
	<!---
	PROPERTIES
	--->
	<cfset variables.instance = StructNew() />

	<!---
	INITIALIZATION / CONFIGURATION
	--->
	<cffunction name="init" access="public" returntype="Org" output="false">
		<cfargument name="OrgID" type="string" required="false" default="" />
		<cfargument name="Name" type="string" required="false" default="" />
		<cfargument name="Abbreviation" type="string" required="false" default="" />
		<cfargument name="Email" type="string" required="false" default="" />
		<cfargument name="Phone" type="string" required="false" default="" />
		<cfargument name="Fax" type="string" required="false" default="" />
		<cfargument name="Address" type="string" required="false" default="" />
		<cfargument name="City" type="string" required="false" default="" />
		<cfargument name="Province" type="string" required="false" default="" />
		<cfargument name="PostalCode" type="string" required="false" default="" />
		<cfargument name="Country" type="string" required="false" default="" />
		<cfargument name="URL" type="string" required="false" default="" />
		<cfargument name="Notes" type="string" required="false" default="" />
		<cfargument name="LegalRegistrationStatus" type="string" required="false" default="" />
		<cfargument name="DUNSCode" type="string" required="false" default="" />
		<cfargument name="implementingPartner" type="string" required="false" default="" />
		<cfargument name="pocFirstname" type="string" required="false" default="" />
		<cfargument name="pocLastName" type="string" required="false" default="" />
		<cfargument name="pocEmail" type="string" required="false" default="" />
		<cfargument name="pocPhone" type="string" required="false" default="" />
		
		<!--- run setters --->
		<cfset setOrgID(arguments.OrgID) />
		<cfset setName(arguments.Name) />
		<cfset setAbbreviation(arguments.Abbreviation) />
		<cfset setEmail(arguments.Email) />
		<cfset setPhone(arguments.Phone) />
		<cfset setFax(arguments.Fax) />
		<cfset setAddress(arguments.Address) />
		<cfset setCity(arguments.City) />
		<cfset setProvince(arguments.Province) />
		<cfset setPostalCode(arguments.PostalCode) />
		<cfset setCountry(arguments.Country) />
		<cfset setURL(arguments.URL) />
		<cfset setNotes(arguments.Notes) />
		<cfset setLegalRegistrationStatus(arguments.LegalRegistrationStatus) />
		<cfset setDUNSCode(arguments.DUNSCode) />
		<cfset setimplementingPartner(arguments.implementingPartner) />
		<cfset setpocFirstname(arguments.pocFirstname) />
		<cfset setpocLastName(arguments.pocLastName) />
		<cfset setpocEmail(arguments.pocEmail) />
		<cfset setpocPhone(arguments.pocPhone) />
		
		<cfreturn this />
 	</cffunction>

	<!---
	PUBLIC FUNCTIONS
	--->
	<cffunction name="setMemento" access="public" returntype="Org" output="false">
		<cfargument name="memento" type="struct" required="yes"/>
		<cfset variables.instance = arguments.memento />
		<cfreturn this />
	</cffunction>
	<cffunction name="getMemento" access="public" returntype="struct" output="false" >
		<cfreturn variables.instance />
	</cffunction>

	<cffunction name="validateSubmit" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />

		<!--- Name --->
		<cfif NOT len(trim(getName()))>				
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project implementing organization is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>			
		<cfif (len(trim(getName())) AND NOT IsSimpleValue(trim(getName())))>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Implementer POC Name is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getName())) GT 255)>
			<cfset thisError.field = "Name" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Implementer POC Name is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- implementingPartner --->
<!--- 		<cfif NOT len(trim(getimplementingPartner()))>				
			<cfset thisError.field = "implementingPartner" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project implementing partner is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>		 --->	
		<cfif (len(trim(getimplementingPartner())) AND NOT IsSimpleValue(trim(getimplementingPartner())))>
			<cfset thisError.field = "implementingPartner" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Implementing partner is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getimplementingPartner())) GT 255)>
			<cfset thisError.field = "implementingPartner" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Implementing partner is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>	
		
		<!--- pocFirstname --->
		<cfif NOT len(trim(getpocFirstname()))>				
			<cfset thisError.field = "pocFirstname" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project Implementer POC first name is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>			
		<cfif (len(trim(getpocFirstname())) AND NOT IsSimpleValue(trim(getpocFirstname())))>
			<cfset thisError.field = "pocFirstname" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Implementer POC first name is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocFirstname())) GT 255)>
			<cfset thisError.field = "pocFirstname" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Implementer POC first name is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- pocLastName --->
		<cfif NOT len(trim(getpocLastName()))>				
			<cfset thisError.field = "pocLastName" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project Implementer POC last name is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>		
		<cfif (len(trim(getpocLastName())) AND NOT IsSimpleValue(trim(getpocLastName())))>
			<cfset thisError.field = "pocLastName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Implementer POC last name is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocLastName())) GT 255)>
			<cfset thisError.field = "pocLastName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Implementer POC last name is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- pocEmail --->
		<cfif NOT len(trim(getpocEmail()))>				
			<cfset thisError.field = "pocEmail" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project Implementer POC email is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>			
		<cfif (len(trim(getpocEmail())) AND NOT IsSimpleValue(trim(getpocEmail())))>
			<cfset thisError.field = "pocEmail" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Implementer POC email is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocEmail())) GT 255)>
			<cfset thisError.field = "pocEmail" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Implementer POC email is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif len(trim(getpocEmail()))>
			<cfif NOT REFindNocase("^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*\.(([a-z]{2,3})|(aero|coop|info|museum|name))$", getpocEmail())>
				<cfset thisError.field = "pocEmail" />
				<cfset thisError.type = "invalidEmail" />
				<cfset thisError.message = "Project Implementer POC email is invalid" />
				<cfset arrayAppend(errors,duplicate(thisError)) />			
			</cfif>
		</cfif>		
		
		<!--- pocPhone --->
		<cfif NOT len(trim(getpocPhone()))>				
			<cfset thisError.field = "pocPhone" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "Project Implementer POC phone is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>			
		<cfif (len(trim(getpocPhone())) AND NOT IsSimpleValue(trim(getpocPhone())))>
			<cfset thisError.field = "pocPhone" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Project Implementer POC phone is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocPhone())) GT 255)>
			<cfset thisError.field = "pocPhone" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Project Implementer POC phone is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>					
		
		<cfreturn errors />		
	</cffunction>	

	<cffunction name="validate" access="public" returntype="array" output="false">
		<cfset var errors = arrayNew(1) />
		<cfset var thisError = structNew() />
		
		<!--- OrgID --->
		<cfif (NOT len(trim(getOrgID())))>
			<cfset thisError.field = "OrgID" />
			<cfset thisError.type = "required" />
			<cfset thisError.message = "OrgID is required" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getOrgID())) AND NOT isNumeric(trim(getOrgID())))>
			<cfset thisError.field = "OrgID" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "OrgID is not numeric" />
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
		
		<!--- Abbreviation --->
		<cfif (len(trim(getAbbreviation())) AND NOT IsSimpleValue(trim(getAbbreviation())))>
			<cfset thisError.field = "Abbreviation" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Abbreviation is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getAbbreviation())) GT 50)>
			<cfset thisError.field = "Abbreviation" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Abbreviation is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Email --->
		<cfif (len(trim(getEmail())) AND NOT isValid("email", (trim(getPhone()))))>
			<cfset thisError.field = "Email" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Email address is not valid" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getEmail())) GT 255)>
			<cfset thisError.field = "Email" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Email is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Phone --->
		<cfif (len(trim(getPhone())) AND NOT IsSimpleValue(trim(getPhone())))>
			<cfset thisError.field = "Phone" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Phone is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getPhone())) GT 255)>
			<cfset thisError.field = "Phone" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Phone is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Fax --->
		<cfif (len(trim(getFax())) AND NOT IsSimpleValue(trim(getFax())))>
			<cfset thisError.field = "Fax" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Fax is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getFax())) GT 255)>
			<cfset thisError.field = "Fax" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Fax is too long" />
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
		
		<!--- City --->
		<cfif (len(trim(getCity())) AND NOT IsSimpleValue(trim(getCity())))>
			<cfset thisError.field = "City" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "City is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getCity())) GT 255)>
			<cfset thisError.field = "City" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "City is too long" />
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
		
		<!--- URL --->
		<cfif (len(trim(getURL())) AND NOT IsSimpleValue(trim(getURL())))>
			<cfset thisError.field = "URL" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "URL is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getURL())) GT 1073741823)>
			<cfset thisError.field = "URL" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "URL is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- Notes --->
		<cfif (len(trim(getNotes())) AND NOT IsSimpleValue(trim(getNotes())))>
			<cfset thisError.field = "Notes" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "Notes is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getNotes())) GT 1073741823)>
			<cfset thisError.field = "Notes" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "Notes is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- LegalRegistrationStatus --->
		<cfif (len(trim(getLegalRegistrationStatus())) AND NOT IsSimpleValue(trim(getLegalRegistrationStatus())))>
			<cfset thisError.field = "LegalRegistrationStatus" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "LegalRegistrationStatus is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getLegalRegistrationStatus())) GT 255)>
			<cfset thisError.field = "LegalRegistrationStatus" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "LegalRegistrationStatus is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- DUNSCode --->
		<cfif (len(trim(getDUNSCode())) AND NOT IsSimpleValue(trim(getDUNSCode())))>
			<cfset thisError.field = "DUNSCode" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "DUNSCode is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getDUNSCode())) GT 255)>
			<cfset thisError.field = "DUNSCode" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "DUNSCode is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- implementingPartner --->
		<cfif (len(trim(getimplementingPartner())) AND NOT IsSimpleValue(trim(getimplementingPartner())))>
			<cfset thisError.field = "implementingPartner" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "implementingPartner is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getimplementingPartner())) GT 255)>
			<cfset thisError.field = "implementingPartner" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "implementingPartner is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>	
		
		<!--- pocFirstname --->
		<cfif (len(trim(getpocFirstname())) AND NOT IsSimpleValue(trim(getpocFirstname())))>
			<cfset thisError.field = "pocFirstname" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "pocFirstname is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocFirstname())) GT 255)>
			<cfset thisError.field = "pocFirstname" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "pocFirstname is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- pocLastName --->
		<cfif (len(trim(getpocLastName())) AND NOT IsSimpleValue(trim(getpocLastName())))>
			<cfset thisError.field = "pocLastName" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "pocLastName is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocLastName())) GT 255)>
			<cfset thisError.field = "pocLastName" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "pocLastName is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- pocEmail --->
		<cfif (len(trim(getpocEmail())) AND NOT IsSimpleValue(trim(getpocEmail())))>
			<cfset thisError.field = "pocEmail" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "pocEmail is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocEmail())) GT 255)>
			<cfset thisError.field = "pocEmail" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "pocEmail is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		
		<!--- pocPhone --->
		<cfif (len(trim(getpocPhone())) AND NOT IsSimpleValue(trim(getpocPhone())))>
			<cfset thisError.field = "pocPhone" />
			<cfset thisError.type = "invalidType" />
			<cfset thisError.message = "pocPhone is not a string" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>
		<cfif (len(trim(getpocPhone())) GT 255)>
			<cfset thisError.field = "pocPhone" />
			<cfset thisError.type = "tooLong" />
			<cfset thisError.message = "pocPhone is too long" />
			<cfset arrayAppend(errors,duplicate(thisError)) />
		</cfif>	
		
		<cfreturn errors />
	</cffunction>

	<!---
	ACCESSORS
	--->
	<cffunction name="setOrgID" access="public" returntype="void" output="false">
		<cfargument name="OrgID" type="string" required="true" />
		<cfset variables.instance.OrgID = arguments.OrgID />
	</cffunction>
	<cffunction name="getOrgID" access="public" returntype="string" output="false">
		<cfreturn variables.instance.OrgID />
	</cffunction>

	<cffunction name="setName" access="public" returntype="void" output="false">
		<cfargument name="Name" type="string" required="true" />
		<cfset variables.instance.Name = arguments.Name />
	</cffunction>
	<cffunction name="getName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Name />
	</cffunction>

	<cffunction name="setAbbreviation" access="public" returntype="void" output="false">
		<cfargument name="Abbreviation" type="string" required="true" />
		<cfset variables.instance.Abbreviation = arguments.Abbreviation />
	</cffunction>
	<cffunction name="getAbbreviation" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Abbreviation />
	</cffunction>

	<cffunction name="setEmail" access="public" returntype="void" output="false">
		<cfargument name="Email" type="string" required="true" />
		<cfset variables.instance.Email = arguments.Email />
	</cffunction>
	<cffunction name="getEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Email />
	</cffunction>

	<cffunction name="setPhone" access="public" returntype="void" output="false">
		<cfargument name="Phone" type="string" required="true" />
		<cfset variables.instance.Phone = arguments.Phone />
	</cffunction>
	<cffunction name="getPhone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Phone />
	</cffunction>

	<cffunction name="setFax" access="public" returntype="void" output="false">
		<cfargument name="Fax" type="string" required="true" />
		<cfset variables.instance.Fax = arguments.Fax />
	</cffunction>
	<cffunction name="getFax" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Fax />
	</cffunction>

	<cffunction name="setAddress" access="public" returntype="void" output="false">
		<cfargument name="Address" type="string" required="true" />
		<cfset variables.instance.Address = arguments.Address />
	</cffunction>
	<cffunction name="getAddress" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Address />
	</cffunction>

	<cffunction name="setCity" access="public" returntype="void" output="false">
		<cfargument name="City" type="string" required="true" />
		<cfset variables.instance.City = arguments.City />
	</cffunction>
	<cffunction name="getCity" access="public" returntype="string" output="false">
		<cfreturn variables.instance.City />
	</cffunction>

	<cffunction name="setProvince" access="public" returntype="void" output="false">
		<cfargument name="Province" type="string" required="true" />
		<cfset variables.instance.Province = arguments.Province />
	</cffunction>
	<cffunction name="getProvince" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Province />
	</cffunction>

	<cffunction name="setPostalCode" access="public" returntype="void" output="false">
		<cfargument name="PostalCode" type="string" required="true" />
		<cfset variables.instance.PostalCode = arguments.PostalCode />
	</cffunction>
	<cffunction name="getPostalCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.PostalCode />
	</cffunction>

	<cffunction name="setCountry" access="public" returntype="void" output="false">
		<cfargument name="Country" type="string" required="true" />
		<cfset variables.instance.Country = arguments.Country />
	</cffunction>
	<cffunction name="getCountry" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Country />
	</cffunction>

	<cffunction name="setURL" access="public" returntype="void" output="false">
		<cfargument name="URL" type="string" required="true" />
		<cfset variables.instance.URL = arguments.URL />
	</cffunction>
	<cffunction name="getURL" access="public" returntype="string" output="false">
		<cfreturn variables.instance.URL />
	</cffunction>

	<cffunction name="setNotes" access="public" returntype="void" output="false">
		<cfargument name="Notes" type="string" required="true" />
		<cfset variables.instance.Notes = arguments.Notes />
	</cffunction>
	<cffunction name="getNotes" access="public" returntype="string" output="false">
		<cfreturn variables.instance.Notes />
	</cffunction>

	<cffunction name="setLegalRegistrationStatus" access="public" returntype="void" output="false">
		<cfargument name="LegalRegistrationStatus" type="string" required="true" />
		<cfset variables.instance.LegalRegistrationStatus = arguments.LegalRegistrationStatus />
	</cffunction>
	<cffunction name="getLegalRegistrationStatus" access="public" returntype="string" output="false">
		<cfreturn variables.instance.LegalRegistrationStatus />
	</cffunction>

	<cffunction name="setDUNSCode" access="public" returntype="void" output="false">
		<cfargument name="DUNSCode" type="string" required="true" />
		<cfset variables.instance.DUNSCode = arguments.DUNSCode />
	</cffunction>
	<cffunction name="getDUNSCode" access="public" returntype="string" output="false">
		<cfreturn variables.instance.DUNSCode />
	</cffunction>

	<cffunction name="setimplementingPartner" access="public" returntype="void" output="false">
		<cfargument name="implementingPartner" type="string" required="true" />
		<cfset variables.instance.implementingPartner = arguments.implementingPartner />
	</cffunction>
	<cffunction name="getimplementingPartner" access="public" returntype="string" output="false">
		<cfreturn variables.instance.implementingPartner />
	</cffunction>

	<cffunction name="setpocFirstname" access="public" returntype="void" output="false">
		<cfargument name="pocFirstname" type="string" required="true" />
		<cfset variables.instance.pocFirstname = arguments.pocFirstname />
	</cffunction>
	<cffunction name="getpocFirstname" access="public" returntype="string" output="false">
		<cfreturn variables.instance.pocFirstname />
	</cffunction>

	<cffunction name="setpocLastName" access="public" returntype="void" output="false">
		<cfargument name="pocLastName" type="string" required="true" />
		<cfset variables.instance.pocLastName = arguments.pocLastName />
	</cffunction>
	<cffunction name="getpocLastName" access="public" returntype="string" output="false">
		<cfreturn variables.instance.pocLastName />
	</cffunction>

	<cffunction name="setpocEmail" access="public" returntype="void" output="false">
		<cfargument name="pocEmail" type="string" required="true" />
		<cfset variables.instance.pocEmail = arguments.pocEmail />
	</cffunction>
	<cffunction name="getpocEmail" access="public" returntype="string" output="false">
		<cfreturn variables.instance.pocEmail />
	</cffunction>

	<cffunction name="setpocPhone" access="public" returntype="void" output="false">
		<cfargument name="pocPhone" type="string" required="true" />
		<cfset variables.instance.pocPhone = arguments.pocPhone />
	</cffunction>
	<cffunction name="getpocPhone" access="public" returntype="string" output="false">
		<cfreturn variables.instance.pocPhone />
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

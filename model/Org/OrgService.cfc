
<cfcomponent name="OrgService" output="false">

	<cfproperty name="orgGateway" inject="model" scope="instance" />
	<cfproperty name="orgDAO" inject="model" scope="instance" />
	<cfproperty name="Org" inject="model" scope="instance" />
	
  <cffunction name="init" access="public" output="false" returntype="OrgService">
    <cfreturn this/>
  </cffunction>

  <cffunction name="new" access="public" output="false" returntype="Org">
    <cfreturn instance.org.init() />
  </cffunction>

	<cffunction name="createOrg" access="public" output="false" returntype="Org">
		<cfargument name="OrgID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Fax" type="string" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="URL" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="LegalRegistrationStatus" type="string" required="false" />
		<cfargument name="DUNSCode" type="string" required="false" />
		<cfargument name="implementingPartner" type="string" required="false" />
		<cfargument name="pocFirstname" type="string" required="false" />
		<cfargument name="pocLastName" type="string" required="false" />
		<cfargument name="pocEmail" type="string" required="false" />
		<cfargument name="pocPhone" type="string" required="false" />		
		
			
		<cfset var Org = createObject("component","Org").init(argumentCollection=arguments) />
		<cfreturn Org />
	</cffunction>

	<cffunction name="getOrg" access="public" output="false" returntype="Org">
		<cfargument name="OrgID" type="numeric" required="true" />
		
		<cfset var Org = createOrg(argumentCollection=arguments) />
		<cfset instance.OrgDAO.read(Org) />
		<cfreturn Org />
	</cffunction>

	<cffunction name="getOrgs" access="public" output="false" returntype="array">
		<cfargument name="OrgID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Fax" type="string" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="URL" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="LegalRegistrationStatus" type="string" required="false" />
		<cfargument name="DUNSCode" type="string" required="false" />
		<cfargument name="implementingPartner" type="string" required="false" />
		<cfargument name="pocFirstname" type="string" required="false" />
		<cfargument name="pocLastName" type="string" required="false" />
		<cfargument name="pocEmail" type="string" required="false" />
		<cfargument name="pocPhone" type="string" required="false" />
		<cfargument name="SectorID" type="string" required="false" />
		<cfargument name="orderBy" type="string" required="false" />
		<cfargument name="likeSearchTerms" type="string" required="false" />
		
		<cfreturn instance.OrgGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="getOrgsQuery" access="public" output="false" returntype="query">
		<cfargument name="OrgID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Abbreviation" type="string" required="false" />
		<cfargument name="Phone" type="string" required="false" />
		<cfargument name="Fax" type="string" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="City" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="URL" type="string" required="false" />
		<cfargument name="Notes" type="string" required="false" />
		<cfargument name="LegalRegistrationStatus" type="string" required="false" />
		<cfargument name="DUNSCode" type="string" required="false" />
		<cfargument name="implementingPartner" type="string" required="false" />
		<cfargument name="pocFirstname" type="string" required="false" />
		<cfargument name="pocLastName" type="string" required="false" />
		<cfargument name="pocEmail" type="string" required="false" />
		<cfargument name="pocPhone" type="string" required="false" />		
		<cfargument name="SectorID" type="string" required="false" />
		<cfargument name="activitiesIn" type="string" required="false" />
		<cfargument name="orderBy" type="string" required="false" />
		<cfargument name="likeSearchTerms" type="string" required="false" />
		
		<cfreturn instance.OrgGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="getOrgNames" access="public" output="false" returntype="query">
		
		<cfreturn instance.OrgGateway.getOrgNames() />
	</cffunction>
	
	<cffunction name="saveOrg" access="public" output="false" returntype="numeric">
		<cfargument name="Org" type="Org" required="true" />

		<cfreturn instance.OrgDAO.save(Org) />
	</cffunction>

	<cffunction name="deleteOrg" access="public" output="false" returntype="boolean">
		<cfargument name="OrgID" type="numeric" required="true" />
		
		<cfset var Org = createOrg(argumentCollection=arguments) />
		<cfreturn instance.OrgDAO.delete(Org) />
	</cffunction>
</cfcomponent>

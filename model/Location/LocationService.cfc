
<cfcomponent name="LocationService" output="false">

	<cfproperty name="LocationGateway" inject="model" scope="instance" />
	<cfproperty name="LocationDAO" inject="model" scope="instance" />
	<cfproperty name="Location" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="LocationService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createLocation" access="public" output="false" returntype="Location">
		<cfargument name="LocationID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Longitude" type="numeric" required="false" />
		<cfargument name="Latitude" type="numeric" required="false" />
		<cfargument name="Address" type="string" required="false" />
		<cfargument name="Province" type="string" required="false" />
		<cfargument name="Country" type="string" required="false" />
		<cfargument name="PostalCode" type="string" required="false" />
		
		<cfset var Location = createObject("component","Location").init(argumentCollection=arguments) />
		<cfreturn Location />
	</cffunction>

	<cffunction name="getLocation" access="public" output="false" returntype="Location">
		<cfargument name="LocationID" type="numeric" required="true" />
		
		<cfset var Location = createLocation(argumentCollection=arguments) />
		<cfset instance.LocationDAO.read(Location) />
		<cfreturn Location />
	</cffunction>

  <cffunction name="getLocations" access="public" output="false" returntype="array">
    <cfargument name="LocationID" type="numeric" required="false" />
    <cfargument name="Name" type="string" required="false" />
    <cfargument name="Longitude" type="numeric" required="false" />
    <cfargument name="Latitude" type="numeric" required="false" />
    <cfargument name="Address" type="string" required="false" />
    <cfargument name="Province" type="string" required="false" />
    <cfargument name="Country" type="string" required="false" />
    <cfargument name="PostalCode" type="string" required="false" />
    
    <cfreturn instance.LocationGateway.getByAttributes(argumentCollection=arguments) />
  </cffunction>

  <cffunction name="getAttachedLocationsQuery" access="public" output="false" returntype="query">
    <cfargument name="activityID" type="numeric" required="true" />
    
    <cfset var qAttachedLocations = instance.LocationGateway.getAttachedLocationsQuery(activityID=arguments.activityID)>
    
    <cfreturn qAttachedLocations />
  </cffunction>

  <cffunction name="getAvailableLocationsQuery" access="public" output="false" returntype="query">
    <cfargument name="activityID" type="numeric" required="true" />
    
    <cfset var qAvailableLocations = instance.LocationGateway.getAvailableLocationsQuery(activityID=arguments.activityID)>
    
    <cfreturn qAvailableLocations />
  </cffunction>

  <cffunction name="getLocationsQuery" access="public" output="false" returntype="Query">
    <cfargument name="LocationID" type="numeric" required="false" />
    <cfargument name="Name" type="string" required="false" />
    <cfargument name="Longitude" type="numeric" required="false" />
    <cfargument name="Latitude" type="numeric" required="false" />
    <cfargument name="Address" type="string" required="false" />
    <cfargument name="Province" type="string" required="false" />
    <cfargument name="Country" type="string" required="false" />
    <cfargument name="PostalCode" type="string" required="false" />
    
    <cfreturn instance.LocationGateway.getByAttributesQuery(argumentCollection=arguments) />
  </cffunction>

	<cffunction name="saveLocation" access="public" output="false" returntype="boolean">
		<cfargument name="Location" type="Location" required="true" />

		<cfreturn instance.LocationDAO.save(Location) />
	</cffunction>

	<cffunction name="deleteLocation" access="public" output="false" returntype="boolean">
		<cfargument name="LocationID" type="numeric" required="true" />
		
		<cfset var Location = createLocation(argumentCollection=arguments) />
		<cfreturn instance.LocationDAO.delete(Location) />
	</cffunction>
</cfcomponent>

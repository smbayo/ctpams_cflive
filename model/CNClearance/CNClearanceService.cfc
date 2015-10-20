<cfcomponent name="CNClearanceService" output="false">
	<cfproperty name="CNClearance" inject="model" scope="instance" />
	<cfproperty name="CNClearanceDAO" inject="model" scope="instance" />
	<cfproperty name="CNClearanceGateway" inject="model" scope="instance" />
	
		
	<cffunction name="init" access="public" output="false" returntype="CNClearanceService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="new" access="public" output="false" returntype="CNClearance">
		<cfreturn instance.CNClearance.init() />
	</cffunction>	
		
	<cffunction name="createCNClearance" access="public" output="false" returntype="CNClearance">
		<cfargument name="CNClearanceID" type="numeric" required="true" />
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="CNStatusID" type="numeric" required="false" />
		<cfargument name="ClearanceStatus" type="string" required="false" />
		<cfargument name="ClearanceAgencyName" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="cstatusDate" type="date" required="false" />
		<cfargument name="ClearanceType" type="string" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		
			
		<cfset var CNClearance = createObject("component","CNClearance").init(argumentCollection=arguments) />
		<cfreturn CNClearance />
	</cffunction>

	<cffunction name="getCNClearance" access="public" output="false" returntype="CNClearance">
		<cfargument name="CNClearanceID" type="numeric" required="true" />
		
		<cfset var CNClearance = createCNClearance(argumentCollection=arguments) />
		<cfset instance.CNClearanceDAO.read(CNClearance) />
		<cfreturn CNClearance />
	</cffunction>

	<cffunction name="getCNClearances" access="public" output="false" returntype="array">
		<cfargument name="CNClearanceID" type="numeric" required="false" />
		<cfargument name="CNID" type="numeric" required="false" />
		<cfargument name="CNStatusID" type="numeric" required="false" />
		<cfargument name="ClearanceStatus" type="string" required="false" />
		<cfargument name="ClearanceAgencyName" type="string" required="false" />
		<cfargument name="Comments" type="string" required="false" />
		<cfargument name="cstatusDate" type="date" required="false" />
		<cfargument name="ClearanceType" type="string" required="false" />
		<cfargument name="sysUserID" type="numeric" required="false" />
		
		<cfreturn instance.CNClearanceGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveCNClearance" access="public" output="false" returntype="boolean">
		<cfargument name="CNClearance" type="CNClearance" required="true" />

		<cfreturn instance.CNClearanceDAO.save(CNClearance) />
	</cffunction>

	<cffunction name="deleteCNClearance" access="public" output="false" returntype="boolean">
		<cfargument name="CNClearanceID" type="numeric" required="true" />
		
		<cfset var CNClearance = createCNClearance(argumentCollection=arguments) />
		<cfreturn instance.CNClearanceDAO.delete(CNClearance) />
	</cffunction>
</cfcomponent>
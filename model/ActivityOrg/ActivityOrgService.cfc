<cfcomponent name="ActivityOrgService" output="false">
	<cfproperty name="ActivityOrgDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityOrgGateway" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ActivityOrgService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createActivityOrg" access="public" output="false" returntype="ActivityOrg">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="OrgID" type="numeric" required="true" />
		
			
		<cfset var ActivityOrg = createObject("component","ActivityOrg").init(argumentCollection=arguments) />
		<cfreturn ActivityOrg />
	</cffunction>

	<cffunction name="getActivityOrg" access="public" output="false" returntype="ActivityOrg">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="OrgID" type="numeric" required="true" />
		
		<cfset var ActivityOrg = createActivityOrg(argumentCollection=arguments) />
		<cfset instance.ActivityOrgDAO.read(ActivityOrg) />
		<cfreturn ActivityOrg />
	</cffunction>

	<cffunction name="getActivityOrgs" access="public" output="false" returntype="array">
		<cfargument name="ActivityID" type="numeric" required="false" />
		<cfargument name="OrgID" type="numeric" required="false" />
		
		<cfreturn instance.ActivityOrgGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityOrg" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityOrg" type="ActivityOrg" required="true" />

		<cfreturn instance.ActivityOrgDAO.save(ActivityOrg) />
	</cffunction>

	<cffunction name="deleteActivityOrg" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityID" type="numeric" required="true" />
		<cfargument name="OrgID" type="numeric" required="true" />
		
		<cfset var ActivityOrg = createActivityOrg(argumentCollection=arguments) />
		<cfreturn instance.ActivityOrgDAO.delete(ActivityOrg) />
	</cffunction>
</cfcomponent>

<cfcomponent name="ActivityStatusService" output="false">

	<cfproperty name="ActivityStatusGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityStatusDAO" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityStatusService">

		<cfreturn this/>
	</cffunction>

	<cffunction name="createActivityStatus" access="public" output="false" returntype="ActivityStatus">
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
			
		<cfset var ActivityStatus = createObject("component","ActivityStatus").init(argumentCollection=arguments) />
		<cfreturn ActivityStatus />
	</cffunction>

	<cffunction name="getActivityStatus" access="public" output="false" returntype="ActivityStatus">
		<cfargument name="CategoryID" type="numeric" required="false" />
		
		<cfset var ActivityStatus = createActivityStatus(argumentCollection=arguments) />
		<cfset instance.ActivityStatusDAO.read(ActivityStatus) />
		<cfreturn ActivityStatus />
	</cffunction>

	<cffunction name="getActivityStatuss" access="public" output="false" returntype="array">
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		
		<cfreturn instance.ActivityStatusGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="getActivityStatusQuery" access="public" output="false" returntype="query">
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="isactive" type="string" required="false" />
		
		<cfreturn instance.ActivityStatusGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>
	
	<cffunction name="getActivityStatusNamefromID" access="public" output="false" returntype="string">
		<cfargument name="CategoryID" type="numeric" required="false" />	
			
		<cfset var statusName = instance.ActivityStatusGateway.getByAttributesQuery(argumentCollection=arguments) />
		<cfreturn statusName.name /> 
	</cffunction>

	<cffunction name="getActivityStatusIDfromName" access="public" output="false" returntype="string">
		<cfargument name="Name" type="string" required="false" />		
			
		<cfset var statusID = instance.ActivityStatusGateway.getByAttributesQuery(argumentCollection=arguments) />
		<cfreturn statusID.categoryID />
	</cffunction>
	
</cfcomponent>

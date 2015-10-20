
<cfcomponent name="ActivityCategoryService" output="false">

	<cfproperty name="ActivityCategoryDAO" inject="model" scope="instance" />
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityCategoryService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createActivityCategory" access="public" output="false" returntype="ActivityCategory">
		<cfargument name="ActivityCategoryID" type="numeric" required="true" />
		<cfargument name="activityid" type="numeric" required="false" />
		<cfargument name="categoryid" type="numeric" required="false" />
		
			
		<cfset var ActivityCategory = createObject("component","ActivityCategory").init(argumentCollection=arguments) />
		<cfreturn ActivityCategory />
	</cffunction>

	<cffunction name="getActivityCategory" access="public" output="false" returntype="ActivityCategory">
		<cfargument name="ActivityCategoryID" type="numeric" required="true" />
		
		<cfset var ActivityCategory = createActivityCategory(argumentCollection=arguments) />
		<cfset instance.ActivityCategoryDAO.read(ActivityCategory) />
		<cfreturn ActivityCategory />
	</cffunction>

	<cffunction name="getActivityCategorys" access="public" output="false" returntype="array">
		<cfargument name="ActivityCategoryID" type="numeric" required="false" />
		<cfargument name="activityid" type="numeric" required="false" />
		<cfargument name="categoryid" type="numeric" required="false" />
		
		<cfreturn instance.ActivityCategoryGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityCategory" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityCategory" type="ActivityCategory" required="true" />

		<cfreturn instance.ActivityCategoryDAO.save(ActivityCategory) />
	</cffunction>

	<cffunction name="deleteActivityCategory" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityCategoryID" type="numeric" required="true" />
		
		<cfset var ActivityCategory = createActivityCategory(argumentCollection=arguments) />
		<cfreturn instance.ActivityCategoryDAO.delete(ActivityCategory) />
	</cffunction>
</cfcomponent>

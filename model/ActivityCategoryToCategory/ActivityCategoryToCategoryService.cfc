<cfcomponent name="ActivityCategoryToCategoryService" output="false">
	<cfproperty name="ActivityCategoryToCategoryDAO" inject="model" scope="instance" />
	<cfproperty name="ActivityCategoryToCategoryGateway" inject="model" scope="instance" />
	<cfproperty name="ActivityCategoryToCategory" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="ActivityCategoryToCategoryService">

		<cfreturn this/>
	</cffunction>

	<cffunction name="createActivityCategoryToCategory" access="public" output="false" returntype="ActivityCategoryToCategory">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="true" />
		<cfargument name="CategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		
			
		<cfset var ActivityCategoryToCategory = createObject("component","ActivityCategoryToCategory").init(argumentCollection=arguments) />
		<cfreturn ActivityCategoryToCategory />
	</cffunction>

	<cffunction name="getActivityCategoryToCategory" access="public" output="false" returntype="ActivityCategoryToCategory">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="true" />
		
		<cfset var ActivityCategoryToCategory = createActivityCategoryToCategory(argumentCollection=arguments) />
		<cfset variables.ActivityCategoryToCategoryDAO.read(ActivityCategoryToCategory) />
		<cfreturn ActivityCategoryToCategory />
	</cffunction>

	<cffunction name="getActivityCategoryToCategorys" access="public" output="false" returntype="array">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="CategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />
		
		<cfreturn variables.ActivityCategoryToCategoryGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveActivityCategoryToCategory" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityCategoryToCategory" type="ActivityCategoryToCategory" required="true" />

		<cfreturn variables.ActivityCategoryToCategoryDAO.save(ActivityCategoryToCategory) />
	</cffunction>

	<cffunction name="updateActivityCategoryToCategory" access="public" output="true" returntype="void">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="false" />
		<cfargument name="CategoryToCategoryIDList" type="string" required="false" />
		<cfargument name="ActivityID" type="numeric" required="false" />		
			
		<!--- remove all existing relationships --->
		  <cfset instance.ActivityCategoryToCategoryGateway.deleteByAttributesQuery(ActivityID=arguments.ActivityID)>
		  <!--- loop through new list and add --->
		  <cfloop list="#arguments.CategoryToCategoryIDList#" index="thisID"> 
		      <cfset var categoryActivityRelationshipNew = instance.ActivityCategoryToCategory.init()>
		       
			  <cfset categoryActivityRelationshipNew.setCategoryToCategoryID(thisID) />
			  <cfset categoryActivityRelationshipNew.setActivityID(arguments.ActivityID) />	
			  	  
		      <cfset instance.ActivityCategoryToCategoryDAO.save(categoryActivityRelationshipNew)>
		     	  
		  </cfloop>
		<cfreturn />
	</cffunction>

	<cffunction name="deleteActivityCategoryToCategory" access="public" output="false" returntype="boolean">
		<cfargument name="ActivityCategoryToCategoryID" type="numeric" required="true" />
		
		<cfset var ActivityCategoryToCategory = createActivityCategoryToCategory(argumentCollection=arguments) />
		<cfreturn variables.ActivityCategoryToCategoryDAO.delete(ActivityCategoryToCategory) />
	</cffunction>
	
</cfcomponent>

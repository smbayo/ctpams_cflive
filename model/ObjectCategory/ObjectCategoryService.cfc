
<cfcomponent name="ObjectCategoryService" output="false">

	<cfproperty name="ObjectCategoryGateway" inject="model" scope="instance" />
	<cfproperty name="ObjectCategoryDAO" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="ObjectCategoryService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createObjectCategory" access="public" output="false" returntype="ObjectCategory">
		<cfargument name="ClassName" type="string" required="true" />
		<cfargument name="ObjectID" type="numeric" required="true" />
		<cfargument name="CategoryID" type="numeric" required="true" />
		<cfargument name="isPrimary" type="boolean" required="false" />
		
			
		<cfset var ObjectCategory = createObject("component","ObjectCategory").init(argumentCollection=arguments) />
		<cfreturn ObjectCategory />
	</cffunction>

	<cffunction name="getObjectCategory" access="public" output="false" returntype="ObjectCategory">
		<cfargument name="ClassName" type="string" required="true" />
		<cfargument name="ObjectID" type="numeric" required="true" />
		<cfargument name="CategoryID" type="numeric" required="true" />
		
		<cfset var ObjectCategory = createObjectCategory(argumentCollection=arguments) />
		<cfset variables.ObjectCategoryDAO.read(ObjectCategory) />
		<cfreturn ObjectCategory />
	</cffunction>

	<cffunction name="getObjectCategorys" access="public" output="false" returntype="array">
		<cfargument name="ClassName" type="string" required="false" />
		<cfargument name="ObjectID" type="numeric" required="false" />
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="isPrimary" type="boolean" required="false" />
		
		<cfreturn instance.ObjectCategoryGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getObjectCategorysQuery" access="public" output="false" returntype="query">
		<cfargument name="ClassName" type="string" required="false" />
		<cfargument name="ObjectID" type="numeric" required="false" />
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="isPrimary" type="boolean" required="false" />
		
		<cfreturn instance.ObjectCategoryGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveObjectCategory" access="public" output="false" returntype="boolean">
		<cfargument name="ObjectCategory" type="ObjectCategory" required="true" />

		<cfreturn instance.ObjectCategoryDAO.save(ObjectCategory) />
	</cffunction>

	<cffunction name="updateObjectCategories" access="public" output="true" returntype="void">
		<cfargument name="ClassName" type="string" required="false" />
		<cfargument name="ObjectID" type="numeric" required="false" />
		<cfargument name="CategoryIDList" type="string" required="false" />
		<cfargument name="primary" type="numeric" required="false" />
		
		<!--- get all current rows for this object --->
		<cfset var qCurrentRelationships = instance.ObjectCategoryGateway.getByAttributesQuery(ClassName=arguments.ClassName,objectid=arguments.objectid)>
		
		<!--- if list being passed in is blank, then remove all ActivityLocation relationships --->
		<cfif listlen(arguments.CategoryIDList) eq 0>
		  <cfset instance.ObjectCategoryGateway.deleteByAttributesQuery(ClassName=arguments.ClassName,objectid=arguments.objectid)>
		<cfelse>
		  <cfset var listCurrentIDs = valuelist(qCurrentRelationships.categoryid)>
		  <!--- loop through current relationships and remove any that are no longer valid --->
		  <cfloop query="qCurrentRelationships">
		    <cfif listfind(arguments.CategoryIDList,categoryid) eq 0>
		      <cfset instance.ObjectCategoryGateway.deleteByAttributesQuery(ClassName=arguments.ClassName,objectid=arguments.objectid,categoryid=categoryid)>
		    </cfif>
		  </cfloop>
		  
		  <!--- loop through new list and add any that don't already exist --->
		  <cfloop list="#arguments.CategoryIDList#" index="thisCategoryID">
		    <cfif listFind(listCurrentIDs,thisCategoryID) eq 0>
			      <cfset var newRelationship = instance.ObjectCategoryDAO.new()>
		      <cfset newRelationship.setClassName(arguments.ClassName)>
		      <cfset newRelationship.setObjectID(arguments.ObjectID)>
		      <cfset newRelationship.setCategoryID(thisCategoryID)>
		      <cfif arguments.primary eq thisCategoryID>
			      <cfset newRelationship.setIsPrimary("True")>
			  </cfif>
		      <cfset instance.ObjectCategoryDAO.save(newRelationship)>
		    <cfelse>
		      <!--- this is an existing relationship so lets update it in case it's being marked as primary ---> 
		      <cfset var existingRelationship = instance.ObjectCategoryDAO.new()>
		      <cfset existingRelationship.setClassName(arguments.ClassName)>
		      <cfset existingRelationship.setObjectID(arguments.ObjectID)>
		      <cfset existingRelationship.setCategoryID(thisCategoryID)>
		      <cfset instance.ObjectCategoryDAO.read(existingRelationship)>
		      <cfif arguments.primary eq thisCategoryID>
			      <cfset existingRelationship.setIsPrimary("True")>
			  </cfif>
		      <cfset instance.ObjectCategoryDAO.save(existingRelationship)>
		    </cfif>
		  </cfloop>
		</cfif>
	</cffunction>
    
	<cffunction name="deleteObjectCategory" access="public" output="false" returntype="boolean">
		<cfargument name="ClassName" type="string" required="true" />
		<cfargument name="ObjectID" type="numeric" required="true" />
		<cfargument name="CategoryID" type="numeric" required="true" />
		
		<cfset var ObjectCategory = createObjectCategory(argumentCollection=arguments) />
		<cfreturn instance.ObjectCategoryDAO.delete(ObjectCategory) />
	</cffunction>
</cfcomponent>

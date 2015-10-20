
<cfcomponent name="CategoryService" output="false">

	<cfproperty name="CategoryGateway" inject="model" scope="instance" />
	<cfproperty name="CategoryDAO" inject="model" scope="instance" />
	
	<cffunction name="init" access="public" output="false" returntype="CategoryService">
		<cfreturn this/>
	</cffunction>

	<cffunction name="createCategory" access="public" output="false" returntype="Category">
		<cfargument name="CategoryID" type="numeric" required="true" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		
			
		<cfset var Category = createObject("component","Category").init(argumentCollection=arguments) />
		<cfreturn Category />
	</cffunction>

	<cffunction name="getCategory" access="public" output="false" returntype="Category">
		<cfargument name="CategoryID" type="numeric" required="true" />
		
		<cfset var Category = createCategory(argumentCollection=arguments) />
		<cfset variables.CategoryDAO.read(Category) />
		<cfreturn Category />
	</cffunction>

	<cffunction name="getCategorys" access="public" output="false" returntype="array">
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		
		<cfreturn variables.CategoryGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getSubCategorys" access="public" output="false" returntype="array">
		<cfargument name="CategoryID" type="numeric" required="false" />
		<cfargument name="ParentID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="ExternalCode" type="string" required="false" />
		
		<cfreturn variables.CategoryGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveCategory" access="public" output="false" returntype="boolean">
		<cfargument name="Category" type="Category" required="true" />

		<cfreturn variables.CategoryDAO.save(Category) />
	</cffunction>

	<cffunction name="deleteCategory" access="public" output="false" returntype="boolean">
		<cfargument name="CategoryID" type="numeric" required="true" />
		
		<cfset var Category = createCategory(argumentCollection=arguments) />
		<cfreturn variables.CategoryDAO.delete(Category) />
	</cffunction>
</cfcomponent>

<cfcomponent name="CategoryToCategoryService" output="false">

	<cfproperty name="CategoryToCategoryGateway" inject="model" scope="instance" />
	<cfproperty name="CategoryToCategoryDAO" inject="model" scope="instance" />
		
	<cffunction name="init" access="public" output="false" returntype="CategoryToCategoryService">
		
		<cfreturn this/>
	</cffunction>

	<cffunction name="createCategoryToCategory" access="public" output="false" returntype="CategoryToCategory">
		<cfargument name="SuperCategoryID" type="numeric" required="false" />
		<cfargument name="SubCategoryID" type="numeric" required="false" />
		
			
		<cfset var CategoryToCategory = createObject("component","CategoryToCategory").init(argumentCollection=arguments) />
		<cfreturn CategoryToCategory />
	</cffunction>

	<cffunction name="getCategoryToCategory" access="public" output="false" returntype="CategoryToCategory">
		
		<cfset var CategoryToCategory = createCategoryToCategory(argumentCollection=arguments) />
		<cfset instance.CategoryToCategoryDAO.read(CategoryToCategory) />
		<cfreturn CategoryToCategory />
	</cffunction>

	<cffunction name="getCategoryToCategorys" access="public" output="false" returntype="array">
		<cfargument name="SuperCategoryID" type="numeric" required="false" />
		<cfargument name="SubCategoryID" type="numeric" required="false" />
		
		<cfreturn instance.CategoryToCategoryGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveCategoryToCategory" access="public" output="false" returntype="boolean">
		<cfargument name="CategoryToCategory" type="CategoryToCategory" required="true" />

		<cfreturn instance.CategoryToCategoryDAO.save(CategoryToCategory) />
	</cffunction>

	<cffunction name="deleteCategoryToCategory" access="public" output="false" returntype="boolean">
		
		<cfset var CategoryToCategory = createCategoryToCategory(argumentCollection=arguments) />
		<cfreturn instance.CategoryToCategoryDAO.delete(CategoryToCategory) />
	</cffunction>
</cfcomponent>

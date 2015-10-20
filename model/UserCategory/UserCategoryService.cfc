
<cfcomponent name="UserCategoryService" output="false">
	<cfproperty name="UserCategoryGateway" inject="model" scope="instance" />
	<cfproperty name="UserCategoryDAO" inject="model" scope="instance" />
	<cfproperty name="SessionStorage" type="coldbox:plugin:sessionstorage" scope="instance" />
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN">

	<cffunction name="init" access="public" output="false" returntype="UserCategoryService">
		<cfargument name="UserCategoryDAO" type="UserCategoryDAO" required="true" />
		<cfargument name="UserCategoryGateway" type="UserCategoryGateway" required="true" />

		<cfset variables.UsersCategoriesDAO = arguments.UserCategoryDAO />
		<cfset variables.UsersCategoriesGateway = arguments.UserCategoryGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createUserCategory" access="public" output="false" returntype="UserCategory">
		<cfargument name="SysUserID" type="numeric" required="true" />
		<cfargument name="CategoryID" type="numeric" required="true" />
		
			
		<cfset var UserCategory = createObject("component","UserCategory").init(argumentCollection=arguments) />
		<cfreturn UserCategory />
	</cffunction>

	<cffunction name="getUserCategory" access="public" output="false" returntype="UserCategory">
		<cfargument name="SysUserID" type="numeric" required="true" />
		<cfargument name="CategoryID" type="numeric" required="true" />
		
		<cfset var UserCategory = createSysUserCategory(argumentCollection=arguments) />
		<cfset variables.UserCategoryDAO.read(SysUserCategory) />
		<cfreturn UserCategory />
	</cffunction>

	<cffunction name="getUserCategories" access="public" output="false" returntype="query">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="CategoryID" type="numeric" required="false" />
		
		<cfreturn instance.UserCategoryGateway.getByAttributesquery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveSysUserCategory" access="public" output="false" returntype="boolean">
		<cfargument name="SysUserCategory" type="SysUserCategory" required="true" />

		<cfreturn variables.UserCategoryDAO.save(SysUserCategory) />
	</cffunction>

	<cffunction name="deleteSysUserCategory" access="public" output="false" returntype="boolean">
		<cfargument name="SysUserID" type="numeric" required="true" />
		<cfargument name="CategoryID" type="numeric" required="true" />
		
		<cfset var SysUserCategory = createSysUserCategory(argumentCollection=arguments) />
		<cfreturn variables.UserCategoryDAO.delete(SysUserCategory) />
	</cffunction>
    
  	<cffunction name="getAttachedUserCategoryQuery" access="public" output="false" returntype="query">
    	<cfargument name="sysuserID" type="numeric" required="true" />
    
    	<cfset var qAttachedUserCategory = instance.UserCategoryGateway.getAttachedUserCategoryQuery(sysuserID=arguments.sysuserID)>
    
    	<cfreturn qAttachedUserCategory />
  	</cffunction>

  	<cffunction name="getAvailableUserCategoryQuery" access="public" output="false" returntype="query">
    	<cfargument name="sysuserID" type="numeric" required="true" />
    
    	<cfset var qAvailableUserCategory = instance.UserCategoryGateway.getAvailableUserCategoryQuery(sysuserID=arguments.sysuserID)>
    
    	<cfreturn qAvailableUserCategory />
    </cffunction>
    
  	<cffunction name="updateUserCategory" access="public" output="true" returntype="void">
    	<cfargument name="SysUserID" type="string" required="true">
    	<cfargument name="CategoryIDList" type="string" required="true">
    
	    <!--- get all current relationships for this activity --->
	    <cfset var qCurrentRelationships = instance.UserCategoryGateway.getByAttributesQuery(sysuserid=arguments.sysuserid)  />
		<!---<cfdump var="#qCurrentRelationships#"><cfabort>--->
	   
	    <!--- if list being passed in is blank, then remove all ActivityLocation relationships --->
	    <cfif listlen(arguments.CategoryIDList) eq 0>
	    	<cfset instance.UserCategoryGateway.deleteByAttributesQuery(sysuserid=arguments.SysUserID)>
	      	<cfoutput>list of current ids after purge: #arguments.sysUserID#<br></cfoutput>
	    <cfelse>
	      	<cfset var listCurrentIDs = valuelist(qCurrentRelationships.CategoryID)>
	      	<!--- loop through current relationships and remove any that are no longer valid --->
	      	<cfloop query="qCurrentRelationships">
	        	<cfif listfind(arguments.CategoryIDList,CategoryID) eq 0>
	          		<cfset instance.UserCategoryGateway.deleteByAttributesQuery(CategoryID=CategoryID,sysuserid=arguments.sysuserid)>
	          		<!--- remove this Categoryid from the list of current id's --->
	          		<cfset listCurrentIDs = listDeleteAt(listCurrentIDs,listfind(listCurrentIDs,CategoryID))>
	        	</cfif>
	      	</cfloop>
	      	<cfoutput>
		      list of current ids after purge: #listCurrentIDs#<br>
		      list new list: #arguments.CategoryIDLIst#
		  	</cfoutput>
	
	      	<!--- loop through new list and add any that don't already exist --->
	      	<cfloop list="#arguments.CategoryIDList#" index="thisCategoryID">
	      		<cfoutput>#thisCategoryID#</cfoutput><br>
	        	<cfif listFind(listCurrentIDs,thisCategoryID) eq 0>
	          		<cfset var newRelationship = instance.UserCategoryDAO.new()>
	          		<cfset newRelationship.setSysUserID(arguments.sysUserID)>
	          		<cfset newRelationship.setCategoryID(thisCategoryID)>
	          		<cfset instance.UserCategoryDAO.save(newRelationship)>
	        	</cfif>
	      	</cfloop>
	    </cfif>
    </cffunction>
    
    <cffunction name="QuickUserCategoryQuery" access="public" output="false" returntype="query">
    <cfargument name="sysuserID" type="numeric" required="false" />
 
   <cfset var qQuickCategories = instance.UserCategoryGateway.getQuickUserCategories()>
    
    <cfreturn qQuickCategories />
    </cffunction>  
      

    
</cfcomponent>

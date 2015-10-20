
<cfcomponent name="PermissionService" output="false">
	<cfproperty name="PermissionGateway" inject="model" scope="instance" />
	<cfproperty name="PermissionDAO" inject="model" scope="instance" />
	<cfproperty name="Permission" inject="model" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="PermissionService">
		<cfreturn this/>
	</cffunction>
	<cffunction name="new" access="public" output="false" returntype="Permission">
		<cfset var Permission = instance.Permission.init()>
		<cfreturn Permission />
	</cffunction>

	<cffunction name="createPermission" access="public" output="false" returntype="Permission">
		<cfargument name="SysPermissionID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		
			
		<cfset var Permission = createObject("component","Permission").init(argumentCollection=arguments) />
		<cfreturn Permission />
	</cffunction>

	<cffunction name="getPermission" access="public" output="false" returntype="Permission">
		<cfargument name="SysPermissionID" type="numeric" required="true" />
		
		<cfset var Permission = createPermission(argumentCollection=arguments) />
		<cfset instance.PermissionDAO.read(Permission) />
		<cfreturn Permission />
	</cffunction>

	<cffunction name="getPermissions" access="public" output="false" returntype="array">
		<cfargument name="SysPermissionID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		
		<cfreturn variables.PermissionGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>
	
    <cffunction name="getPermissionsQuery" access="public" output="false" returntype="query">
		<cfargument name="SysPermissionID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		
		<cfreturn instance.PermissionGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="savePermission" access="public" output="false" returntype="boolean">
		<cfargument name="Permission" type="Permission" required="true" />

		<cfreturn instance.PermissionDAO.save(Permission) />
	</cffunction>

	<cffunction name="deletePermission" access="public" output="false" returntype="boolean">
		<cfargument name="SysPermissionID" type="numeric" required="true" />
		
		<cfset var Permission = createPermission(argumentCollection=arguments) />
		<cfreturn instance.PermissionDAO.delete(Permission) />
        
	</cffunction>
    
    <cffunction name="PermissionList" access="public" output="false" returntype="Query">
   
   <cfset var qPermissions = "" />
   <cfset qPermissions = instance.PermissionGateway.getAllPermissions()>
   <cfreturn qPermissions>
  </cffunction>
    
    
    
    
    
    
    
    
</cfcomponent>

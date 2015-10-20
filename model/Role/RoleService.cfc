
<cfcomponent name="RoleService" output="false">
	<cfproperty name="RoleGateway" inject="model" scope="instance" />
	<cfproperty name="RoleDAO" inject="model" scope="instance" />
	<cfproperty name="Role" inject="model" scope="instance" />
	
	<cfproperty name="SessionStorage" type="coldbox:plugin:sessionstorage" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="RoleService">
		<cfreturn this/>
	</cffunction>


	<cffunction name="new" access="public" output="false" returntype="Role">
		<cfset var Role = instance.Role.init()>
		<cfreturn Role />
	</cffunction>



	<cffunction name="createRole" access="public" output="false" returntype="Role">
		<cfargument name="SysRoleID" type="numeric" required="true" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="authName" type="string" required="false" />
		
			
		<cfset var Role = createObject("component","Role").init(argumentCollection=arguments) />
		<cfreturn Role />
	</cffunction>

	<cffunction name="getRole" access="public" output="false" returntype="Role">
		<cfargument name="SysRoleID" type="numeric" required="true" />
		
		<cfset var Role = createRole(argumentCollection=arguments) />
		<cfset instance.RoleDAO.read(Role) />
		<cfreturn Role />
	</cffunction>

	<cffunction name="getRoles" access="public" output="false" returntype="array">
		<cfargument name="SysRoleID" type="numeric" required="false" />
		<cfargument name="Name" type="string" required="false" />
		<cfargument name="Description" type="string" required="false" />
		<cfargument name="authName" type="string" required="false" />
		
		<cfreturn variables.RoleGateway.getByAttributes(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveRole" access="public" output="false" returntype="numeric">
		<cfargument name="Role" type="Role" required="true" />
		
		<cfreturn instance.RoleDAO.save(arguments.Role) />
	</cffunction>

	<cffunction name="deleteRole" access="public" output="false" returntype="boolean">
		<cfargument name="SysRoleID" type="numeric" required="true" />
		
		<cfset var Role = createRole(argumentCollection=arguments) />
		<cfreturn instance.RoleDAO.delete(Role) />
	</cffunction>

    <cffunction name="RoleList" access="public" output="false" returntype="Query">
   
   <cfset var qRoles = "" />
   <cfset qRoles = instance.RoleGateway.getAllRoles()>
   
   <cfreturn qRoles>
  </cffunction>

    
    
    
    
</cfcomponent>

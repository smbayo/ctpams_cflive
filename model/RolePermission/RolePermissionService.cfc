
<cfcomponent name="RolePermissionService" output="false">
	<cfproperty name="RolePermissionGateway" inject="model" scope="instance" />
	<cfproperty name="RolePermissionDAO" inject="model" scope="instance" />
    	<cfproperty name="RolePermission" inject="model" scope="instance" />
	<cfproperty name="SessionStorage" type="coldbox:plugin:sessionstorage" scope="instance" />

	<cffunction name="init" access="public" output="false" returntype="RolePermissionService">
		<cfreturn this/>
	</cffunction>


	<cffunction name="new" access="public" output="false" returntype="RolePermission">
		<cfset var RolePermission = instance.RolePerminssions.init()>
		<cfreturn RolePermission />
	</cffunction>


	<cffunction name="createRolePermission" access="public" output="false" returntype="RolePermission">
		<cfargument name="SysRoleID" type="numeric" required="true" />
		<cfargument name="SysPermissionID" type="numeric" required="true" />
		
			
		<cfset var RolePermission = createObject("component","RolePermission").init(argumentCollection=arguments) />
		<cfreturn RolePermission />
	</cffunction>

	<cffunction name="getRolePermission" access="public" output="false" returntype="RolePermission">
		<cfargument name="SysRoleID" type="numeric" required="true" />
		<cfargument name="SysPermissionID" type="numeric" required="true" />
		
		<cfset var RolePermission = createRolePermission(argumentCollection=arguments) />
		<cfset instance.RolePermissionDAO.read(RolePermission) />
		<cfreturn RolePermission />
	</cffunction>

	<cffunction name="getRolePermissions" access="public" output="false" returntype="query">
		<cfargument name="SysRoleID" type="numeric" required="false" />
		<cfargument name="SysPermissionID" type="numeric" required="false" />
		
		<cfreturn instance.RolePermissionGateway.getByAttributesQuery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveRolePermission" access="public" output="false" returntype="boolean">
		<cfargument name="RolePermission" type="RolePermission" required="true" />

		<cfreturn variables.RolePermissionDAO.save(RolePermission) />
	</cffunction>

	<cffunction name="deleteRolePermission" access="public" output="false" returntype="boolean">
		<cfargument name="SysRoleID" type="numeric" required="true" />
		<cfargument name="SysPermissionID" type="numeric" required="true" />
		
		<cfset var RolePermission = createRolePermission(argumentCollection=arguments) />
		<cfreturn variables.RolePermissionDAO.delete(RolePermission) />
	</cffunction>
    
    
      <cffunction name="getAttachedRolePermissionQuery" access="public" output="false" returntype="query">
    <cfargument name="sysRoleID" type="numeric" required="true" />
    
    <cfset var qAttachedRolePermission = instance.RolePermissionGateway.getAttachedRolePermissionQuery(sysRoleID=arguments.sysRoleID)>
    
    <cfreturn qAttachedRolePermission />
  </cffunction>

  <cffunction name="getAvailableRolePermissionQuery" access="public" output="false" returntype="query">
    <cfargument name="sysRoleID" type="numeric" required="true" />
    
    <cfset var qAvailableRolePermission = instance.RolePermissionGateway.getAvailableRolePermissionQuery(sysRoleID=arguments.sysRoleID)>
    
    <cfreturn qAvailableRolePermission />
  </cffunction>
  
    <cffunction name="updateRolePermissions" access="public" output="true" returntype="void">
    <cfargument name="SysRoleID" type="string" required="true">
    <cfargument name="SysPermissionIDList" type="string" required="true">
    
    <!--- get all current relationships for this activity --->
    <cfset var qCurrentRelationships = instance.RolePermissionGateway.getByAttributesQuery(sysRoleid=arguments.sysroleid)>
    <!---<cfdump var = "#arguments.sysroleid#"><cfabort>--->
    
    
    <!--- if list being passed in is blank, then remove all ActivityLocation relationships --->
    <cfif listlen(arguments.sysPermissionIDList) eq 0>
      <cfset instance.RolePermissionGateway.deleteByAttributesQuery(sysroleid=arguments.SysroleID)>
      <cfoutput>list of current ids after purge: #arguments.sysRoleID#<br></cfoutput>
    <cfelse>
        
      <cfset var listCurrentIDs = valuelist(qCurrentRelationships.sysPermissionID)>
        
      
      <!--- loop through current relationships and remove any that are no longer valid --->
      <cfloop query="qCurrentRelationships">
        <cfif listfind(arguments.sysPermissionIDList,sysPermissionID) eq 0>
          <cfset instance.RolePermissionGateway.deleteByAttributesQuery(sysPermissionID=sysPermissionID,sysRoleid=arguments.sysRoleid)>
          <!--- remove this sysRoleid from the list of current id's --->
          <cfset listCurrentIDs = listDeleteAt(listCurrentIDs,listfind(listCurrentIDs,sysPermissionID))>
        </cfif>
      </cfloop>
      
      <!--- loop through new list and add any that don't already exist --->
      <cfloop list="#sysPermissionIDList#" index="thisSysPermissionID">
        <cfif listFind(listCurrentIDs,thisSysPermissionID) eq 0>
          <cfset var newRelationship = instance.RolePermissionDAO.new()>
          <cfset newRelationship.setSysRoleID(arguments.SysroleID)>
          <cfset newRelationship.setSysPermissionID(thisSysPermissionID)>
          <cfset instance.RolePermissionDAO.save(newRelationship)>
          
      
        </cfif>
      </cfloop>
   
    
    </cfif>
</cffunction>
  
  
  
  
  
  
    
</cfcomponent>

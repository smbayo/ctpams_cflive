
<cfcomponent name="UserRoleService" output="false">
	<cfproperty name="UserRoleGateway" inject="model" scope="instance" />
	<cfproperty name="UserRoleDAO" inject="model" scope="instance" />
	<cfproperty name="SessionStorage" type="coldbox:plugin:sessionstorage" scope="instance" />
	<cfproperty name="dsn" inject="coldbox:datasource:theDSN">

	<cffunction name="init" access="public" output="false" returntype="UserRoleService">
		<cfargument name="UserRoleDAO" type="UserRoleDAO" required="true" />
		<cfargument name="UserRoleGateway" type="UserRoleGateway" required="true" />

		<cfset variables.UsersRolesDAO = arguments.UserRoleDAO />
		<cfset variables.UsersRolesGateway = arguments.UserRoleGateway />

		<cfreturn this/>
	</cffunction>

	<cffunction name="createUserRole" access="public" output="false" returntype="UserRole">
		<cfargument name="SysUserID" type="numeric" required="true" />
		<cfargument name="SysRoleID" type="numeric" required="true" />
		
			
		<cfset var UserRole = createObject("component","UserRole").init(argumentCollection=arguments) />
		<cfreturn UserRole />
	</cffunction>

	<cffunction name="getUserRole" access="public" output="false" returntype="UserRole">
		<cfargument name="SysUserID" type="numeric" required="true" />
		<cfargument name="SysRoleID" type="numeric" required="true" />
		
		<cfset var UserRole = createSysUserRole(argumentCollection=arguments) />
		<cfset variables.UserRoleDAO.read(SysUserRole) />
		<cfreturn UserRole />
	</cffunction>

	<cffunction name="getUserRoles" access="public" output="false" returntype="query">
		<cfargument name="SysUserID" type="numeric" required="false" />
		<cfargument name="SysRoleID" type="numeric" required="false" />
		
		<cfreturn instance.UserRoleGateway.getByAttributesquery(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="saveSysUserRole" access="public" output="false" returntype="boolean">
		<cfargument name="SysUserRole" type="SysUserRole" required="true" />

		<cfreturn variables.UserRoleDAO.save(SysUserRole) />
	</cffunction>

	<cffunction name="deleteSysUserRole" access="public" output="false" returntype="boolean">
		<cfargument name="SysUserID" type="numeric" required="true" />
		<cfargument name="SysRoleID" type="numeric" required="true" />
		
		<cfset var SysUserRole = createSysUserRole(argumentCollection=arguments) />
		<cfreturn variables.UserRoleDAO.delete(SysUserRole) />
	</cffunction>
    
  	<cffunction name="getAttachedUserRoleQuery" access="public" output="false" returntype="query">
    	<cfargument name="sysuserID" type="numeric" required="true" />
    
    	<cfset var qAttachedUserRole = instance.UserRoleGateway.getAttachedUserRoleQuery(sysuserID=arguments.sysuserID)>
    
    	<cfreturn qAttachedUserRole />
  	</cffunction>

  	<cffunction name="getAvailableUserRoleQuery" access="public" output="false" returntype="query">
    	<cfargument name="sysuserID" type="numeric" required="true" />
    
    	<cfset var qAvailableUserRole = instance.UserRoleGateway.getAvailableUserRoleQuery(sysuserID=arguments.sysuserID)>
    
    	<cfreturn qAvailableUserRole />
    </cffunction>
    
  	<cffunction name="updateUserRole" access="public" output="true" returntype="void">
    	<cfargument name="SysUserID" type="string" required="true">
    	<cfargument name="SysRoleIDList" type="string" required="true">
    
	    <!--- get all current relationships for this activity --->
	    <cfset var qCurrentRelationships = instance.UserRoleGateway.getByAttributesQuery(sysuserid=arguments.sysuserid)  />
		<!---<cfdump var="#qCurrentRelationships#"><cfabort>--->
	   
	    <!--- if list being passed in is blank, then remove all ActivityLocation relationships --->
	    <cfif listlen(arguments.sysRoleIDList) eq 0>
	    	<cfset instance.UserRoleGateway.deleteByAttributesQuery(sysuserid=arguments.SysUserID)>
	      	<cfoutput>list of current ids after purge: #arguments.sysUserID#<br></cfoutput>
	    <cfelse>
	      	<cfset var listCurrentIDs = valuelist(qCurrentRelationships.sysRoleID)>
	      	<!--- loop through current relationships and remove any that are no longer valid --->
	      	<cfloop query="qCurrentRelationships">
	        	<cfif listfind(arguments.sysRoleIDList,sysRoleID) eq 0>
	          		<cfset instance.UserRoleGateway.deleteByAttributesQuery(sysRoleID=sysRoleID,sysuserid=arguments.sysuserid)>
	          		<!--- remove this sysRoleid from the list of current id's --->
	          		<cfset listCurrentIDs = listDeleteAt(listCurrentIDs,listfind(listCurrentIDs,sysRoleID))>
	        	</cfif>
	      	</cfloop>
	      	<cfoutput>
		      list of current ids after purge: #listCurrentIDs#<br>
		      list new list: #arguments.sysRoleIDLIst#
		  	</cfoutput>
	
	      	<!--- loop through new list and add any that don't already exist --->
	      	<cfloop list="#arguments.sysRoleIDList#" index="thisSysRoleID">
	      		<cfoutput>#thissysRoleID#</cfoutput><br>
	        	<cfif listFind(listCurrentIDs,thisSysRoleID) eq 0>
	          		<cfset var newRelationship = instance.UserRoleDAO.new()>
	          		<cfset newRelationship.setSysUserID(arguments.sysUserID)>
	          		<cfset newRelationship.setSysRoleID(thisSysRoleID)>
	          		<cfset instance.UserRoleDAO.save(newRelationship)>
	        	</cfif>
	      	</cfloop>
	    </cfif>
    </cffunction>
    
    <cffunction name="QuickUserRoleQuery" access="public" output="false" returntype="query">
    <cfargument name="sysuserID" type="numeric" required="false" />
 
   <cfset var qQuickRoles = instance.UserRoleGateway.getQuickUserRoles()>
    
    <cfreturn qQuickRoles />
    </cffunction>  
      
    <cffunction name="authenticateRoles" access="public" output="false" returntype="string">
		<cfargument name="sysUserID" type="numeric" required="true" />
	   
		<cfset var rtnRoles = instance.UserRoleGateway.getQuickUserPermissions(sysUserID=arguments.sysUserID) />

		   <cfset valRoles = "">
		   <cfset var rolelist = "">
                
                <cfif rtnRoles.recordcount>
                    <cfloop query="rtnRoles">
                        <cfif rtnRoles.currentrow is rtnRoles.recordcount>
                            <cfset var r = (#rtnRoles.PermissionName#)>
                        <cfelse>
                            <cfset var r = (#rtnRoles.PermissionName# & ',')>
                        </cfif>
                        <cfset var rolelist = (#trim(rolelist)# & #r#)>
                    </cfloop>
                    <cfset var valRoles=rolelist> 
                <cfelse>
                	<cfset var valRoles="">
                </cfif>

		<cfreturn valRoles />
	</cffunction>
    
</cfcomponent>

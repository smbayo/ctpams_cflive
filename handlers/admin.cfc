

<cfcomponent name="Admin" extends="coldbox.system.EventHandler" autowire="true">

	<!--- Inject Dependencies --->
	<cfproperty name="activityService" inject="model" scope="instance">
	<cfproperty name="PermissionService" inject="model" scope="instance">
	<cfproperty name="ProgramService" inject="model" scope="instance">
	<cfproperty name="Role" inject="model" scope="instance">
	<cfproperty name="RolePermissionService" inject="model" scope="instance">
	<cfproperty name="RolePermission" inject="model" scope="instance">
	<cfproperty name="RoleService" inject="model" scope="instance">
	<cfproperty name="UserRoleService" inject="model" scope="instance">
	<cfproperty name="UserCategoryService" inject="model" scope="instance">
	<cfproperty name="userService" inject="model" scope="instance">
	<cfproperty name="MailService" inject="coldbox:plugin:MailService" scope="instance">
	<cfproperty name="ProposalService" inject="model" scope="instance" />

	<cfproperty name="UserRoleGateway" inject="model" scope="instance" />
	<cfproperty name="RolePermissionGateway" inject="model" scope="instance">

	<!--- ************************************************************* --->
	<cffunction name="onRequestStart" access="public" returntype="void" output="false">
		<cfargument name="Event" type="any">
		<!---
		Security Check
		You need to check for the doLogin method, beacuse, if not, the doLogin method
		will never get a chance to be called.
		So check if the session.loggedin flag exists or not true, and if we
		are not logging in.
		--->

		<cfscript>
			var rc = Event.getCollection();

			//Set xeh's
			rc.xehLogout = "General.doLogout";
			rc.xehHome = "General.Home";
		</cfscript>
	</cffunction>
	<!--- ************************************************************* --->

	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="Admin Menu">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>

		<cfset rc.PageTitle = "Admin Menu">
		<!---<cfset rc.qGrants = instance.ActivityService.getLastUpdated(toplimit=5)>--->

		<cfset setNextEvent("admin.userlist")>
	</cffunction>

	<cffunction name="UserList" returntype="void" output="false" hint="User List">

		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>

		<cfset rc.PageTitle = "User List">
   		<cfset rc.qUsers = instance.UserService.UserList()>
   		<cfset rc.qQuickRoles = instance.UserRoleService.QuickUserRoleQuery()>



		<!---<cfset rc.qGrants = instance.ActivityService.getLastUpdated(toplimit=5)>--->

		<cfset event.setView("admin/userlist")>
	</cffunction>

	<cffunction name="ViewUser" returntype="void" output="false" hint="View User">
		<cfargument name="event" required="true">

      		<cfscript>
			var rc = event.getCollection();
			var allPrograms = "";

			rc.allPrograms = instance.ProgramService.getProgramsQuery();
			rc.availableRSIRegions = instance.ProposalService.getRegions();
			rc.availableDOSRegions = instance.ProposalService.getStateRegions();

			rc.ctfPartners = instance.ProposalService.getCTFPartners();

			event.paramValue("rc.SysUserID","");

			if(structKeyExists(rc,"SysUserID")) {
				rc.qUser = instance.UserService.getUser(sysUserID=rc.sysUserID);

				// Get all the UserRoles objects for this Grant as a query
				rc.allRoles = instance.RoleService.Rolelist();
				rc.attachedUserRoles = instance.UserRoleService.getUserRoles(sysUserID=rc.sysUserId);
				rc.qUserCategories = instance.UserCategoryService.getUserCategories(sysUserID=rc.sysUserId);
				rc.attachedUserCategories = valuelist(rc.qUserCategories.categoryID);
			}
			else {
				rc.qUser = instance.UserService.getUser(sysUserID=0,isActive=0);
				rc.allRoles = instance.RoleService.Rolelist();
				rc.attachedUserRoles = instance.UserRoleService.getUserRoles(sysUserID=0);
				rc.attachedUserCategories ="";
			}

			</cfscript>


 		<cfset rc.listUserRoles = valuelist(rc.attachedUserRoles.sysRoleID)>

		<cfset rc.PageTitle = "User Record">

		<!---<cfset rc.qGrants = instance.ActivityService.getLastUpdated(toplimit=5)>--->

		<cfset event.setView("admin/viewuser")>
	</cffunction>

	<cffunction name="adminsavePass" returntype="void" output="false" hint="Update user password">

   		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysUserID","");

			if(structKeyExists(rc,"SysUserID")) {
					var genpass=instance.UserService.generate();
					instance.UserService.updatePass(sysUserID=rc.sysUserID,password=genpass);
			}

			// Create a new mail object
			Email = instance.MailService.newMail();
			Email.setTo( rc.sysUserEmail );
			Email.setFrom( "noreply@ctprograms.com" );
			//Email.setCC( "copycat@email.fake" );
			Email.setType( "html" );
			Email.setSubject( "CTProgram Password Reset" );
			Email.setBody( "<p>Your CTPrograms password has been reset. Your new password is " & genpass & ".</p>" );
			// Send email
			instance.MailService.send( Email );
		</cfscript>

		<cfset setNextEvent(event='admin/userlist')>
	</cffunction>

 	<cffunction name="usersavePass" returntype="void" output="false" hint="Update user password">
      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysUserID","");
			if(structKeyExists(rc,"SysUserID")) {
				rc.qUser = instance.UserService.getUser(sysUserID=rc.sysUserID);
			}

		</cfscript>
		<cfset event.setView("admin/updatepass")>
	</cffunction>

	<cffunction name="predeleteUser" returntype="void" output="false" hint="Delete User">
		<cfargument name="event" required="true">
      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysUserID","");
			if(structKeyExists(rc,"SysUserID")) {
				rc.qUser = instance.UserService.getUser(sysUserID=rc.sysUserID);
			}
			</cfscript>
		<cfset rc.PageTitle = "Delete User Record?">
		<cfset event.setView("admin/predeleteuser")>
	</cffunction>

 	<cffunction name="deleteUser" returntype="void" output="false" hint="Delete User">
		<cfargument name="event" required="true">
      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysUserID","");
			if(structKeyExists(rc,"SysUserID")) {
				rc.qUser = instance.UserService.deleteUser(sysUserID=rc.sysUserID);
			}
			</cfscript>
		<cfset rc.PageTitle = "Deleted">
		<cfset event.setView("admin/confirmdeleteuser")>
	</cffunction>

   	<cffunction name="predeleteRole" returntype="void" output="false" hint="Delete User">
		<cfargument name="event" required="true">
      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysRoleID","");


			if(structKeyExists(rc,"SysRoleID")) {
				rc.qRole = instance.RoleService.getRole(sysRoleID=rc.sysRoleID);
   				rc.qActiveRole = instance.UserRoleService.getUserRoles(sysRoleID=rc.sysRoleID);

			}
			</cfscript>
            <cfif rc.qActiveRole.recordcount is not 0>
					<cfset rc.PageTitle = "Deletion Prohibited">
			<cfelse>
					<cfset rc.PageTitle = "Delete Role Record?">
            </cfif>

		<cfset event.setView("admin/predeleterole")>
	</cffunction>

 	<cffunction name="deleteRole" returntype="void" output="false" hint="Delete User">
		<cfargument name="event" required="true">
      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysRoleID","");
			if(structKeyExists(rc,"SysRoleID")) {
				rc.qRole = instance.RoleService.deleteRole(sysRoleID=rc.sysRoleID);
			}
			</cfscript>
		<cfset rc.PageTitle = "Deleted">
		<cfset event.setView("admin/confirmdeleterole")>
	</cffunction>

    <cffunction name="predeletePermission" returntype="void" output="false" hint="Delete User">
		<cfargument name="event" required="true">
      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysPermissionID","");
			if(structKeyExists(rc,"SysPermissionID")) {
				rc.qPermission = instance.PermissionService.getPermission(sysPermissionID=rc.sysPermissionID);
				rc.qActivePermission = instance.RolePermissionService.getRolePermissions(sysPermissionID=rc.sysPermissionID);
			}
			</cfscript>
            <cfif rc.qActivePermission.recordcount is not 0>
					<cfset rc.PageTitle = "Deletion Prohibited">
			<cfelse>
					<cfset rc.PageTitle = "Delete Permission Record?">
            </cfif>
			<cfset event.setView("admin/predeletePermission")>
	</cffunction>

 	<cffunction name="deletePermission" returntype="void" output="false" hint="Delete User">
		<cfargument name="event" required="true">
      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysPermissionID","");
			if(structKeyExists(rc,"SysPermissionID")) {
				rc.qPermission = instance.PermissionService.deletePermission(sysPermissionID=rc.sysPermissionID);
			}
			</cfscript>
		<cfdump var="#rc.qPermission#"><cfabort>
		<cfset rc.PageTitle = "Deleted">
		<cfset event.setView("admin/confirmdeletePermission")>
	</cffunction>

	<cffunction name="saveUser" output="false" hint=" editUser">
    	<cfargument name="event">

		<cfset var rc = event.getCollection()>

        <cfif isdefined("rc.isactive") is false>
             <cfset rc.isactive=0>
         <cfelse>
			<cfset rc.isactive=1>
         </cfif>

		<!--- //////////////// extending user new/update a little bit ///////////////////// --->
		<cfset var retUser = "" />
		<cfif StructKeyExists(rc,"sysUserID") and len(trim(rc.sysUserID))>
			<cfif IsUserInRole("administer users")>

				<cfset var user = instance.UserService.new() />
				<cfset PopulateModel(User) />
				<cfif rc.sysUserID GT 0>
					<cfset var curUser = instance.UserService.getUser(rc.sysUserID) />
					<cfset user = instance.UserService.updateUser(updatedUser=user,existingUser=curUser) />
					<cfset user.setactivationExpiration(DateAdd('d', 120, now())) />
				<cfelse>
					<cfset thenewpassword = #generate()#>
					<cfset user.setPassword(thenewpassword) />
					<cfset user.setConfirm(thenewpassword) />
					<cfset user.setactivationExpiration(DateAdd('d', 120, now())) />
				</cfif>

			<cfelse>

				<cfset var user = instance.UserService.getUser(rc.sysUserID) />
				<cfset user.setName(rc.name) />

				<cfif ( StructKeyExists(rc,"password") and StructKeyExists(rc,"confirm") ) and ( len(trim(rc.password)) or len(trim(rc.confirm)) )>
					<!--- if trying to change the password --->
					<cfset user.setPassword(rc.password) />
					<cfset user.setConfirm(rc.Confirm) />
				<cfelse>
					<!--- ... otherwise set "confirm" manually to avoid validation error --->
					<cfset user.setConfirm(user.getPassword()) />
				</cfif>

				<cfset user.setactivationGUID('') />
				<cfset user.setactivationExpiration(DateAdd('d', 120, now())) />

			</cfif>
		</cfif>
		<!--- /////////////////end////////////////// --->

		<cfset rc.arrErrors = user.validate() />

		<!--- //////////////// this is not the proper way to do this /////////////// --->
		<cfif StructKeyExists(rc,'attachedRoles') and len(trim(rc.attachedRoles))>
			<cfset var qroles = instance.RolePermissionGateway.getRolePermissionQuery(sysroleid=rc.attachedRoles)  />
			<cfset var usrRolePermList = valueList(qroles.permissionName) />
			<cfset var restrictedPermissionsList = "create activity,edit activity,review activity,implementing partner" />

			<cfset var icount = 0 />
			<cfloop list="#restrictedPermissionsList#" index="p">
				<cfif listFindNoCase(usrRolePermList,p,",")>
					<cfset icount = icount + 1 />
				</cfif>
			</cfloop>

			<cfif icount GT 0 AND (NOT len(trim(rc.programid)) )>
				<!--- program required --->
				<cfset var thisError = structNew() />
				<cfset thisError.field = "Name" />
				<cfset thisError.type = "invalidType" />
				<cfset thisError.message = "One or more permissions set in this role require a progam be specified." />
				<cfset arrayAppend(rc.arrErrors,duplicate(thisError)) />
			</cfif>

			<cfif listFindNoCase(usrRolePermList,"implementing partner",",")  AND (NOT len(trim(rc.implementingPartner)) )>
				<cfset var thisError = structNew() />
				<cfset thisError.field = "Name" />
				<cfset thisError.type = "invalidType" />
				<cfset thisError.message = "One or more permissions set in this role require an implementing partner be specified." />
				<cfset arrayAppend(rc.arrErrors,duplicate(thisError)) />
			</cfif>
		</cfif>
		<!--- ///////////////////////////////// end /////////////////////// --->

		<cfif arraylen(rc.arrErrors)>
			<cfset getPlugin("MessageBox").warn("Error while saving User") />
			<cfset event.setView("Admin/errors") />
		<cfelse>

        	<cfif User.getsysUserID() is 0>
				<cfset usercount = instance.UserService.checkEmail(email=rc.email) />

				<cfif usercount is not 0>
                    <cfset getPlugin("MessageBox").setMessage("error","Email for this user already exists") />
					<cfset setNextEvent(event='admin/viewUser')>
				<cfelse>
                	<cfset retUser = instance.UserService.saveUser(user) />
                </cfif>

			<cfelse>
				<cfif rc.password IS "">
					<cfset user.setPassword("") />
				</cfif>
				<cfset retUser = instance.UserService.saveUser(user) />
            </cfif>

    	    <cfif isDefined("rc.attachedRoles")>
                 <cfset instance.userRoleService.updateUserRole(sysUserID=retUser,sysRoleIDList=rc.attachedRoles) />
		    </cfif>

		    <cfif isDefined("rc.attachedCategories")>
                 <cfset instance.userCategoryService.updateUserCategory(sysUserID=retUser,CategoryIDList=rc.attachedCategories) />
		    </cfif>

		    <cfscript>
				// Create a new mail object
				Email = instance.MailService.newMail();
				Email.setTo( user.getemail() );
				Email.setFrom( "noreply@ctprograms.com" );
				/* /Email.setCC( "copycat@email.fake" ); */
				Email.setType( "html" );

				if (rc.sysUserID == 0) {
					Email.setSubject( "CTProgram Account Setup Complete" );
					Email.setBody( "<p>Your CTPrograms account is now active. Your username is " & user.getemail() & " and temporary password is " & thenewpassword & ".</p><br /><p>Please follow the <a href='https://www.ctprograms.com'>link</a> or access the management system to use your account.</p><br /><p>www.ctprograms.com</p>" );
				} else {


					Email.setSubject( "CTProgram Account Updated" );
					Email.setBody( "<p>Your CTPrograms account has been updated successfully.</p><br /><p>Please follow the <a href='https://www.ctprograms.com'>link</a> or access the management system.</p><br /><p>www.ctprograms.com</p>" );
				}

				// Send email
				instance.MailService.send( Email );
			</cfscript>


           	<cfset getPlugin("MessageBox").setMessage("info","User details saved") />
           	<cfset getPlugin("Logger").logEntry("information","User #retUser# #User.getName()# saved.") />

			<cfif IsUserInRole("administer users")>
				<cfset setNextEvent(event='admin/userlist')>
			<cfelse>
				<cfset setNextEvent(event='admin/viewuser',queryString='sysuserid/#user.getsysUserID()#')>
			</cfif>

		</cfif>
	</cffunction>

	<cffunction name="generate" hint="generates new random password" access="public" output="false" returntype="String">
		<cfset ststring=structNew()>

		<!--- since this is a 12 character password, loop it 12 times --->

		<cfloop index="i" from="1" to="12" step="1">
		    <!--- let "a" be random number between 48 and 122. Thus this will include everything from 0 to 9, Capital A to Z and small case a to z. --->

		    <cfset a = randrange(48,122)>

		    <!--- This is where the stucture is populated, Conceptually, ststring is a new structure specified above....ststring1 is key 1, ststring2 is key 2, ststring3 is key 3, and so on --->

		    <!--- since all characters between 57 and 65 and those between 90 and 97 are charachters like "[,],+,=,..,$,#" and so on, we don't need them. --->

		    <cfif (#a# gt 57 and #a# lt 65) or (#a# gt 90 and #a# lt 97)>
		        <cfset ststring["#i#"]="E">
		    <cfelse>
		        <cfset ststring["#i#"]=#chr(a)#>
		    </cfif>

		</cfloop>

		<!--- Now that our password is made up of 12 strings, it is just a question of putting that together --->

		<cfset stpassword ="#ststring[1]##ststring[2]##ststring[3]##ststring[4]##ststring[5]##ststring[6]##ststring[7]##ststring[8]##ststring[9]##ststring[10]##ststring[11]##ststring[12]#">

		<cfreturn stpassword>
	</cffunction>

	<cffunction name="ViewRole" returntype="void" output="false" hint="Role">
		<cfargument name="event" required="true">

      		<cfscript>
			var rc = event.getCollection();

			event.paramValue("rc.SysRoleID","");

			if(structKeyExists(rc,"SysroleID")) {
				rc.Role = instance.RoleService.getRole(sysroleID=rc.sysroleID);
				// Get all the UserRole objects for this Grant as a query
				rc.allPermissions = instance.PermissionService.getPermissionsQuery();
				rc.attachedRolePermissions = instance.RolePermissionService.getRolePermissions(sysroleID=rc.sysroleId);
			}
			else {
				rc.Role = instance.RoleService.getRole(sysRoleID=0);
				rc.allPermissions = instance.PermissionService.getPermissionsQuery();
				rc.attachedRolePermissions = instance.RolePermissionService.getRolePermissions(sysroleID=0);
			}

			</cfscript>


		<cfset rc.PageTitle = "Role Record and Permission">

		<!---<cfset rc.qGrants = instance.ActivityService.getLastUpdated(toplimit=5)>--->

		<cfset event.setView("admin/viewRole")>
	</cffunction>

	<cffunction name="saveRole" output="false" hint=" saveRole">
	    <cfargument name="event">
	    <cfset var rc = event.getCollection()>
	    <cfset var role = instance.RoleService.new()>
	    <cfset var retRole = "">

	    <cfset PopulateModel(Role)>

	    <cfset rc.arrErrors = role.validate()>

	    <cfif arraylen(rc.arrErrors)>
			<cfset getPlugin("MessageBox").warn("Error while saving Role")>
	        <cfset event.setView("Admin/errors")>
	    <cfelse>
	    	<cfset retRole = instance.RoleService.saveRole(Role)>

			<cfif retRole is not "">
	            <cfif not structKeyExists(rc,"rolePermissions")>
	                <cfset rc.rolePermissions="">
	            </cfif>

	            <cfset plist="">
	            <cfloop index="i" from="1" to="#rc.reccount#">
	                <cfparam name="attached_#i#" default="off">
	                <cfif evaluate("attached_#i#") is "on">
	                    <cfset plist=(#plist# & evaluate("sysPermissionID_#i#") & ',')>
	                </cfif>
	            </cfloop>
	            <cfif plist is not "">
	                <cfset plist=#trim(mid(plist,1,len(plist)-1))#>
	            </cfif>
	            <cfset instance.rolePermissionService.updateRolePermissions(sysRoleID=retRole,sysPermissionIDList=plist)>
	        <cfelse>
	            <cfset getPlugin("MessageBox").setMessage("error","Role not saved") />
	            <cfset setNextEvent(event='admin/viewrole')>
	        </cfif>

	        <cfset getPlugin("MessageBox").setMessage("info","Role details saved") />
	        <cfset getPlugin("Logger").logEntry("information","Role #retRole# #Role.getName()# saved.") />
	        <cfset setNextEvent(event='admin/rolelist')>
	    </cfif>
	</cffunction>

	<cffunction name="ViewPermission" returntype="void" output="false" hint="Permission">
		<cfargument name="event" required="true">

      		<cfscript>
			var rc = event.getCollection();
			event.paramValue("rc.SysPermissionID","");
			if(structKeyExists(rc,"SysPermissionID")) {
				rc.Permission = instance.PermissionService.getPermission(sysPermissionID=rc.sysPermissionID);
						}
			else {
				rc.Permission = instance.PermissionService.getPermission(sysPermissionID=0);
			}

			</cfscript>

		<cfset rc.PageTitle = "Permission Record">
		<cfset event.setView("admin/viewPermission")>
	</cffunction>

	<cffunction name="savePermission" output="false" hint=" savePermission">
		<cfargument name="event">
		<cfset var rc = event.getCollection()>
		<cfset var permission = instance.PermissionService.new()>
		<cfset var retPermission = "">

		<cfset PopulateModel(Permission)>

		<cfset rc.arrErrors = permission.validate()>

		<cfif arraylen(rc.arrErrors)>
			<cfset getPlugin("MessageBox").warn("Error while saving Permission")>
			<cfset event.setView("Admin/errors")>
		<cfelse>
			<cfset retPermission = instance.PermissionService.savePermission(Permission)>
			<cfif retPermission is not "">

			<cfelse>
			    <cfset getPlugin("MessageBox").setMessage("error","Role not saved") />
				<cfset setNextEvent(event='admin/viewpermission')>
			</cfif>

	    	<cfset getPlugin("MessageBox").setMessage("info","Permission details saved") />
	    	<cfset getPlugin("Logger").logEntry("information","Permission #retPermission# #Permission.getName()# saved.") />
			<cfset setNextEvent(event='admin/permissionslist')>
		</cfif>
	</cffunction>

   	<cffunction name="RoleList" returntype="void" output="false" hint="Role List">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>

		<cfset rc.PageTitle = "User Roles">
   		<cfset rc.qRoles = instance.RoleService.RoleList()>


		<cfset event.setView("admin/rolelist")>
	</cffunction>

   	<cffunction name="PermissionsList" returntype="void" output="false" hint="User List">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>
		<cfset rc.PageTitle = "Role Permissions">
  		<cfset rc.qPermissions = instance.PermissionService.PermissionList()>

		<cfset event.setView("admin/Permissionslist")>
	</cffunction>

   	<cffunction name="activateUser" returntype="void" output="false" hint="activateUser">
    	<cfargument name="event">
		<cfset var rc = event.getCollection()>

		<cfset rc.PageTitle = "Activate User">
   		<cfset rc.qRoles = instance.UserService.activateUser(sysUserID=rc.SysUserId)>

		<cfset setNextEvent(event='admin/userlist')>
	</cffunction>

    <cffunction name="disableUser" returntype="void" output="false" hint="disableUser">
    	<cfargument name="event">
		<cfset var rc = event.getCollection()>

		<cfset rc.PageTitle = "Disable User">
   		<cfset rc.qRoles = instance.UserService.disableUser(sysUserID=rc.SysUserId)>

		<cfset setNextEvent(event='admin/userlist')>
	</cffunction>


<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>


</cfcomponent>
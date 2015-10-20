<cfcomponent name="UserService" output="false">	<cfproperty name="userGateway" inject="model" scope="instance" />	<cfproperty name="userRoleGateway" inject="model" scope="instance" />	<cfproperty name="userDAO" inject="model" scope="instance" />    <cfproperty name="user" inject="model" scope="instance" />    <cfproperty name="SessionStorage" type="coldbox:plugin:sessionstorage" scope="instance" />	<cfproperty name="dsn" inject="coldbox:datasource:theDSN">	<cffunction name="init" access="public" output="false" returntype="UserService">		<cfreturn this/>	</cffunction>		<cffunction name="new" access="public" output="false" returntype="User">		<cfset var User = instance.User.init()>		<cfreturn User />	</cffunction>	<cffunction name="createUser" access="public" output="false" returntype="User">		<cfargument name="SysUserID" type="numeric" required="true" />		<cfargument name="Name" type="string" required="false" />		<cfargument name="Description" type="string" required="false" />		<cfargument name="Email" type="string" required="false" />		<cfargument name="isActivexx" type="string" required="false" />		<cfargument name="Password" type="string" required="false" />		<cfargument name="activationGUID" type="string" required="false" />		<cfargument name="activationExpiration" type="date" required="false" />		<cfargument name="isActive" type="boolean" required="false" />		<cfargument name="programID" type="numeric" required="false" />		<cfargument name="categoryID" type="numeric" required="false" />		<cfargument name="implementingPartner" type="numeric" required="false" />							<cfset var User = createObject("component","User").init(argumentCollection=arguments) />		<cfreturn User />	</cffunction>	<cffunction name="getUser" access="public" output="false" returntype="User">		<cfargument name="SysUserID" type="numeric" required="true" />				<cfset var User = createUser(argumentCollection=arguments) />		<cfset instance.userDAO.read(User) />		<cfreturn User />	</cffunction>	<cffunction name="authenticateUser" access="public" output="false" returntype="numeric">		<cfargument name="username" type="string" required="true" />		<cfargument name="password" type="string" required="true" />		<!---    <cfset var rtnStruct = structnew()>    	<cfset var thePassword = "">    	<cfset rtnStruct.validated = false>--->		<cfset rtnSysUserID="">    			<cfset var AuthSysUserID = instance.UserGateway.getSysUserID(email=arguments.username, password=arguments.password, isActive=1) />						<cfif AuthSysUserID gt 0>			<cfset rtnSysUserID=AuthSysUserID>		<cfelse>			<cfset rtnSysUserID=0>		</cfif>				<cfreturn rtnSysUserID />    </cffunction>	<cffunction name="checkUserExpires" access="public" output="false" returntype="date">		<cfargument name="sysuserID" type="numeric" required="true" />				<cfset var AuthUserExpires = instance.UserGateway.getSysUserExpires(sysuserid=arguments.sysuserid) />		<cfreturn AuthUserExpires />	</cffunction>	<cffunction name="checkNumberOfLogons" access="public" output="false" returntype="numeric">		<cfargument name="sysuserID" type="numeric" required="true" />				<cfset var AuthUserNumberLogons = instance.UserGateway.getSysUserNumberOfLogons(sysuserid=arguments.sysuserid) />		<cfreturn AuthUserNumberLogons />	</cffunction>	<cffunction name="checkOwnedProjectsNoBudget" access="public" output="false" returntype="numeric">		<cfargument name="sysuserID" type="numeric" required="true" />				<cfset var OwnedProjectsNoBudget = instance.UserGateway.checkOwnedProjectsNoBudget(sysuserid=arguments.sysuserid) />		<cfreturn OwnedProjectsNoBudget />	</cffunction>			<cffunction name="getSubmittedProposals" access="public" output="false" returntype="String">		<cfargument name="sysuserID" type="numeric" required="true" />				<cfset var AuthUserSubmittedProposals = instance.UserGateway.getSysUserSubmittedProposals(sysuserid=arguments.sysuserid) />		<cfreturn AuthUserSubmittedProposals />	</cffunction>							<cffunction name="validateUser" access="public" output="false" returntype="boolean" hint="gets only active users">		<cfargument name="username" type="string" required="true" />		<cfargument name="password" type="string" required="true" />				<cfset var authenticated = false>		<cfset var oUser = "">				<cfset var oUser = getUsers(email=arguments.username, password=arguments.password, isActive=1) />				<cfif arraylen(oUser)>			<cfreturn true />		<cfelse>			<cfreturn false />		</cfif>	</cffunction>	<cffunction name="checkEmail" access="public" output="false" returntype="numeric">		<cfargument name="Email" type="string" required="false" />		<cfset var usercount=instance.UserGateway.checkemail(email=arguments.email) />	    	<cfreturn usercount />	</cffunction>	<cffunction name="getUsers" access="public" output="false" returntype="array">		<cfargument name="SysUserID" type="numeric" required="false" />		<cfargument name="Name" type="string" required="false" />		<cfargument name="Description" type="string" required="false" />		<cfargument name="Email" type="string" required="false" />		<cfargument name="isActivexx" type="string" required="false" />		<cfargument name="Password" type="string" required="false" />		<cfargument name="activationGUID" type="string" required="false" />		<cfargument name="activationExpiration" type="date" required="false" />		<cfargument name="isActive" type="boolean" required="false" default="true" />		<cfargument name="programID" type="numeric" required="false" />		<cfargument name="categoryID" type="numeric" required="false" />		<cfargument name="implementingPartner" type="numeric" required="false" />				<cfreturn instance.UserGateway.getByAttributes(argumentCollection=arguments) />	</cffunction>	<cffunction name="saveUser" access="public" output="false" returntype="numeric">		<cfargument name="User" type="User" required="true" />    		<cfset var sysUserID=#instance.user.getSysUserID()#>		         	<cfset var sysuserid = instance.userDAO.save(User)>					<cfreturn sysuserid />	</cffunction>	<cffunction name="updatePass" access="public" output="false" returntype="numeric">		<cfargument name="sysUserID" type="numeric" required="true" />		<cfargument name="password" type="string" required="true" />                 <cfset instance.userDAO.updatePass(sysUserID=#arguments.sysUserID#,password=#arguments.password#)>		<cfreturn arguments.sysuserid />	</cffunction>	<cffunction name="deleteUser" access="public" output="false" returntype="boolean">		<cfargument name="SysUserID" type="numeric" required="true" />				<cfset var User = createUser(argumentCollection=arguments) />		<cfreturn instance.userDAO.delete(User) />	</cffunction>		<!--- Clean a user's session. --->	<cffunction name="cleanUserSession" output="false" access="public" returntype="void" hint="This method will clean the user session.">		<cfset var rc = Event.getCollection()>	    <cfscript>	    	getPlugin("SessionStorage").deleteVar("loggedin");    	</cfscript>	</cffunction>	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">		<cfargument name="qry" type="query" required="true">				<cfscript>			/**			 * Makes a row of a query into a structure.			 * 			 * @param query 	 The query to work with. 			 * @param row 	 Row number to check. Defaults to row 1. 			 * @return Returns a structure. 			 * @author Nathan Dintenfass (nathan@changemedia.com) 			 * @version 1, December 11, 2001 			 */			//by default, do this to the first row of the query			var row = 1;			//a var for looping			var ii = 1;			//the cols to loop over			var cols = listToArray(qry.columnList);			//the struct to return			var stReturn = structnew();			//if there is a second argument, use that for the row number			if(arrayLen(arguments) GT 1)				row = arguments[2];			//loop over the cols and build the struct from the query row			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){				stReturn[cols[ii]] = qry[cols[ii]][row];			}					//return the struct			return stReturn;		</cfscript>	</cffunction>        <cffunction name="UserList" access="public" output="false" returntype="Query">      		<cfset var qUsers = "" />      		<cfset qUsers = instance.UserGateway.getAllUsers()>         	   <cfreturn qUsers>  	</cffunction>      	<!--- ACTIVATE USER --->	<cffunction name="activateUser" hint="changes isActive to YES" access="public" output="false" returntype="boolean">		<cfargument name="SysUserID" type="numeric" required="true" />			 	<cfset newpass = #generate()#>		<cfset instance.userDAO.activateUser(sysUserID=arguments.SysUserID,password=newpass)>	   <cfreturn true>	</cffunction>         	<!--- DiableUSER --->	<cffunction name="disableUser" hint="changes isActive to No" access="public" output="false" returntype="boolean">		<cfargument name="SysUserID" type="numeric" required="true" />				<cfset instance.userDAO.disableUser(sysUserID=arguments.SysUserID)>	   <cfreturn true>	</cffunction>         	<!--- GENERATES NEW PASSWORD --->	<cffunction name="generate" hint="generates new random password" access="public" output="false" returntype="String">		<cfset ststring=structNew()>				<!--- since this is a 6 character password, loop it 6 times --->				<cfloop index="i" from="1" to="8" step="1">		    <!--- let "a" be random number between 48 and 122. Thus this will include everything from 0 to 9, Capital A to Z and small case a to z. --->				    <cfset a = randrange(48,122)>				    <!--- This is where the stucture is populated, Conceptually, ststring is a new structure specified above....ststring1 is key 1, ststring2 is key 2, ststring3 is key 3, and so on --->				    <!--- since all characters between 57 and 65 and those between 90 and 97 are charachters like "[,],+,=,..,$,#" and so on, we don't need them. --->				    <cfif (#a# gt 57 and #a# lt 65) or (#a# gt 90 and #a# lt 97)>		        <cfset ststring["#i#"]="E">		    <cfelse>		        <cfset ststring["#i#"]=#chr(a)#>		    </cfif>				</cfloop>				<!--- Now that our password is made up of 6 strings, it is just a question of putting that together --->				<cfset stpassword ="#ststring[1]##ststring[2]##ststring[3]##ststring[4]##ststring[5]##ststring[6]##ststring[7]##ststring[8]#">		<cfreturn stpassword>	</cffunction>      		<!--- compare user1 and user2  objects and update user2 with differences --->   			<cffunction name="updateUser" access="public" output="false" hint="compare user1 and user2  objects and update user2 with differences" returntype="user">		<cfargument name="updatedUser" type="User" required="true" />		<cfargument name="existingUser" type="User" required="true" />	    	<cfif arguments.updatedUser.getSysUserID() IS arguments.existingUser.getSysUserID()>    		    		<cfif arguments.updatedUser.getName() NEQ arguments.existingUser.getName()>    			<cfset arguments.existingUser.setName(arguments.updatedUser.getName()) />    		</cfif>    			    		<cfif arguments.updatedUser.getDescription() NEQ arguments.existingUser.getDescription()>    			<cfset arguments.existingUser.setDescription(arguments.updatedUser.getDescription()) />    		</cfif>      			    		<!--- Do not want to be doing this ... deactivate user instead    		<cfif arguments.updatedUser.getEmail() IS arguments.existingUser.getEmail()>    			<cfset arguments.existingUser.setEmail(arguments.updatedUser.getEmail()) />    		</cfif>    		--->     		<!--- <cfset user.setEmail(arguments.updatedUser.getEmail()) /> --->
   		     		<cfif ( len(trim(arguments.updatedUser.getPassword()))) and ( hash(arguments.updatedUser.getPassword()) NEQ arguments.existingUser.getPassword() )>    			<!--- <cfset user.setPassword(arguments.updatedUser.getPassword()) />    			<cfset user.setConfirm(arguments.updatedUser.getConfirm()) /> --->       			<cfset arguments.existingUser.setPassword(arguments.updatedUser.getPassword()) />    			<cfset arguments.existingUser.setConfirm(arguments.updatedUser.getConfirm()) />    				    		<cfelseif (NOT len(trim(arguments.updatedUser.getPassword())))>    			<!--- <cfset user.setPassword(arguments.existingUser.getPassword()) />    			<cfset user.setConfirm(arguments.existingUser.getPassword()) /> --->     			<cfset arguments.existingUser.setPassword(arguments.existingUser.getPassword()) />    			<cfset arguments.existingUser.setConfirm(arguments.existingUser.getPassword()) />     		</cfif>   		   				     		<!--- <cfif arguments.updatedUser.getactivationGUID() NEQ arguments.existingUser.getactivationGUID()> --->    			<!--- ... this just nulls the object value --->    		<cfset arguments.existingUser.setactivationGUID(arguments.updatedUser.getactivationGUID()) />    		<!--- </cfif> --->    		     		<!--- <cfif arguments.updatedUser.getactivationExpiration() NEQ arguments.existingUser.getactivationExpiration()> --->    			<!--- ... this just nulls the object value --->    		<cfset arguments.existingUser.setactivationExpiration(arguments.updatedUser.getactivationExpiration()) />    		<!--- </cfif> --->    		    	     		<cfif arguments.updatedUser.getisActive() NEQ arguments.existingUser.getisActive()>    			<cfset arguments.existingUser.setisActive(arguments.updatedUser.getisActive()) />    		</cfif>      			     		<cfif arguments.updatedUser.getprogramID() NEQ arguments.existingUser.getprogramID()>    			<cfset arguments.existingUser.setprogramID(arguments.updatedUser.getprogramID()) />    		</cfif>         			    		<cfif arguments.updatedUser.getcategoryID() NEQ arguments.existingUser.getcategoryID()>    			<cfset arguments.existingUser.setcategoryID(arguments.updatedUser.getcategoryID()) />    		</cfif>        			    		<cfif arguments.updatedUser.getimplementingPartner() NEQ arguments.existingUser.getimplementingPartner()>    			<cfset arguments.existingUser.setimplementingPartner(arguments.updatedUser.getimplementingPartner()) />    		</cfif>        			    	</cfif>		<cfreturn arguments.existingUser />	</cffunction>	<!--- <cffunction name="UserEmail" access="private" output="false" returntype="struct">		<cfargument name="programID" type="string" required="true" />				<cfset var qList = "" />				<cfquery name="qList" datasource="#dsn.getName()#">						</cfquery>			</cffunction>  --->	<!--- 	<cffunction name="legalUserEmail" access="private" output="false" returntype="struct">		<cfargument name="qry" type="query" required="true">				</cffunction>			<cffunction name="budgetUserEmail" access="private" output="false" returntype="struct">		<cfargument name="qry" type="query" required="true">				</cffunction> --->		</cfcomponent>

<cfcomponent name="General" extends="coldbox.system.EventHandler" autowire="true">

	<!--- Inject Dependencies --->
  <cfproperty name="userService" inject="model" scope="instance">
  <cfproperty name="activityService" inject="model" scope="instance">
  <cfproperty name="UserRoleService" inject="model" scope="instance">
	<cfproperty name="UserCategoryService" inject="model" scope="instance">
	<cfproperty name="proposalService" inject="model" scope="instance">
  <cfproperty name="programService" inject="model" scope="instance">
	<cfproperty name="MailService" inject="coldbox:plugin:MailService" scope="instance">
	<cfproperty name="ActivityStatusLogService" inject="model" scope="instance" />
	<cfproperty name="UserGateway" inject="model" scope="instance" />

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

			//Set application URL
			//var pLenght = len(cgi.script_name);
			//var position = findNoCase(variables.appName,cgi.script_name)>
			//var path_root = removeChars(cgi.script_name,position,pLenght) & variables.appName & "/";
			var tempPath = getdirectoryfrompath(getcurrenttemplatepath());
		</cfscript>

		<!--- <cfoutput>
			cgi.script_name = #cgi.script_name#<br />
			tempPath = #tempPath#<br />
			pLenght = #pLenght#<br />
		</cfoutput>
		<cfabort> --->

	</cffunction>
	<!--- ************************************************************* --->


	<!--- Default Action --->
	<cffunction name="index" returntype="void" output="false" hint="My main event">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>

		<cfset rc.PageTitle = "Main Menu">
		<cfset rc.qGrants = instance.ActivityService.getLastUpdated(toplimit=5)>

		<cfset event.setView("home")>
	</cffunction>

 	<cffunction name="login" output="false" returntype="void">
		<cfargument name="event" type="any">


		  <cfif isdefined("url.username") and url.username is 'tchen@automatastudios.com' <!---and isdefined("url.password") and url.password is 'traffiK123'--->>
	        <cfset dojsonLogin()>
	   		<cfabort>
        </cfif>

		<cfscript>
			var rc = Event.getCollection();


			//Set xeh's
			rc.xehLogin = "General.doLogin";
			//Set the page's title
			Event.setValue("title", "SCT Login App: Login page");

			event.setView("general/login");
		</cfscript>
	</cffunction>


	<cffunction name="doLogin" output="false" returntype="void">
		<cfargument name="event" type="any">

	    <cfscript>
	      //Do Login Procedure.
	      var objDataStore = "";
	      var rc = Event.getCollection();
	      var ValidationStruct = "";
	      //Error checks, does the form variables username & password exist
	      //in the request collection? if they do, are they blank?
	      if (StructKeyExists(rc,"passforgot")) {
	      	if(!StructKeyExists(rc,"username") or trim(rc.username) is ""){
	      		getPlugin("MessageBox").setMessage("error","Please enter your username.");
	        	setNextEvent("General.Login","passforgot=true");
	      	} else {
	      		resetUser = instance.userGateway.getByAttributesQuery(email=rc.username);
	      		if (resetUser.recordcount gt 0) {
	      			rtnSysUserID = resetUser.sysUserId;
	      			newPass = instance.userService.generate();
	        		rtnUpdatePassUsrID = instance.userService.updatePass(rtnSysUserID, newPass);
					Email = instance.MailService.newMail();
					Email.setTo( rc.username );
					Email.setFrom( "noreply@ctprograms.com" );
					Email.setType( "html" );
					Email.setSubject( "CTPrograms PAMS Password Reset" );
					Email.setBody( "<p>Your CTPrograms PAMS password has been reset.</p><p>Your new password is: " & newPass & "</p>" );
					instance.MailService.send(Email);
	      			getPlugin("MessageBox").setMessage("info","A new password has been emailed to you.");
	        		setNextEvent("General.Login");
	      		} else {
	      			getPlugin("MessageBox").setMessage("error","The username you entered is not associated with an active user.");
	        		setNextEvent("General.Login","passforgot=true");
	      		}
	      	}
	      }
	      else if (StructKeyExists(rc,"passreset")) {
	      	if(!StructKeyExists(rc,"username") or !StructKeyExists(rc,"password") or !StructKeyExists(rc,"newpassword") or !StructKeyExists(rc,"confirmpassword") or trim(rc.username) is "" or trim(rc.password) is "" or trim(rc.newpassword) is "" or trim(rc.confirmpassword) is ""  ){
	      		getPlugin("MessageBox").setMessage("error","Please enter all fields.");
	        	getPlugin("Logger").logEntry("error","Login without variables set detected.");
	        	setNextEvent("General.Login","passreset=true");
	      	} else {
	      		rtnSysUserID = instance.userService.authenticateUser(rc.username, rc.password);
	      		if ( rtnSysUserID   and rc.password neq rc.newpassword){
	      			var user = instance.UserService.getUser(rtnSysUserID);
	      			user.setPassword(rc.newpassword);
	      			user.setConfirm(rc.confirmpassword);
	      			user.setactivationGUID('');
					user.setactivationExpiration(DateAdd('d', 120, now()));
	      			rc.arrErrors = user.validate();

	      			if (arraylen(rc.arrErrors)) {
	      				errorString = "";
	      				iter = rc.arrErrors.iterator();
						while(iter.hasNext()){
							errorString = errorString & " - " & iter.next().message & "<br>";
						}
	      				getPlugin("MessageBox").setMessage("error",#errorString#);
	          			setNextEvent("General.Login","passreset=true");
	      			} else {
	      				retUser = instance.UserService.saveUser(user);
	      				getPlugin("MessageBox").setMessage("info","Your password has been changed.");
	      				setNextEvent("General.Login");
	      			}


	      		} else if (  rtnSysUserID   and rc.password eq rc.newpassword){
	      			//Set a message to display
	          		getPlugin("MessageBox").setMessage("error","Your new password must not be the same as your old one.");
	          		setNextEvent("General.Login","passreset=true");

	      		}

	      		else {
	      			 //Set a message to display
	          		getPlugin("MessageBox").setMessage("error","Invalid Logon Information. Please try again.");
	         		 getPlugin("Logger").logEntry("warning","Invalid logon information detected. IP used: #cgi.remote_addr#");
	          		setNextEvent("General.Login","passreset=true");

	      		}

	      	}
	      }
	      else if(!StructKeyExists(rc,"username") or !StructKeyExists(rc,"password") or trim(rc.username) is "" or trim(rc.password) is "" ){
	        //Set a message to display
	        getPlugin("MessageBox").setMessage("error","Enter both a username and password.");
	        getPlugin("Logger").logEntry("error","Login without variables set detected.");
	        //Redirect to next event, you can also add extra parameters to the URL
	        setNextEvent("General.Login","username=#Event.getValue("username","")#");
	      }
	      else {
	      	//Init DataStorage


	        rtnSysUserID = instance.userService.authenticateUser(rc.username, rc.password);

	        if ( rtnSysUserID  ){
	        	userExpires = instance.userService.checkUserExpires(rtnSysUserID);
	        	if (userExpires lt now()) {



		          	getPlugin("MessageBox").setMessage("error","Your PAMS password has expired. Please enter a new password. ");
		          	getPlugin("Logger").logEntry("warning","Password expired. Must reset. User ID: #rtnSysUserID#");
		          	setNextEvent("General.Login?passreset=true");

	        	}
	        	else {
			    	//Login Correct.
					//set my session vars
					getPlugin("SessionStorage").setVar("loggedin",true);
					getPlugin("SessionStorage").setVar("name",rc.username);
					//getPlugin("SessionStorage").setVar("sysUserid",ValidationStruct.qUser.sysUserid);
					getPlugin("SessionStorage").setVar("sysUserid",rtnSysUserID);
					getPlugin("SessionStorage").setVar("filtereportquerystring","");
					getPlugin("SessionStorage").setVar("mapquerystring","");
					getPlugin("SessionStorage").setVar("programchartquerystring","");
					getPlugin("SessionStorage").setVar("regionchartquerystring","");
					getPlugin("SessionStorage").setVar("countrychartquerystring","");
					getPlugin("SessionStorage").setVar("orgchartquerystring","");

					RolesStruct = instance.userRoleService.authenticateRoles(rtnSysUserID);

			       	if( RolesStruct gt 0 ){
			        	getPlugin("SessionStorage").setVar("userAuth",RolesStruct);
					}
					else {
						getPlugin("SessionStorage").setVar("userAuth","");
					 }

					//get other sysUser details
					rtnUser = instance.userService.getUser(rtnSysUserID);
					qUserRole = instance.userRoleService.getUserRoles(SysUserID=rtnSysUserID);
					qUserCategories = instance.userCategoryService.getUserCategories(SysUserID=rtnSysUserID);
					qUserEditable = instance.proposalService.getUserEditable(SysUserID=rtnSysUserID);


					//get sysUser Program deatils
					if ( !structIsEmpty(rtnUser) ) {

						//do CFLogin
						doCFLogin(name="#rc.username#", roles="#RolesStruct#", password="#rc.password#");
						rtnProposals = instance.userService.getSubmittedProposals(rtnUser.getSysUserID());
						//Load more user details into session
						curUserAuth = getPlugin("SessionStorage");
						//curUserAuth = structNew();
						curUserAuth.setVar("curUserAuth.sysUserID",rtnUser.getSysUserID());
						curUserAuth.setVar("curUserAuth.name",rtnUser.getName());
						curUserAuth.setVar("curUserAuth.roleName",qUserRole.roleName);
						curUserAuth.setVar("curUserAuth.roleID",qUserRole.sysRoleID);
						curUserAuth.setVar("curUserAuth.Categories",valuelist(quserCategories.categoryid));
						curUserAuth.setVar("curUserAuth.submittedProposals",rtnProposals);
						curUserAuth.setVar("curUserAuth.editableProposals",qUserEditable);

						if ( len(rtnUser.getProgramID()) ) {//if used
							rtnProgram = instance.programService.getProgram(rtnUser.getProgramID());
							curUserAuth.setVar("curUserAuth.programID",rtnUser.getProgramID());
							curUserAuth.setVar("curUserAuth.program",rtnProgram.getName());
							curUserAuth.setVar("curUserAuth.programParentID",rtnProgram.getParentID());
						}
						else {
							curUserAuth.setVar("curUserAuth.programID","");
							curUserAuth.setVar("curUserAuth.program","");
							curUserAuth.setVar("curUserAuth.programParentID","");
						}

						if ( len(rtnUser.getCategoryID()) ) {//if used
							curUserAuth.setVar("curUserAuth.categoryID",rtnUser.getcategoryID());
						}
						else {
							curUserAuth.setVar("curUserAuth.categoryID","");
						}

						if ( len(rtnUser.getimplementingPartner()) ) {//if used
							curUserAuth.setVar("curUserAuth.implementingPartner",rtnUser.getimplementingPartner());
						}
						else {
							curUserAuth.setVar("curUserAuth.implementingPartner","");
						}
					}

					numberofLogons = instance.userService.checkNumberOfLogons(rtnSysUserID);
					//numberofNoBudget = instance.userService.checkOwnedProjectsNoBudget(rtnSysUserID);
		        	if(numberoflogons is 0) {
		        		usermessage = "Greetings, " & rtnUser.getName() & ".  Welcome to CT bureau's Project Activity Management System (PAMS). Please note that your professional contact information, such as your office email address, will be securely stored in PAMS and may be used to contact you regarding the system. If you have any questions, please contact PAMSHelp1@state.gov.  Your IP address - currently " & cgi.remote_addr & " - will be logged each time you logon in effort to keep this site secure.";
		        	//} else if(numberofNoBudget gt 0) {
		        	//	usermessage = "**Please note that you have at least one project that has been active for over two months with no budget entered.** <br><br>Go to 'My Projects' to find the project and enter a budget. ";
		        	} else {
		        		usermessage = "Greetings, " & rtnUser.getName() & ". Your current IP address (" & cgi.remote_addr & ") has been logged.";
		        	}
		        	getPlugin("MessageBox").setMessage("info",usermessage);

		        	//Log the entry
		        	getPlugin("Logger").logEntry("information","The user #rc.username# has now logged in.");
		        	var oActivityStatusLog = instance.ActivityStatusLogService.new();
					oActivityStatusLog.setActivityID(11);
					oActivityStatusLog.setStatusDate(now());
					oActivityStatusLog.setSysUserID(rtnSysUserID);
					oActivityStatusLog.setActivityStatusID(265);
					lognote = "logged on - " & cgi.remote_addr;
					oActivityStatusLog.setlogNote(lognote);
					instance.ActivityStatusLogService.saveActivityStatusLog(oActivityStatusLog);


	       			//relocate to home page.
					if(structKeyExists(rc,"senduserto") and comparenocase(left(rc.senduserto,len("general/login")),"general/login") neq 0)
					 setNextEvent(rc.senduserto);
					else
						if(rc.resetpw is "yes") {
							 if (rc.newpassword is rc.confirmpassword)
							 {
								instance.userService.updatePass(password=#rc.newpassword#,sysuserid=#session.cbstorage.sysuserid#);
				               doresetLogout();
							 }
							else
							 {
							  	getPlugin("MessageBox").setMessage("error","New passwords do not match. Please try again");
								setNextEvent("General.Login/passrest/yes");
							 }
						}

					if (IsUserInRole("has workload")) {
		            		setNextEvent("summary.index");
		            }
		            else if (IsUserInRole("administer users")) {
		            		setNextEvent("admin.index");
		            }
		            else {
		            		setNextEvent("status.index");
		            }

		        }
	        }
	        else{
	          //Set a message to display
	          getPlugin("MessageBox").setMessage("error","Invalid Logon Information. Your IP address has been logged. Please try again.");
	          getPlugin("Logger").logEntry("warning","Invalid logon information detected. IP used: #cgi.remote_addr#");
	          //Redirect to next event, you can also add extra parameters to the URL
	          setNextEvent("General.Login");
	        }
	      }
	    </cfscript>

        <cfabort>

    </cffunction>

	<cffunction name="doMimic" output="false" returntype="void">
		<cfargument name="event" type="any">
		<cflogout />
	    <cfscript>
	      //Do Login Procedure.

	      var rc = Event.getCollection();

	      getPlugin("SessionStorage").clearAll();

			    	//Login Correct.
					//set my session vars
					getPlugin("SessionStorage").setVar("loggedin",true);
					getPlugin("SessionStorage").setVar("name","admin-mimic@ctprograms.com");
					getPlugin("SessionStorage").setVar("sysUserid",rc.sysuserid);
					getPlugin("SessionStorage").setVar("filtereportquerystring","");
					getPlugin("SessionStorage").setVar("mapquerystring","");
					getPlugin("SessionStorage").setVar("programchartquerystring","");
					getPlugin("SessionStorage").setVar("regionchartquerystring","");
					getPlugin("SessionStorage").setVar("countrychartquerystring","");
					getPlugin("SessionStorage").setVar("orgchartquerystring","");

					RolesStruct = instance.userRoleService.authenticateRoles(rc.sysuserid);

			       	if( RolesStruct gt 0 ){
			        	getPlugin("SessionStorage").setVar("userAuth",RolesStruct);
					}
					else {
						getPlugin("SessionStorage").setVar("userAuth","");
					 }

					//get other sysUser details
					rtnUser = instance.userService.getUser(rc.sysuserid);
					qUserRole = instance.userRoleService.getUserRoles(SysUserID=rc.sysuserid);
					qUserCategories = instance.userCategoryService.getUserCategories(SysUserID=sysUserID);
					qUserEditable = instance.proposalService.getUserEditable(SysUserID=rc.sysuserid);


					//get sysUser Program deatils
					if ( !structIsEmpty(rtnUser) ) {

						//do CFLogin
						doCFLogin(name="#rtnUser.getEmail()#", roles="#RolesStruct#", password="");
						rtnProposals = instance.userService.getSubmittedProposals(rtnUser.getSysUserID());
						//Load more user details into session
						curUserAuth = getPlugin("SessionStorage");
						//curUserAuth = structNew();
						curUserAuth.setVar("curUserAuth.sysUserID",rtnUser.getSysUserID());
						curUserAuth.setVar("curUserAuth.name","#rtnUser.getEmail()#");
						curUserAuth.setVar("curUserAuth.roleName",qUserRole.roleName);
						curUserAuth.setVar("curUserAuth.roleID",qUserRole.sysRoleID);
						curUserAuth.setVar("curUserAuth.Categories",valuelist(quserCategories.categoryid));
						curUserAuth.setVar("curUserAuth.submittedProposals",rtnProposals);
						curUserAuth.setVar("curUserAuth.editableProposals",qUserEditable);

						if ( len(rtnUser.getProgramID()) ) {//if used
							rtnProgram = instance.programService.getProgram(rtnUser.getProgramID());
							curUserAuth.setVar("curUserAuth.programID",rtnUser.getProgramID());
							curUserAuth.setVar("curUserAuth.program",rtnProgram.getName());
							curUserAuth.setVar("curUserAuth.programParentID",rtnProgram.getParentID());
						}
						else {
							curUserAuth.setVar("curUserAuth.programID","");
							curUserAuth.setVar("curUserAuth.program","");
							curUserAuth.setVar("curUserAuth.programParentID","");
						}

						if ( len(rtnUser.getCategoryID()) ) {//if used
							curUserAuth.setVar("curUserAuth.categoryID",rtnUser.getcategoryID());
						}
						else {
							curUserAuth.setVar("curUserAuth.categoryID","");
						}

						if ( len(rtnUser.getimplementingPartner()) ) {//if used
							curUserAuth.setVar("curUserAuth.implementingPartner",rtnUser.getimplementingPartner());
						}
						else {
							curUserAuth.setVar("curUserAuth.implementingPartner","");
						}
					}

					numberofLogons = 0;

		        	usermessage = "Greetings, Admin User. You are currently impersonating " & rtnUser.getName() & ".  Please view only, and don't forget to logout.";

		        	getPlugin("MessageBox").setMessage("info",usermessage);




	       			//relocate to home page.

					if (IsUserInRole("has workload")) {
		            		setNextEvent("summary.index");
		            }
		            else if (IsUserInRole("administer users")) {
		            		setNextEvent("admin.index");
		            }
		            else {
		            		setNextEvent("status.index");
		            }




	    </cfscript>

        <cfabort>

    </cffunction>


    <cffunction name="doJSONLogin" output="false" returntype="void">
		<cfargument name="event" type="any">

       	<cfif isdefined("url.username")>
        	<cfset rc.username=#url.username#>
        </cfif>
   	    <cfif isdefined("url.password")>
        	<cfset rc.password=#url.password#>
        </cfif>

	    <cfscript>
	      //Do Login Procedure.
	      var objDataStore = "";
	      var ValidationStruct = "";
	      //Error checks, does the form variables username & password exist
	      //in the request collection? if they do, are they blank?
	      if( trim(rc.username) is "" or trim(rc.password) is "" ){
	        //Set a message to display
	        getPlugin("MessageBox").setMessage("error","No username or password defined.");
	        getPlugin("Logger").logEntry("error","Login without variables set detected.");
	        //Redirect to next event, you can also add extra parameters to the URL
	        setNextEvent("General.Login","username=#Event.getValue("username","")#");
	      }
	      else{
	      	//Init DataStorage
	        rtnSysUserID = instance.userService.authenticateUser(rc.username, rc.password);

	        if ( rtnSysUserID  ){
		    	//Login Correct.
				//set my session vars
				getPlugin("SessionStorage").setVar("loggedin",true);
				getPlugin("SessionStorage").setVar("name",rc.username);
				//getPlugin("SessionStorage").setVar("sysUserid",ValidationStruct.qUser.sysUserid);
				getPlugin("SessionStorage").setVar("sysUserid",rtnSysUserID);

				RolesStruct = instance.userRoleService.authenticateRoles(rtnSysUserID);

		       	if( RolesStruct gt 0 ){
		        	getPlugin("SessionStorage").setVar("userAuth",RolesStruct);
				}
				else {
					getPlugin("SessionStorage").setVar("userAuth","");
				 }

				//get other sysUser details
				rtnUser = instance.userService.getUser(rtnSysUserID);
				qUserRole = instance.userRoleService.getUserRoles(SysUserID=rtnSysUserID);

				//get sysUser Program deatils
				if ( !structIsEmpty(rtnUser) ) {

					//do CFLogin
					doCFLogin(name="#rc.username#", roles="#RolesStruct#", password="#rc.password#");

					//Load more user details into session
					curUserAuth = getPlugin("SessionStorage");
					//curUserAuth = structNew();
					curUserAuth.setVar("curUserAuth.sysUserID",rtnUser.getSysUserID());
					curUserAuth.setVar("curUserAuth.name",rtnUser.getName());
					curUserAuth.setVar("curUserAuth.roleName",qUserRole.roleName);
					curUserAuth.setVar("curUserAuth.roleID",qUserRole.sysRoleID);

					if ( len(rtnUser.getProgramID()) ) {//if used
						rtnProgram = instance.programService.getProgram(rtnUser.getProgramID());
						curUserAuth.setVar("curUserAuth.programID",rtnUser.getProgramID());
						curUserAuth.setVar("curUserAuth.program",rtnProgram.getName());
						curUserAuth.setVar("curUserAuth.programParentID",rtnProgram.getParentID());
					}
					else {
						curUserAuth.setVar("curUserAuth.programID","");
						curUserAuth.setVar("curUserAuth.program","");
						curUserAuth.setVar("curUserAuth.programParentID","");
					}

					if ( len(rtnUser.getCategoryID()) ) {//if used
						curUserAuth.setVar("curUserAuth.categoryID",rtnUser.getcategoryID());
					}
					else {
						curUserAuth.setVar("curUserAuth.categoryID","");
					}
				}

	        	//Log the entry
	        	getPlugin("Logger").logEntry("information","The user #rc.username# has now logged in.");

       			 writeOutput("Automata Logged in Successful");

				//relocate to home page.

	        }
	        else{
	          //Set a message to display
			   writeOutput("Invalid Logon Information. Please try again");
	        }
	      }
	    </cfscript>

        <cfabort>


    </cffunction>


	<cffunction name="doCFlogin" output="false" returntype="void">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="password" type="string" required="true" />
		<cfargument name="roles" type="string" required="true" />

	     <cflogin idletimeout = "1800">
			<cfloginuser name="#arguments.name#" password="#hash(arguments.password,"SHA")#" roles="#arguments.roles#"  />
		</cflogin>

	</cffunction>

	<cffunction name="doResetLogout" output="false" returntype="void">
		<cfargument name="Event" type="any">
		<cfscript>

			//Delete login Information
			getPlugin("SessionStorage").clearAll();

			//Set the next event to display

	        getPlugin("MessageBox").setMessage("info","Logon with new password.");
        	getPlugin("Logger").logEntry("info","Password reset by user.");
			setNextEvent("general.Login");
		</cfscript>
	</cffunction>

	<cffunction name="doLogout" output="false" returntype="void">
		<cfargument name="Event" type="any">

		<cfset var username = GetAuthUser()>

		<!--- <cfif isDefined("cflogin")> --->
		<cflogout />
		<!--- </cfif> --->

		<cfscript>
			//Log the entry
          	getPlugin("Logger").logEntry("information","The user #username# has now logged out.");

			//Delete login Information
			getPlugin("SessionStorage").clearAll();

			//Set the next event to display
			setNextEvent("general.Login");
		</cfscript>

	</cffunction>

	<cffunction name="showUsers" output="false" returntype="void">
		<cfargument name="event" type="any">

		<cfset var qUsers = instance.userService.getUsers(isActive='y')>

	</cffunction>

<!------------------------------------------- PRIVATE EVENTS ------------------------------------------>


</cfcomponent>
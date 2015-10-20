
<cfoutput>

<!--- Login Form --->
	<cfform name="loginform" action="#cgi.SCRIPT_NAME#" method="post" role="form">
		<fieldset>
		<input type="hidden" name="event" value="#Event.getValue("xehLogin")#">
		<input type="hidden" name="senduserto" value="#event.getCurrentRoutedURL()#">

		<cfif isdefined("form.passreset")>
			<input type="hidden" name="resetpw" value="yes">
		<cfelse>
			<input type="hidden" name="resetpw" value="no">
		</cfif>

			<cfif isdefined("rc.passreset")>
				<h3>Change Password</h3>
				<div class="form-group">
				<label>Username</label><cfinput name="username"  class="form-control" type="text" id="username" value="#Event.getValue("username","")#" required="true" message="Enter a username" />
				</div>
				<div class="form-group">
				<label>Current Password</label><cfinput name="password"  class="form-control" type="password" id="password" required="true" message="Enter a password" />
				</div>
				<div class="form-group">
				<label>New Password</label><cfinput name="newpassword"  class="form-control" type="password" id="newpassword" required="true" message="Enter New password" />
				</div>
				<div class="form-group">
				<label>Retype New Password</label><cfinput name="confirmpassword" class="form-control" type="password" id="confirmpassword" required="true" message="Retype New password" />
				</div>
				<button class="btn btn-large btn-primary" type="submit"><i class="icon-ok  icon-white"></i> Change Password</button>&nbsp;&nbsp;
				<a href="#cgi.SCRIPT_NAME#" class="btn btn-default btn-sm"><i class="icon-remove-sign"></i> Cancel</a>
				<input type="hidden" name="passreset" value="true">

			<cfelseif isdefined("rc.passforgot")>
				<h3>Reset Password</h3>
				<div class="form-group">
				<label>Username</label><cfinput name="username" class="form-control" type="text" id="username" value="#Event.getValue("username","")#" required="true" message="Enter a username" />
				</div>
				<input type="hidden" name="passforgot" value="true">
				<button class="btn btn-large btn-primary" type="submit"><i class="icon-envelope  icon-white"></i> Reset Password</button> &nbsp;&nbsp;
				<a href="#cgi.SCRIPT_NAME#" class="btn btn-default btn-sm"><i class="icon-remove-sign"></i> Cancel</a>
			<cfelse>
				<h3>Sign In</h3>
				<div class="form-group">
                     <label>Username</label><cfinput name="username"  class="form-control" type="text" id="username" value="#Event.getValue("username","")#" required="true" message="Enter a username" />
                 </div>
                 <div class="form-group">
                      <label>Password</label><cfinput name="password"  class="form-control" type="password" id="password" required="true" message="Enter a password" />
                  </div>
				<button class="btn btn-large btn-primary pull-right" type="submit">Sign in</button><br><br><br>
				<p  class="text-center"><a href="#cgi.SCRIPT_NAME#?passreset=true" class="btn btn-default btn-xs"><i class="icon-edit"></i> Change Password</a>&nbsp;
				| &nbsp; <a href="#cgi.SCRIPT_NAME#?passforgot=true" class="btn btn-default btn-xs"><i class="icon-question-sign"></i> Forgot Password</a></p>
			</cfif>

		</fieldset>
	</cfform>

</cfoutput>
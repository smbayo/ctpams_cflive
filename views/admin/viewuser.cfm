<ol class="breadcrumb">
  <li>Admin</li>
  <li><cfoutput><a href="#event.buildLink("admin/userlist")#"></cfoutput>Users</a></li>
  <li class="active">User Profile</li>
</ol>

<cfoutput>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-user fa-fw"></i> <cfif len(rc.qUser.getSysUserID()) and rc.qUser.getSysUserID() GT 0>Edit<cfelse>New</cfif> User Profile
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">


		<form onsubmit="selectAll(userRoles,true);" name="Userform" id="userform" class="formular" method="post" action="#event.buildLink('admin.saveUser')#">
			<input type="hidden" name="event" value="#event.buildLink('admin.saveUser')#">
			<input name="sysUserID" type="hidden" value="#rc.qUser.getSysUserID()#" />
			<input type="hidden" size="5" value="#rc.allRoles.recordcount#" name="reccount">
			<label>Full Name</label>

			           <input name="Name" type="text" class="form-control validate[required,length[6,100]]" id="Name" value="#rc.qUser.getName()#"  />

			    <cfif rc.qUser.getsysUserID() is 0>
			   		 <input name="password" type="hidden" value="new">
			    	<input name="confirm" type="hidden" value="new">
			    <cfelse>

			        <label><cfif len(rc.qUser.getSysUserID()) and rc.qUser.getSysUserID() GT 0>New</cfif> Password:</label>
			           <input name="password" type="password"  class="form-control" id="password" value=""  />

					<label>Confirm Password</label>

			           <input name="confirm" type="password" id="confirm" class="form-control" value=""  />

			    </cfif>
			    <label>Email</label>

		               <input name="email" type="text" class="form-control validate[required,length[6,100]]" id="email" value="#rc.qUser.getEmail()#" <cfif (NOT IsUserInRole("administer users"))>disabled="disabled"</cfif>  />

				<cfif IsUserInRole("administer users")>


			            <cfif rc.qUser.getsysUserID() is 0>
			            	 <input name="isActive" type="hidden" id="isActive" value="1" />

			            <cfelse><br>

			              	<cfif rc.qUser.getIsActive() is 0>
				              	<label>isActive
								<span data-toggle="tooltip" title="Checking IsActive will generate a new password and email a notification to the User's email account"><i class="icon-question-sign"></i></span>
								</label>
				               <input name="isActive" type="checkbox"  id="isActive" />

							<cfelse>
								<label>isActive
								<span data-toggle="tooltip" title="Disabling IsActive will remove the user's ability to logon and send an alert to the User's email account"><i class="icon-question-sign"></i></span>
								</label>
				               <input name="isActive" type="checkbox" id="isActive"  checked="yes" />

							</cfif><br><br>

			            </cfif>

			            <label>Description</label>

			              <textarea  cols="80" rows="7" name="Description" id="Description"  class="form-control validate[length[0,3999]] text-input"/>#rc.qUser.getDescription()#</textarea>


							<label>Program
							<span class="ttip" title="Required for reviewer and submitter roles, optional for others"><i class="icon-question-sign"></i></span>
							</label>
							<select name="programid" class="form-control">
								<option value="">N/A</option>
								<cfloop query="rc.allPrograms">
									<option value="#programid#" <cfif rc.qUser.getProgramID() is programid>selected</cfif>>#name# - #description#</option>
								</cfloop>
							</select>


							<label>RSI Regions
							<span class="ttip" title="Required for regional review role, optional for others.  Hit ctrl+option to unselect a single option."><i class="icon-question-sign"></i></span>
							</label>
							<select name="attachedCategories" multiple="true" class="form-control">
								<cfloop query="rc.availableRSIRegions">
									<option value="#CategoryID#" <cfif listfind(rc.attachedUserCategories,categoryid)>selected</cfif>>#Name#</option>
								</cfloop>
							</select>

							<label>DOS Regions
							<span class="ttip" title="Optional for regional review role.  Hit ctrl+option to unselect a single option."><i class="icon-question-sign"></i></span>
							</label>
							<select name="attachedCategories" multiple="true" class="form-control">
								<cfloop query="rc.availableDOSRegions">
									<option value="#CategoryID#" <cfif listfind(rc.attachedUserCategories,categoryid)>selected</cfif>>#Name#</option>
								</cfloop>
							</select>

							<input type="hidden" name="categoryid" value="">
							<input type="hidden" name="attachedCategories">


							<label>CTF/ATA Partner
							<span class="ttip" title="Required for CTF/ATA Partner role"><i class="icon-question-sign"></i></span>
							</label>
							<select name="implementingPartner" class="form-control">
								<option value="">N/A</option>
								<cfloop query="rc.ctfPartners">
									<option value="#categoryID#" <cfif rc.qUser.getimplementingPartner() is categoryID>selected</cfif>>#name#</option>
								</cfloop>
							</select>

							<label>Role</label>
		                    <select name="attachedRoles" class="form-control">
		                    <option value="">Select User Role</option>
		                    <cfloop query="rc.allRoles">
					  			<option  value="#sysRoleID#" <cfif listfind(rc.listUserRoles,sysRoleID)>selected</cfif>>#rc.allRoles.name#</option>
		                    </cfloop>
		                    </select>


			</cfif>		<br>
					<p>

						<input name="btnSubmit" type="submit" value="Save" class="btn btn-primary btn-xs"/>
						<input type="BUTTON" value="Cancel" onclick="history.go(-1)" class="btn btn-default btn-xs">
					</p>
		</form>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

</cfoutput>



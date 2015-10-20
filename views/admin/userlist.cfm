<ol class="breadcrumb">
  <li>Admin</li>
  <li class="active">Users</li>
</ol>

<cfoutput>
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-users fa-fw"></i> PAMS Users
					<div class="pull-right">
						<a href="#event.buildLink("admin/viewuser")#" class=" btn btn-xs btn-primary" title="Add User"> Add New User</a>&nbsp; &nbsp;
						<a href="emails.cfm" target="_blank" class=" btn btn-xs btn-success" target="_blank">Active User Email List</a>
					</div>
			</div>
				            <!-- /.panel-heading -->
			<div class="panel-body">
				<div class="text-center text-muted">shift+click to sort by multiple columns</div>



	<table class="table table-striped table-hover" id="filteredreport">
		<thead>
			<tr>
			  	<th>User</th>
                <th>Username</th>
                <th>Role</th>
				<th>Program</th>
				<th>Active</th>
				<th>Disable</th>
				<th>Reset</th>
				<th>Impersonate</th>
			</tr>
		</thead>
		<tfoot>
			<tr>
			  	<th>User</th>
                <th>Username</th>
                <th>Role</th>
				<th>Program</th>
				<th>Active</th>
				<th>Disable</th>
				<th>Reset</th>
				<th>Impersonate</th>
			</tr>
		</tfoot>
		<tbody>
			<cfloop query="rc.qUsers">
				<cfset ux=#rc.qUsers.sysUserID#>
			    <cfquery dbtype="query" name="rlist">
			    select rolename from rc.qQuickRoles where sysUserID=#ux#
			    </cfquery>

				<tr>
					<td><a href="#event.buildLink('admin.viewuser.sysuserid.#sysuserid#')#">#trim(name)#</a></td>
					<td>#email#</td>
					<td><cfloop query="rlist">#rlist.rolename#<cfif currentrow neq rlist.recordcount>, </cfif></cfloop></td>
					<td>#program#</td>
				   <cfif isActive is 1>
				    	<td>Yes</td>
				    	<td>
						   	<form  name="diableform" id="disableform" class="formular" method="post" action="#event.buildLink('admin.disableUser')#">
								<input name="sysUserID" type="hidden" value="#SysUserID#" />
								<input onClick="if(confirm('Are you sure you want to disable user?')) return true; else return false;"  name="btnSubmit" type="submit" value="Disable" class="btn btn-xs btn-danger"/>
							</form>
						</td>
						<td>
						    <form  name="resetppass" id="resetpass" class="formular" method="post" action="#event.buildLink('admin.adminsavePass')#">
								<input name="sysUserID" type="hidden" value="#SysUserID#" />
								<input name="sysUserEmail" type="hidden" value="#email#" />
								<input onClick="if(confirm('This will auto generate a new password for and send an email to the selected user. To change password to something you know or can remember, click on user to go to user profile and type in new password .\n Are you sure you want to reset password?')) return true; else return false;"  name="btnSubmit" type="submit" value="Reset PW" class="btn btn-xs btn-primary" />
							</form>
						</td>
					<cfelse>
						<td>No</td>
						<td>
							<form  name="activateform" id="activateform" class="formular" method="post" action="#event.buildLink('admin.activateUser')#">
								<input name="sysUserID" type="hidden" value="#SysUserID#" />
								<input  name="btnSubmit" type="submit" value="Activate"  class="btn btn-xs btn-success" />
							</form>
						</td>
						<td>&nbsp;</td>
					</cfif>
						<td>
						    <form  name="mimic" id="mimic" method="post" action="#event.buildLink('general.doMimic')#">
								<input name="sysUserID" type="hidden" value="#SysUserID#" />
								<input  name="btnSubmit" type="submit" value="Impersonate User" class="btn btn-default btn-xs" />
							</form>
						</td>
			    </tr>
	  		</cfloop>
		</tbody>
	</table>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

</cfoutput>

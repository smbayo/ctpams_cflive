<ol class="breadcrumb">
  <li>Admin</li>
  <li><cfoutput><a href="#event.buildLink("admin/rolelist")#"></cfoutput>Roles</a></li>
  <li class="active">Role</li>
</ol>

<cfset plist="">
<cfloop query="rc.attachedRolePermissions">
  <cfset p1=#rc.attachedRolePermissions.syspermissionID#>
  <cfif rc.attachedRolePermissions.currentrow is rc.attachedRolePermissions.recordcount>
  	<cfset plist=#trim(plist)# & #trim(p1)#>
  <cfelse>
  	<cfset plist=#trim(plist)# & #trim(p1)# & ','>
  </cfif>
</cfloop>

<cfoutput>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-list fa-fw"></i> PAMS Role
					<div class="pull-right">

					</div>
			</div>
				            <!-- /.panel-heading -->
			<div class="panel-body">

<form onsubmit="selectAll(rolePermissions,true);" name="Roleform" id="roleform" class="formular" method="post" action="#event.buildLink('admin.saveRole')#">
<input type="hidden" name="event" value="#event.buildLink('admin.saveRole')#">
<input name="sysRoleID" type="hidden" value="#rc.role.getSysRoleID()#" />
<input type="hidden" size="5" value="#rc.allPermissions.recordcount#" name="reccount">

				<label>Role Name</label>
           		<input name="Name" type="text" class="form-control" id="Name"  value="#rc.role.getName()#"  />

					<label>Role Description</label>
		              <textarea  cols="80" rows="7" name="Description" id="Description"  class="form-control"/>#rc.role.getDescription()#</textarea>

						<label>Permissions</label><br>

			            	<cfloop query="rc.allPermissions">
                      			<input type="hidden" name="sysPermissionID_#currentrow#" id="sysPermissionID_#currentrow#" value="#rc.allPermissions.sysPermissionID#">

		                      	<cfset x=rc.allPermissions.sysPermissionID>
								<cfset z = 0>
		                      	<cfloop list="#plist#" index="p">
		                            <cfif x is p>
		                            	<cfset z=1>
		                                <cfbreak>
		                            </cfif>
		                        </cfloop>
		                        <cfif z is 1>
		                            <input type="checkbox" name="attached_#currentrow#"  id="sysPermissionID_#currentrow#"checked="yes" />#rc.allPermissions.name#<br />
		                      	<cfelse>
		                           <input type="checkbox" name="attached_#currentrow#" id="sysPermissionID_#currentrow#" />#rc.allPermissions.name#<br />
								</cfif>
                      		</cfloop>	<br>
<p>
			<input  class="btn btn-xs btn-primary" name="btnSubmit" type="submit" value="Save"/>
			<INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)" class="btn btn-default btn-xs">
</p>
</form>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>


 </cfoutput>

<script>
$(document).ready(function() {


function selectAll(selectBox,selectAll) {
    // have we been passed an ID
    if (typeof selectBox == "string") {
        selectBox = document.getElementById(selectBox);
    }

    // is the select box a multiple select box?
    if (selectBox.type == "select-multiple") {
        for (var i = 0; i < selectBox.options.length; i++) {
            selectBox.options[i].selected = selectAll;
        }
    }
}

</script>



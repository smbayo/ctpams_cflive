<br>
<cfoutput>
<h1>Admin</h1>
<br>
<!--- <p>&nbsp;</p> --->

<div class="clear"></div>
			<fieldset>
		        <legend><div  class="section"><h2>User Management Menu</h2></div></legend>
					<!--- <div class="span-15 append-bottom last">			
					    <ul>
							<li><a class="button" href="#event.buildLink("admin.viewuser")#">       &nbsp;Add User&nbsp;     </a> </li>
							<li><a class="button" href="#event.buildLink("admin/UserList")#">       &nbsp;Users&nbsp;     </a> </li>
							<li><a class="button" href="#event.buildLink("admin/RoleList")#">       &nbsp;Roles&nbsp;     </a> </li>
							<!--- <li><a class="button" href="#event.buildLink("admin/PermissionsList")#">       &nbsp;Permissions&nbsp;     </a> </li> --->
						</ul>  
					</div> --->
					
								<table cellpadding="0" cellspacing="0">
						<tr>
							<td><a class="button" href="#event.buildLink("admin.viewuser")#">&nbsp;Add User&nbsp;</a></td>
							<td><a class="button" href="#event.buildLink("admin/UserList")#">&nbsp;Users&nbsp;</a></td>
							<td><a class="button" href="#event.buildLink("admin/RoleList")#">&nbsp;Roles&nbsp;</a></td>
						</tr>
					</table>
				<div class="clear"></div>
			</fieldset>	



  <!--- 
<table width="80%">
<tr>
    <td>
      <h1>User Management</h1>
    </td>
  </tr>
  <tr>
   <td>
     <a href="#event.buildLink('admin.viewuser')#">Add User</a> <br />
	 
   </td>
  </tr>
  <tr>
   <td>
     <a href="#event.buildLink("admin/UserList")#">Users</a>
   </td>
  </tr>
  <tr id="altrow">
   <td>
     <a href="#event.buildLink("admin/RoleList")#">Roles</a>
   </td>
  </tr>
  <tr>
   <td>
     <a href="#event.buildLink("admin/PermissionsList")#">Permissions</a>
   </td>
  </tr>
</table>
  ---> 

</cfoutput>
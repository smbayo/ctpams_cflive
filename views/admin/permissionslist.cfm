
<cfoutput>
	<cfif not getPlugin("MessageBox").isEmpty()>
  		#getPlugin("MessageBox").renderit()#
	</cfif>
	<h1>User Permission</h1>
	<br>
	<p><div>
			<cfif IsUserInRole("administer users")>
				<button id="addRolelink" class="right" onclick="window.location='#event.buildLink("admin.viewRole")#';">Add New Permission</button>
			</cfif>
		</div>
	</p>
	<table>
		<thead>
			<tr>
			  	<th>User Permission</th>
                <th>Description</th>
                <th>Delete</th>
			</tr>
		</thead>
		<tbody>
		
		
<!--- <table width="80%">
  <tr>
    <td>
      <h1>Permission</h1>
    </td>
    <td>
      <h1>Description</h1>
    </td>
    <td>
       <div id="addPermissionlink"><a href="#event.buildLink('admin.viewPermission')#">Add Permission</a></div>
	</td>
  </tr> --->

  		<cfloop query="rc.qPermissions">
	  		<tr <cfif currentRow mod 2 eq 0>id="altrow"</cfif>>
	   			<td><a href="#event.buildLink('admin.viewPermission.sysPermissionId.#sysPermissionId#')#">#name#</a></td>
	   			<td>#Description#</td>
	   			<td><a href="#event.buildLink('admin.predeletePermission.sysPermissionId.#sysPermissionId#')#">Delete</a></td>	
	  		</tr>
		</cfloop>
	</table>
</cfoutput>
<br>



<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<h1>Results Framework</h1>
	<br>
	<p><div>
			<cfif IsUserInRole("administer users")>
				<button id="addRolelink" class="right" onclick="window.location='#event.buildLink("admin.viewRole")#';">Add New Role</button>
			</cfif>
		</div>
	</p>

	<table>
		<thead>
			<tr>
			  	<th>Number</th>
                <th>Name</th>
                <th>Description</th>
                <th>Delete</th>
			</tr>
		</thead>
		<tbody>		
<!---   <tr>
    <td>
      <h1>Role Name</h1>
    </td>
    <td>
      <h1>Description</h1>
    </td>
    <td>
      <h1>AuthName</h1>
    </td>

  </tr> --->
	
    
    
    
      <cfloop query="rc.fullResults">
	  	<tr <cfif currentRow mod 2 eq 0>id="altrow"</cfif>>
	   		<td>#displayNumber#</a></td>
	   		<td><a href="#event.buildLink('framework.viewResult.resultsFrameworkElementID.#resultsFrameworkElementID#')#">#name#</a></td>
	   		<td>#Description#</td>
<!---				<cfif rc.qRoles.name IS "submitter"
					OR rc.qRoles.name IS "program" OR rc.qRoles.name IS "Program Review"
						OR rc.qRoles.name IS "submitter/program"
							OR rc.qRoles.name IS "legal" 
								OR rc.qRoles.name IS "budget" 
									OR rc.qRoles.name IS "admin"
										OR rc.qRoles.name IS "manager">	   		
	   				<td>&nbsp;</td>
	   			<cfelse>
	--->   				<td><a href="#event.buildLink('framework.predeleteResult.resultsFramworkElementID.#resultsFrameworkElementID#')#">Delete</a></td>
				<!---</cfif>	--->
	  	</tr>
	  </cfloop>
	</table>
</cfoutput>
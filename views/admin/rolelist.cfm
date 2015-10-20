<ol class="breadcrumb">
  <li>Admin</li>
  <li class="active">Roles</li>
</ol>

<cfoutput>
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-list fa-fw"></i> PAMS Roles
					<div class="pull-right">
						<a href="#event.buildLink("admin/viewrole")#" class=" btn btn-xs btn-primary" title="Add User"> Add New Role</a>

					</div>
			</div>
				            <!-- /.panel-heading -->
			<div class="panel-body">
	<table class="table table-striped table-hover" id="filteredreport">
		<thead>
			<tr>
			  	<th>User Role</th>
                <th>Description</th>
                <th></th>
			</tr>
		</thead>
		<tbody>

	  <cfloop query="rc.qRoles">
	  	<tr <cfif currentRow mod 2 eq 0>id="altrow"</cfif>>
	   		<td><a href="#event.buildLink('admin.viewRole.sysRoleId.#sysRoleId#')#">#name#</a></td>
	   		<td>#Description#</td>

	   				<td><a href="#event.buildLink('admin.predeleteRole.sysRoleId.#sysRoleId#')#" class="btn btn-xs btn-danger">Delete</a></td>

	  	</tr>
	  </cfloop>
	</table>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>
</cfoutput>



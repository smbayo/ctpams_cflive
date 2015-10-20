<cfinclude template="header.cfm">

	<cfoutput>
<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-list-ul fa-fw"></i> Project Edit Log
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
					<table class="table table-striped table-hover" id="filteredreport">
						<thead>
						<tr>
							<th>User</th>
							<th>Date</th>
							<th>Log Note</th>

						</tr>
					</thead>

	 					<cfloop query="rc.editlog">
							<tr>
								<td><a href="mailto:#useremail#" class="ttip" title="#useremail#" data-placement="right">#username#</td>
								<td>#dateformat(statusdate,'mm/dd/yyyy')#</td>
								<td>#lognote#</td>
							</tr>

						</cfloop>



					</table>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

	</cfoutput>



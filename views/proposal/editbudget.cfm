<cfinclude template="header.cfm">

<cfoutput>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-edit fa-fw"></i> Edit Funding Breakdown <i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Please list a budget breakdown by country. If services are engaged or experts are employed, please attribute funds to the country receiving such services."></i>
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">

	<cfset QCount = 0>
	<form  name="proposalForm" id="proposalForm" class="formular"  method="post" action="#event.buildLink('proposal.saveProposalBudget')#">
		<input type="hidden" name="activityID" value="#rc.proposal.ActivityID#">
		<input type="hidden" name="proposalNumber" value="#rc.proposal.proposalNumber#">
		<input type="hidden" name="roleName" value="#rc.roleName#">
		<input type="hidden" name="pagetitle" value="#rc.pagetitle#">
		<input type="hidden" name="sysUserID" value="#getPlugin('SessionStorage').getVar('curUserAuth.sysUserID')#">
		<input type="hidden" name="projecttitle" value="#rc.projecttitle#">




					<table class="table table-bordered table-striped table-hover">
						<thead>
							<tr>

								<th>Country</th>
								<th>Budget Item</th>
								<th>Amount</th>
								<th>Del</th>
							</tr>
						</thead>
						<tbody>
							<cfset b = 0>
							<cfloop query="rc.projectFunding">
								<cfset b = b + 1>
								<tr>

									<td style="width:220px">
										<select name="budgetcountry_#b#" class="form-control">
											<option value="">Select:</option>
											<cfloop query="rc.regionCountryAll">
												<option value="#categoryID#" <cfif rc.regionCountryAll.CategoryID EQ rc.projectFunding.CountryID>selected</cfif>>#Name#</option>
											</cfloop>
										</select>
									</td>
									<td><input type="text" name="budgetitem_#b#" value="#rc.projectFunding.BudgetItem#" class="form-control"></td>
									<td style="width:230px">
										<div class="input-group">
										  <span class="input-group-addon">$</span>
										  <input type="text"  name="budgetamount_#b#" value="#rc.projectFunding.BudgetAmount#" class="form-control">
										  <span class="input-group-addon">.00</span>
										</div>
									</td>
									<td style="width:50px"><cfif b GT 1><input type="Checkbox" name="fundingDelete_#b#" value="1" /><cfelse>&nbsp;</cfif></td>
								</tr>
							</cfloop>
						</tbody>
						<input type="hidden" name="bcnt" value="#b#">
					</table>
		<span class="pull-right">
			<button type="submit" name="btnAddRow"  class="btn btn-default btn-xs"  value="Add Budget Item"><i class="icon-plus-sign"></i> Add Additional Budget Item</button>
		</span><br><br>

		<span class="pull-right">
			<input type="submit" name="saveProposalForm" value="Save" class="btn btn-primary btn-xs" />
			<a href="#event.buildLink("proposal.obstatus.activityID." & rc.proposal.ActivityID)#" class="btn btn-default btn-xs"> Cancel</a>
		</span>


	</form>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>
</cfoutput>

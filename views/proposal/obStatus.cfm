<cfinclude template="header.cfm">
<cfoutput>

		<!--- view only after CN is approved 400 --->
<cfif rc.proposal.activityStatusCode GTE 500 >
	<cfif rc.proposal.reprogramFunds is 1 or isUserinRole('administer budget')>

		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-list-alt fa-fw"></i> Reprogrammed Funds
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
						<form name="obForm" id="obForm" method="post" action="#event.buildLink('proposal.saveObStatus')#" enctype="multipart/form-data">
							<input type="hidden" name="activityID" value="#rc.activityID#">
									<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
									<input type="hidden" name="sysUserID" value="#rc.sysUserID#">


						<cfif isUserinRole('administer budget')>
										<label>Reprogram Comments</label>
										<textarea name="reprogramComments" class="form-control" rows="3" required="true">#rc.proposal.reprogramComments# </textarea>
										<input type="hidden" name="reprogramFunds" value="1"> &nbsp;
										<br><input type="submit" name="reprogram" value="Reprogram" class="btn btn-default btn-xs pull-right" />

						<cfelse>

									<strong>Reprogram Comments: </strong>#rc.proposal.reprogramComments#

						</cfif>

					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>


	</cfif>

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-credit-card fa-fw"></i> Obligated Amounts
					<div class="pull-right">
						<cfif ((isUserinRole('review activity') and getPlugin("SessionStorage").getVar("curUserAuth.programID") is rc.proposal.programid) or isUserinRole('edit all activities') or isUserinRole('administer budget')) and rc.proposal.activityStatusCode GTE 500>
							<a href="#event.buildLink("proposal.editbudget.activityID." & rc.proposal.activityID)#" class="btn btn-primary btn-xs"><i class="icon-edit icon-white"></i> Edit Funding Breakdown</a>
						</cfif>
					</div>
				</div>
	            <!-- /.panel-heading -->
				<div class="panel-body">


					<table class="table table-bordered table-hover" id="obligations">
						<cfset programfundBalance = 0 />
						<cfif rc.obligations.recordCount>
						<thead>
						<tr>
							<th>Date Obligated</th>
							<th>Amount Obligated</th>
							<th>Obligation ##</th>
							<th>FY Source</th>
							<th>Comments</th>
							<cfif isUserinRole('administer budget')>
								<th>Delete</th>
							</cfif>
						</tr>
						</thead>
						<tbody>
							<cfloop query="rc.obligations">
								<tr>
									<td <cfif isUserinRole('administer budget')>class="obdate" id="#rc.obligations.activityobligateid#"</cfif>>#dateFormat(rc.obligations.obligationDate,'mm/dd/yyyy')#</td>
									<td <cfif isUserinRole('administer budget')>class="obamount" id="#rc.obligations.activityobligateid#"</cfif> style="text-align:right;">#dollarFormat(rc.obligations.amount)#</td>
									<td <cfif isUserinRole('administer budget')>class="obnumber" id="#rc.obligations.activityobligateid#"</cfif>>#rc.obligations.obligationnumber#</td>
									<td <cfif isUserinRole('administer budget')>class="obfy" id="#rc.obligations.activityobligateid#"</cfif>>#rc.obligations.obligationFYyearSource#</td>
									<td <cfif isUserinRole('administer budget')>class="obcomments" id="#rc.obligations.activityobligateid#"</cfif>><cfif not len(rc.obligations.comments)>None<cfelse>#rc.obligations.comments#</cfif></td>
									<cfif isUserinRole('administer budget')>
										<td><a href="#event.buildLink('proposal/deleteOb?activityobligateid=#rc.obligations.activityobligateid#&activityid=#rc.activityid#')#" onclick="javascript: return confirm('Are you sure you want to delete this obligation?')">delete</a></td>
									</cfif>
								</tr>
								<cfset programfundBalance = (programfundBalance + rc.obligations.amount) />
							</cfloop>
						<cfelse>
							No Obligation Found
						</cfif>
						</tbody>
					</table>
					<strong class="pull-right">Total Obligated: #dollarFormat(programfundBalance)#</strong><br>
					<strong class="pull-right">Amount Appropriated: #dollarFormat(rc.proposal.BudgetCeilingAmount)#</strong><br>
					<strong class="pull-right">Remaining Funds: #dollarFormat(rc.proposal.BudgetCeilingAmount - programfundBalance)#</strong><br>

				</div>
	            <!-- /.panel-body -->
			</div>
		</div>
	</div>


	<cfif isUserinRole('administer budget')>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-usd fa-fw"></i> Obligate More Funds
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

						<!--- <h3>Sub Title</h3> --->
						<span class="text-warning"><ul><cfif rc.proposal.activityStatusCode GTE 600>
							<li>To add or subtract funds, click Restore Obligation Status.</li></cfif> <li>Enter the amount in the field provided.</li>
							<li>Fill in the FY, a comment of explanation, and obligation number.</li>
							<li>Click Obligate Funds to add funds, or Deobligate Funds to subtract funds.</li>
							<li>Click Declare Program Fully Obligated once all obligated funds have been entered.</li></ul></span>
						<table class="table table-bordered">
							<thead>
							<tr>
								<th>Amount</th>
								<th>Appropriation Year</th>
								<th>Obligation ##</th>
								<th>Comment</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td style="width:240px">
										<div class="input-group">
										  <span class="input-group-addon">$</span>
										  <input class="form-control" id="appendedPrependedInput" type="text" name="obligAmount" value="" <cfif rc.proposal.activityStatusCode GTE 600>disabled</cfif>>
										  <span class="input-group-addon">.00</span>
										</div>
								</td>
								<td style="width:170px">
									<select name="obligFY" class="form-control" <cfif rc.proposal.activityStatusCode GTE 600>disabled</cfif>>
										<cfloop from="-5" to="3" index="i">
											<option value="#datePart('yyyy',dateAdd('yyyy',i,now()))#" <cfif datePart('yyyy',dateAdd('yyyy',i,now())) is datePart('yyyy',now())> selected</cfif>>#datePart('yyyy',dateAdd('yyyy',i,now()))#</option>
										</cfloop>
									</select>
								</td>
								<td style="width:240px">
									<input type="text" name="obligationNumber" value="" class="form-control" <cfif rc.proposal.activityStatusCode GTE 600>disabled</cfif>>
								</td>
								<td>
									<input type="text" name="obligComment" value="" class="form-control" <cfif rc.proposal.activityStatusCode GTE 600>disabled</cfif>>
								</td>
							</tr>
							</tbody>
						</table>



							<input type="hidden" name="projectCost" value="#rc.proposal.BudgetCeilingAmount#" >



							<cfif rc.proposal.activityStatusCode GTE 600>
								<input type="submit" name="restoreObigStatus" value="Restore Obligation Status" class="btn btn-default btn-xs pull-right" />
							<cfelse>
							<span class="pull-right">

								<input type="submit" name="updateObligation" value="Obligate Funds" class="btn btn-success btn-xs" />
								<cfif rc.proposal.BudgetCeilingAmount gt 0>
									&nbsp;&nbsp; <input type="submit" name="updateObligation" value="Deobligate Funds" class="btn btn-warning btn-xs" />
								</cfif>

								<br><br>
								<input type="submit" name="fullyObigPrgm" value="Declare Program Fully Obligated" class="btn btn-primary btn-xs" />
							</span>
							</cfif>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
	</cfif>
			</form>

	<cfif IsUserInRole("post am/cn comments")>
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comments-o fa-fw"></i> Comments
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

							<cfif StructKeyExists(rc,"recommendations") AND rc.recommendations.recordCount>
								<cfloop query="rc.recommendations">
									<dt>#dateFormat(rc.recommendations.commentDate,'mm/dd/yyyy')# - #uCase(rc.recommendations.sender)#</dt>
									<dd>#rc.recommendations.comments#</dd>
								</cfloop>
							<cfelse>
											No Obligation comments added yet
										</cfif>



					</div>
		            <!-- /.panel-body -->
				</div>
			</div>

			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-comment-o fa-fw"></i> Add Obligation Comments
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
					<form name="legalForm" id="legalForm" class="formular"  method="post" action="#event.buildLink('proposal.saveObComment')#" enctype="multipart/form-data">
						<input type="hidden" name="activityID" value="#rc.activityID#">
						<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
						<input type="hidden" name="sender" value="#rc.roleName#">
						<input type="hidden" name="sysUserID" value="#rc.sysUserID#">


								    	<textarea name="prelegalComment" rows="5" class="form-control" required="true"></textarea><br>

								  	<button type="submit" class="btn btn-info btn-xs pull-right" name="addComment" value="Add Comment"><i class="icon-bullhorn icon-white"></i> Add Comment</button>

						</fieldset>

					</form>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
	</cfif>

<cfelse>
			<h4>The activity has not yet reached this stage in the approval process.</h4>
</cfif>

</cfoutput>

<cfif isUserinRole('administer budget')>
	<script>

		$(document).ready(function() {
		     $('.obamount').editable('<cfoutput>#event.buildLink("remote/saveBudgetAmountRemote")#</cfoutput>', {
		         cancel    : 'Cancel',
		         submit    : 'OK',
		         tooltip   : 'Click to edit...',
		         width     :  90
    			 });

    			  $('.obdate').editable('<cfoutput>#event.buildLink("remote/saveBudgetDateRemote")#</cfoutput>', {
		         cancel    : 'Cancel',
		         submit    : 'OK',
		         tooltip   : 'Click to edit...',
		         width     :  90
    			 });

    			  $('.obcomments').editable('<cfoutput>#event.buildLink("remote/saveBudgetCommentsRemote")#</cfoutput>', {
		         cancel    : 'Cancel',
		         submit    : 'OK'
    			 });

    			 $('.obnumber').editable('<cfoutput>#event.buildLink("remote/saveBudgetObNumberRemote")#</cfoutput>', {
		         cancel    : 'Cancel',
		         submit    : 'OK'
    			 });

    			  $('.obfy').editable('<cfoutput>#event.buildLink("remote/saveBudgetFYRemote")#</cfoutput>', {
		         cancel    : 'Cancel',
		         submit    : 'OK',
		         tooltip   : 'Click to edit...',
		         width     :  90
    			 });
		 });
	</script>
</cfif>

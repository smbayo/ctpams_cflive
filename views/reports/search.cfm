<ol class="breadcrumb">
  <li class="active">Search</li>
</ol>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-search fa-fw"></i> Search Term: "<cfoutput>#rc.searchTerm#</cfoutput>"
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">

		<cfif structKeyExists(rc,"searchResults")  AND rc.searchResults.recordCount>

					<table class="table table-striped table-hover"  id="filteredreport">
						<thead>
							<tr>
								<th style="width:90px">ID</th>

								<th style="width:350px">Title</th>
								<th style="width:350px">Countries</th>
								<th>Regions</th>
								<th style="width:80px">Amount</th>
								<th>Status</th>
								<th style="width:50px">FY</th>

							</tr>
						</thead>

						<tbody>

							<cfoutput query="rc.searchResults">
							<tr class="sectionReview first">
								<td>
									<cfif rc.searchResults.activityStatusCode EQ 100 or rc.searchResults.activityStatusCode EQ 101>
										<a href=#event.buildLink("proposal.editproject.activityID." & rc.searchResults.ActivityID)# class="ttip" data-placement="right" title="Funding Mechanism: #rc.searchresults.implementMethod#<br>Funding Source: #rc.searchresults.subAccount#<br>CN Number: #rc.searchresults.AMCNnumber#<br>Project Owner: #rc.searchresults.owners#<br>Date Submitted: #dateformat(rc.searchresults.proposalSubmitDate, "mm/dd/yyyy")#<br>Obligated: #dollarFormat(rc.searchresults.obAmount)#">#uCase(proposalNumber)#</a>
									<cfelse>
										<a href=#event.buildLink("proposal.review.activityID." & rc.searchResults.ActivityID)# class="ttip" data-placement="right" title="Funding Mechanism: #rc.searchresults.implementMethod#<br>Funding Source: #rc.searchresults.subAccount#<br>CN Number: #rc.searchresults.AMCNnumber#<br>Project Owner: #rc.searchresults.owners#<br>Date Submitted: #dateformat(rc.searchresults.proposalSubmitDate, "mm/dd/yyyy")#<br>Obligated: #dollarFormat(rc.searchresults.obAmount)#">#uCase(proposalNumber)#</a>
									</cfif>
								</td>

								<td>
									<cfif rc.searchResults.activityStatusCode EQ 100 or rc.searchResults.activityStatusCode EQ 101>
										<a href=#event.buildLink("proposal.editproject.activityID." & rc.searchResults.ActivityID)# class="ttip" data-placement="right" title="#projecttitle#">#projectTitle#</a>
									<cfelse>
										<a href=#event.buildLink("proposal.review.activityID." & rc.searchResults.ActivityID)# class="ttip" data-placement="right" title="#projecttitle#">#projectTitle#</a>
									</cfif>
								</td>

								<td>#rc.searchresults.implementationCountry#</td>
								<td>#rc.searchresults.implementationRegion#</td>
								<td>#dollarFormat(rc.searchresults.projectAmount)#</td>
								<td>
									<cfif rc.searchresults.implementationStatus is "MOU Modification" or rc.searchresults.implementationStatus is "CN Re-notification" or rc.searchresults.implementationStatus is "CN Partial Hold">
										#rc.searchresults.implementationStatus#
									<cfelse>
										#rc.searchresults.statusname#
									</cfif>
								</td>
								<td>#rc.searchresults.fiscalyear#</td>

							</tr>
						</cfoutput>
					</tbody>

				</table>

			<cfelse>
				<!--- no records --->
				<h4>There are no records at this time.</h4>
			</cfif>


			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>







		<cfif structKeyExists(rc,"summary") and rc.summary.recordCount>	<br>

			<br />

					<table class="table table-striped table-hover">
						<thead>
							<tr>
 								<th>Project ID</th>
								<th>Proposal Title</th>
								<th>Funding Source</th>
								<th>CN #</th>
								<th>Fiscal Year<br />Appropriated</th>
								<th>Amount Requested ($USD)</th>
								<th>Status</th>

				<cfif listfind(rc.columns,"Countries")>
					<th>Countries</th>
				</cfif>
				<cfif listfind(rc.columns,"Regions")>
					<th>Regions</th>
				</cfif>
				<cfif listfind(rc.columns,"Implementing Orgs")>
					<th>Implementing Orgs</th>
				</cfif>
				<cfif listfind(rc.columns,"Implementing Partners")>
					<th>Implementing Partners</th>
					<th>Partner Details</th>
				</cfif>
				<cfif listfind(rc.columns,"Total Obligated")>
					<th>Total Obligated</th>
				</cfif>
				<cfif listfind(rc.columns,"Obligation Numbers")>
					<th>Obligation Numbers</th>
				</cfif>
				<cfif listfind(rc.columns,"AMCN Approved Date")>
					<th>AMCN Approved Date</th>
				</cfif>
				<cfif listfind(rc.columns,"Budget Funding Approved Date")>
					<th>Budget Funding Approved Date</th>
				</cfif>
				<cfif listfind(rc.columns,"Description")>
					<th>Description</th>
				</cfif>
				<cfif listfind(rc.columns,"Cleared Prelegal Date")>
					<th>Cleared Prelegal Date</th>
				</cfif>
				<cfif listfind(rc.columns,"Approved Date")>
					<th>Approved Date</th>
				</cfif>
				<cfif listfind(rc.columns,"AMCN Budget Submit Date")>
					<th>AMCN Budget Submit Date</th>
				</cfif>
				<cfif listfind(rc.columns,"AMCN Congress Submit Date")>
					<th>AMCN Congress Submit Date</th>
				</cfif>
				<cfif listfind(rc.columns,"Funding Mechanism")>
					<th>Funding Mechanism</th>
				</cfif>
				<cfif listfind(rc.columns,"Program Audience")>
					<th>Program Audience</th>
				</cfif>
				<cfif listfind(rc.columns,"Implementation Dates")>
					<th>Start Date</th>
					<th>End Date</th>
				</cfif>
				<cfif listfind(rc.columns,"Project Purpose")>
					<th>Project Purpose</th>
				</cfif>
				<cfif listfind(rc.columns,"Implementation Status")>
					<th>Implementation Status</th>
				</cfif>
				<cfif listfind(rc.columns,"Results Framework")>
					<th>Primary Result</th>
					<th>Secondary Results</th>
				</cfif>


							</tr>
						</thead>
						<tbody>
							<!--- <cfoutput> --->
							<cfoutput query="rc.summary">
							<tr>
								<td><a href=#event.buildLink("proposal.review.activityID." & rc.summary.ActivityID)#>#ucase(rc.summary.ProposalNumber)#</a></td>
								<td>#rc.summary.projectTitle#</td>
								<td>#rc.summary.fundingSources#</td>
								<td>#rc.summary.amcnnumber#</td>
								<td>#rc.summary.fiscalyear#</td>
								<td>#dollarFormat(rc.summary.projectAmount)#</td>
								<td>#rc.summary.statusname#</td>

								<cfif listfind(rc.columns,"Countries")>
									<td>#Country#</td>
								</cfif>
								<cfif listfind(rc.columns,"Regions")>
									<td>#region#</td>
								</cfif>
								<cfif listfind(rc.columns,"Implementing Orgs")>
									<td>#implementingOrgs#</td>
								</cfif>
								<cfif listfind(rc.columns,"Implementing Partners")>
									<td>
											 #ctfpartner#
									</td>
									<td>
										#implementingPartners#
									</td>
								</cfif>
								<cfif listfind(rc.columns,"Total Obligated")>
									<td>#totObAmount#</td>
								</cfif>
								<cfif listfind(rc.columns,"Obligation Numbers")>
									<td>#obligationnumbers#</td>
								</cfif>
								<cfif listfind(rc.columns,"AMCN Approved Date")>
									<td>#dateformat(AMCNApprovedDate, "mm/dd/yyyy")#</td>
								</cfif>
								<cfif listfind(rc.columns,"Budget Funding Approved Date")>
									<td>#dateformat(budgetfundapprovaldate, "mm/dd/yyyy")#</td>
								</cfif>
								<cfif listfind(rc.columns,"Description")>
									<td>#description#</td>
								</cfif>
								<cfif listfind(rc.columns,"Cleared Prelegal Date")>
									<td>#dateformat(clearedprelegaldate, "mm/dd/yyyy")#</td>
								</cfif>
								<cfif listfind(rc.columns,"Approved Date")>
									<td>#dateformat(proposalapproveddate, "mm/dd/yyyy")#</td>
								</cfif>
								<cfif listfind(rc.columns,"AMCN Budget Submit Date")>
									<td>#dateformat(amcnbudgetsubmitdate, "mm/dd/yyyy")#</td>
								</cfif>
								<cfif listfind(rc.columns,"AMCN Congress Submit Date")>
									<td>#dateformat(amcncongresssubmitdate, "mm/dd/yyyy")#</td>
								</cfif>
								<cfif listfind(rc.columns,"Funding Mechanism")>
									<td>#implementmethod#</td>
								</cfif>
								<cfif listfind(rc.columns,"Program Audience")>
									<td>#programAudience#</td>
								</cfif>
								<cfif listfind(rc.columns,"Implementation Dates")>
									<td>#dateformat(startdate, "mm/dd/yyyy")#</td>
									<td >#dateformat(enddate, "mm/dd/yyyy")#</td>
								</cfif>
								<cfif listfind(rc.columns,"Project Purpose")>
									<td>#projectObjective#</td>
								</cfif>
								<cfif listfind(rc.columns,"Implementation Status")>
									<td>#implementationStatus#</td>
								</cfif>
								<cfif listfind(rc.columns,"Results Framework")>
									<td>#primaryResult#</td>
									<td>#secondaryResults#</td>
								</cfif>

							</tr>
							</cfoutput>
						</tbody>
					</table>
					<!--- </cfoutput> --->
		<cfelse>
			<!--- no records --->
			<h4>There are no items at this time.</h4>

		</cfif>

	<!-- InstanceEndEditable -->
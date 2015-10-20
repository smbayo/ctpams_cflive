<cfinclude template="header.cfm">

	<cfoutput>

		<!--- view only after CN is approved 400 --->
<cfif len(trim(rc.proposal.AMCNApprovedDate)) >

<div class="row">
	<div class="col-md-4">

	<cfif ((isUserinRole('review activity') and getPlugin("SessionStorage").getVar("curUserAuth.programID") is rc.proposal.programid) or isUserinRole('confirm funding mechanism all proposals')) and rc.proposal.activitystatusid is 288>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-dot-circle-o fa-fw"></i> Confirm Funding Mechanism Type
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

			<form method="post" enctype="multipart/form-data" action="#event.buildLink('proposal.confirmfundingMechanism')#">
				<input type="hidden" name="activityID" value="#rc.activityID#">
				<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
				<input type="hidden" name="proposalNumber" value="#rc.proposal.proposalNumber#">
				<input type="hidden" name="sysUserID" value="#rc.sysUserID#">
							<!--- init var --->
						<table  class="table">
							<tr>
								<td colspan="2">
									<div class="form-group">
									<label>Funding Mechanism: </label>
									<select name="fundImpMechanismID" class="form-control" id="fundImpMechanismID" onChange="setCheckBoxes();">
										<option value="" <cfif (rc.proposal.fundImpMechanismID EQ "")>selected</cfif>>Select</option>
										<cfloop query="rc.FundMechTypes">
											<option value="#categoryID#" <cfif (rc.proposal.fundImpMechanismID EQ rc.FundMechTypes.categoryID)>selected</cfif>>#rc.FundMechTypes.name#</option>
										</cfloop>
									</select>
									</div>
								</td>
							</tr>
							<tr>
								<td>


										<div id="moudiv" style="display:none">
											<p>Upload the necessary documents for this funding mechanism, listed below.  Each item is mandatory.<br> When you have done so, check the boxes below for each document, and click the confirm button.
										</p>
										<p><b>For non-Assisted Acquisition IAAs (performed by USG employees)</b></p>
										<input type="checkbox" name="moucheck1" value="1"> <span id="moulabel">MOU</span><br>
										<input type="checkbox" name="moucheck1" value="1"> <span id="aalabel">Attachment A</span><br>
										<input type="checkbox" name="moucheck1" value="1"> <span id="balabel">Approved Budget</span><br>
										<input type="checkbox" name="moucheck1" value="1"> <span id="dslabel">DS 1921</span><br>
										<input type="checkbox" name="moucheck1" value="1"> <span id="sfwlabel">State First Waiver</span><br>

										<br><p><b>For Assisted Acquisition IAAs (performed by contractors at other Federal agencies) – please view PIB 2013-03 for more details.</b>
										</p>
										<input type="checkbox" name="moucheck2" value="1"> <span id="fmsalabel">FMS 7600A & Attachment A</span><br>
										<input type="checkbox" name="moucheck2" value="1"> <span id="fmsblabel">FMS 7600B & SOW</span><br>
										<input type="checkbox" name="moucheck2" value="1"> <span id="bpalabel">Best Procurement Approach</span><br>
										<input type="checkbox" name="moucheck2" value="1"> <span id="pocslabel">Other Agency POCs</span>
										</div>
										<div id="cagrantdiv" style="display:none">
											<p>This transaction is performed in SAMS.  Please prepare the necessary documents for this funding mechanism, listed below. When you have prepared them, check the boxes below for each document, and click the confirm button.
										</p>
										<p><b>For sole source awards, the following documents are needed.</b></p>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="moulabel">CN</span><br>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="aalabel">Sole Source Justification </span><br>


										<br><p><b>For solicitations through www.Grants.gov, the following documents are needed.</b>
										</p>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="fmsalabel">CN</span><br>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="fmsblabel">Request For Applications (RFA) – advertise project for potential grantees to bid</span><br>


										<br><p><b>Once winner is selected or sole source justification is approved, the remaining documents are needed.</b>
										</p>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="fmsalabel">Clearance Memo Signed by DAS authorizing effort</span><br>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="fmsblabel">Action Memo – formal request address to AQM to process grant</span><br>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="bpalabel">Grantee registration package – GrantSolutions and PMS registration forms</span><br>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="pocslabel">OMB formatted budget</span><br>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="bpalabel">Project proposal</span><br>
										<input type="checkbox" name="cagrantcheck" value="1"> <span id="pocslabel">Funding Memo required in Grantsolutions</span>
										</div>
										<div id="btfcdiv" style="display:none">
											<p>Verify the funding amount below, and enter POC information (name, email, phone) below.<br> When you have done so, click the confirm button.
										</p>
											<span id="falabel">Funding Amount: #dollarFormat(rc.proposal.BudgetCeilingAmount)#</span><br><br>
											<span id="btlabel">Budget Officer/FMO POC: </span> <input type="text"  id="bureauTransferPOC" name="bureauTransferPOC" value="#rc.proposal.bureauTransferPOC#" class="span7">
											<br>(<span id="btcftext"></span>)
										</div>
										<div id="contractdiv" style="display:none">
											<p>Upload the necessary documents for this funding mechanism, listed below.  Each item is mandatory.<br> When you have done so, check the boxes below for each document, and click the confirm button.
										</p>
											<input type="checkbox" name="contractcheck" value="1"> <span id="sowlabel">SOW</span><br>
											<input type="checkbox" name="contractcheck" value="1"> <span id="salabel">Approved Budget</span><br>
											<input type="checkbox" name="contractcheck" value="1"> <span id="salabel">Acquisition Plan </span>
										</div>


								</td>
							</tr>
						</table>
						<input type="submit" name="btnConfirmFundMech" value="Confirm Funding Mechanism and Submit to Budget" class="btn btn-primary btn-xs pull-right" />
				</form>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
	</cfif>
	<cfif len(rc.proposal.fundImpMechanismID)>

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-dot-circle-o fa-fw"></i> Funding Mechanism Type
					<div class="pull-right">

					</div>
				</div>
	            <!-- /.panel-heading -->
				<div class="panel-body">

	<cfif isUserinRole('administer funding') or isUserInRole("l funding clearance")>
	<form name="fundingForm" id="fundingForm" method="post" action="#event.buildLink('proposal.savefundingMechanism')#" enctype="multipart/form-data">
									<input type="hidden" name="activityID" value="#rc.activityID#">
									<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
									<input type="hidden" name="sysUserID" value="#rc.sysUserID#">
									<input type="hidden" name="isFClearanceComplete" value="#rc.isFClearanceComplete#">
									<input type="hidden" name="isMOUMod" value="#rc.isMOUMod#">

									<select name="fundImpMechanismID" id="fundImpMechanismID" class="form-control">
										<option value="" <cfif (rc.proposal.fundImpMechanismID EQ "")>selected</cfif>>Select</option>
										<cfloop query="rc.FundMechTypes">
											<option value="#categoryID#" <cfif (rc.proposal.fundImpMechanismID EQ rc.FundMechTypes.categoryID)>selected</cfif>>#rc.FundMechTypes.name#</option>
										</cfloop>
									</select>
<br>
							<input <cfif ( len(trim(rc.proposal.FundApprovedDate)) and not rc.isMOUMod )>disabled="true"</cfif>  type="submit" name="btnChangeFundMech" value="Change Funding Mechanism Type" class="btn btn-default btn-xs pull-right" >

						<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA" and not rc.isMOUMod and len(rc.proposal.fundapproveddate)>
							<input type="submit" name="btnMOUMod" value="Add MOU/IAA Modification" class="btn btn-default btn-xs pull-right">
						</cfif>
							<br>

	<cfelse>
							<b>#rc.proposal.fundimpmechanism#</b><br>



	</cfif>	<br>
	<cfif rc.proposal.fundImpMechanismID is 2>
						<p>
							Budget Officer/FMO POC, Bureau: #rc.proposal.bureauTransferPOC#
						</p>

	<cfelseif rc.proposal.fundImpMechanismID is 3>
						<p>
							Budget Officer/FMO POC, with traveler and travel dates, if applicable: #rc.proposal.bureauTransferPOC#
						</p>

	<cfelseif rc.proposal.fundImpMechanismID is 4>
						Required Documents for non-Assisted Acquisition IAAs (performed by USG employees):<br>
						<ul>
							<li>MOU</li>
							<li>Attachment A</li>
							<li>Approved Budget</li>
							<li>DS 1921</li>
							<li>State First Waiver</li>
						</ul> or, For non-Assisted Acquisition IAAs (performed by USG employees):
						<ul>
							<li>Form 7600A & Attachment A </li>
							<li>Form 7600B & SOW</li>
							<li>Best Procurement Approach</li>
							<li>Other Agency POCs</li>
						</ul>



	<cfelseif rc.proposal.fundImpMechanismID is 318>
						Required Documents:<br>
						For sole source awards, the following documents are needed:<br>
						<ul>
							<li>CN</li>
							<li>Sole Source Justification</li>
						</ul> or, for solicitations through www.Grants.gov, the following documents are needed:
						<ul>
							<li>CN</li>
							<li>Request For Applications (RFA) – advertise project for potential grantees to bid</li>
						</ul> Once winner is selected or sole source justification is approved, the remaining documents are needed:
						<ul>
							<li>Clearance Memo Signed by DAS authorizing effort</li>
							<li>Action Memo – formal request address to AQM to process grant</li>
							<li>Grantee registration package – GrantSolutions and PMS registration forms</li>
							<li>OMB formatted budget</li>
							<li>Project proposal</li>
							<li>Funding Memo required in Grantsolutions</li>
						</ul>

	</cfif>

				</div>
	            <!-- /.panel-body -->
			</div>
		</div>
	</div>


	<cfif len(rc.proposal.fundImpMechanismID)>

	<!--- <cfif isUserInRole("attach funding document")> --->
	<cfif isUserinRole('administer funding') or isUserInRole("attach funding document")>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-upload fa-fw"></i> Attach Funding Document
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">



											<label>Add Document <span class="text-danger">(Unclassified only - No SBU)</span><i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Document Title: A brief description that uniquely identifies the document."></i></label>
											<input type="text" placeholder="Document Title" name="documentTitle" value="" class="form-control">


											<input type="hidden" name="longdescription" value="" ><br>
									<span class="pull-right">


									<input type="submit" name="btnUploadDocument" value="Upload Document" class="btn btn-primary  btn-xs" id="uploadButton" style="display:none;" />

								</span>
								<br><input type="file" class="btn btn-default  btn-xs" name="documentUpload"  title="Search for a file to add" onclick="$('##uploadButton').show('fast', function() {});">
								<p class="text-muted"><br>Note: Document filenames should contain only letters and numbers, and not exceed 50 characters in length	</p>

					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>

	</cfif>



	</cfif>





	<!---end 6-col div --->
	</div>
	<div class="col-md-8">
	<cfif len(rc.proposal.previousFClearances) gt 0>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-check-circle-o fa-fw"></i> Previous Clearance
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">

						#rc.proposal.previousFClearances#
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
	</cfif>
</cfif>

<cfif len(trim(rc.proposal.AMCNApprovedDate)) >

	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-check-square-o fa-fw"></i> Funding Mechanism Clearance<cfif rc.isMOUMod> - MOU/IAA Modification</cfif>
					<div class="pull-right">

					</div>
				</div>
	            <!-- /.panel-heading -->
				<div class="panel-body">
						<input type="hidden" name="fundingReqDate" value="#dateFormat(now(),'mm/dd/yyyy')#">
						 <strong>Budget Funding Request Date: </strong>&nbsp; #dateFormat(rc.proposal.BudgetFundRequestDate,'mm/dd/yyyy')#


						<br /><br>

	<cfif rc.proposal.fundimpmechanism NEQ "Fund cite to post">

							<table class="table table-striped table-hover">


								<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA" or rc.proposal.fundimpmechanism EQ "Bureau Transfer">
									<tr>
										<td>Budget:</td>
										<cfif NOT isUserInRole("administer funding") or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
											<td>
												#rc.budgetClearanceStatus#
											</td>
											<td>
												<cfif isDate(rc.budgetClearanceDate)>#dateFormat(rc.budgetClearanceDate,'mm/dd/yyyy')#</cfif>
											</td>
											<td>
												#rc.budgetClearanceComment#
											</td>
										<cfelse>
											<td>
												<select name="budgetClearanceStatus"  class="form-control" autocomplete="off">
													<option value="" <cfif rc.budgetClearanceStatus EQ "">SELECTED</cfif>>SELECT:</option>
													<option value="Pending" <cfif rc.budgetClearanceStatus EQ "Pending">SELECTED</cfif>>Pending</option>
													<option value="Yes" <cfif rc.budgetClearanceStatus EQ "Yes">SELECTED</cfif>>Yes</option>
													<option value="No" <cfif rc.budgetClearanceStatus EQ "No">SELECTED</cfif>>No</option>
												</select>
											</td>
											<td colspan="2"><input type="text" name="budgetClearanceComment" value="#rc.budgetClearanceComment#"  class="form-control"></td>
											<input type="hidden" name="budgetClearanceID" value="#rc.budgetClearanceID#">
										</cfif>
									</tr>
	</cfif>



	<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA">
									<tr>
										<td>Legal (L):</td>
										<cfif (NOT isUserInRole("administer funding") and not isUserInRole("l funding clearance"))
											OR (isUserInRole("administer funding") and (rc.legalClearanceStatus EQ "Yes" OR rc.legalClearanceStatus EQ "No")) or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
											<td>
											 	#rc.legalClearanceStatus#
											</td>
											<td>
												<cfif isDate(rc.legalClearanceDate)>#dateFormat(rc.legalClearanceDate,'mm/dd/yyyy')#</cfif>
											</td>
											<td>
												#rc.legalClearanceComment#
											</td>
										<cfelse>
											<td>
												<select name="legalClearanceStatus" class="form-control" autocomplete="off">
													<option value="" <cfif rc.legalClearanceStatus EQ "">SELECTED</cfif>>SELECT:</option>
													<option value="Pending" <cfif rc.legalClearanceStatus EQ "Pending">SELECTED</cfif>>Pending</option>
													<cfif isUserInRole("l funding clearance")>
													<option value="Yes" <cfif rc.legalClearanceStatus EQ "Yes">SELECTED</cfif>>Yes</option>
													<option value="No" <cfif rc.legalClearanceStatus EQ "No">SELECTED</cfif>>No</option>
													</cfif>
												</select>
											</td>
											<td colspan="2"><input type="text" name="legalClearanceComment" value="#rc.legalClearanceComment#"  class="form-control"></td>
											<input type="hidden" name="legalClearanceID" value="#rc.legalClearanceID#">
										</cfif>
									</tr>
	</cfif>

	<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA" or rc.proposal.fundimpmechanism EQ "Grant" or rc.proposal.fundimpmechanism EQ "Cooperative Agreement">
									<tr>
										<td>Front Office (F/O):</td>
										<cfif NOT isUserInRole("administer funding") or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
											<td>
												#rc.foClearanceStatus#
											</td>
											<td>
												<cfif isDate(rc.foClearanceDate)>#dateFormat(rc.foClearanceDate,'mm/dd/yyyy')#</cfif>
											</td>
											<td>
												#rc.foClearanceComment#
											</td>
										<cfelse>
											<td>
												<select name="foClearanceStatus"  class="form-control" autocomplete="off">
													<option value="" <cfif rc.foClearanceStatus EQ "">SELECTED</cfif>>SELECT:</option>
													<option value="Pending" <cfif rc.foClearanceStatus EQ "Pending">SELECTED</cfif>>Pending</option>
													<option value="Yes" <cfif rc.foClearanceStatus EQ "Yes">SELECTED</cfif>>Yes</option>
													<option value="No" <cfif rc.foClearanceStatus EQ "No">SELECTED</cfif>>No</option>
												</select>
											</td>
											<td colspan="2"><input type="text" name="foClearanceComment" value="#rc.foClearanceComment#"  class="form-control"></td>
											<input type="hidden" name="foClearanceID" value="#rc.foClearanceID#">
										</cfif>
									</tr>
	</cfif>



	<cfif (rc.proposal.fundimpmechanism EQ "MOU/IAA" or rc.proposal.fundimpmechanism EQ "Grant" or rc.proposal.fundimpmechanism EQ "Cooperative Agreement") and not rc.isMOUMod>
									<tr>
										<td >AQM:</td>
										<cfif NOT isUserInRole("administer funding")  or not len(rc.proposal.fundapproveddate) is 0>
										<td>
											#rc.aqmClearanceStatus#
										</td>
										<td>
											<cfif isDate(rc.aqmClearanceDate)>#dateFormat(rc.aqmClearanceDate,'mm/dd/yyyy')#</cfif>
										</td>
										<td>
											#rc.aqmClearanceComment#
										</td>
										<cfelse>
										<td>
											<select name="aqmClearanceStatus"  class="form-control" autocomplete="off">
												<option value="" <cfif rc.aqmClearanceStatus EQ "">SELECTED</cfif>>SELECT:</option>
												<option value="Pending" <cfif rc.aqmClearanceStatus EQ "Pending">SELECTED</cfif>>Pending</option>
												<option value="Yes" <cfif rc.aqmClearanceStatus EQ "Yes">SELECTED</cfif>>Yes</option>
												<option value="No" <cfif rc.aqmClearanceStatus EQ "No">SELECTED</cfif>>No</option>
											</select>
										</td>
										<td colspan="2"><input type="text" name="aqmClearanceComment" value="#rc.aqmClearanceComment#"  class="form-control"></td>
										<input type="hidden" name="aqmClearanceID" value="#rc.aqmClearanceID#">
										</cfif>
									</tr>
	</cfif>

	<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA">
									<tr>
										<td>Agency:</td>


										<cfif NOT isUserInRole("administer funding") or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
										<td>
											#rc.agencyClearanceStatus#
										</td>
										<td>
											<cfif isDate(rc.agencyClearanceDate)>#dateFormat(rc.agencyClearanceDate,'mm/dd/yyyy')#</cfif>
										</td>
										<td>
											#rc.agencyClearanceComment#
										</td>
										<cfelse>
										<td>
											<select name="agencyClearanceStatus"  class="form-control" autocomplete="off">
												<option value="" <cfif rc.agencyClearanceStatus EQ "">SELECTED</cfif>>SELECT:</option>
												<option value="Pending" <cfif rc.agencyClearanceStatus EQ "Pending">SELECTED</cfif>>Pending</option>
												<option value="Yes" <cfif rc.agencyClearanceStatus EQ "Yes">SELECTED</cfif>>Yes</option>
												<option value="No" <cfif rc.agencyClearanceStatus EQ "No">SELECTED</cfif>>No</option>
											</select>
										</td>
										<td colspan="2"><input type="text" name="agencyClearanceComment" value="#rc.agencyClearanceComment#"  class="form-control"></td>
										<input type="hidden" name="agencyClearanceID" value="#rc.agencyClearanceID#">
										</cfif>
									</tr>
								</cfif>

						</table>
	</cfif>


	<cfif isUserinRole('administer funding') or isUserinRole('l funding clearance')>
							<input <cfif ( len(trim(rc.proposal.FundApprovedDate)) and not rc.isMOUMod )>disabled="true"</cfif> type="submit" name="btnUpdateClearanceStatus" value="Update Date &amp; Clearance Status" class="btn btn-default btn-xs pull-right" />
	</cfif>

					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>



	<cfif len(trim(rc.proposal.BudgetFundRequestDate)) and rc.isFClearanceComplete  and isUserinRole('administer funding') and (NOT len(trim(rc.proposal.FundApprovedDate)) or (rc.isMOUModClearanceComplete and rc.isMOUMod))>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-list-alt fa-fw"></i> Budget Funding Approval
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">



					<cfif NOT len(trim(rc.proposal.FundApprovedDate))>

									<input type="submit" name="fundApproval" value="Save and Complete Funding/Implementation" class="btn btn-primary btn-xs pull-right" />


					<cfelseif rc.isMOUModClearanceComplete and rc.isMOUMod>

									<input type="submit" name="saveMouMod" value="Save and Complete MOU/IAA Modification" class="btn btn-primary btn-xs pull-right"/>

					</cfif>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>


	</cfif>
				<input type="hidden" id="fundingApprovalDate" name="fundingApprovalDate" value="#dateFormat(now(),'yyyy-mm-dd')#" />
			</form>
</cfif>

<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-files-o fa-fw"></i> Funding Documents
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
						<!--- START ACCORDION --->
						<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
							  <div class="panel panel-default">
							    <div class="panel-heading" role="tab" id="heading-activedocs">
							      <h4 class="panel-title">
							        <a class="collapsed" data-toggle="collapse" data-parent="##accordion" href="##collapse-activedocs" aria-expanded="false" aria-controls="collapse-activedocs">
							           Documents
							        </a>
							      </h4>
							    </div>
							    <div id="collapse-activedocs" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif> in" role="tabpanel" aria-labelledby="heading-activedocs">
							      <div class="panel-body">


					<cfif structKeyExists(rc,"attachedFiles") AND rc.attachedFiles.recordcount GT 0>
					<table class="table table-striped table-hover">

							<cfset docCnt = 1>
							<cfloop query="rc.attachedFiles">
								<tr>
									<td><span id="#attachedFileID#link"><b>#docCnt#.</b> <a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.attachedFiles.AttachedFileID)# data-toggle="tooltip" data-placement="top" title="#rc.attachedFiles.UploadedFileName# uploaded: #dateformat(rc.attachedFiles.AttachedFileDate, 'mm/dd/yyyy')#" data-placement="right"><i class="fa fa-file-text-o"></i> #rc.attachedFiles.Name#</a>
										</span>
									<span id="#AttachedFileID#" style="display:none;">
														<form name="docnameForm" id="docnameForm" class="form-inline"  method="post" action="#event.buildLink('proposal.renameDocument')#">
														<input type="hidden" name="activityid" value="#rc.activityID#">
														<input type="hidden" name="AttachedFileID" value="#AttachedFileID#">
														<input type="hidden" name="target" value="fundimpmechanism">
														<input type="text" name="name" value="#rc.attachedFiles.Name#" required="true" class="form-control input-sm" style="width:150px">&nbsp;
														<span class="pull-right">
														<!--- <input type="submit" name="Edit" value="Save" class="btn btn-xs btn-primary"> --->
														<button type="submit" name="Edit" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Save Name Change"><i class="fa fa-check fa-fw"></i></button>
														&nbsp;<a href="javascript:void(0)" onclick="$('###attachedFileID#').toggle('fast', function() {});$('###attachedFileID#link').toggle('fast', function() {});" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="top" title="Cancel Name Change"><i class="fa fa-close fa-fw"></i></a>
														</span>
														</form>
													</span></td>
										<cfif IsUserInRole("attach funding document")>
										<td style="width:120px">
											<span class="pull-right">
												&nbsp;<a href="javascript:void(0)" onclick="$('###attachedFileID#').toggle('fast', function() {});$('###attachedFileID#link').toggle('fast', function() {});" class="btn btn-default btn-xs" data-toggle="tooltip" data-placement="top" title="Edit Document Name"><i class="fa fa-edit fa-fw"></i></a>
												&nbsp;<a href=#event.buildLink("proposal.archivefile.AttachedFileID." & rc.attachedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=fundImpMechanism")# class="btn btn-warning  btn-xs" data-toggle="tooltip" data-placement="top" title="Archive Document"><i class="fa fa-level-down fa-fw"></i></a>

												<cfif  IsUserInRole("deactivate files")>
												 	&nbsp;<a href=#event.buildLink("proposal.deactivatefile.AttachedFileID." & rc.attachedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=fundImpMechanism")# class="btn btn-danger  btn-xs" data-toggle="tooltip" data-placement="top" title="Delete Document" onClick="if(confirm('WARNING: You will not be able to access this document once deactivated. Do you want to continue?')) return true; else return false;"><i class="fa fa-eraser fa-fw"></i></a>
												</cfif>
											</span>
											</td>
										</cfif>
										</span>


								</tr>
								<cfset docCnt = docCnt + 1>
							</cfloop>
					</table>
					<cfelse>
						No documents attached
					</cfif>
					      </div>
					    </div>
					  </div>

	<cfif structKeyExists(rc,"archivedFiles") AND rc.archivedFiles.recordcount GT 0>
							<div class="panel panel-default">
							    <div class="panel-heading" role="tab" id="heading-archivedocs">
							      <h4 class="panel-title">
							        <a class="collapsed" data-toggle="collapse" data-parent="##accordion" href="##collapse-archivedocs" aria-expanded="false" aria-controls="collapse-archivedocs">
							           Archived Documents
							        </a>
							      </h4>
							    </div>
							    <div id="collapse-archivedocs" class="panel-collapse <cfif not (#CGI.HTTP_USER_AGENT# CONTAINS "MSIE 7.0" or #CGI.HTTP_USER_AGENT# CONTAINS "MSIE 8.0")>collapse</cfif>" role="tabpanel" aria-labelledby="heading-archivedocs">
							      <div class="panel-body">

							<table class="table table-striped table-hover" id="archivedTable">

									<cfset docCnt = 1>
									<cfloop query="rc.archivedFiles">
										<tr>
											<td>
										<b>#docCnt#.</b> <a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.archivedFiles.AttachedFileID)# title="#rc.archivedFiles.UploadedFileName# uploaded: #dateformat(rc.archivedFiles.AttachedFileDate, 'mm/dd/yyyy')#" data-toggle="tooltip" data-placement="top"><i class="fa fa-file-text-o"></i> #rc.archivedFiles.Name#</a>
										</td>
												<cfif IsUserInRole("attach am/cn document")>
												<td style="width:100px">
													<span class="pull-right">
														&nbsp;<a href=#event.buildLink("proposal.unarchivefile.AttachedFileID." & rc.archivedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=fundImpMechanism")#  class="btn btn-warning  btn-xs" data-toggle="tooltip" data-placement="top" title="Un-Archive Document"><i class="fa fa-level-up fa-fw"></i></a>
														<cfif  IsUserInRole("deactivate files")>
														 	&nbsp;<a href=#event.buildLink("proposal.deactivatefile.AttachedFileID." & rc.archivedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=fundImpMechanism")# class="btn btn-danger  btn-xs" data-toggle="tooltip" data-placement="top" title="Delete Document"><i class="fa fa-eraser fa-fw"></i></a>
														</cfif>
													</span>
												</td>
												</cfif>

										<cfset docCnt = docCnt + 1>
									</tr>
									</cfloop>
							</table>
								</div>
						    </div>
						  </div>
	</cfif>


						</div>
						<!--- END ACCORDION --->
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>

	<!---end 6-col div --->
	</div>
</div>




<cfelse>
			<h4>The activity has not yet reached this stage in the approval process.</h4>
</cfif>

</cfoutput>




<cfif ((isUserinRole('review activity') and getPlugin("SessionStorage").getVar("curUserAuth.programID") is rc.proposal.programid) or isUserinRole('confirm funding mechanism all proposals')) and rc.proposal.activitystatusid is 288>
	<script type = "text/javascript">
		function setCheckBoxes() {
			var fundingType = document.getElementById("fundImpMechanismID").value;

			if(fundingType == 4) {
				$('#moudiv').show('fast', function() { });
				$('#btfcdiv').hide('fast', function() { });
				$('#contractdiv').hide('fast', function() { });
				$('#cagrantdiv').hide('fast', function() { });

			} else if (fundingType == 2 || fundingType == 3) {
				$('#moudiv').hide('fast', function() { });
				$('#btfcdiv').show('fast', function() { });
				$('#contractdiv').hide('fast', function() { });
				$('#cagrantdiv').hide('fast', function() { });
				if (fundingType == 2) {
					document.getElementById( "btcftext" ).innerHTML = "include Bureau";
				} else {
					document.getElementById( "btcftext" ).innerHTML = "include dates of travel and name of traveler, if applicable";

				}

			} else if (fundingType == 5 || fundingType == 347) {
				$('#moudiv').hide('fast', function() { });
				$('#btfcdiv').hide('fast', function() { });
				$('#contractdiv').hide('fast', function() { });
				$('#cagrantdiv').show('fast', function() { });

			} else if (fundingType == 318) {
				$('#moudiv').hide('fast', function() { });
				$('#btfcdiv').hide('fast', function() { });
				$('#contractdiv').show('fast', function() { });
				$('#cagrantdiv').hide('fast', function() { });

			} else {
				$('#moudiv').hide('fast', function() { });
				$('#btfcdiv').hide('fast', function() { });
				$('#contractdiv').hide('fast', function() { });
				$('#cagrantdiv').hide('fast', function() { });

			}

		}

		$(document).ready(function() {
			setCheckBoxes();
		});
	</script>
</cfif>


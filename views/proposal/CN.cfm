<cfinclude template="header.cfm">
<cfoutput>

<cfif len(trim(rc.proposal.proposalApprovedDate)) AND rc.activecn.recordCount>

		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-link fa-fw"></i> CN Projects
						<div class="pull-right">
							<cfif rc.activitycns.recordcount gt 1>
										<div class="btn-group">
										    <button class="btn btn-default dropdown-toggle btn-xs" data-toggle="dropdown" aria-expanded="false">
										      Other CNs #uCase(rc.proposal.proposalnumber)# is Linked To
										      <span class="caret"></span>
										    </button>
										    <ul class="dropdown-menu" role="menu">
											   <cfloop query="rc.activitycns">
												  <cfif rc.cnid is not rc.activitycns.cnid>
										     	 <li> <a href=#event.buildLink("proposal.cn.activityID." & rc.proposal.ActivityID & ".cnid." & rc.activitycns.cnid)#><cfif len(rc.activitycns.cnnumber) gt 0>#rc.activitycns.cnnumber#<cfelse>CN Number Not Entered</cfif><cfif len(rc.activitycns.cntitle) gt 0> - #rc.activitycns.cntitle#</cfif></a></li>
										     	 </cfif>
										      </cfloop>
										    </ul>
										  </div>
							</cfif>
						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
						<b>CN Number:</b><cfif len(rc.activecn.cnnumber) gt 0>#rc.activecn.cnnumber#<cfelse>Not Yet Assigned</cfif><br>
						<cfif len(rc.activecn.cntitle) gt 0><b>CN Name:</b> #rc.activecn.cntitle#<br></cfif><br>
			<cfif rc.cnActivities.recordcount gt 0>
								<cfloop query="rc.cnActivities">
									<a href=#event.buildLink("proposal.cn.activityID." & rc.cnActivities.ActivityID)# data-toggle="tooltip" data-placement="top" title="#rc.cnActivities.projecttitle#<br>#dollarformat(rc.cnActivities.budgetceilingamount)#" data-placement="right">#uCase(rc.cnActivities.proposalNumber)#</a><cfif rc.cnActivities.recordcount - rc.cnActivities.currentrow gt 0>, </cfif>
								</cfloop>
			</cfif>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
<div class="row">
	<div class="col-md-4">
			<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-files-o fa-fw"></i> CN Documents
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
											<td><span id="#attachedFileID#link"><b>#docCnt#.</b> <a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.attachedFiles.AttachedFileID)# data-toggle="tooltip" data-placement="top" title="#rc.attachedFiles.UploadedFileName#; uploaded: #dateformat(rc.attachedFiles.AttachedFileDate, 'mm/dd/yyyy')#" data-placement="right"><i class="fa fa-file-text-o"></i> #rc.attachedFiles.Name#</a></span>
											<span id="#AttachedFileID#" style="display:none;">
														<form name="docnameForm" id="docnameForm" class="form-inline"  method="post" action="#event.buildLink('proposal.renameDocument')#">
														<input type="hidden" name="activityid" value="#rc.activityID#">
														<input type="hidden" name="cnid" value="#rc.cnID#">
														<input type="hidden" name="AttachedFileID" value="#AttachedFileID#">
														<input type="hidden" name="target" value="cn">
														<input type="text" name="name" value="#rc.attachedFiles.Name#" required="true" class="form-control input-sm" style="width:150px">&nbsp;
														<span class="pull-right">
														<!--- <input type="submit" name="Edit" value="Save" class="btn btn-xs btn-primary"> --->
														<button type="submit" name="Edit" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Save Name Change"><i class="fa fa-check fa-fw"></i></button>
														&nbsp;<a href="javascript:void(0)" onclick="$('###attachedFileID#').toggle('fast', function() {});$('###attachedFileID#link').toggle('fast', function() {});" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="top" title="Cancel Name Change"><i class="fa fa-close fa-fw"></i></a>
														</span>
														</form>
													</span>
												</td>
												<cfif IsUserInRole("attach am/cn document")>
												<td style="width:120px">
													<span class="pull-right">
														&nbsp;<a href="javascript:void(0)" onclick="$('###attachedFileID#').toggle('fast', function() {});$('###attachedFileID#link').toggle('fast', function() {});" class="btn btn-default btn-xs" data-toggle="tooltip" data-placement="top" title="Edit Document Name"><i class="fa fa-edit fa-fw"></i></a>
														&nbsp;<a href=#event.buildLink("proposal.archivefile.AttachedFileID." & rc.attachedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=cn")# class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="top" title="Archive Document"><i class="fa fa-level-down fa-fw"></i></a>

														<cfif  IsUserInRole("deactivate files")>
														 	&nbsp;<a href=#event.buildLink("proposal.deactivatefile.AttachedFileID." & rc.attachedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=cn")# class="btn btn-danger btn-xs" data-toggle="tooltip" data-placement="top" title="Delete Document" onClick="if(confirm('WARNING: You will not be able to access this document once deactivated. Do you want to continue?')) return true; else return false;"><i class="fa fa-eraser fa-fw"></i></a>
														</cfif>
													</span>

												</td>
												</cfif>
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
												<b>#docCnt#.</b>  <a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.archivedFiles.AttachedFileID)# title="#rc.archivedFiles.UploadedFileName# uploaded: #dateformat(rc.archivedFiles.AttachedFileDate, 'mm/dd/yyyy')#" data-toggle="tooltip" data-placement="top"><i class="fa fa-file-text-o"></i> #rc.archivedFiles.Name#</a>
												</td>
														<cfif IsUserInRole("attach am/cn document")>
														<td style="width:100px">
															<span class="pull-right">
																&nbsp;<a href=#event.buildLink("proposal.unarchivefile.AttachedFileID." & rc.archivedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=cn")#  class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="top" title="Un-Archive Document"><i class="fa fa-level-up fa-fw"></i></a>
																<cfif  IsUserInRole("deactivate files")>
																 	&nbsp;<a href=#event.buildLink("proposal.deactivatefile.AttachedFileID." & rc.archivedFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=cn")# class="btn btn-danger btn-xs" data-toggle="tooltip" data-placement="top" title="Delete Document"><i class="fa fa-eraser fa-fw"></i></a>
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

				<cfif isUserInRole("attach am/cn document")>
		<div class="row">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-upload fa-fw"></i> Attach CN Documents
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
									<form name="amcnForm" id="amcnForm" class="formular"  method="post" action="#event.buildLink('proposal.submitCN')#" enctype="multipart/form-data">
											<input type="hidden" name="activityID" value="#rc.proposal.activityID#">
											<input type="hidden" name="cntitle" value="#rc.activecn.cntitle#">
											<input type="hidden" name="cnnumber" value="#rc.activecn.cnnumber#">
											<input type="hidden" name="cnID" value="#rc.cnid#">
											<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
											<input type="hidden" name="sysUserID" value="#rc.sysUserID#">
											<input type="hidden" name="roleName" value="#rc.roleName#">

													<label>Add Document <span class="text-danger">(Unclassified only - No SBU)</span><i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Document Title: A brief description that uniquely identifies the document."></i></label>
													<input type="text" placeholder="Document Title" name="documentTitle" value="" class="form-control" required="true">


													<input type="hidden" name="longdescription" value="" ><br>
											<span class="pull-right">
										<cfif NOT len(trim(rc.activecn.BudgetSubmitDate))>
											<input type="submit" name="submitCN" value="Upload Initial CN Document" class="btn btn-primary  btn-xs" id="uploadButton" style="display:none;" />

										<cfelse>

											<input type="submit" name="saveCommentDoc" value="Upload Document" class="btn btn-primary  btn-xs" id="uploadButton" style="display:none;" />
										</cfif>
										</span>
										<br><input type="file" class="btn btn-default  btn-xs" name="documentUpload"  title="Search for a file to add" required="true" onclick="$('##uploadButton').show('fast', function() {});">
										<p class="text-muted"><br>Note: Document filenames should contain only letters and numbers, and not exceed 50 characters in length	</p>

							</form>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
		</cfif>




			<cfif IsUserInRole("post am/cn comments")>
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-comments-o fa-fw"></i> CN Comments
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
											No CN comments added yet
										</cfif>
						</div>
			            <!-- /.panel-body -->
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-comment-o fa-fw"></i> Add CN Comments
							<div class="pull-right">

							</div>
						</div>
			            <!-- /.panel-heading -->
						<div class="panel-body">
								<form name="legalForm" id="legalForm" class="formular"  method="post" action="#event.buildLink('proposal.saveCNComment')#" enctype="multipart/form-data">
									<input type="hidden" name="activityID" value="#rc.activityID#">
									<input type="hidden" name="cnID" value="#rc.cnID#">

									<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
									<input type="hidden" name="sender" value="#rc.roleName#">
									<input type="hidden" name="sysUserID" value="#rc.sysUserID#">

											    	<textarea name="prelegalComment" rows="5" class="form-control" required="true"></textarea><br>

											  	<button type="submit" class="btn btn-info pull-right btn-xs" name="addComment" value="Add Comment"><i class="icon-bullhorn icon-white"></i> Add Comment</button>


								</form>
						</div>
			            <!-- /.panel-body -->
					</div>
				</div>
			</div>
			</cfif>


	</div>
	<div class="col-md-8">
			<cfif rc.attachedFiles.recordCount or rc.archivedFiles.recordcount or rc.relatedfiles.recordcount>
			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-check-square-o fa-fw"></i> CN Clearance
							<div class="pull-right">

							</div>
						</div>
			            <!-- /.panel-heading -->
						<div class="panel-body">
					<!--- only proceed with am/cn clearance after program has submitted initial document --->

						<form name="cnClearanceUpdate" method="post" action="#event.buildLink('proposal.saveCN')#" enctype="multipart/form-data">
							<input type="hidden" name="activityID" value="#rc.proposal.activityID#">
							<input type="hidden" name="cntitle" value="#rc.activecn.cntitle#">
							<input type="hidden" name="cnID" value="#rc.cnid#">
							<!--- <input type="hidden" name="cnnumber" value="#rc.activecn.cnnumber#"> --->
							<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
							<input type="hidden" name="sysUserID" value="#rc.sysUserID#">
							<input type="hidden" name="isCNClearanceComplete" value="#rc.isCNClearanceComplete#">

								<cfif not len(trim(rc.proposal.AMCNApprovedDate))>
									<ul class="text-warning">
										<li>Click the "Update Clearance Status" button to save changes and notes. </li>
										<li>Set clearance status to "Pending" after answering a question </li>
										<li>In-line notes next to clearances are limited to 240 characters and can be overwritten. </li>
										<li>Additional, full-length comments which will be permanently saved can be entered at the bottom of the page.  </li>
										<li>All comments will be seen by other CT staff, L, F, H, and S/P. </li>
										<li>CN drafts with edits or tracked changes can be uploaded at the top of the page.</li>
										<li>A list of system-generated notification emails can be be accessed in the Help section</li>
									</ul>
								</cfif>


									<table class="table table-striped table-hover">
										<tr>
											<td style="width:170px"></td>
											<td style="width:200px"></td>
											<td style="width:90px"></td>
											<td></td>
										</tr>
										<tr>
											<td>CT/EX:</td>

											<cfif isUserInRole("administer am/cn")>
												<td>
													<select name="sctCoordinatorStatus" class="form-control">
														<option value="" <cfif rc.sctCoordinatorStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Pending" <cfif rc.sctCoordinatorStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Not Yet Selected" <cfif rc.sctCoordinatorStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Yes" <cfif rc.sctCoordinatorStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="No" <cfif rc.sctCoordinatorStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.sctCoordinatorStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.sctCoordinatorStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.sctCoordinatorStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<option value="On Hold" <cfif rc.sctCoordinatorStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="sctCoordinatorComment" value="#rc.sctCoordinatorComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.sctCoordinatorStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td style="width:80px">
													<select name="sctCoordinatorStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.sctCoordinatorStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="sctCoordinatorComment" value="#rc.sctCoordinatorComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<!--- <td colspan="2"> --->
												<td>
													#rc.sctCoordinatorStatus#
												</td>
												<td>
													<cfif isDate(rc.sctCoordinatorDate)>#dateFormat(rc.sctCoordinatorDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
												 	#rc.sctCoordinatorComment#
												</td>
											</cfif>
											<input type="hidden" name="sctCoordinatorID" value="#rc.sctCoordinatorID#">
										</tr>
										<tr>
											<td>Legal (L):</td><!---Legal::--->
											<cfif (isUserInRole("administer am/cn") or isUserInRole("l clearance")) and not (rc.legalReviewStatus EQ "Yes" or rc.legalReviewStatus EQ "No")>
												<td>
													<select name="legalReviewStatus" class="form-control">
															<option value="" <cfif rc.legalReviewStatus EQ "">SELECTED</cfif>>SELECT:</option>
															<option value="Pending" <cfif rc.legalReviewStatus EQ "Pending">SELECTED</cfif>>Pending</option>
															<option value="Not Yet Selected" <cfif rc.legalReviewStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<cfif isUserInRole("l clearance")>
															<option value="Yes" <cfif rc.legalReviewStatus EQ "Yes">SELECTED</cfif>>Yes</option>
															<option value="No" <cfif rc.legalReviewStatus EQ "No">SELECTED</cfif>>No</option>
														</cfif>
															<option value="Questions for Budget" <cfif rc.legalReviewStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
															<option value="Questions for Program" <cfif rc.legalReviewStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
															<option value="Questions for Both" <cfif rc.legalReviewStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
															<option value="On Hold" <cfif rc.legalReviewStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>

													</select>
												</td>
												<td colspan="2"><input type="text" name="legalReviewComment" value="#rc.legalReviewComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.legalReviewStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="legalReviewStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.legalReviewStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="legalReviewComment" value="#rc.legalReviewComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.legalReviewStatus#
												</td>
												<td>
													<cfif isDate(rc.legalReviewDate)>#dateFormat(rc.legalReviewDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
													#rc.legalReviewComment#

												</td>
											</cfif>
											<input type="hidden" name="legalReviewID" value="#rc.legalReviewID#">
										</tr>
										<tr>
											<td>Foreign Assistance (F):</td>
											<cfif isUserInRole("administer am/cn") or isUserInRole("f clearance")>
												<td>
													<select name="foreignAssistanceStatus"  class="form-control">
														<option value="" <cfif rc.foreignAssistanceStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.foreignAssistanceStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.foreignAssistanceStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.foreignAssistanceStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="No" <cfif rc.foreignAssistanceStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.foreignAssistanceStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.foreignAssistanceStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.foreignAssistanceStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<cfif isUserInRole("administer am/cn")>
															<option value="On Hold" <cfif rc.foreignAssistanceStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
														</cfif>
													</select>
												</td>
												<td colspan="2"><input type="text" name="foreignAssistanceComment" value="#rc.foreignAssistanceComment#" class="form-control" maxlength="240"></td>

											<cfelseif (rc.foreignAssistanceStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="foreignAssistanceStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.foreignAssistanceStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="foreignAssistanceComment" value="#rc.foreignAssistanceComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.foreignAssistanceStatus#
												</td>
												<td>
													<cfif isDate(rc.foreignAssistanceDate)>#dateFormat(rc.foreignAssistanceDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
													#rc.foreignAssistanceComment#
												</td>
											</cfif>
											<input type="hidden" name="foreignAssistanceID" value="#rc.foreignAssistanceID#">
										</tr>
										<tr>
											<td><!--- Congressional Affairs --->Legislative Affairs (H):</td>
											<cfif isUserInRole("administer am/cn")  or isUserInRole("h clearance")>
												<td>
													<select name="congressionalAffairsStatus" class="form-control">
														<option value="" <cfif rc.congressionalAffairsStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.congressionalAffairsStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.congressionalAffairsStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.congressionalAffairsStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="No" <cfif rc.congressionalAffairsStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.congressionalAffairsStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.congressionalAffairsStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.congressionalAffairsStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<cfif isUserInRole("administer am/cn")>
															<option value="On Hold" <cfif rc.congressionalAffairsStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
														</cfif>
													</select>
												</td>
												<td colspan="2"><input type="text"  name="congressionalAffairsComment"  value="#rc.congressionalAffairsComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.congressionalAffairsStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="congressionalAffairsStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.congressionalAffairsStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="congressionalAffairsComment" value="#rc.congressionalAffairsComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.congressionalAffairsStatus#
												</td>
												<td>
													<cfif isDate(rc.congressionalAffairsDate)>#dateFormat(rc.congressionalAffairsDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
													#rc.congressionalAffairsComment#
												</td>

											</cfif>
											<input type="hidden" name="congressionalAffairsID" value="#rc.congressionalAffairsID#">
										</tr>
										<tr>
											<td>Policy Planning (S/P):</td>
											<cfif isUserInRole("administer am/cn")  or isUserInRole("s/p clearance")>
												<td>
													<select name="policyPlanningStatus" class="form-control">
														<option value="" <cfif rc.policyPlanningStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.policyPlanningStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.policyPlanningStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.policyPlanningStatus EQ "Yes">SELECTED</cfif>><cfif rc.proposal.programid is 4>Info<cfelse>Yes</cfif></option>
														<option value="No" <cfif rc.policyPlanningStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.policyPlanningStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.policyPlanningStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.policyPlanningStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<cfif isUserInRole("administer am/cn")>
															<option value="On Hold" <cfif rc.policyPlanningStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
														</cfif>
													</select>
												</td>
												<td colspan="2"><input type="text"  name="policyPlanningComment" value="#rc.policyPlanningComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.policyPlanningStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="policyPlanningStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.policyPlanningStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="policyPlanningComment" value="#rc.policyPlanningComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.policyPlanningStatus#
												</td>
												<td>
													<cfif isDate(rc.policyPlanningDate)>#dateFormat(rc.policyPlanningDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
													#rc.policyPlanningComment#
												</td>
											</cfif>
											<input type="hidden" name="policyPlanningID" value="#rc.policyPlanningID#">
										</tr>
										<tr>
											<td>Management and Budget (OMB):</td>
											<cfif isUserInRole("administer am/cn")>
												<td>
													<select name="ombReviewStatus" class="form-control">
														<option value="" <cfif rc.ombReviewStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.ombReviewStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.ombReviewStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.ombReviewStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="No" <cfif rc.ombReviewStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.ombReviewStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.ombReviewStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.ombReviewStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<option value="On Hold" <cfif rc.ombReviewStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="ombReviewComment" value="#rc.ombReviewComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.ombReviewStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="ombReviewStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.ombReviewStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="ombReviewComment" value="#rc.ombReviewComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.ombReviewStatus#
												</td>
												<td>
													<cfif isDate(rc.ombReviewDate)>#dateFormat(rc.ombReviewDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
												 	#rc.ombReviewComment#
												</td>
											</cfif>
											<input type="hidden" name="ombReviewID" value="#rc.ombReviewID#">
										</tr>
										<!--- <tr>
											<td>Deputy Review (DAS):</td>
											<cfif isUserInRole("administer am/cn")>
												<td>
													<select name="deputyReviewStatus" class="form-control">
														<option value="" <cfif rc.deputyReviewStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.deputyReviewStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.deputyReviewStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.deputyReviewStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="No" <cfif rc.deputyReviewStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.deputyReviewStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.deputyReviewStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.deputyReviewStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<option value="On Hold" <cfif rc.deputyReviewStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="deputyReviewComment" value="#rc.deputyReviewComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.deputyReviewStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="deputyReviewStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.deputyReviewStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="deputyReviewComment" value="#rc.deputyReviewComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.deputyReviewStatus#
												</td>
												<td>
													<cfif isDate(rc.deputyReviewDate)>#dateFormat(rc.deputyReviewDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
												 	#rc.deputyReviewComment#
												</td>
											</cfif>
											<input type="hidden" name="deputyReviewID" value="#rc.deputyReviewID#">
											<input type="hidden" name="deputyReviewStatus" value="Yes">
										</tr> --->
										<tr>
											<td>Front Office (FO):</td>
											<cfif isUserInRole("administer am/cn") or isUserInRole("fo clearance")>
												<td>
													<select name="frontOfficeStatus" class="form-control">
														<option value="" <cfif rc.frontOfficeStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.frontOfficeStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.frontOfficeStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.frontOfficeStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="No" <cfif rc.frontOfficeStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.frontOfficeStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.frontOfficeStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.frontOfficeStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<cfif isUserInRole("administer am/cn")>
															<option value="On Hold" <cfif rc.frontOfficeStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
														</cfif>
													</select>
												</td>
												<td colspan="2"><input type="text" name="frontOfficeComment" value="#rc.frontOfficeComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.frontOfficeStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="frontOfficeStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.frontOfficeStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="frontOfficeComment" value="#rc.frontOfficeComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.frontOfficeStatus#
												</td>
												<td>
													<cfif isDate(rc.frontOfficeDate)>#dateFormat(rc.frontOfficeDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
													#rc.frontOfficeComment#
												</td>
											</cfif>
											<input type="hidden" name="frontOfficeID" value="#rc.frontOfficeID#">
										</tr>
										<tr>
											<td>Foreign Assistance Front Office (FFO):</td>
											<cfif isUserInRole("administer am/cn")>
												<td>
													<select name="fassistfrontOfficeStatus" class="form-control">
														<option value="" <cfif rc.fassistfrontOfficeStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.fassistfrontOfficeStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.fassistfrontOfficeStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.fassistfrontOfficeStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="N/A" <cfif rc.fassistfrontOfficeStatus EQ "N/A">SELECTED</cfif>>N/A</option>
														<option value="No" <cfif rc.fassistfrontOfficeStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.fassistfrontOfficeStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.fassistfrontOfficeStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.fassistfrontOfficeStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<option value="On Hold" <cfif rc.fassistfrontOfficeStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="fassistfrontOfficeComment" value="#rc.fassistfrontOfficeComment#" class="form-control" maxlength="240"></td>
											<cfelseif (rc.fassistfrontOfficeStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="fassistfrontOfficeStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.fassistfrontOfficeStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="fassistfrontOfficeComment" value="#rc.fassistfrontOfficeComment#" class="form-control" maxlength="240"></td>
												<input type="hidden" name="fassistfrontOfficeID" value="#rc.fassistfrontOfficeID#">
											<cfelse>
												<td>
													#rc.fassistFrontOfficeStatus#
												</td>
												<td>
													<cfif isDate(rc.fassistfrontOfficeDate)>#dateFormat(rc.fassistfrontOfficeDate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
												 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #rc.fassistfrontOfficeComment#
												</td>
											</cfif>
											<input type="hidden" name="fassistfrontOfficeID" value="#rc.fassistfrontOfficeID#">
										</tr>
										<tr>
											<td>Legislative Affairs Front Office (HFO):</td>
											<cfif isUserInRole("administer am/cn")>
												<td>
													<select name="legalAffairsFOStatus" class="form-control">
														<option value="" <cfif rc.legalAffairsFOStatus EQ "">SELECTED</cfif>>SELECT:</option>
														<option value="Not Yet Selected" <cfif rc.legalAffairsFOStatus EQ "Not Yet Selected">SELECTED</cfif>>Not Yet Selected</option>
														<option value="Pending" <cfif rc.legalAffairsFOStatus EQ "Pending">SELECTED</cfif>>Pending</option>
														<option value="Yes" <cfif rc.legalAffairsFOStatus EQ "Yes">SELECTED</cfif>>Yes</option>
														<option value="No" <cfif rc.legalAffairsFOStatus EQ "No">SELECTED</cfif>>No</option>
														<option value="Questions for Budget" <cfif rc.legalAffairsFOStatus EQ "Questions for Budget">SELECTED</cfif>>Questions for Budget</option>
														<option value="Questions for Program" <cfif rc.legalAffairsFOStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
														<option value="Questions for Both" <cfif rc.legalAffairsFOStatus EQ "Questions for Both">SELECTED</cfif>>Questions for Both</option>
														<option value="On Hold" <cfif rc.legalAffairsFOStatus EQ "On Hold">SELECTED</cfif>>On Hold</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="legalAffairsFOComment" value="#rc.legalAffairsFOComment#" class="form-control" maxlength="240"></td>

											<cfelseif (rc.legalAffairsFOStatus EQ "Questions for Program") and IsUserInRole("review activity")>
												<td>
													<select name="legalAffairsFOStatus" class="form-control">
														<option value="Pending">Pending</option>
														<option value="Questions for Program" <cfif rc.legalAffairsFOStatus EQ "Questions for Program">SELECTED</cfif>>Questions for Program</option>
													</select>
												</td>
												<td colspan="2"><input type="text" name="legalAffairsFOComment" value="#rc.legalAffairsFOComment#" class="form-control" maxlength="240"></td>

											<cfelse>
												<td>
													#rc.legalAffairsFOStatus#
												</td>
												<td>
													<cfif isDate(rc.legalAffairsFODate)>#dateFormat(rc.legalAffairsFODate,'mm/dd/yyyy')#</cfif>
												</td>
												<td>
													#rc.legalAffairsFOComment#
												</td>
											</cfif>
											<input type="hidden" name="legalAffairsFOID" value="#rc.legalAffairsFOID#">
										</tr>
									</table>

									<input type="hidden" name="deputyReviewID" value="#rc.deputyReviewID#">
									<input type="hidden" name="deputyReviewStatus" value="Yes">
									<input type="hidden" name="deputyReviewComment" value="N/A">






								<cfif (isUserInRole("administer am/cn") or isUserInRole("l clearance") or isUserInRole("f clearance") or isUserInRole("h clearance") or isUserInRole("s/p clearance") or isUserInRole("fo clearance") or IsUserInRole("review activity")) and not len(trim(rc.activecn.ApprovedDate))>

										<input <cfif ( len(trim(rc.activecn.ApprovedDate)) )>disabled="true"</cfif> type="submit" name="clearanceStatus" value="Update Clearance Status" class="btn btn-default pull-right btn-xs" />

								</cfif>

						</div>
			            <!-- /.panel-body -->
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12">
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-check-circle-o fa-fw"></i> CN Congressional Approval
							<div class="pull-right">

							</div>
						</div>
			            <!-- /.panel-heading -->
						<div class="panel-body">


										<cfif isUserInRole("administer am/cn") >
											<div class="form-group">
											<label>Update CN Number</label>
											<input type="text" name="CNnumber" value="#rc.activecn.CNnumber#" class="form-control" Placeholder="Not Yet Assigned" />
											</div>
										<cfelse>
										<strong>CN Number:</strong>
											&nbsp; <cfif len(rc.activecn.CNnumber)>#rc.activecn.CNnumber#<cfelse>Not Yet Assigned</cfif>
											<input type="hidden" name="CNnumber" value="#rc.activecn.CNnumber#" />
										</cfif>


										<cfif isUserInRole("administer am/cn") >
										<div class="form-group">
										<label><strong>Select CN Congressional Approval Status:</strong></label>
											<select name="cnApprovalStatus" class="form-control" >
												<option value="" <cfif rc.cnApprovalStatus EQ "">SELECTED</cfif>>SELECT:</option>
												<option value="Pending" <cfif rc.cnApprovalStatus EQ "Pending">SELECTED</cfif>>CN Pending</option>
												<cfif  rc.isCNClearanceComplete or ( len(trim(rc.proposal.AMCNApprovedDate)) )>
													<option value="Approved" <cfif rc.cnApprovalStatus EQ "Approved">SELECTED</cfif>>CN Approved</option>
												</cfif>
												<option value="Denied" <cfif rc.cnApprovalStatus EQ "Denied">SELECTED</cfif>>CN Denied</option>
												<option value="On-Hold" <cfif rc.cnApprovalStatus EQ "On-Hold">SELECTED</cfif>>CN On-Hold</option>
												<option value="Withdrawn" <cfif rc.cnApprovalStatus EQ "Withdrawn">SELECTED</cfif>>CN Withdrawn</option>
											</select>
											</div>
											<div class="form-group">
											<label>Comments</label>
											<input type="text" name="cnApprovalComments" value="#rc.cnApprovalComments#" class="form-control" maxlength="240">
											</div>
											<br /><i>* Please select "Pending" first to register CN to Congress transmittal date .</i>
										<cfelse>
										<br><strong>CN Congressional Approval Status:</strong>
										&nbsp; #rc.cnApprovalStatus# <cfif len(rc.cnApprovalComments)> - &nbsp;#rc.cnApprovalComments#</cfif>
										</cfif>

										<input type="hidden" name="cnApprovalID" value="#rc.cnApprovalID#">

										<cfif isUserInRole("administer am/cn") >
											<input <cfif  len(trim(rc.activecn.ApprovedDate)) >disabled="true"</cfif> type="submit" class="btn btn-default pull-right btn-xs" name="cnapproval" value="Update CN Congressional Approval Status" />
										</cfif>
									</form>

						</div>
			            <!-- /.panel-body -->
					</div>
				</div>
			</div>
			</cfif>
	</div>
</div>
















<cfelseif len(trim(rc.proposal.proposalApprovedDate)) AND not rc.activecn.recordCount>
	<h4>The activity has been approved, but not yet linked to a CN.</h4>
	<cfif isUserInRole('link cn activities')>
		Link to an existing CN from your workload summary, or <a href=#event.buildLink("summary.newcnactivitylink")#>click here</a> to create a new CN.
	</cfif>
<!--- <cfelseif not rc.inactivecns.recordCount> --->
<cfelse>
			<h4>The activity has not yet reached this stage in the approval process.</h4>
</cfif>


	</cfoutput>






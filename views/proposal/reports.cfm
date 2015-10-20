<cfinclude template="header.cfm">
<cfoutput>

		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-files-o fa-fw"></i> Project Report Documents
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

						<cfif structKeyExists(rc,"attachedRptFiles") AND rc.attachedRptFiles.recordcount GT 0>
							<table class="table table-striped table-hover">

							<cfset docCnt = 1>
							<cfloop query="rc.attachedRptFiles">
								<tr>
									<td><span id="#attachedFileID#link"><b>#docCnt#.</b> <a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.attachedRptFiles.AttachedFileID)# data-toggle="tooltip" data-placement="top" title="#rc.attachedRptFiles.UploadedFileName# uploaded: #dateformat(rc.attachedRptFiles.AttachedFileDate, 'mm/dd/yyyy')#" data-placement="right"><i class="fa fa-file-text-o"></i> #rc.attachedRptFiles.Name#</a>
									</span>
									<span id="#AttachedFileID#" style="display:none;">
														<form name="docnameForm" id="docnameForm" class="form-inline"  method="post" action="#event.buildLink('proposal.renameDocument')#">
														<input type="hidden" name="activityid" value="#rc.activityID#">
														<input type="hidden" name="AttachedFileID" value="#AttachedFileID#">
														<input type="hidden" name="target" value="activityreports">
														<input type="text" name="name" value="#rc.attachedRptFiles.Name#" required="true" class="form-control input-sm" style="width:200px">&nbsp;
														<span class="pull-right">
														<!--- <input type="submit" name="Edit" value="Save" class="btn btn-xs btn-primary"> --->
														<button type="submit" name="Edit" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Save Name Change"><i class="fa fa-check fa-fw"></i></button>
														&nbsp;<a href="javascript:void(0)" onclick="$('###attachedFileID#').toggle('fast', function() {});$('###attachedFileID#link').toggle('fast', function() {});" class="btn btn-default btn-sm" data-toggle="tooltip" data-placement="top" title="Cancel Name Change"><i class="fa fa-close fa-fw"></i></a>
														</span>
														</form>
													</span></td>
										<cfif IsUserInRole("attach reports document")>
										<td style="width:120px">
											<span class="pull-right">
												&nbsp;<a href="javascript:void(0)" onclick="$('###attachedFileID#').toggle('fast', function() {});$('###attachedFileID#link').toggle('fast', function() {});" class="btn btn-default btn-xs" data-toggle="tooltip" data-placement="top" title="Edit Document Name"><i class="fa fa-edit fa-fw"></i></a>
												&nbsp;<a href=#event.buildLink("proposal.archivefile.AttachedFileID." & rc.attachedRptFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=activityreports")# class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="top" title="Archive Document"><i class="fa fa-level-down fa-fw"></i></a>

												<cfif  IsUserInRole("deactivate files")>
												 	&nbsp;<a href=#event.buildLink("proposal.deactivatefile.AttachedFileID." & rc.attachedRptFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=activityreports")# class="btn btn-danger btn-xs" data-toggle="tooltip" data-placement="top" title="Delete Document"><i class="fa fa-eraser fa-fw"></i></a>
												</cfif>
											</span>
											</td>
										</cfif>
										</span>



									</td>
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

				<cfif structKeyExists(rc,"archivedRptFiles") AND rc.archivedRptFiles.recordcount GT 0>
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
									<cfloop query="rc.archivedRptFiles">
										<tr>
											<td>
										<b>#docCnt#.</b> <a target="blank" href=#event.buildLink("attachedFile.index.AttachedFileID." & rc.archivedRptFiles.AttachedFileID)# title="#rc.archivedRptFiles.UploadedFileName# uploaded: #dateformat(rc.attachedRptFiles.AttachedFileDate, 'mm/dd/yyyy')#" data-toggle="tooltip" data-placement="top"><i class="fa fa-file-text-o"></i> #rc.archivedRptFiles.Name#</a>
												</td>
												<cfif IsUserInRole("attach am/cn document")>
												<td style="width:100px">
													<span class="pull-right">
														&nbsp;<a href=#event.buildLink("proposal.unarchivefile.AttachedFileID." & rc.archivedRptFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=activityreports")#  class="btn btn-warning btn-xs" data-toggle="tooltip" data-placement="top" title="Un-Archive Document"><i class="fa fa-level-up fa-fw"></i></a>
														<cfif  IsUserInRole("deactivate files")>
														 	&nbsp;<a href=#event.buildLink("proposal.deactivatefile.AttachedFileID." & rc.archivedRptFiles.AttachedFileID & "?activityID=" & rc.activityID & "&backto=activityreports")# class="btn btn-danger btn-xs" data-toggle="tooltip" data-placement="top" title="Delete Document"><i class="fa fa-eraser fa-fw"></i></a>
														</cfif>
													</span>
													</td>
												</cfif>

										<cfset docCnt = docCnt + 1>
										</td>
									</tr>
									</cfloop>
							</table>
								</div>
						    </div>
						  </div>
					</cfif>
					</div>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>



	<cfif isUserInRole("attach obligation document")>

			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-upload fa-fw"></i> Attach Report Document
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">


							<form name="obForm" id="obForm" method="post" action="#event.buildLink('proposal.saveReports')#" enctype="multipart/form-data">
									<input type="hidden" name="activityID" value="#rc.activityID#">
							<input type="hidden" name="activityStatusID" value="#rc.proposal.activityStatusID#">
							<input type="hidden" name="sysUserID" value="#rc.sysUserID#">

											<label>Add Document <span class="text-danger">(Unclassified only - No SBU)</span><i class="fa fa-question-circle fa-fw" data-toggle="tooltip" data-placement="top" title="Document Title: A brief description that uniquely identifies the document."></i></label>
											<input type="text" placeholder="Document Title" name="documentTitle" value=""  class="form-control" required="true">


											<input type="hidden" name="longdescription" value="" ><br>
									<span class="pull-right">


									<input type="submit" name="saveCommentDoc" value="Upload Document" class="btn btn-primary btn-xs" id="uploadButton" style="display:none;" />

								</span>
								<br><input type="file"  class="btn btn-default  btn-xs" name="documentUpload"  title="Search for a file to add" required="true" onclick="$('##uploadButton').show('fast', function() {});">
								<p class="text-muted"><br>Note: Document filenames should contain only letters and numbers, and not exceed 50 characters in length	</p>
							</form>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
	</cfif>



		</div>



</cfoutput>




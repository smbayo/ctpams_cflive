<cfoutput>
<ol class="breadcrumb">
  <li>#uCase(rc.proposal.proposalnumber)#</li>
    <cfif #cgi.PATH_INFO# contains "review"><li class="active">Review</li><cfelse><li><a href="#event.buildLink("proposal.review.activityID." & rc.ActivityID)#">Review</a></li></cfif>
	<cfif #cgi.PATH_INFO# contains "cn"><li class="active">CN</li><cfelse><li><a href="#event.buildLink("proposal.cn.activityID." & rc.ActivityID)#">CN</a></li></cfif>
	<cfif #cgi.PATH_INFO# contains "fundimpmechanism"><li class="active">Funding</li><cfelse><li><a href="#event.buildLink("proposal.fundimpmechanism.activityID." & rc.ActivityID)#">Funding</a></li></cfif>
	<cfif #cgi.PATH_INFO# contains "obstatus"><li class="active">Obligation</li><cfelse><li><a href="#event.buildLink("proposal.obstatus.activityID." & rc.ActivityID)#">Obligation</a></li></cfif>
	<cfif #cgi.PATH_INFO# contains "impstatus"><li class="active">Implementation</li><cfelse><li><a href="#event.buildLink("proposal.impstatus.activityID." & rc.ActivityID)#">Implementation</a></li></cfif>
	<cfif #cgi.PATH_INFO# contains "rmp"><li class="active">PMP</li><cfelse><li><a href="#event.buildLink("proposal.rmp.activityID." & rc.ActivityID)#">PMP</a></li></cfif>
	<cfif #cgi.PATH_INFO# contains "activityreports"><li class="active">Reports</li><cfelse><li><a href="#event.buildLink("proposal.activityreports.activityID." & rc.ActivityID)#">Reports</a></li></cfif>
	<cfif #cgi.PATH_INFO# contains "editlog"><li class="active">Log</li><cfelse><li><a href="#event.buildLink("proposal.editlog.activityID." & rc.ActivityID)#">Log</a></li></cfif>
</ol>



<cfif not #cgi.PATH_INFO# contains "editproject" and not #cgi.PATH_INFO# contains "/view">

<div class="row">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
							<div class="row">
								<div class="col-md-9">
                            <span class="bigger">#uCase(rc.proposal.proposalnumber)#: #rc.projectTitle#</span>
							</div>
                            <div class="col-md-3">
								<span class="pull-right">
										<cfif #cgi.PATH_INFO# contains "cn">
                                        <a href="#event.buildLink("proposal.printamcn.activityID." & rc.proposal.ActivityID & ".cnid." & rc.cnid)#" class="btn btn-success btn-xs">Export Page Details</a>
										</cfif>
										<cfif #cgi.PATH_INFO# contains "review">
                                        <a href="#event.buildLink("proposal.print.activityID." & rc.proposal.ActivityID)#" class="btn btn-success btn-xs">Export Page Details</a>
										</cfif>
										<cfif #cgi.PATH_INFO# contains "fundimpmechanism">
                                        <a href="#event.buildLink("proposal.printfunding.activityID." & rc.proposal.ActivityID)#" class="btn btn-success btn-xs">Export Page Details</a>
										</cfif>
										<cfif #cgi.PATH_INFO# contains "obstatus">
                                        <a href="#event.buildLink("proposal.printobstatus.activityID." & rc.proposal.ActivityID)#" class="btn btn-success btn-xs">Export Page Details</a>
										</cfif>
										<cfif #cgi.PATH_INFO# contains "rmp">
                                        <a href="#event.buildLink("proposal.printrmp.activityID." & rc.proposal.ActivityID)#" class="btn btn-success btn-xs">Export Page Details</a>
										</cfif>
								</span>
                            </div>
							</div>

                        </div>
                        <!-- /.panel-heading -->
						<div class="panel-body">
                        <div class="row">
								<div class="col-md-1">
								</div>
								<div class="col-md-4">
									<dl class="dl-horizontal">
									  <dt>Funding Requested:</dt>
									  <dd>#dollarFormat(rc.proposal.budgetCeilingAmount)#</dd>
									  <dt>Status:</dt>
									  <dd><cfif rc.progressStatus is "CN Partial Hold"><strong class="text-error">#rc.progressStatus#</strong><cfelse>#rc.progressStatus#</cfif></dd>
									</dl>
								</div>
								<div class="col-md-4">
									<dl class="dl-horizontal">
									  <dt>Age:</dt>
									  <dd>#rc.progressAge# day(s)</dd>
									  <dt>Submit Date:</dt>
									  <dd>#dateFormat(rc.proposal.proposalSubmitDate,'dd mmm yyyy')#</dd>
									</dl>
								</div>
								<div class="col-md-3">
									<cfif rc.proposal.ctex is 1>
									  <span class="text-danger">Archived</span>
									<cfelse>
										<cfif rc.proposal.reprogramfunds is 1 or rc.proposal.implementationstatus is 'CN Re-notification'><span class="text-danger">Reprogrammed/Re-notified</span></cfif>
									</cfif>

								</div>
							</div>
						</div>
                        <!-- /.panel-body -->
                    </div>

                    <!-- /.panel -->
                </div>
</div>

<!--- <nav class="navbar navbar-default">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="##bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
     <!---  <a class="navbar-brand" href="#event.buildLink("proposal.review.activityID." & rc.ActivityID)#">#uCase(rc.proposal.proposalnumber)#:</a> --->
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
		    <li <cfif #cgi.PATH_INFO# contains "review">class="active"</cfif>><a href="#event.buildLink("proposal.review.activityID." & rc.ActivityID)#">Review</a></li>
			<li <cfif #cgi.PATH_INFO# contains "cn">class="active"</cfif>><a href="#event.buildLink("proposal.cn.activityID." & rc.ActivityID)#">CN</a></li>
			<li <cfif #cgi.PATH_INFO# contains "fundimpmechanism">class="active"</cfif>><a href="#event.buildLink("proposal.fundimpmechanism.activityID." & rc.ActivityID)#">Funding</a></li>
			<li <cfif #cgi.PATH_INFO# contains "obstatus">class="active"</cfif>><a href="#event.buildLink("proposal.obstatus.activityID." & rc.ActivityID)#">Obligation</a></li>
			<li <cfif #cgi.PATH_INFO# contains "impstatus">class="active"</cfif>><a href="#event.buildLink("proposal.impstatus.activityID." & rc.ActivityID)#">Implementation</a></li>
			<li <cfif #cgi.PATH_INFO# contains "rmp">class="active"</cfif>><a href="#event.buildLink("proposal.rmp.activityID." & rc.ActivityID)#">PMP</a></li>
			<li <cfif #cgi.PATH_INFO# contains "activityreports">class="active"</cfif>><a href="#event.buildLink("proposal.activityreports.activityID." & rc.ActivityID)#">Reports</a></li>
			<li <cfif #cgi.PATH_INFO# contains "editlog">class="active"</cfif>><a href="#event.buildLink("proposal.editlog.activityID." & rc.ActivityID)#">Log</a></li>

      </ul>

    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
</nav> --->

</cfif>
</cfoutput>

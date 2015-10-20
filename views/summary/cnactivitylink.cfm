<ol class="breadcrumb">
  <li class="active">Link CN Activities</li>
</ol>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-tasks fa-fw"></i> Link CN Activities
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
				<cfif structKeyExists(rc,"getcn")  AND rc.getcn.recordCount>
				<cfoutput query="rc.getcn">
					<form name="amcnForm" id="amcnForm" method="post" action="#event.buildLink('summary.saveCNActivityLink')#">
						<input type="hidden" name="linkedActivities">
						<input type="hidden" name="cnId" value="#rc.cnid#">
					   <div class="form-group">
					    <label for="cntitle">CN Title</label>
					    <input type="text" name="cntitle" class="form-control" value="#cntitle#" id="cntitle">
					    <p class="help-block">Title example: <i>2013.10 RSI FY13 $4,000,000 CN</i><br>
						Guidelines: CN link year and month in decimal format, program office, FY source of funds, funding amount, "CN"</p>
					  </div>
					  <div class="form-group">
					    <label for="cnnumber">CN Number</label>
					    <input type="text" name="cnnumber" value="#cnnumber#" class="form-control" id="cnnumber">
					  </div>
					  </cfoutput>
					  <div class="form-group">
					    <label for="exampleInputFile">Linked Activities</label>
					    <cfoutput query="rc.getlinkedcnactivities">
											<dd><input type="checkbox" value="#activityid#" name="linkedActivities" checked> #proposalnumber# - #projecttitle# </dd>
										</cfoutput>
					  </div>
					   <div class="form-group">
					    <label for="exampleInputFile">Unlinked Activities</label>
					   <cfoutput query="rc.getpotentialcnactivities">
											<dd><input type="checkbox" value="#activityid#" name="linkedActivities"> #proposalnumber# - #projecttitle# </dd>
										</cfoutput>
					  </div>

					<span class="pull-right">
					  <button type="submit" class="btn btn-primary btn-xs" name="setLinkedActivities"><i class="icon-ok icon-white"></i> Set Linked Activities</button> &nbsp; &nbsp;
							 <cfoutput><a href="#event.buildLink('summary.index')#" class="btn btn-default btn-xs"><i class="icon-remove-sign"></i> Cancel</a></cfoutput> &nbsp; &nbsp;
						</span>

					</form>
				</cfif>


			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>
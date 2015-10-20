<link rel="stylesheet" href="includes/styles/dc.css" type="text/css">
<style>
	#chart-country, #chart-fy, #chart-program, #chart-region, #chart-fundingmech, #dc-data-table, #chart-bubble {color:#666666;}
      #dcinfobar {
        font-size: 16px;
        padding-top: 24px;
        padding-bottom: 24px;
		color:#666666;
      }
	#dcheader {font-size: 24px; color:#666666;}
	#number-total, #filter-count, #total-count {color:#df9526;}
	#chart-startdate g.y {
            display: none;
        }
	.biggercount { font-size: 18px; }
 </style>

<ol class="breadcrumb">
  <li>Workload</li>
  <li class="active">Dashboard</li>
</ol>



<div class="row">
	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> Progress Status
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body" id="chartwidth">
				   <div id="chart-progress"></div>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> Project Last Updated
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
				   <div id="chart-lastupdated"></div>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> Implementation Status
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
				   <div id="chart-impstatus"></div>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>

	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-pie-chart fa-fw"></i> Program
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
				   <div id="chart-program"></div>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>



<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-eye fa-fw"></i> Projects
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">
					<span class="dc-data-count">
					<span class="filter-count" id="filter-count"></span> selected out of <span class="total-count" id="total-count"></span> records | <a href="javascript:dc.filterAll(); dc.renderAll();">Reset All</a>
				</span>
				    <table id="dc-data-table" class="table table-striped table-hover">
											<thead>
											<tr class="header">
												<th style="width:100px">ID</th>
												<th>Project Title</th>
												<th style="width:260px">Progress Status</th>
												<th>Implementation</th>
												<th>Inactive</th>
											</tr>
											</thead>
										</table>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>




<script src="includes/javascript/d3/d3.v3.min.js"></script>
<script src="includes/javascript/d3/dc.js"></script>
<script src="includes/javascript/d3/crossfilter.js"></script>

	<script>
var chartWidth = $('#chartwidth').width() -20;

var dateFormat = d3.time.format("%m/%d/%Y");

var progressChart   = dc.rowChart("#chart-progress"),
    programChart  = dc.pieChart("#chart-program"),
    lastUpdatedChart  = dc.rowChart("#chart-lastupdated"),
    impStatusChart  = dc.rowChart("#chart-impstatus"),
    datatable = dc.dataTable("#dc-data-table");

var ctData = <cfoutput>#rc.jstring#</cfoutput>


var scount = 0;
ctData.forEach(function(d) {
    d.count = ++scount;
});


var ctx = crossfilter(ctData),
	progressDim  = ctx.dimension(function(d) {return d.activityStatus;}),
    programDim  = ctx.dimension(function(d) {return d.program;}),
    lastUpdatedDim  = ctx.dimension(function(d) {return d.inactivePeriod;}),
    impStatusDim  = ctx.dimension(function(d) {return d.implementationStatus;}),
    progressCount = progressDim.group(),
    programCount = programDim.group(),
    lastUpdatedCount = lastUpdatedDim.group(),
    impStatusCount = impStatusDim.group(),
    all = ctx.groupAll();


programChart
    .width(chartWidth).height(260)
    .dimension(programDim)
    .group(programCount)
    .ordinalColors(["#BFC9DA","#DFE4EC","#9FAFC7","#3F5F90","#5F79A3","#7F94B5"])
    .innerRadius(50);

progressChart
    .width(chartWidth).height(260)
    .dimension(progressDim)
    .group(progressCount)
    .ordinalColors(["#BFC9DA"])
	.elasticX(false)
	.xAxis().ticks(4);

lastUpdatedChart
    .width(chartWidth).height(260)
    .dimension(lastUpdatedDim)
    .group(lastUpdatedCount)
    .ordinalColors(["#BFC9DA"])
    .elasticX(false)
    .xAxis().ticks(4);


impStatusChart
    .width(chartWidth).height(260)
    .dimension(impStatusDim)
    .group(impStatusCount)
    .ordinalColors(["#BFC9DA"])
    .elasticX(false)
    .xAxis().ticks(4);



dc.dataCount(".dc-data-count")
        .dimension(ctx)
        .group(all);


datatable
    .dimension(progressDim)
    .group(function(d) {return d.activityStatus;})
    .size(1000)
    .columns([
        function(d) { return "<a href='index.cfm/proposal/review/activityID/" + d.activityid + "'>" + d.proposalnumber + "</a>"},
        function(d) { return "<a href='index.cfm/proposal/review/activityID/" + d.activityid + "'>" + d.projectTitle + "</a>"},
        function(d) { return d.activityStatus},
        function(d) {return d.implementationStatus;},
        function(d) {return d.daysInactive;}
    ])
    .sortBy(function (d) {
                        return d.activityid;
                    })
    .order(d3.ascending);


dc.renderAll();
</script>
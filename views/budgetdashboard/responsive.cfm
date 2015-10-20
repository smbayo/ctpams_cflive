<ol class="breadcrumb">
<li class="active">Budget Dashboard</li>
</ol>

<link rel="stylesheet" href="includes/styles/dc.css" type="text/css">
<style>
	#chart-country, #chart-fy, #chart-program, #chart-region, #chart-fundingmech, #dc-data-table, #chart-bubble {color:#666666;}
      #infobar {
        font-size: 18px;
        padding-top: 24px;
        padding-bottom: 24px;
		color:#666666;
      }
	#header {font-size: 24px; color:#666666;}
	#number-total, #filter-count, #total-count {color:#df9526;}
	#chart-startdate g.y {
            display: none;
        }
		.biggercount { font-size: 18px; }
    </style>



<div class="row">
	<div class="col-md-3">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-bar-chart-o fa-fw"></i> Country
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body" id="countrywidth">
				<div id="chart-country"></div>
			</div>
            <!-- /.panel-body -->
		</div>
	</div>

	<div class="col-md-9">
		<div class="row">
			<div class="col-md-12 biggercount">

						Total Requested/Budgeted: <span id="number-total"></span> |  <a href="javascript:dc.filterAll(); dc.renderAll();">Reset All</a><br><br>

			</div>
		</div>
		<div class="row">
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-pie-chart fa-fw"></i> Fiscal Year
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body" id="chartwidth">
						<div id="chart-fy"></div>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-bar-chart-o fa-fw"></i> Program
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
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-bar-chart-o fa-fw"></i> Region
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
						<div id="chart-region"></div>
					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
			<div class="col-md-6">
				<div class="panel panel-default">
					<div class="panel-heading">
						<i class="fa fa-bar-chart-o fa-fw"></i> Funding Mechanism
						<div class="pull-right">

						</div>
					</div>
		            <!-- /.panel-heading -->
					<div class="panel-body">
						<div id="chart-fundingmech"></div>
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
						<span class="dc-data-count"><span class="filter-count" id="filter-count"></span> selected out of <span class="total-count" id="total-count"></span> records |  <a href="javascript:dc.filterAll(); dc.renderAll();">Reset All</a></span>
						<table id="dc-data-table" class="table table-striped table-hover">
							<thead>
							<tr class="header">
								<th style="width:90px">ID</th>
								<th>Name</th>
								<th>Country</th>
								<th>Budget Item</th>
								<th>Amount</th>
								<th>FY</th>
							</tr>
							</thead>
						</table>

					</div>
		            <!-- /.panel-body -->
				</div>
			</div>
		</div>
	</div>
</div>


<script src="includes/javascript/d3/d3.v3.min.js"></script>
<script src="includes/javascript/d3/dc.js"></script>
<script src="includes/javascript/d3/crossfilter.js"></script>


<script type="text/javascript">

var countryWidth = $('#countrywidth').width() -20;
var chartWidth = $('#chartwidth').width() -20;

var dateFormat = d3.time.format("%m/%d/%Y");

var yearChart   = dc.pieChart("#chart-fy"),
    programChart  = dc.rowChart("#chart-program"),
    fundingmechChart  = dc.rowChart("#chart-fundingmech"),
    regionChart  = dc.rowChart("#chart-region"),
    countryChart = dc.rowChart("#chart-country"),
    boxND    = dc.numberDisplay("#number-total"),
    datatable = dc.dataTable("#dc-data-table");

var ctData = <cfoutput>#rc.jstring#</cfoutput>


var scount = 0;
ctData.forEach(function(d) {
    d.smdate = dateFormat.parse(d.startdate);
    d.startmonth = d3.time.month(d.smdate);
    d.emdate = dateFormat.parse(d.enddate);
    d.endmonth = d3.time.month(d.emdate);
    d.count = ++scount;
});


var ctx = crossfilter(ctData),
	budgetDim  = ctx.dimension(function(d) {return d.budgetamount;}),
    yearDim  = ctx.dimension(function(d) {return d.fiscalyear;}),
    programDim  = ctx.dimension(function(d) {return d.program;}),
    budgetitemDim  = ctx.dimension(function(d) {return d.budgetitem;}),
    countryDim  = ctx.dimension(function(d) {return d.country;}),
    regionDim  = ctx.dimension(function(d) {return d.region;}),
    fundingmechDim  = ctx.dimension(function(d) {return d.fundingmechanism;}),
    spendPerYear = yearDim.group().reduceSum(function(d) {return (d.budgetamount / 1000000);}),
    spendPerProgram = programDim.group().reduceSum(function(d) {return (d.budgetamount / 1000000);}),
    spendPerRegion = regionDim.group().reduceSum(function(d) {return (d.budgetamount / 1000000);}),
    spendPerFundingmech = fundingmechDim.group().reduceSum(function(d) {return (d.budgetamount / 1000000);}),
    spendPerCountry = countryDim.group().reduceSum(function(d) {return (d.budgetamount / 1000000);}),
    all = ctx.groupAll(),
    allbudget = ctx.groupAll().reduce(
          function (p, v) {
              ++p.n;
              p.tot += v.budgetamount;
              return p;
          },
          function (p, v) {
              --p.n;
              p.tot -= v.budgetamount;
              return p;
          },
          function () { return {n:0,tot:0}; }
      ),
    totalbudget = function(d) {
      return d.n ? d.tot : 0;
  	},
  	itemcount = function(d) {
      return d.n ? d.n : 0;
  	}
  	averagebudget = function(d) {
      return (d.n && d.tot) ? (d.tot/d.n) : 0;
  	};


yearChart
    .width(chartWidth).height(260)
    .dimension(yearDim)
    .group(spendPerYear)
    .ordinalColors(["#3F5F90","#5F79A3","#7F94B5","#9FAFC7","#BFC9DA","#DFE4EC"])
    .title(function (d) {
            return d.key + ": " + (Math.floor(d.value* 1000000) );
        })
    .innerRadius(50);

programChart
    .width(chartWidth).height(260)
    .dimension(programDim)
    .group(spendPerProgram)
    .ordinalColors(["#BFC9DA"])
    .title(function (d) {
            return d.key + ": " + (Math.floor(d.value* 1000000) );
        })
	.elasticX(true)
	.xAxis().ticks(4);

regionChart
    .width(chartWidth).height(260)
    .dimension(regionDim)
    .group(spendPerRegion)
    .ordinalColors(["#BFC9DA"])
     .title(function (d) {
            return d.key + ": " + (Math.floor(d.value* 1000000) );
        })
    .elasticX(true)
    .xAxis().ticks(4);


fundingmechChart
    .width(chartWidth).height(260)
    .dimension(fundingmechDim)
    .group(spendPerFundingmech)
    .ordinalColors(["#BFC9DA"])
    .title(function (d) {
            return d.key + ": " + (Math.floor(d.value* 1000000) );
        })
    .elasticX(true)
    .xAxis().ticks(4);


countryChart
    .width(countryWidth).height(2400)
    .dimension(countryDim)
    .group(spendPerCountry)
    .renderLabel(true)
	.ordinalColors(["#BFC9DA"])
	.title(function (d) {
            return d.key + ": " + (Math.floor(d.value* 1000000) );
        })
    .elasticX(true)
    .xAxis().ticks(4);

boxND
    .formatNumber(d3.format(".3s"))
    .valueAccessor(totalbudget)
    .group(allbudget);

dc.dataCount(".dc-data-count")
        .dimension(ctx)
        .group(all);


datatable
    .dimension(budgetitemDim)
    .group(function(d) {return d.program;})
    .size(10000)
    .columns([
        function(d) { return "<a href='index.cfm/proposal/review/activityID/" + d.activityid + "'>" + d.proposalnumber + "</a>"},
        function(d) { return "<a href='index.cfm/proposal/review/activityID/" + d.activityid + "'>" + d.proposalname + "</a>"},
        function(d) { return d.country},
        function(d) {return d.budgetitem;},
        function(d) {return d.budgetamount;},
        function(d) {return d.fiscalyear;}
    ])
    .sortBy(function (d) {
                        return d.activityid;
                    })
    .order(d3.ascending);

dc.renderAll();

</script>
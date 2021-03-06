<!DOCTYPE html>
<meta charset="utf-8">
<style>
.node rect {
  cursor: pointer;
  fill: #c2e1ff; /* light blue */
  stroke: steelblue;
  stroke-width: 1.5px;
}

.node circle {
  cursor: pointer;
  stroke: steelblue;
  stroke-width: 1.5px;
}

.node text {
  font: 10px Verdana,Helvetica, sans-serif;
}

.activity {
    fill: green;
    fill-opacity: 0.5;
}

.indicator {
    fill: #A22538; /* red */
    fill-opacity: 0.5;
}

.result {
    fill: #185A9C; /* blue */
    fill-opacity: 0.5;
}

path.link {
  fill: none;
  stroke: #757575; /* dark grey */
  stroke-width: 1px;
}

#simplemodal-overlay {
    background-color:#757575; /* dark grey */
}
#simplemodal-container {
    background-color:#fff; 
    border:1px solid #185A9C; /* blue */
    padding:10px;
    font: 10px Verdana, sans-serif;
}
#simplemodal-container a.modalCloseImg {
    background:url(x.png) no-repeat; /* adjust url as required */
    width:25px;
    height:29px;
    display:inline;
    z-index:3200;
    position:absolute;
    top:-15px;
    right:-18px;
    cursor:pointer;
}
#simplemodal-container h4.rstpop{
    background-color: #fff;
	font-weight:bold;
}
#simplemodal-container h4.actpop{
    background-color: #fff;
	font-weight:bold; /* green */
}
</style>
<body>
        <a href="http://ctprogramstest.com/ctprograms/index.cfm/" target='MSI'>MSI Login</a>
        <a href="#expand" onclick="RF_CLUSTER.expandAll();">Expand All</a>
        <a href="#collapse" onclick="RF_CLUSTER.collapseAll();">Collapse All</a>

        <!--The "chart" contains the SVG-->
	<div id="chart"></div>

        <!--Dependency scripts-->
        <script src="includes/dev1_active/jquery-1.7.2.min.js"></script>
        <script src="includes/dev1_active/jquery.simplemodal.1.4.2.min.js"></script>
        <script src="includes/dev1_active/d3.v2.min.js"></script>
        <script src="includes/dev1_active/helper_functions.min.js"></script>
        <script src="includes/dev1_active/textFlow.min.js"></script>

        <!--Main script that draws the RF Tree-->
	<script src="includes/dev1_active/rfTree_inter.js"></script>

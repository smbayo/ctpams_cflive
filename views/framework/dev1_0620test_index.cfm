<!DOCTYPE html>
<meta charset="utf-8">
<style>
.node rect {
  cursor: pointer;
  fill: #ffffff; /* white */
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
  stroke: #ffffff; /* white */
  stroke-width: 3px;
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
<center>
<table cellspacing=0 cellpadding=0 width=1000>
<tr>
<td width=33% style="text-align:left"><img src="views/framework/icon_key.jpg"></td>
<td width=33% style="text-align:center">
<a onclick="RF_CLUSTER.expandAll();">Expand All</a>&nbsp;&nbsp;&nbsp;<a onclick="RF_CLUSTER.collapseAll();">Collapse All</a>
</td>



<td width=33% style="text-align:right"><FORM METHOD="LINK" ACTION="index.cfm/framework/editResult">
		<INPUT TYPE="submit" VALUE="Add New Result">
	</FORM>
</td></tr></table>
</center>
      <!---  <a href="http://ctprogramstest.com/ctprograms/index.cfm/" target='MSI'>MSI Login</a>--->

        <!--The "chart" contains the SVG-->
	<div id="chart"></div>

        <!--Dependency scripts-->
        <script src="includes/dev1_0620test/jquery-1.7.2.min.js"></script>
        <script src="includes/dev1_0620test/jquery.simplemodal.1.4.2.min.js"></script>
        <script src="includes/dev1_0620test/d3.v2.min.js"></script>
        <script src="includes/dev1_0620test/helper_functions.min.js"></script>
        <script src="includes/dev1_0620test/textFlow.min.js"></script>

        <!--Main script that draws the RF Tree-->
	<script src="includes/dev1_0620test/rfTree_inter.js"></script>

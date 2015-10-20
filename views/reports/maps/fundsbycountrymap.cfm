<ol class="breadcrumb">
  <li>Maps</li>
  <li class="active">Funding Map</li>
</ol>


<link rel="stylesheet" href="includes/styles/leaflet.css" />
<script src="includes/javascript/leaflet.js"></script>
 <link rel="stylesheet" href="includes/styles/Control.FullScreen.css" />
 <script src="includes/javascript/Control.FullScreen.js"></script>
<style>



		#map {
			width: 100%;
			 height:770px;
		}

		.info {
			padding: 6px 8px;
			font: 14px/16px Arial, Helvetica, sans-serif;
			background: white;
			background: rgba(255,255,255,0.8);
			box-shadow: 0 0 15px rgba(0,0,0,0.2);
			border-radius: 5px;
			text-align: left;
		}

		.top-block {
			width:290px;
			height:50px;
		}

		.info h4 {
			margin: 0 0 5px;
			color: #777;
		}

		.legend {
			text-align: left;
			line-height: 18px;
			color: #555;
		}
		.legend i {
			width: 18px;
			height: 18px;
			float: left;
			margin-right: 8px;
			opacity: 0.7;
		}
</style>


<cfset start = Year(Now())+3>
<cfset rc.mapquerystring = getPlugin("SessionStorage").setVar("mapquerystring",CGI.QUERY_STRING)>

<div class="row" id="maprow">
	<div class="col-md-12">

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-filter fa-fw"></i> Apply Filters
				<div class="pull-right">
					<a href="<cfoutput>#event.buildLink("reports/fundsbycountrymap")#</cfoutput>" class="btn btn-default btn-xs">Clear Filters</a>
				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body">

 <form>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select id="program" name="program" multiple="true">
			<cfloop query="rc.programs">
        	<cfoutput><option value="#name#" <cfif listfind(rc.program,rc.programs.name)>selected</cfif>>#name#</option></cfoutput>
			</cfloop>
        </select>

		<select id="fy" name="fy" multiple="true">
			<cfloop from="#start#" to="#start-10#" step="-1" index="thisyear">
        	<cfoutput><option <cfif listfind(rc.fy,thisyear)>selected</cfif>>#thisYear#</option></cfoutput>
			</cfloop>
        </select>

		<select id="region" name="region" multiple="true">

			<cfoutput query="rc.regions">
        	<option value="#name#" <cfif listfind(rc.region,rc.regions.name)>selected</cfif>>#name#</option>
			</cfoutput>
        </select>

		<select id="themeID" name="themeID" multiple="true" style="visibility: visible;">
												<cfoutput query="rc.themes">
													<option value="#categoryID#" <cfif listfind(rc.themeID,rc.themes.categoryID)>selected</cfif>>#name#</option>
												</cfoutput>
									</select>

		<!--- <select id="statusID" name="statusID">
			<option value="" <cfif (rc.ActivityStatuses.categoryID EQ 0)>selected</cfif>>Status (all active)</option>
				<cfloop query="rc.ActivityStatuses">
					<cfoutput><option value="#categoryID#" <cfif (rc.ActivityStatuses.categoryID EQ rc.statusID)>selected</cfif>>#name#</option></cfoutput>
				</cfloop>
			</select> --->

		<select id="statusID" name="statusID" multiple="true" style="visibility: visible;">
										<option value="268,269,270,272,275,308"  <cfif listfind(rc.statusID,"268")>selected</cfif>>Project Review</option>
										<option value="276,277,280,281,283" <cfif listfind(rc.statusID,"276")>selected</cfif>>CN Clearance</option>
										<option value="288,289"  <cfif listfind(rc.statusID,"288")>selected</cfif>>Funding Clearance</option>
										<option value="294"  <cfif listfind(rc.statusID,"294")>selected</cfif>>Obligation Pending</option>
										<option value="297"  <cfif listfind(rc.statusID,"297")>selected</cfif>>Fully Obligated</option>
									</select>


		<button type="submit" class="btn btn-primary btn-sm" name="submit" value="Go"><i class="icon-filter icon-white"></i> Go</button>
</form>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fa fa-map-marker fa-fw"></i> Map <span class="text-muted"> (click on map to access country profiles)</span>
				<div class="pull-right">

				</div>
			</div>
            <!-- /.panel-heading -->
			<div class="panel-body" id="mapcontainer">

	<div id="map">
        CT Programs Activity Map
	</div>

			</div>
            <!-- /.panel-body -->
		</div>
	</div>
</div>

	</div>
</div>

<script language="JavaScript">


	$(document).ready(function() {

	    $('#program').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Program (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Program: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

    $('#region').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Region (all) <b class="caret"></b>';
        }
        else if (options.length > 2) {
          return 'Region: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

	$('#fy').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Fiscal Year (all) <b class="caret"></b>';
        }
        else if (options.length > 3) {
          return 'Fiscal Year: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

    $('#themeID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Theme (all) <b class="caret"></b>';
        }
        else if (options.length > 1) {
          return 'Theme: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

	    //$('#statusID').multiselect({
	    //	buttonWidth: '200px',
	    //});

	     $('#statusID').multiselect({
    	buttonWidth: '180px',
    	maxHeight: 340,
      buttonText: function(options) {
        if (options.length == 0) {
          return 'Status (all active) <b class="caret"></b>';
        }
        else if (options.length > 1) {
          return 'Status: ' +  options.length + ' selected  <b class="caret"></b>';
        }
        else {
          var selected = '';
          options.each(function() {
            selected += $(this).text() + ', ';
          });
          return selected.substr(0, selected.length -2) + ' <b class="caret"></b>';
        }
      }
    });

    });

	<cfif #CGI.HTTP_USER_AGENT# CONTAINS "MSIE">
		var urlstart = './fundsbycountrylist?'
	<cfelse>
		var urlstart = 'index.cfm/reports/fundsbycountrylist?'
	</cfif>


    //LEAFLET
    var theworld =<cfoutput>#rc.jstring#</cfoutput>

    var geojson=L.geoJson(theworld, {style: style,onEachFeature: onEachFeature});



    <cfif len(rc.countrylist)>
		var map = L.map('map').fitBounds(geojson.getBounds());
	<cfelse>
		var map = L.map('map').setView([-15.0,20.0], 2);
	</cfif>

	//L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
		//    attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'}).addTo(map);

	L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}', {
		attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ',
		maxZoom: 16
	}).addTo(map);



	// create fullscreen control
		var fullScreen = new L.Control.FullScreen();
		// add fullscreen control to the map
		map.addControl(fullScreen);

		// detect fullscreen toggling
		map.on('enterFullscreen', function(){
			if(window.console) window.console.log('enterFullscreen');
		});
		map.on('exitFullscreen', function(){
			if(window.console) window.console.log('exitFullscreen');
		});


		function getColor(d) {
		    return d > 90000000 ? '#722D29' :
			   d > 50000000  ? '#8A4D4A' :
			   d > 30000000  ? '#D09B98' :
			   d > 15000000  ? '#1A4246' :
			   d > 7500000  ? '#42666A' :
			   d > 3000000  ? '#819799' :
			   d > 1000000   ? '#8A754A' :
			   d > 250000   ? '#AD986B' :
				      '#D0BE98';
		}

		function style(feature) {
		    return {
			fillColor: getColor(feature.properties.budgetplain),
			weight: .5,
			opacity: 1,
			color: 'black',
			dashArray: '',
			fillOpacity: 0.7
		    };
		}
		function highlightFeature(e) {
		    var layer = e.target;

		    layer.setStyle({

			weight: .5,
			color: '#cccccc',
			dashArray: '',
			fillOpacity: 0.5
		    });

			info.update(layer.feature.properties);

		    if (!L.Browser.ie && !L.Browser.opera) {
			layer.bringToFront();
		    }
		}

		function resetHighlight(e) {
		    geojson.resetStyle(e.target);
			info.update();
		}
		function zoomToFeature(e) {
		    map.fitBounds(e.target.getBounds());
		}
		//Now we’ll use the onEachFeature option to add the listeners on our state layers:

		function onEachFeature(feature, layer) {
		    layer.on({
			mouseover: highlightFeature,
			mouseout: resetHighlight,
			click: (function() {
  					window.location = urlstart + feature.properties.queryparam
  					return false;
					})
		    });
		}
		var info = L.control();

		info.onAdd = function (map) {
		    this._div = L.DomUtil.create('div', 'info top-block'); // create a div with a class "info"
		    this.update();
		    return this._div;
		};

		// method that we will use to update the control based on feature properties passed
		info.update = function (props) {
		    this._div.innerHTML = (props ?
			'<b>' + props.name + '</b><br />'
			+ 'Total Budget Requested: ' + props.budget + '<br />'
			: 'Hover over a highlighted country,<br>click to view profile');
		};

		info.addTo(map);

		var legend = L.control({position: 'bottomright'});

		legend.onAdd = function (map) {

			var div = L.DomUtil.create('div', 'info legend'),
				grades = [0, 250000, 1000000, 3000000, 7500000, 15000000, 30000000, 50000000, 90000000],
				labels = [];
				div.innerHTML = '<b>Budget Color Scale</b><br>'

			// loop through our density intervals and generate a label with a colored square for each interval
			for (var i = 0; i < grades.length; i++) {
				div.innerHTML +=
					'<div><i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
					grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '</div>' : '+</div>');
			}

			return div;
		};

		legend.addTo(map);

		geojson.addTo(map);


				$('#map').width($('#mapcontainer').width());

			$('#map').height(770);

</script>





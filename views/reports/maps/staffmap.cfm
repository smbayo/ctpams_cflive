	<div id="map"></div>
	<div id="cargando">Loading Data Sets...</div>
	<div id="maptitle">Bureau of Counterterrorism Field Units<div id="subtitle">Use layer control at top right to view different field units</div></div>
	

	

	
<script language="JavaScript">					

		var map = L.map('map').setView([10.0,20.0], 3);
		
		L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Light_Gray_Base/MapServer/tile/{z}/{y}/{x}', {
		attribution: 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ',
		maxZoom: 16
		}).addTo(map);
		
		var MarkerIcon = L.Icon.extend({
		    options: {
		       // shadowUrl: 'includes/images/marker-shadow.png'
		    }
		});
		
	var greenIcon = new MarkerIcon({iconUrl: 'includes/images/mgreen.png', iconAnchor: [22, 40], popupAnchor: [-10, -38]}),
    redIcon = new MarkerIcon({iconUrl: 'includes/images/mred.png', iconAnchor: [4, 35], popupAnchor: [22, -32]}),
    blueIcon = new MarkerIcon({iconUrl: 'includes/images/mblue.png', iconAnchor: [10, 41], popupAnchor: [10, -39]}),
    orangeIcon = new MarkerIcon({iconUrl: 'includes/images/morange.png', iconAnchor: [35, 36], popupAnchor: [-24, -30]});
    
var baseMaps = {};
var overlayMaps = {};
var maplayers = L.control.layers(baseMaps, overlayMaps).addTo(map);
loadrsi();

var legend = L.control({position: 'bottomright'});

legend.onAdd = function (map) {

	var div = L.DomUtil.create('div', 'info legend');
	div.innerHTML = '';
	div.innerHTML += '<div><i style="background:#F6962F"></i>RSI Field Coordinator</div><br>';
	div.innerHTML += '<div><i style="background:#93C926"></i>ATA Resident PM/Support Staff</div><br>';
	div.innerHTML += '<div><i style="background:#E84B37"></i>RLA/ILA</div><br>';
	div.innerHTML += '<div><i style="background:#39ADE2"></i>Other</div>';
	return div;
};

		legend.addTo(map);


function loadata() {
	var ata = L.geoCsv(null, {
		onEachFeature: function (feature, layer) {
			var popup = '';
			for (var clave in feature.properties) {
				var title = ata.getPropertyTitle(clave);
				popup += '<b>'+title+'</b><br />'+feature.properties[clave]+'<br /><br />';
			}
			layer.bindPopup(popup);
		},
		pointToLayer: function (feature, latlng) {
		    var zmark = L.marker(latlng, {icon: greenIcon}, zIndexOffset=300).addTo(map);
			return zmark;
		},
		firstLineTitles: true, fieldSeparator: ','
	});
	
	$.ajax ({
		type:'GET',
		dataType:'text',
		url:'includes/data/ata.csv',
	   error: function() {
	     alert('There was an error uploading the ATA data set');
	   },
		success: function(csv) {
			ata.addData(csv);
			map.addLayer(ata);
			maplayers.addOverlay(ata,"ATA Resident PM/Support Staff");
			
		},
	   complete: function() {
	   	  loadrla();
	   }
	});
}


function loadother() {
	var other = L.geoCsv(null, {
		onEachFeature: function (feature, layer) {
			var popup = '';
			for (var clave in feature.properties) {
				var title = other.getPropertyTitle(clave);
				popup += '<b>'+title+'</b><br />'+feature.properties[clave]+'<br /><br />';
			}
			layer.bindPopup(popup);
		}, 
	pointToLayer: function (feature, latlng) {
			var zmark = L.marker(latlng, {icon: blueIcon}, zIndexOffset=500).addTo(map);
			return zmark;
		},
		firstLineTitles: true, fieldSeparator: ','
	});
	
	$.ajax ({
		type:'GET',
		dataType:'text',
		url:'includes/data/other.csv',
	   error: function() {
	     alert('There was an error uploading the Other data set');
	   },
		success: function(csv) {
			other.addData(csv);
			map.addLayer(other);
			maplayers.addOverlay(other,"Other");

		},
	   complete: function() {
	   	  checkAdd();
	   }
	});
}


function loadrsi() {
	var rsi = L.geoCsv(null, {
		onEachFeature: function (feature, layer) {
			var popup = '';
			for (var clave in feature.properties) {
				var title = rsi.getPropertyTitle(clave);
				popup += '<b>'+title+'</b><br />'+feature.properties[clave]+'<br /><br />';
			}
			layer.bindPopup(popup);
		},
		pointToLayer: function (feature, latlng) {
			var zmark = L.marker(latlng, {icon: orangeIcon}, zIndexOffset=1000).addTo(map);
			return zmark;
		},
		firstLineTitles: true, fieldSeparator: ','
	});
	
	
	$.ajax ({
		type:'GET',
		dataType:'text',
		url:'includes/data/rsi.csv',
	   error: function() {
	     alert('There was an error uploading the RSI data set');
	   },
		success: function(csv) {
			rsi.addData(csv);
			map.addLayer(rsi);
			maplayers.addOverlay(rsi,"RSI Field Coordinator");
			
		},
	   complete: function() {
	   	  loadata();
	   }
	});
}


function loadrla() {
	var rla = L.geoCsv(null, {
		onEachFeature: function (feature, layer) {
			var popup = '';
			for (var clave in feature.properties) {
				var title = rla.getPropertyTitle(clave);
				popup += '<b>'+title+'</b><br />'+feature.properties[clave]+'<br /><br />';
			}
			layer.bindPopup(popup);
		},
		pointToLayer: function (feature, latlng) {
			var zmark = L.marker(latlng, {icon:redIcon}, zIndexOffset=-1000).addTo(map);
			return zmark;
		},
		firstLineTitles: true, fieldSeparator: ','
	});
	
	
	$.ajax ({
		type:'GET',
		dataType:'text',
		url:'includes/data/rla.csv',
	   error: function() {
	     alert('There was an error uploading the RLA data set');
	   },
		success: function(csv) {
			rla.addData(csv);
			map.addLayer(rla);
			maplayers.addOverlay(rla,"RLA/ILA");
			
		},
	   complete: function() {
	   	  loadother();
	   }
	});
}

function checkAdd() {
	  $('#cargando').delay(500).fadeOut('slow');
}




</script>

	





	




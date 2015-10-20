
<!DOCTYPE html>
<html lang="en">
<head>

	<title>PAMS</title>

	<cfoutput>
		<base href="#getSetting('htmlBaseURL')#">
	</cfoutput>

<link rel="stylesheet" href="includes/styles/leaflet.css" />

<link href="includes/styles/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="includes/styles/leaflet.awesome-markers.css">

<script src="includes/javascript/leaflet.js"></script>
<script src="includes/javascript/leaflet.geocsv.js"></script>
<script src="includes/javascript/jquery-2.1.3.min.js"></script>
<script src="includes/javascript/leaflet.awesome-markers.min.js"></script>

	<style>
		html, body, #map {
      height:100%;
      width:100%;
      padding:0px;
      margin:0px;
   }

   #cargando {
			position:fixed;
			top:0;
			left:0;
			width:100%;
			height:100%;
			background-color:#666;
			color:#fff;
			font-size:2em;
			padding:20% 40%;
			z-index:10;
		}

		#maptitle {
			position:fixed;
			top:0;
			left:0;
			width: 100%;
			height:50px;
			//background-color:#fff;
			background: rgb(255, 255, 255);
            background: rgba(255, 255, 255, .5);
			color:#666;
			font-size:2em;
			padding:16px 60px;
			z-index:9;
			font-family: Arial, Helvetica, sans-serif;
		}
		#subtitle {
			position:relative;
			top:40;
			left:0;
			color:#666;
			font-size: 13px;
			z-index:58;
			font-family: Arial, Helvetica, sans-serif;
		}
		.info {
			padding: 6px 8px;
			font: 14px/16px Arial, Helvetica, sans-serif;
			background: white;
			background: rgba(255,255,255,0.8);
			box-shadow: 0 0 15px rgba(0,0,0,0.2);
			border-radius: 5px;
			text-align: left;
			width: 240px;
		}
		.legend i {
			width: 18px;
			height: 18px;
			float: left;
			margin-right: 8px;
			opacity: 1;
		}



	</style>




</head>
	<body>




		      <!------------------------------------------------------ Begin Page Content ------------------------------------------------------>
						<!--- Render The View. This is set wherever you want to render the view in your Layout. --->
						 <cfoutput>#renderView()#</cfoutput>
		      <!------------------------------------------------------ End Page Content ------------------------------------------------------>



	</body>
</html>
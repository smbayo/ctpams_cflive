<cfcomponent name="attachedFile" extends="coldbox.system.EventHandler" autowire="true">

	<!--- Inject Dependencies --->
	<cfproperty name="AttachedFileGateway" inject="model" scope="instance" />
	<cfproperty name="AttachedFileService" inject="model" scope="instance" />	

	<cffunction name="index" returntype="void" output="false" hint="view attachment">
		<cfargument name="event" required="true">
		<cfset var rc = event.getCollection()>

		<!--- prepare file  --->
		<cfset rc.FileMimeType = "" />
		<cfset rc.attachedFilePath = getPlugin("FileUtils").getAbsolutePath("attachedFiles") />
		<cfset rc.attachedFile =  instance.AttachedFileGateway.getByAttributesQuery(AttachedFileID=rc.AttachedFileID) />
		
		
		<cfset var fileExtension = "" />
		<cfset var mimeStruct = structNew() />
		
		<!--- build mime type array --->
		<cfset mimeStruct.ai = "application/postscript" />
		<cfset mimeStruct.aif = "audio/x-aiff" />
		<cfset mimeStruct.aifc = "audio/x-aiff" />
		<cfset mimeStruct.aiff = "audio/x-aiff" />
		<cfset mimeStruct.asc = "text/plain" />
		<cfset mimeStruct.au = "audio/basic" />
		<cfset mimeStruct.avi = "video/x-msvideo" />
		<cfset mimeStruct.bcpio = "application/x-bcpio" />
		<cfset mimeStruct.bin = "application/octet-stream" />
		<cfset mimeStruct.c = "text/plain" />
		<cfset mimeStruct.cc = "text/plain" />
		<cfset mimeStruct.ccad = "application/clariscad" />
		<cfset mimeStruct.cdf = "application/x-netcdf" />
		<cfset mimeStruct.class = "application/octet-stream" />
		<cfset mimeStruct.cpio = "application/x-cpio" />
		<cfset mimeStruct.cpt = "application/mac-compactpro" />
		<cfset mimeStruct.csh = "application/x-csh" />
		<cfset mimeStruct.css = "text/css" />
		<cfset mimeStruct.dcr = "application/x-director" />
		<cfset mimeStruct.dir = "application/x-director" />
		<cfset mimeStruct.dms = "application/octet-stream" />
		<cfset mimeStruct.doc = "application/msword" />
		<cfset mimeStruct.docx = "application/msword" />
		<cfset mimeStruct.drw = "application/drafting" />
		<cfset mimeStruct.dvi = "application/x-dvi" />
		<cfset mimeStruct.dwg = "application/acad" />
		<cfset mimeStruct.dxf = "application/dxf" />
		<cfset mimeStruct.dxr = "application/x-director" />
		<cfset mimeStruct.eps = "application/postscript" />
		<cfset mimeStruct.etx = "text/x-setext" />
		<cfset mimeStruct.exe = "application/octet-stream" />
		<cfset mimeStruct.ez = "application/andrew-inset" />
		<cfset mimeStruct.f = "text/plain" />
		<cfset mimeStruct.f90 = "text/plain" />
		<cfset mimeStruct.fli = "video/x-fli" />
		<cfset mimeStruct.gif = "image/gif" />
		<cfset mimeStruct.gtar = "application/x-gtar" />
		<cfset mimeStruct.gz = "application/x-gzip" />
		<cfset mimeStruct.h = "text/plain" />
		<cfset mimeStruct.hdf = "application/x-hdf" />
		<cfset mimeStruct.hh = "text/plain" />
		<cfset mimeStruct.hqx = "application/mac-binhex40" />
		<cfset mimeStruct.htm = "text/html" />
		<cfset mimeStruct.html = "text/html" />
		<cfset mimeStruct.ice = "x-conference/x-cooltalk" />
		<cfset mimeStruct.ief = "image/ief" />
		<cfset mimeStruct.iges = "model/iges" />
		<cfset mimeStruct.igs = "model/iges" />
		<cfset mimeStruct.ips = "application/x-ipscript" />
		<cfset mimeStruct.ipx = "application/x-ipix" />
		<cfset mimeStruct.jpe = "image/jpeg" />
		<cfset mimeStruct.jpeg = "image/jpeg" />
		<cfset mimeStruct.jpg = "image/jpeg" />
		<cfset mimeStruct.js = "application/x-javascript" />
		<cfset mimeStruct.kar = "audio/midi" />
		<cfset mimeStruct.latex = "application/x-latex" />
		<cfset mimeStruct.lha = "application/octet-stream" />
		<cfset mimeStruct.lsp = "application/x-lisp" />
		<cfset mimeStruct.lzh = "application/octet-stream" />
		<cfset mimeStruct.m = "text/plain" />
		<cfset mimeStruct.man = "application/x-troff-man" />
		<cfset mimeStruct.me = "application/x-troff-me" />
		<cfset mimeStruct.mesh = "model/mesh" />
		<cfset mimeStruct.mid = "audio/midi" />
		<cfset mimeStruct.midi = "audio/midi" />
		<cfset mimeStruct.mif = "application/vnd.mif" />
		<cfset mimeStruct.mime = "www/mime" />
		<cfset mimeStruct.mov = "video/quicktime" />
		<cfset mimeStruct.movie = "video/x-sgi-movie" />
		<cfset mimeStruct.mp2 = "audio/mpeg" />
		<cfset mimeStruct.mp3 = "audio/mpeg" />
		<cfset mimeStruct.mpe = "video/mpeg" />
		<cfset mimeStruct.mpeg = "video/mpeg" />
		<cfset mimeStruct.mpg = "video/mpeg" />
		<cfset mimeStruct.mpga = "audio/mpeg" />
		<cfset mimeStruct.ms = "application/x-troff-ms" />
		<cfset mimeStruct.msh = "model/mesh" />
		<cfset mimeStruct.nc = "application/x-netcdf" />
		<cfset mimeStruct.oda = "application/oda" />
		<cfset mimeStruct.pbm = "image/x-portable-bitmap" />
		<cfset mimeStruct.pdb = "chemical/x-pdb" />
		<cfset mimeStruct.pdf = "application/pdf" />
		<cfset mimeStruct.pgm = "image/x-portable-graymap" />
		<cfset mimeStruct.pgn = "application/x-chess-pgn" />
		<cfset mimeStruct.png = "image/png" />
		<cfset mimeStruct.pnm = "image/x-portable-anymap" />
		<cfset mimeStruct.pot = "application/mspowerpoint" />
		<cfset mimeStruct.ppm = "image/x-portable-pixmap" />
		<cfset mimeStruct.pps = "application/mspowerpoint" />
		<cfset mimeStruct.ppt = "application/mspowerpoint" />
		<cfset mimeStruct.ppz = "application/mspowerpoint" />
		<cfset mimeStruct.pre = "application/x-freelance" />
		<cfset mimeStruct.prt = "application/pro_eng" />
		<cfset mimeStruct.ps = "application/postscript" />
		<cfset mimeStruct.qt = "video/quicktime" />
		<cfset mimeStruct.ra = "audio/x-realaudio" />
		<cfset mimeStruct.ram = "audio/x-pn-realaudio" />
		<cfset mimeStruct.ras = "image/cmu-raster" />
		<cfset mimeStruct.rgb = "image/x-rgb" />
		<cfset mimeStruct.rm = "audio/x-pn-realaudio" />
		<cfset mimeStruct.roff = "application/x-troff" />
		<cfset mimeStruct.rpm = "audio/x-pn-realaudio-plugin" />
		<cfset mimeStruct.rtf = "text/rtf" />
		<cfset mimeStruct.rtx = "text/richtext" />
		<cfset mimeStruct.scm = "application/x-lotusscreencam" />
		<cfset mimeStruct.set = "application/set" />
		<cfset mimeStruct.sgm = "text/sgml" />
		<cfset mimeStruct.sgml = "text/sgml" />
		<cfset mimeStruct.sh = "application/x-sh" />
		<cfset mimeStruct.shar = "application/x-shar" />
		<cfset mimeStruct.silo = "model/mesh" />
		<cfset mimeStruct.sit = "application/x-stuffit" />
		<cfset mimeStruct.skd = "application/x-koan" />
		<cfset mimeStruct.skm = "application/x-koan" />
		<cfset mimeStruct.skp = "application/x-koan" />
		<cfset mimeStruct.skt = "application/x-koan" />
		<cfset mimeStruct.smi = "application/smil" />
		<cfset mimeStruct.smil = "application/smil" />
		<cfset mimeStruct.snd = "audio/basic" />
		<cfset mimeStruct.sol = "application/solids" />
		<cfset mimeStruct.spl = "application/x-futuresplash" />
		<cfset mimeStruct.src = "application/x-wais-source" />
		<cfset mimeStruct.step = "application/STEP" />
		<cfset mimeStruct.stl = "application/SLA" />
		<cfset mimeStruct.stp = "application/STEP" />
		<cfset mimeStruct.sv4cpio = "application/x-sv4cpio" />
		<cfset mimeStruct.sv4crc = "application/x-sv4crc" />
		<cfset mimeStruct.swf = "application/x-shockwave-flash" />
		<cfset mimeStruct.t = "application/x-troff" />
		<cfset mimeStruct.tar = "application/x-tar" />
		<cfset mimeStruct.tcl = "application/x-tcl" />
		<cfset mimeStruct.tex = "application/x-tex" />
		<cfset mimeStruct.texi = "application/x-texinfo" />
		<cfset mimeStruct.texinfo = "application/x-texinfo" />
		<cfset mimeStruct.tif = "image/tiff" />
		<cfset mimeStruct.tiff = "image/tiff" />
		<cfset mimeStruct.tr = "application/x-troff" />
		<cfset mimeStruct.tsi = "audio/TSP-audio" />
		<cfset mimeStruct.tsp = "application/dsptype" />
		<cfset mimeStruct.tsv = "text/tab-separated-values" />
		<cfset mimeStruct.txt = "text/plain" />
		<cfset mimeStruct.unv = "application/i-deas" />
		<cfset mimeStruct.ustar = "application/x-ustar" />
		<cfset mimeStruct.vcd = "application/x-cdlink" />
		<cfset mimeStruct.vda = "application/vda" />
		<cfset mimeStruct.viv = "video/vnd.vivo" />
		<cfset mimeStruct.vivo = "video/vnd.vivo" />
		<cfset mimeStruct.vrml = "model/vrml" />
		<cfset mimeStruct.wav = "audio/x-wav" />
		<cfset mimeStruct.wrl = "model/vrml" />
		<cfset mimeStruct.xbm = "image/x-xbitmap" />
		<cfset mimeStruct.xlc = "application/vnd.ms-excel" />
		<cfset mimeStruct.xll = "application/vnd.ms-excel" />
		<cfset mimeStruct.xlm = "application/vnd.ms-excel" />
		<cfset mimeStruct.xls = "application/vnd.ms-excel" />
		<cfset mimeStruct.xlsx = "application/vnd.ms-excel" />
		<cfset mimeStruct.xlw = "application/vnd.ms-excel" />
		<cfset mimeStruct.xml = "text/xml" />
		<cfset mimeStruct.xpm = "image/x-xpixmap" />
		<cfset mimeStruct.xwd = "image/x-xwindowdump" />
		<cfset mimeStruct.xyz = "chemical/x-pdb" />
		<cfset mimeStruct.zip = "application/zip" />			

		<!--- file extension --->
		<cfset fileExtension = Reverse(SpanExcluding(Reverse(rc.attachedFile.AttachedFileName),".")) />
		
		<cfif structKeyExists(mimeStruct,fileExtension)>
			<cfset rc.FileMimeType = mimeStruct[fileExtension] />
		<cfelse>
			<cfset rc.FileMimeType = "unknown/unknown" />
		</cfif>
		
		<cfset rc.PageTitle = "#rc.attachedFile.AttachedFileName#">
		<cfset event.setView("attachedFile/index","true")>
	</cffunction>

</cfcomponent>
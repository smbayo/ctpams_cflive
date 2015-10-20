
<cfheader name="Content-Disposition" value="attachment; filename=#rc.attachedFile.AttachedFileName#"><!--- attachment inline --->
<cfcontent type="#rc.FileMimeType#" file="#rc.attachedFilePath#\#rc.attachedFile.AttachedFileName#" deletefile="no">

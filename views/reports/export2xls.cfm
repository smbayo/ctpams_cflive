<!--- Open / Download Spreadsheet File --->
<cfheader name="content-disposition" value="inline;filename=sct_report.xls">
<cfheader name="Expires" value="#now()#">
<cfcontent type="application/vnd.ms-excel" file="#GetTempDirectory()#sct_report.xls" deletefile="yes" reset="true" />

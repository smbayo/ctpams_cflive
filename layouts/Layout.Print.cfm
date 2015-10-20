<cfsavecontent variable="strWordData2">

<cfset oSession = getPlugin("SessionStorage")>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>

CT Project Management System</title>
<cfoutput>
	<base href="#getSetting('htmlBaseURL')#">
</cfoutput>



<!--- <link rel="stylesheet" href="includes/styles/core/print.css" type="text/css" media="print"> --->
<!--[if lt IE 7]><link rel="stylesheet" href="includes/styles/css/ie.css" type="text/css" media="screen, projection"><![endif]-->


</head>
<body>


<div class="wrapper">
	<div class="container">

		  
		<div class=" span-24 content ">
			<!-- skipnav -->
			<div>
				<cfoutput>

						<table>
							<tr>
								<td class="firstTD">Proposal: </td>
								<td><strong>#uCase(rc.projectTitle)#</strong></td>
							</tr>
							<tr>
								<td class="firstTD">Proposal ##: </td>
								<td><strong>#uCase(rc.proposal.proposalnumber)#</strong></td>
							</tr>
							<tr>
								<td class="firstTD"> Funding Requested: </td>
								<td><strong>
									#dollarFormat(rc.proposal.budgetCeilingAmount)#</strong></td>
							</tr>
							<tr>
								<td class="firstTD">Status: </td>
								<td><strong>#rc.progressStatus#</strong></td>
							</tr>

							<tr>
								<td class="firstTD  age"> Age: </td>
								<td><strong>#rc.progressAge# day(s)</strong></td>
							</tr>
							<tr>
								<td class="firstTD date"> Submit Date:</td>
								<td class="days"><strong>
									#dateFormat(rc.proposal.proposalSubmitDate,'dd mmm yyyy')#</strong></td>
							</tr>
						</table>

				</cfoutput>

			</div>
			
			<!------------------------------------------------------ Begin Page Content ------------------------------------------------------>
			<!--- Render The View. This is set wherever you want to render the view in your Layout. --->
			<cfoutput>#renderView()#</cfoutput>
			<!------------------------------------------------------ End Page Content ------------------------------------------------------>
		</div>

	</div>



	<br>

</body>
</html>

</cfsavecontent>

<cfheader name="Content-Disposition" value="attachment; filename=printproposal.doc"/>
					
				
<cfcontent
type="application/msword"
variable="#ToBinary( ToBase64( strWordData2.Trim() ) )#"
/>

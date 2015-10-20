<cfif cgi.SERVER_NAME is 'ctprogramstest.com'>
		<cfset expPath = "http://ctprogramstest.com/">
<cfelseif cgi.SERVER_NAME is '127.0.0.1'>
		<cfset expPath = "http://127.0.0.1/ct-pams/">
<cfelse>
		<cfset expPath = "https://www.ctprograms.com/">
</cfif>

<cfdocument format="pdf" orientation = "landscape" fontEmbed = "no">

<cfscript>
/**
* Fixes text using Microsoft Latin-1 &quot;Extentions&quot;, namely ASCII characters 128-160.
*
* @param text      Text to be modified. (Required)
* @return Returns a string.
* @author Shawn Porter (sporter@rit.net)
* @version 1, June 16, 2004
*/
function DeMoronize (text) {
    var i = 0;

// map incompatible non-ISO characters into plausible
    // substitutes
    text = Replace(text, Chr(128), "&euro;", "All");

    text = Replace(text, Chr(130), ",", "All");
    text = Replace(text, Chr(131), "<em>f</em>", "All");
    text = Replace(text, Chr(132), ",,", "All");
    text = Replace(text, Chr(133), "...", "All");

    text = Replace(text, Chr(136), "^", "All");

    text = Replace(text, Chr(139), ")", "All");
    text = Replace(text, Chr(140), "Oe", "All");

    text = Replace(text, Chr(145), "`", "All");

	text = Replace(text, Chr(145), "â€™", "All");
	text = Replace(text, Chr(149), "â?¢", "All");
	text = Replace(text, "•", "*", "All");
	text = Replace(text, "–", "-", "All");
	text = Replace(text, "—", "-", "All");
    text = Replace(text, Chr(146), "'", "All");
    text = Replace(text, Chr(147), """", "All");
    text = Replace(text, Chr(148), """", "All");
    text = Replace(text, Chr(149), "*", "All");
    text = Replace(text, Chr(150), "-", "All");
    text = Replace(text, Chr(151), "--", "All");
    text = Replace(text, Chr(152), "~", "All");
    text = Replace(text, Chr(153), "&trade;", "All");

    text = Replace(text, Chr(155), ")", "All");
    text = Replace(text, Chr(156), "oe", "All");

    // remove any remaining ASCII 128-159 characters
    for (i = 128; i LTE 159; i = i + 1)
        text = Replace(text, Chr(i), "", "All");

    // map Latin-1 supplemental characters into
    // their &name; encoded substitutes
    text = Replace(text, Chr(160), "&nbsp;", "All");

    text = Replace(text, Chr(163), "&pound;", "All");

    text = Replace(text, Chr(169), "&copy;", "All");

    text = Replace(text, Chr(176), "&deg;", "All");

    // encode ASCII 160-255 using Ï§ format
    for (i = 160; i LTE 255; i = i + 1)
        text = REReplace(text, "(#Chr(i)#)", "&###i#;", "All");

// supply missing semicolon at end of numeric entities
    text = ReReplace(text, "&##([0-2][[:digit:]]{2})([^;])", "&##\1;\2", "All");

// fix obscure numeric rendering of &lt; &gt; &amp;
    text = ReReplace(text, "&##038;", "&amp;", "All");
    text = ReReplace(text, "&##060;", "&lt;", "All");
    text = ReReplace(text, "&##062;", "&gt;", "All");

    // supply missing semicolon at the end of &amp; &quot;
    text = ReReplace(text, "&amp(^;)", "&amp;\1", "All");
    text = ReReplace(text, "&quot(^;)", "&quot;\1", "All");


	text = Replace(text, "’", "'", "All");
	text = Replace(text, "“", """", "All");
	text = Replace(text, "”", """", "All");
    return text;
}
</cfscript>

<html>

<head>


</head>

<body>

	<table style=" background-color:#a6a6a6; width=100%" width="100%" cellspacing="14" cellpadding="0">
		<tr valign="middle">
			<td width="180"><img width="140" height="140" src="<cfoutput>#expPath#</cfoutput>includes/images/usdos-logo-seal.gif" style="float:left;">
			</td>
			<td><span style="color: #ffffff; font-size: 11px;">
				U.S. Department of State<br></span>
				<span style="color: #ffffff; font-size: 28px;">CT Foreign Assistance<br></span>
				<span style="color: #ffffff; font-size: 18px;">Region Funding<br></span>
				<span style="color: #254061; font-size: 26px;"><cfoutput>#rc.region#</cfoutput></span>
			</td>
		</tr>
	</table><br><br><br>

<table border="0" cellspacing="0" cellpadding="0" width="100%">

<tr>

<td><img width="550" height="460" src="<cfoutput>#expPath#</cfoutput>includes/images/generated/<cfoutput>#rc.imagenamebar#</cfoutput>.jpg"></td>


<td><img width="550" height="460" src="<cfoutput>#expPath#</cfoutput>includes/images/generated/<cfoutput>#rc.imagenamepie#</cfoutput>.jpg"></td>

</tr>
</table>

<div style="page-break-after:always;">&nbsp;</div>

<table cellspacing="0" cellpadding="5" align=center width="100%">
 <thead>
  <tr>
   <td nowrap colspan="8"style='border:solid black 1.0pt;background:#254061;color:white;font-size:16.0pt;font-family:arial,sans-serif;'>
   <cfoutput>#rc.region#</cfoutput> CT Projects
   </td>
  </tr>
  <tr>
   <td valign="bottom" style='border-top:none;border-left:solid black 1.0pt;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   Proposal Number
   </td>
   <td valign="bottom" style='border-top:none;border-left:none;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   Project Title
   </td>
   <td valign="bottom" style='border-top:none;border-left:none;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   Requested Amount
   </td>
   <td valign="bottom" style='border-top:none;border-left:none;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   Status
   </td>
   <td valign="bottom" style='border-top:none;border-left:none;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   Project Summary
   </td>
   <td valign="bottom" style='border-top:none;border-left:none;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   Regions
   </td>
   <td valign="bottom" style='border-top:none;border-left:none;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   Implementing Partner
   </td>
   <td valign="bottom" style='border-top:none;border-left:none;border-bottom:none;border-right:solid black 1.0pt;background:#254061;color:white;font-size:12.0pt;font-family:arial,sans-serif;'>
   FY
   </td>
  </tr>
 </thead>
 <cfset totalall=0>
<cfset totalcountry=0>
<cfoutput query="rc.byregion">
 <tr>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:solid black 1.0pt;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
  #Demoronize(trim(uCase(proposalNumber)))#
  </td>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
  #Demoronize(trim(proposalname))#
  </td>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
  #Demoronize(trim(dollarFormat(budgetceilingamount)))#
  </td>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
	<cfif len(implementationstatus) gt 0 and activitystatus is "program fully obligated">
		#Demoronize(trim(implementationstatus))#
	<cfelse>
		#Demoronize(trim(activitystatus))#
	</cfif>
  </td>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
   <div>#Demoronize(trim(projectObjective))#</div>
  </td>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
  #Demoronize(trim(region))#
  </td>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
  #Demoronize(trim(implementer))#
  </td>
  <td valign="top" style='border-top:solid black 1.0pt;border-left:none;border-bottom:solid black 1.0pt;border-right:solid black 1.0pt;font-family:arial,sans-serif;'>
  #Demoronize(trim(fy))#
  </td>
 </tr>
 <cfif budgetceilingamount gt 0>
	<cfset totalall=totalall + budgetceilingamount>
</cfif>
<cfif budgetamount gt 0>
	<cfset totalcountry=totalcountry + budgetamount>
</cfif>
</cfoutput>
</table>

<p class=MsoNormal>&nbsp;</p>

</div>

 <span style='font-size:12.0pt;
  font-family:"Arial","sans-serif"'>Total requested
  $ requested for projects including <cfoutput>#rc.region#</cfoutput>:<b><cfoutput>#Demoronize(trim(dollarFormat(totalall)))#</cfoutput></b></span><br>
<span style='font-size:12.0pt;
  font-family:"Arial","sans-serif"'>Total
  $ allocated to <cfoutput>#rc.region#</cfoutput> for projects in <cfif rc.fy is "">FY2010-FY<CFOUTPUT>#year(now())#</CFOUTPUT><cfelse>FY<cfoutput>#rc.fy#</cfoutput></cfif>:<b><cfoutput>#Demoronize(trim(dollarFormat(totalcountry)))#</cfoutput></b></span>
</body>

</html>

</cfdocument>
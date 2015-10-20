<cfif cgi.SERVER_NAME is 'ctprogramstest.com'>
		<cfset expPath = "http://ctprogramstest.com/">
<cfelseif cgi.SERVER_NAME is '127.0.0.1'>
		<cfset expPath = "http://127.0.0.1/ct-pams/">
<cfelse>
		<cfset expPath = "http://www.ctprograms.com/">
</cfif>

<cfsavecontent variable="strWordData2">

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
<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
<meta name=Generator content="Microsoft Word 14 (filtered)">
<style>

 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	line-height:115%;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
p.MsoHeader, li.MsoHeader, div.MsoHeader
	{mso-style-link:"Header Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
p.MsoFooter, li.MsoFooter, div.MsoFooter
	{mso-style-link:"Footer Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
p
	{margin-right:0in;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:.5in;
	line-height:115%;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
span.HeaderChar
	{mso-style-name:"Header Char";
	mso-style-link:Header;}
span.FooterChar
	{mso-style-name:"Footer Char";
	mso-style-link:Footer;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
p.msolistparagraphcxspfirst, li.msolistparagraphcxspfirst, div.msolistparagraphcxspfirst
	{mso-style-name:msolistparagraphcxspfirst;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	line-height:115%;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
p.msolistparagraphcxspmiddle, li.msolistparagraphcxspmiddle, div.msolistparagraphcxspmiddle
	{mso-style-name:msolistparagraphcxspmiddle;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	line-height:115%;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
p.msolistparagraphcxsplast, li.msolistparagraphcxsplast, div.msolistparagraphcxsplast
	{mso-style-name:msolistparagraphcxsplast;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:.5in;
	line-height:115%;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
p.msochpdefault, li.msochpdefault, div.msochpdefault
	{mso-style-name:msochpdefault;
	margin-right:0in;
	margin-left:0in;
	font-size:14.0pt;
	font-family:"Times New Roman","serif";}
p.msopapdefault, li.msopapdefault, div.msopapdefault
	{mso-style-name:msopapdefault;
	margin-right:0in;
	margin-bottom:10.0pt;
	margin-left:0in;
	line-height:115%;
	font-size:12.0pt;
	font-family:"Times New Roman","serif";}
.MsoChpDefault
	{font-size:14.0pt;}
.MsoPapDefault
	{margin-bottom:10.0pt;
	line-height:115%;}
@page WordSection1
	{size:8.5in 11in;
	margin:.5in .5in .5in .5in;
	border:solid windowtext 1.0pt;
	padding:24.0pt 1.0pt 24.0pt 1.0pt;}
div.WordSection1
	{page:WordSection1;}

</style>

</head>

<body lang=EN-US>

	<table style="background:transparent; background-color:#a6a6a6; width=100%" width="100%">
		<tr valign="middle">
			<td width="180"><img width=140 height=140 src="<cfoutput>#expPath#</cfoutput>includes/images/usdos-logo-seal.gif" style="float:left;">
			</td>
			<td>
				<span style="color: white; font-size: 10px;">U.S. Department of State</span><br>
				<span style="color: white; font-size: 30px;">CT Foreign Assistance</span><br>
				<span style="color: white; font-size: 20px;">Organization Funding</span><br>
				<span style="color: #254061; font-size: 26px;"><cfoutput>#rc.organization#</cfoutput></span>
			</td>
		</tr>
	</table><br>


<div class=WordSection1>

<p class=MsoNormal style='margin-bottom:12.0pt'><span style='font-size:12.0pt; line-height:115%'>

<img width=480 height=400 src="<cfoutput>#expPath#</cfoutput>includes/images/generated/<cfoutput>#rc.imagenamebar#</cfoutput>.jpg">

</span>
<span style='font-size:12.0pt;line-height:115%'>
<img width=480 height=400 src="<cfoutput>#expPath#</cfoutput>includes/images/generated/<cfoutput>#rc.imagenamepie#</cfoutput>.jpg">

</span></p>



<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>&nbsp;</p>

<p class=MsoNormal>&nbsp;</p>

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0
 style='margin-left:-.05in;border-collapse:collapse' align=center>
 <thead>
  <tr style='page-break-inside:avoid;height:20.25pt'>
   <td nowrap colspan=8 valign=bottom style='
   border:solid windowtext 1.0pt;background:#254061;padding:0in 5.4pt 0in 5.4pt;
   height:20.25pt'>
   <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;
   line-height:normal'><span style='font-size:16.0pt;font-family:"Arial","sans-serif";
   color:white'><cfoutput>#rc.organization#</cfoutput> CT Projects</span></p>
   </td>
  </tr>
  <tr style='page-break-inside:avoid;height:51.0pt'>
   <td width=72 valign=bottom style='width:.75in;border-top:none;border-left:
   solid windowtext 1.0pt;border-bottom:none;border-right:solid windowtext 1.0pt;
   background:#254061;padding:0in 5.4pt 0in 5.4pt;height:51.0pt'>
   <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
   text-align:center;line-height:normal'><b><span style='font-size:10.0pt;
   font-family:"Arial","sans-serif";color:white'>Proposal Number</span></b></p>
   </td>
   <td width=114 valign=bottom style='width:85.5pt;border:none;border-right:
   solid windowtext 1.0pt;background:#254061;padding:0in 5.4pt 0in 5.4pt;
   height:51.0pt'>
   <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
   text-align:center;line-height:normal'><b><span style='font-size:10.0pt;
   font-family:"Arial","sans-serif";color:white'>Project Title</span></b></p>
   </td>
   <td width=90 valign=bottom style='width:67.5pt;border:none;border-right:
   solid windowtext 1.0pt;background:#254061;padding:0in 5.4pt 0in 5.4pt;
   height:51.0pt'>
   <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
   text-align:center;line-height:normal'><b><span style='font-size:10.0pt;
   font-family:"Arial","sans-serif";color:white'>Requested Amount </span></b></p>
   </td>
   <td width=78 valign=bottom style='width:58.5pt;border:none;border-right:
   solid windowtext 1.0pt;background:#254061;padding:0in 5.4pt 0in 5.4pt;
   height:51.0pt'>
   <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
   text-align:center;line-height:normal'><b><span style='font-size:10.0pt;
   font-family:"Arial","sans-serif";color:white'>Status</span></b></p>
   </td>
   <td width=340 valign=bottom style='width:280.0pt;border:none;border-right:
   solid windowtext 1.0pt;background:#254061;padding:0in 5.4pt 0in 5.4pt;
   height:51.0pt'>
   <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
   text-align:center;line-height:normal'><b><span style='font-size:10.0pt;
   font-family:"Arial","sans-serif";color:white'>Project Summary</span></b></p>
   </td>
   <td width=78 valign=bottom style='width:58.5pt;border:none;border-right:
   solid windowtext 1.0pt;background:#254061;padding:0in 5.4pt 0in 5.4pt;
   height:51.0pt'>
   <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
   text-align:center;line-height:normal'><b><span style='font-size:10.0pt;
   font-family:"Arial","sans-serif";color:white'>Organization</span></b></p>
   </td>
   <td width=96 valign=bottom style='width:1.0in;border:none;border-right:solid windowtext 1.0pt;
   background:#254061;padding:0in 5.4pt 0in 5.4pt;height:51.0pt'>
   <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;
   line-height:normal'><b><span style='font-size:10.0pt;font-family:"Arial","sans-serif";
   color:white'>Implementing Partner</span></b></p>
   </td>
   <td width=36 valign=bottom style='width:27.0pt;border:none;border-right:
   solid windowtext 1.0pt;background:#254061;padding:0in 0in 0in 0in;
   height:51.0pt'>
   <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
   text-align:center;line-height:normal'><b><span style='font-size:10.0pt;
   font-family:"Arial","sans-serif";color:white'>FY</span></b></p>
   </td>
  </tr>
 </thead>
 <cfset totalall=0>
<cfset totalcountry=0>
<cfoutput query="rc.byCountry">
 <tr style='page-break-inside:avoid;height:64.3pt'>
  <td width=72 nowrap valign=bottom style='width:.75in;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal'><span style='font-size:10.0pt;font-family:"Arial","sans-serif"'>#Demoronize(trim(uCase(proposalNumber)))#</span></p>
  </td>
  <td width=114 nowrap valign=bottom style='width:85.5pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal'><span style='font-size:10.0pt;font-family:"Arial","sans-serif"'>#Demoronize(trim(name))#</span></p>
  </td>
  <td width=90 nowrap valign=bottom style='width:67.5pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:normal'><span style='font-size:10.0pt;
  font-family:"Arial","sans-serif"'>#Demoronize(trim(dollarFormat(budgetceilingamount)))#</span></p>
  </td>
  <td width=78 nowrap valign=bottom style='width:58.5pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal'><span style='font-size:10.0pt;font-family:"Arial","sans-serif"'>
<cfif len(implementationstatus) gt 0 and activitystatus is "program fully obligated">
		#Demoronize(trim(implementationstatus))#
	<cfelse>
		#Demoronize(trim(activitystatus))#
	</cfif>
			</span></p>
  </td>
  <td width=340 nowrap valign=bottom style='width:280.0pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal><span style='font-size:10.0pt;line-height:115%;font-family:
  "Arial","sans-serif"'>#Demoronize(trim(projectObjective))#</span></p>
  </td>
  <td width=78 nowrap valign=bottom style='width:58.5pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal style='margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal'><span style='font-size:10.0pt;font-family:"Arial","sans-serif"'>#Demoronize(trim(organization))#</span></p>
  </td>
  <td width=96 nowrap valign=bottom style='width:1.0in;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal align=right style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:right;line-height:normal'><span style='font-size:10.0pt;
  font-family:"Arial","sans-serif"'>#Demoronize(trim(implementer))#</span></p>
  </td>
  <td width=36 valign=bottom style='width:27.0pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt;height:64.3pt'>
  <p class=MsoNormal align=center style='margin-bottom:0in;margin-bottom:.0001pt;
  text-align:center;line-height:normal'><span style='font-size:10.0pt;
  font-family:"Arial","sans-serif"'>#Demoronize(trim(fy))#</span></p>
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
  font-family:"Arial","sans-serif"'>Total
  $ requested for projects including <cfoutput>#rc.organization#</cfoutput>:<b><cfoutput>#Demoronize(trim(dollarFormat(totalall)))#</cfoutput></b></span><br>
<span style='font-size:12.0pt;
  font-family:"Arial","sans-serif"'>Total requested
  $ allocated to <cfoutput>#rc.organization#</cfoutput> for projects in <cfif rc.fy is "">FY2010-FY<CFOUTPUT>#year(now())#</CFOUTPUT><cfelse>FY<cfoutput>#rc.fy#</cfoutput></cfif>:<b><cfoutput>#Demoronize(trim(dollarFormat(totalcountry)))#</cfoutput></b></span>
</body>

</html>

</cfsavecontent>



<cfheader name="Content-Disposition" value="attachment; filename=orgprofile.doc"/>


 <cfcontent
type="application/word"
variable="#ToBinary( ToBase64( strWordData2.Trim() ) )#"
/>

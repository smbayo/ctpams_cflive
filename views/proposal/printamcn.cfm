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

<cffunction name="formatForRTF" access="public" returntype="string">
	<cfargument name="stringtoformat" required="yes">
	
	<cfset var stringToReturn = "">	
	<cfset var badStrings = "â€“Â¬|â€™">
	<cfset var replacementStrings = "--|'">
	<cfset var currentBadString = "">
	<cfset var loopIndex = 1>
	
	<cfset stringToReturn = arguments.stringToFormat>
	
	<cfloop list="badStrings" delimiters="|" index="currentBadString">
		<cfset stringToReturn = replacenocase(stringToReturn, currentBadString, listgetAt(replacementStrings,loopIndex,"|"), "all")>
		<cfset loopIndex = loopIndex + 1>
	</cfloop>
	
	<cfreturn stringToReturn>
	
</cffunction>



<div class=" span-24 content ">

	<cfoutput>
		<cfif not getPlugin("MessageBox").isEmpty()>
		  #getPlugin("MessageBox").renderit()#
		</cfif>		
		<cfset QCount = 0>		


			<table>
				<tr>
								<td>CN ##:</td>

								

									<!--- <td colspan="2"> --->
									<td colspan="3">
										#rc.activecn.CNnumber#
									</td>


							</tr>	
							<tr>
								<td>CN Title:</td>

								

									<!--- <td colspan="2"> --->
									<td colspan="3">
										#rc.activecn.CNtitle#
									</td>


							</tr>	
							<tr>
								<td>Congressional Approval Status:</td>

								

									<!--- <td colspan="2"> --->
									<td colspan="3">
										#rc.cnApprovalStatus#<cfif len(rc.cnApprovalComments)> - &nbsp;#rc.cnApprovalComments#</cfif>
									</td>


							</tr>	
							<tr>
								<td>CT:</td>

								

									<!--- <td colspan="2"> --->
									<td>
										#rc.sctCoordinatorStatus#
									</td>
									<td>
										<cfif isDate(rc.sctCoordinatorDate)>#dateFormat(rc.sctCoordinatorDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
									 	#rc.sctCoordinatorComment#
									</td>

							</tr>						
							<tr> 
								<td>Legal (L):</td><!---Legal::--->							
						
									<td>
										#rc.legalReviewStatus# 
									</td>
									<td>
										<cfif isDate(rc.legalReviewDate)>#dateFormat(rc.legalReviewDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
										#rc.legalReviewComment#

									</td>

							</tr>						
							<tr>
								<td>Foreign Assistance (F):</td>							


									<td>
										#rc.foreignAssistanceStatus#
									</td>
									<td>
										<cfif isDate(rc.foreignAssistanceDate)>#dateFormat(rc.foreignAssistanceDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
										#rc.foreignAssistanceComment#
									</td>

							</tr>
							<tr>
								<td><!--- Congressional Affairs --->Legislative Affairs (H):</td>							


									<td>
										#rc.congressionalAffairsStatus# 
									</td>
									<td>
										<cfif isDate(rc.congressionalAffairsDate)>#dateFormat(rc.congressionalAffairsDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
										#rc.congressionalAffairsComment#
									</td>

							</tr>
							<tr>
								<td>Policy Planning (S/P):</td>							


									<td>
										#rc.policyPlanningStatus#
									</td>
									<td>
										<cfif isDate(rc.policyPlanningDate)>#dateFormat(rc.policyPlanningDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
										#rc.policyPlanningComment#
									</td>

							</tr>
							<tr>
								<td>Management and Budget (OMB):</td>

									<td>
										#rc.ombReviewStatus#
									</td>
									<td>
										<cfif isDate(rc.ombReviewDate)>#dateFormat(rc.ombReviewDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
									 	#rc.ombReviewComment#
									</td>

							</tr>
							<tr>
								<td>Deputy Review (DAS):</td>


									<td>
										#rc.deputyReviewStatus#
									</td>
									<td>
										<cfif isDate(rc.deputyReviewDate)>#dateFormat(rc.deputyReviewDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
									 	#rc.deputyReviewComment#
									</td>

							</tr>
							<tr>
								<td>Front Office (FO):</td>


									<td>
										#rc.frontOfficeStatus#
									</td>
									<td>
										<cfif isDate(rc.frontOfficeDate)>#dateFormat(rc.frontOfficeDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
										#rc.frontOfficeComment#
									</td>

							</tr>
							<tr>
								<td>Foreign Assistance Front Office (FFO):</td>


									<td>
										#rc.fassistFrontOfficeStatus# 
									</td>
									<td>
										<cfif isDate(rc.fassistfrontOfficeDate)>#dateFormat(rc.fassistfrontOfficeDate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
									 	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #rc.fassistfrontOfficeComment#
									</td>

							</tr>						
							<tr>
								<td>Legislative Affairs Front Office (HFO):</td>


									<td>
										#rc.legalAffairsFOStatus#
									</td>
									<td>
										<cfif isDate(rc.legalAffairsFODate)>#dateFormat(rc.legalAffairsFODate,'mm/dd/yyyy')#</cfif>
									</td>
									<td>
										#rc.legalAffairsFOComment#
									</td>

							</tr>																				
						</table>	
					
			<div class="clear"></div>
			
			<cfif StructKeyExists(rc,"recommendations") AND rc.recommendations.recordCount>
				<br>
			<b>COMMENTS:</b><br>
								<cfloop query="rc.recommendations">
									#dateFormat(rc.recommendations.commentDate,'mm/dd/yyyy')# - #uCase(rc.recommendations.sender)#: 
									#rc.recommendations.comments#<br>
								</cfloop>
			</CFIF>
	
		<br />
	</div>
</cfoutput>
<!-- InstanceEndEditable -->
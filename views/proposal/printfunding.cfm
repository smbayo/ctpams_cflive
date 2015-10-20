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

<br><br>
			<table>
				<cfif len(rc.proposal.previousFClearances)>
					<tr>
						<td valign="top">Previous Clearances:</td>
							<td colspan="3">
								#rc.proposal.previousFClearances#	<p>&nbsp;</p>
							</td>
					</tr>	
				
				</cfif>
				<tr>
					<td>Funding Mechanism Type:</td>
						<td colspan="3">
							#rc.proposal.fundimpmechanism#	
						</td>
				</tr>	
							<tr>
								<td>Budget Funding Request Date:</td>

								

									<!--- <td colspan="2"> --->
									<td colspan="3">
										#dateFormat(rc.proposal.BudgetFundRequestDate,'mm/dd/yyyy')#
									</td>


							</tr>	
							<tr>
								<td colspan="4">
									<cfif rc.proposal.fundimpmechanism NEQ "Fund cite to post">					

							<table>

								
								<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA" or rc.proposal.fundimpmechanism EQ "Bureau Transfer">
									<tr>
										<td>Budget:</td>
										<!--- <cfif #rc.budgetClearanceDate# gt ""> #dateformat(rc.budgetClearanceDate, "mm/dd/yyyy")#</cfif> --->
										<cfif NOT isUserInRole("administer funding") or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
											<td>
												#rc.budgetClearanceStatus# 
											</td>									
											<td>
												<cfif isDate(rc.budgetClearanceDate)>#dateFormat(rc.budgetClearanceDate,'mm/dd/yyyy')#</cfif>
											</td>
											<td>
												#rc.budgetClearanceComment#
											</td>							

										</cfif>
									</tr>
								</cfif>
								

								
								<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA">
									<tr>
										<td>Legal (L):</td>
										<!--- <cfif #rc.legalClearanceStatus# EQ "Yes"> --->
										<cfif (NOT isUserInRole("administer funding") and not isUserInRole("l funding clearance"))
											OR (isUserInRole("administer funding") and (rc.legalClearanceStatus EQ "Yes" OR rc.legalClearanceStatus EQ "No")) or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
											<td>
											 	#rc.legalClearanceStatus#
											</td>
											<td>
												<cfif isDate(rc.legalClearanceDate)>#dateFormat(rc.legalClearanceDate,'mm/dd/yyyy')#</cfif>
											</td>
											<td>
												#rc.legalClearanceComment#
											</td>

										</cfif>
									</tr>
								</cfif>
								
								<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA" or rc.proposal.fundimpmechanism EQ "Grant" or rc.proposal.fundimpmechanism EQ "Cooperative Agreement">
									<tr>
										<td>Front Office (F/O):</td>
										<!--- <cfif #rc.foClearanceDate# gt ""> #dateformat(rc.foClearanceDate, "mm/dd/yyyy")#</cfif> --->
										<cfif NOT isUserInRole("administer funding") or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
											<td>
												#rc.foClearanceStatus# 
											</td>	
											<td>
												<cfif isDate(rc.foClearanceDate)>#dateFormat(rc.foClearanceDate,'mm/dd/yyyy')#</cfif>
											</td>
											<td>
												#rc.foClearanceComment#
											</td>						

										</cfif>
									</tr>
								</cfif>
								

								
								<cfif (rc.proposal.fundimpmechanism EQ "MOU/IAA" or rc.proposal.fundimpmechanism EQ "Grant" or rc.proposal.fundimpmechanism EQ "Cooperative Agreement") and not rc.isMOUMod>
									<tr>
										<td ><!--- Acquisition Management Office (AQM) --->Grant Officer:</td>
										<!--- <cfif #rc.aqmClearanceDate# gt ""> #dateformat(rc.aqmClearanceDate, "mm/dd/yyyy")#</cfif> --->
										<cfif NOT isUserInRole("administer funding")  or not len(rc.proposal.fundapproveddate) is 0>
										<td>
											#rc.aqmClearanceStatus# 
										</td>
										<td>
											<cfif isDate(rc.aqmClearanceDate)>#dateFormat(rc.aqmClearanceDate,'mm/dd/yyyy')#</cfif>
										</td>
										<td>
											#rc.aqmClearanceComment#
										</td>							

										</cfif>
									</tr>
								</cfif>
								
								<cfif rc.proposal.fundimpmechanism EQ "MOU/IAA">
									<tr>
										<td>Agency:</td>
										<!---  <cfif #rc.agencyClearanceDate# gt ""> #dateformat(rc.agencyClearanceDate, "mm/dd/yyyy")#</cfif> --->
										
										<cfif NOT isUserInRole("administer funding") or (not len(rc.proposal.fundapproveddate) is 0  and not rc.isMOUMod)>
										<td>
											#rc.agencyClearanceStatus# 
										</td>
										<td>
											<cfif isDate(rc.agencyClearanceDate)>#dateFormat(rc.agencyClearanceDate,'mm/dd/yyyy')#</cfif>
										</td>
										<td>
											#rc.agencyClearanceComment#
										</td>							

										</cfif>
									</tr>
								</cfif>

						</table>
					</cfif>
								</td>

							</tr><!--- 			 --->			
																					
						</table>	
					
			<div class="clear"></div>
			

	
		<br />
	</div>
</cfoutput>
<!-- InstanceEndEditable -->
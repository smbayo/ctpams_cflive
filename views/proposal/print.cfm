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
	text = Replace(text, Chr(149), "â¢", "All");
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


			<table cellspacing="0" cellpadding="5" id="proposalTable" style="display:block;height:100%;visibility:visible; border:0px;">
				<tr>
					<td>
						<!--- 1 --->
						<cfset QCount = QCount + 1>
						<label><strong>Project Owner(s):</strong></label>
					</td>
					</tr>
					<tr>
						<td>
						<table border="0" width="450">
							<thead>
								<tr>
									<th></th>
									<th align="left">Name</th>
									<th align="left">Email</th>
									<th align="left">Phone</th>
								</tr>
							</thead>
							<tbody>
							<cfset o = 0>
							<cfloop query="rc.owners">
								<cfset o = o + 1>				
								<tr>						
									<!--- <td>#rc.owners.firstName#</td> --->
									<td>#o#.</td>
									<td>#rc.owners.firstName# #rc.owners.lastName#</td>
									<td>#rc.owners.email#</td>
									<td>#rc.owners.phone#</td>
								</tr>
							</cfloop>
							</tbody>
						</table>		
					</td>
				</tr>
				<tr>
					<!--- 3 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><label><strong>
					<cfif rc.proposal.programID is 4>
						Project Summary:
					<cfelse>
						Project Purpose:
					</cfif>	
					</strong> </label></td>
					</tr><tr>
					<td valign="top">
						#Demoronize(rc.proposal.ProjectObjective)#
					</td>
				</tr>
				<tr>
					<!--- 4 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><label><strong>Description of Program Proposed:</strong> </label></td>
					</tr><tr>
					<td valign="top">#Demoronize(rc.proposal.Description)#</td>
				</tr>
				<tr>
					<!--- 5 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><label><strong>
						<cfif rc.proposal.programID is 4>
						Project Context/Rationale:
					<cfelse>
						Specify explicitly how this proposal advances US national security and foreign policy interests:
					</cfif>
					</strong></label></td>
					</tr><tr>
					<td valign="top">#Demoronize(rc.proposal.InterestSpecification)#</td>
				</tr>
				<tr>
					<!--- 6 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><label><strong>
						<cfif rc.proposal.programID is 4>
						Law Enforcement Nexus (NADR funding only): 
					<cfelse>
						Specify explicitly how this activity supports law enforcement's ability to counter terrorism:
					</cfif>
					</strong></label></td>
					</tr><tr>
					<td valign="top">#Demoronize(rc.proposal.LawEnforcementSpecification)#</td>
				</tr>
				<tr>
					<!--- 7 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><label><strong>
						<cfif rc.proposal.programID is 4>
						Coordination: 
					<cfelse>
						What have the sponsors of the  project done to coordinate this program with this interagency or multilateral partners? (What offices/agencies have been consulted. How did you ensure this is not duplicative?)
					</cfif>
					</strong></label></td>
					</tr><tr>
					<td valign="top">#Demoronize(rc.proposal.CoordinationSpecification)#</td>
				</tr>
				<cfif rc.proposal.programID is 4>
					<tr>
						<!--- 6 --->
						<cfset QCount = QCount + 1>
						<td><label><strong>
						Measuring Impact and Effectiveness:
						</strong> </label></td>
						</tr><tr>
						<td>#rc.proposal.lessonsLearned#</td>
					</tr>
					<tr>
						<!--- 7 --->
						<cfset QCount = QCount + 1>
						<td><label><strong>
						Sustainability:
						</strong></label></td>
						</tr><tr>
						<td>#rc.proposal.sustainability#</td>
					</tr>
					<tr>
						<!--- 7 --->
						<cfset QCount = QCount + 1>
						<td><label><strong>
						 Neighborhood, City or Province:
						</strong></label></td>
						</tr><tr>
						<td>#rc.proposal.cityProvince#</td>
					</tr>
				<cfelse>
					<tr>
						<!--- 6 --->
						<cfset QCount = QCount + 1>
						<td><label><strong>
						Project Monitoring:
						</strong> </label></td>
						</tr><tr>
						<td>#rc.proposal.lessonsLearned#</td>
					</tr>
				</cfif>
				<tr>
					<!--- 8 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><label><strong>Time Frame for Implementation:</strong></label></td>
					</tr><tr>
					<td valign="top">
						<b>From:</b>&nbsp;#dateformat(rc.proposal.StartDate,"MM/DD/YYYY")#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<b>To:</b>&nbsp;#dateformat(rc.proposal.EndDate,"MM/DD/YYYY")#
					</td>
				</tr>	
				<tr>
					<!--- 9 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><label><strong>Place of Implementation:</strong></label></td>
					</tr><tr>
					<td valign="top">
						<b>
						<ul>
							<cfif rc.proposal.placeOfImplementation EQ "Country">
								<cfloop query="rc.projectCountries">
									<li><strong>#Name#</strong></li>
								</cfloop>
							<cfelseif rc.proposal.placeOfImplementation EQ "Region">
								<cfloop query="rc.projectRegions">
									<li><strong>#Name#</strong></li>
								</cfloop>
							<cfelseif rc.proposal.placeOfImplementation EQ "None">
								<li>Not Country/Region Specific</li>
							</cfif>			
						</ul>
						</b>
					</td>
				</tr>	
				<tr>
					<!--- 10 --->
					<cfset QCount = QCount + 1>
					<td valign="top">
					<label><strong>Implementer Information:</strong></label></td>
					</tr><tr>
					<td valign="top">
			
					
						 <table width="90%">
			              <thead>
			                <tr>
			                  <th align="left"></th>  
							  <th align="left">Implementer</th>
			                  <th align="left">Partner</th>
			                  <th align="left">POC Name</th>
			                  <th align="left">POC Email</th>
			                  <th align="left">POC Phone</th>
			                  <!--- <th>Actions</th> --->
			                </tr>
			              </thead>
			              <tbody>
							<cfset i = 0>
							<cfloop query="rc.implementer">
								<cfset i = i + 1><!--- colspan="6"  --->				
				                <tr class="noOne">
				                  <td align="left"><b>#i#</b></td>
								  <td align="left"> #rc.implementer.Name#</td>
								  <td align="left"> #rc.implementer.implementingPartner#</td>
								  <td align="left"> #rc.implementer.pocFirstName# #rc.implementer.pocLastName#</td>
								  <td align="left"> #rc.implementer.pocEmail#</td>
								  <td align="left"> #rc.implementer.pocPhone#</td>
				                </tr>
							</cfloop>
			              </tbody>
			            </table>
					</td>
				</tr>
				<tr>
					<!--- 11 --->
					<cfset QCount = QCount + 1>
					<!--- <td colspan="2"> --->
					<td valign="top">	
						<label><strong>Program Audience:</strong></label>
					</td>
					</tr><tr>
					<td valign="top">
						<strong>#rc.proposal.ProgramAudience#</strong>
					</td>
				</tr>
						
				<tr>
					<!--- 13 --->
					<cfset QCount = QCount + 1>
					<td valign="top">
						<label><strong>Funding Breakdown:</strong></label></td>
						</tr><tr>
						<td valign="top">
						<!--- <fieldset><legend><h3>Funding Breakdown</h3></legend> --->
						<table width="500">
							<thead>
							<tr>
								<th align="left">Country</th>
								<th align="left">Budget Item</th>
								<th align="left">Amount</th>
							</tr>
							</thead>
							<tbody>
							<cfloop query="rc.projectFunding">					
								<tr>
									<td  align="left">#rc.projectFunding.Country#</td>
									<td  align="left">#rc.projectFunding.BudgetItem#</td>
									<td  align="left">#dollarFormat(rc.projectFunding.BudgetAmount)#</td>
								</tr>
							</cfloop>
							</tbody>
						</table>
						<!--- </fieldset> --->
					</td>
				</tr>	
				<tr>
					<!--- 14 --->
					<cfset QCount = QCount + 1>
					<td valign="top"><!---  --->
						<label><strong>Funding/Implementation Mechanism Type:</strong></label></td>
						</tr><tr>
						<td valign="top">
						<!--- <fieldset><legend><h3>Funding/Implementation Mechanism Type</h3></legend> --->
						 <table width="100%">
							<thead>
							<tr>
								<td>
									<ul>
									<cfif rc.proposal.fundImpMechanismID EQ "">
										<li>None</li> 									
									<cfelse>
										<cfloop query="rc.FundMechTypes">
											<cfif rc.proposal.fundImpMechanismID EQ rc.FundMechTypes.CategoryID>
												<li><strong>#rc.FundMechTypes.name#</strong></li>
											</cfif>
										</cfloop>
									</cfif>
									</ul>
								 </td>
							</tr>
							</thead>
							<tbody>
						</table>
						<!--- </fieldset> --->															
					</td>	
				</tr>												
				<tr>		
					<!--- 15 --->
					<cfset QCount = QCount + 1>
					<td valign="top">
					<label><strong>Objectives & Indicators:</strong></label></td>
					</tr><tr>
					<td valign="top">
						<cfset oi = 0>

						<!--- no more than 2 indicators can be listed --->
						<table width="500">
							<tr>
							<thead><th align="left">Objective</th><th align="left">Indicator</th></thead>
							<tbody>
								<cfloop query="rc.indicators">
								<cfset oi = oi + 1>
								<tr>
									<td align="left"><b>#oi#.</b> #rc.indicators.objective#</td><td align="left">#rc.indicators.name#</td>
								</tr>
								</cfloop>
							</tbody>	
						</table>
						<!--- </fieldset> --->
					</td>
				</tr>
				<tr>
					<!--- 16 --->
					<cfset QCount = QCount + 1>
					<td >
						<label><strong>Funding Sources:</strong></label></td>
						</tr><tr>
						<td>
						<!--- <fieldset><legend><div class="section"><h3>Funding Sources</h3></div></legend> --->
						<table width="100%">
							<tr>
								<td>
									<ul>
										<cfif rc.projectFundingSources.recordCount EQ 0>
											<li><strong>None</strong></li> 
										<cfelse>
											<cfloop query="rc.projectFundingSources">
											<li><strong>#rc.projectFundingSources.Name#</strong></li>
											</cfloop>
										</cfif>											
									</ul> 
								</td>
							</tr>									
						</table>		
						<!--- </fieldset> --->
					</td>
				</tr>	
				
				<tr>
					<!--- 11 --->
					<cfset QCount = QCount + 1>
					<!--- <td colspan="2"> --->
					<td valign="top">	
						<label><strong>Fiscal Year:</strong></label>
					</td>
					</tr><tr>
					<td valign="top">
						<strong>#rc.proposal.fiscalyear#</strong>
					</td>
				</tr>				

			</table>
					
			<div class="clear"></div>
			<strong>Comments:</strong>
 <dl>
						<cfif StructKeyExists(rc,"recommendations") AND rc.recommendations.recordCount>
							
							<cfloop query="rc.recommendations">
								<dt>#dateFormat(rc.recommendations.commentDate,'mm/dd/yyyy')# - #uCase(rc.recommendations.sender)#</dt>
								<dd>#rc.recommendations.comments#</dd>
							</cfloop>
						</cfif>
						<cfif len(trim(rc.proposal.clearedPrelegalDate))>
							<dt>Legal signed off #dateFormat(rc.proposal.clearedPrelegalDate,'mm/dd/yyyy')#</dt>
						</cfif>
						</dl>
	
		<br />
	</div>
</cfoutput>
<!-- InstanceEndEditable -->
<cfparam name="url.jv" default="N">
       <cfset startBracket='{'>
        <cfset endBracket='}'>
        <cfset jsonElement="">
        <cfset jsonElement=(#jsonElement# & #startBracket#)>
        <cfif rc.jv is 'Y'>
	            <cfset jsonElement=(#jsonElement# & '<br>')>
        </cfif>

		<cfif isdefined("jsonQuery")>
            <cfloop list="numericlist,dateList,stringList" index="listType">
           
    
                <cfloop list="#evaluate('#listType#')#" index="columnVAR">
                    <cfif evaluate("jsonQuery." & columnVAR) is ''>
                        <cfif listType is not 'stringList'>
                             <cfset #jline#=('"' & columnVAR & '": ' & 'NULL')>
                        <cfelse>
                             <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("jsonQuery." & columnVAR) & '"')>
                        </cfif>
                   <cfelse>
                        <cfif listType is 'numericList'>
                           <cfset #jline#=('"' & columnVAR & '": ' & evaluate("jsonQuery." & columnVAR))>
                        <cfelseif listType is "dateList">
                            <cfset #jline#=('"' & columnVAR & '":' & '"' & dateformat(evaluate("jsonQuery." & columnVAR), "mmddyyyy") & '"')>
                       <cfelse>
                          <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("jsonQuery." & columnVAR) & '"')>
                       </cfif>
                    </cfif>
                    <cfset jsonElement=(#jsonElement# & #jline#)>
                    <cfif columnvar is not #lastcol#>
                          <cfset jsonElement=(#jsonElement# & ',')>
                    </cfif>
                    <cfif rc.jv is 'Y'>
                        <cfset jsonElement=(#jsonElement# & '<br>')>
                    </cfif>
                </cfloop>
              
            </cfloop>
		</cfif>

		<cfloop from="1" to="8" step="1" index="aNum">
        	<cfset arrayID=('array' & #anum#)>
            <cfif isdefined("#arrayID#")>
            
                    <cfset arrayCol=('arrayCol_' & #anum#)>
                    <cfset arrayTabCol=(#arrayID# & '.' & #evaluate(#arrayCol#)#)>
                    <cfset arrayCount=(#arrayID# & '.recordcount')>
                   
		

 		       <cfif #evaluate("#arrayCount#")# is 0>
		        	 <cfset #jline#=('"' & #evaluate("#arrayCol#")# & '": ' & 'NULL')>
        		<cfelse>
					<cfset thisArray = ArrayNew(1)> 
        		    <cfloop query = "#arrayID#"> 
           			     <cfset temp = ArrayAppend(thisArray, "#evaluate("#arrayTabCol#")#")> 
           			 </cfloop> 
           			 <cfset myList = ArrayToList(thisArray, ",")> 
          			  <cfset #jline#=('"' & #evaluate("#arrayCol#")# & '": ' & '[' & #myList# & ']')>
 				</cfif>
				<cfset jsonElement=(#jsonElement# & #jline#)>
                <cfif #evaluate("#arrayCol#")# is not #lastcol#>
                      <cfset jsonElement=(#jsonElement# & ',')>
                </cfif>
                <cfif rc.jv is 'Y'>
                      <cfset jsonElement=(#jsonElement# & '<br>')>
                </cfif>       
         	</cfif>
		</cfloop>

		 <cfif isdefined("jsonMatrix")>
		 <cfif jsonMatrix.recordcount is not 0>
  	            <cfset jsonElement=(#jsonElement# & '"' & #className# & '":[')>
				<cfif rc.jv is 'Y'>
                   <cfset jsonElement=(#jsonElement# & '<br>')>
                 </cfif>

               
                    <cfloop query="jsonMatrix">
                        <cfset jsonElement=(#jsonElement# & #startbracket#)>
                        <cfif rc.jv is 'Y'>
                            <cfset jsonElement=(#jsonElement# & '<br>')>
                        </cfif>
                        <cfloop list="numericlist,dateList,stringList" index="listType">
                        
                            
                             <cfloop list="#evaluate('#listType#')#" index="columnVAR">
                            
                                <cfif evaluate("jsonMatrix." & columnVAR) is ''>
                                    <cfif listType is not 'stringList'>
                                         <cfset #jline#=('"' & columnVAR & '": ' & 'NULL')>
                                    <cfelse>
                                         <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("jsonMatrix." & columnVAR) & '"')>
                                    </cfif>
                               <cfelse>
                                    <cfif listType is 'numericList'>
                                       <cfset #jline#=('"' & columnVAR & '": ' & evaluate("jsonMatrix." & columnVAR))>
                                    <cfelseif listType is "dateList">
                                        <cfset #jline#=('"' & columnVAR & '":' & '"' & dateformat(evaluate("jsonMatrix." & columnVAR), "mmddyyyy") & '"')>
                                   <cfelse>
                                      <cfset #jline#=('"' & columnVAR & '":' & '"' & evaluate("jsonMatrix." & columnVAR) & '"')>
                                   </cfif>
                                </cfif>
                                <cfset jsonElement=(#jsonElement# & #jline#)>
                                
                                <cfif columnvar is not #lastcol#>
                                      <cfset jsonElement=(#jsonElement# & ',')>
                                </cfif>
                                <cfif rc.jv is 'Y'>
                                    <cfset jsonElement=(#jsonElement# & '<br>')>
                                </cfif>
                              </cfloop> 
                         </cfloop> 
                         <cfset jsonElement=(#jsonElement# & #endbracket#)>
                         <cfif jsonMatrix.recordcount is not #jsonMatrix.currentrow#>
                               <cfset jsonElement=(#jsonElement# & ',')>
                         </cfif>
                         <cfif rc.jv is 'Y'>
                            <cfset jsonElement=(#jsonElement# & '<br>')>
                         </cfif>
    
                     </cfloop>
					<cfset jsonElement=(#jsonElement# & ']')>
                    <cfif rc.jv is 'Y'>
                       <cfset jsonElement=(#jsonElement# & '<br>')>
                     </cfif>
				
           </cfif> 
         </cfif> 
                


        <cfset jsonElement=(#jsonElement# & #endBracket#)>

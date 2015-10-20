<!--- 
    Needs a query each to populate selects for:

       rc.Activity = instance.activityService.getActivity(activityid=rc.activityID);
       rc.Sector = instance.activityService.getAllSectors();
       rc.Org = instance.orgService.getOrgs();
       rc.ParentGrant = instance.activityService.getAllActivities();
--->

    <!-- AJAX SUCCESS TEST FONCTION 
      <script>function callSuccessFunction(){alert("success executed")}
          function callFailFunction(){alert("fail executed")}
      </script>
    -->
    
<script>  
$(document).ready(function() {
  
  $("#grantform").validationEngine()

  
  //$.validationEngine.loadValidation("#date")
  //alert($("#formID").validationEngine({returnIsValid:true}))
  //$.validationEngine.buildPrompt("#date","This is an example","error")       // Exterior prompt build example
  //$.validationEngine.closePrompt(".formError",true)               // CLOSE ALL OPEN PROMPTS
});
function selectAll(selectBox,selectAll) {
    // have we been passed an ID
    if (typeof selectBox == "string") {
        selectBox = document.getElementById(selectBox);
    }

    // is the select box a multiple select box?
    if (selectBox.type == "select-multiple") {
        for (var i = 0; i < selectBox.options.length; i++) {
            selectBox.options[i].selected = selectAll;
        }
    }
}




function fieldfiller() {
	var formObj = document.grantForm;
	formObj.file_title.value = formObj.u_path.value
	}
	
function changer() {
	var formObj = document.grantForm;
	if (formObj.doc_type.value != 0) {
		formObj.currentversion.disabled = false}
	if (formObj.doc_type.value != 11) {
		formObj.currentversion.disabled = false}
	if (formObj.doc_type.value == 0) {
		formObj.currentversion.disabled = true}
	if (formObj.doc_type.value == 11) {
		formObj.currentversion.disabled = true}
		}
	
function ValidateForm() {
	var formObj = document.grantForm;
	
	if (formObj.doc_type.value == 0) {
	alert("You must select a document type if you want to upload a document.");
	formObj.doc_type.focus();
	return false;
	}
	
		
	if (formObj.u_path.value.length == 0) {
	alert("Please select a document to upload.");
	formObj.u_path.focus();
	return false;
	}
	return true;
	}


</script>




<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<table width="100%" id="msiheadertable">
  <tr>	
    <td><cfif rc.ResultsFrameworkElementID is not 0>
			<h1>Edit Result Element</h1>
        <cfelse>
        	<h1>Add Result Element</h1>
        </cfif>
         
    </td>
 
	</tr>
</table>
	
<form onsubmit="selectAll(resultChildren,true);" name="resultform" id="resultform" class="formular" method="post" action="#event.buildLink('framework.saveResult')#"  enctype="multipart/form-data">
<input type="hidden" name="event" value="#event.buildLink('grant.saveResult')#">



<cfif rc.ResultsFrameworkElementID is not 0>
<input name="ResultsFrameworkElementID" type="hidden" value="#rc.ResultsFrameworkElementID#" />
</cfif>
<table width="100%" cellspacing="0" cellpadding="2" border="0">
    <tr>
        <td width="100" class="msiFormLabel">Result Name</td>
        <td class="msiFormInput"><input type="text" name="Name" size="120" value="#rc.resultsFrameworkElement.getName()#"></td>
    </tr>
<tr>
       <td width="100" class="msiFormLabel">Related Program</td>
       <td class="msiFormInput">
            <select name="programID" id="programID">
              <option value=""></option>
              <cfloop query="RC.programs">
                <option value="#programID#" <cfif rc.resultsFrameworkElement.getProgramID() eq programID>selected</cfif> >#Description# [#Name#]</option>
              </cfloop>
            </select>
        </td>
</tr>




			</table>

 <table border=1>
 <tr style="font-weight:bold">
<td width="100" class="msiFormLabel">&nbsp;</td>
<td>Result Name</td>
 </tr>
<cfloop list="F,O" index="viewtab">
	<cfif viewtab is "F">
        <cfquery name="frameSet" dbtype="query">
        SELECT * from rc.vFullFrame where resultsFrameworkelementID <> 0
        </cfquery>
        <cfinclude template="frameworkGen.cfm">
    <cfelse>
        <cfif rc.listorphans is not ''>
			<cfif rc.qOrphans.recordcount is not 0>
            
                 <cfquery name="frameSet" dbtype="query">
      			  SELECT * from rc.qOrphans
      			  </cfquery>
   
               
                <tr><td colspan=2>Results without Parent Relationships</td></tr>
                <cfinclude template="frameworkGen.cfm">
            </cfif>
        </cfif>
     
    </cfif>
</cfloop>
 </table> 


<table width="100%">
	<tr>
		<td colspan="2" align="right" class="msiFormLabel">
 <cfif rc.ResultsFrameworkElementID is not 0>     
    <input type="submit" name="btnUpdate" value="Save" />
 <cfelse>  
   	<input class="submit" name="btnSubmit" type="submit" value="Save"/>
</cfif>
			<INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
		</td>
	</tr>
</table>
</form>
 </cfoutput>




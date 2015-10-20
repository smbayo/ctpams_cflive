

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

</script>


<br>
<cfoutput>
<h1>Permission Detail</h1>
<br>

  
</cfoutput>


<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>



<form name="Permissionform" id="Permissionform" class="formular" method="post" action="#event.buildLink('admin.savePermission')#">
<input type="hidden" name="event" value="#event.buildLink('admin.savePermission')#">
<input name="sysPermissionID" type="hidden" value="#rc.Permission.getSysPermissionID()#" />

<table width="100%" cellspacing="0" cellpadding="2" border="0">
    <tr>
        <td width="100" class="msiFormLabel">Permission</td>
        <td class="msiFormInput">
           <input name="Name" type="text" class="validate[required,length[6,100]]" id="Name" size="100" value="#rc.Permission.getName()#"  /><br />
           Permission Name must be a single text string with no spaces. examples: addProject, viewReports, editUsers

        </td>
    </tr>
</table>


			<table width="100%" cellpadding="1" cellspacing="1" border="0">
		        <tr>
		            <td class="msiFormLabel" valign="top">Description</td>
		            <td class="msiFormInput">
		              <textarea  cols="80" rows="7" name="Description" id="Description"  class="validate[length[0,3999]] text-input"/>#rc.Permission.getDescription()#</textarea>
		            </td>
		        </tr>
			</table>


<table width="100%">
	<tr>
		<td colspan="2" align="right" class="msiFormLabel">
			<input class="submit" name="btnSubmit" type="submit" value="Save"/>
			<INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
		</td>
	</tr>
</table>
</form>
 </cfoutput>




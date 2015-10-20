

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
<h1>Delete User Confirmation</h1>

<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<table width="100%" id="msiheadertable">
  <tr>
    <td>
<form name="Userform" id="userform" class="formular" method="post" action="#event.buildLink('admin.deleteUser')#">
<input name="sysUserID" type="hidden" value="#rc.qUser.getSysUserID()#" />
Delete User #rc.qUser.getName()# from database?<br />
<input class="submit" name="btnSubmit" type="submit" value="Confirm"/>
<INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
		</td>
	</tr>
</table>
</form>
 </cfoutput>




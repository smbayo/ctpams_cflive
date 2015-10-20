

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

</script>



<br>
<h1>Change Password</h1>
<cfoutput>
<cfif not getPlugin("MessageBox").isEmpty()>
  #getPlugin("MessageBox").renderit()#
</cfif>
<form name="Uppass" id="uppass" class="formular" method="post" action="#event.buildLink('admin.usersavepassword')#">
<input name="sysUserID" type="hidden" value="#rc.qUser.getSysUserID()#" />
<table width="100%" cellspacing="0" cellpadding="2" border="0">
    <tr>
        <td width="100" class="msiFormLabel">User</td>
        <td class="msiFormInput">#rc.qUser.getName()#</td>
    </tr>
        <tr>
            <td width="100" class="msiFormLabel">Email</td>
            <td class="msiFormInput">#rc.qUser.getEmail()#</td>
        </tr>

        <cfif rc.SysUserID is #session.cbstorage.sysuserID#>
        <tr>
            <td width="100" class="msiFormLabel">Password</td>
            <td class="msiFormInput">
               <input name="password" type="password" class="validate[required,length[6,50]]" id="password" size="50" value="#rc.qUser.getPassword()#"  />
            </td>
        </tr>
		</cfif>        
	<tr>
		<td colspan="2" align="right" class="msiFormLabel">
			<input class="submit" name="btnSubmit" type="submit" value="Save"/>
			<INPUT TYPE="BUTTON" VALUE="Cancel" ONCLICK="history.go(-1)">
		</td>
	</tr>
</table>
</form>
 </cfoutput>




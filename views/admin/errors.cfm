<cfoutput>
<h1>Error Occurred While Saving</h1>
<br>
<p>The following error(s) occurred while trying to save your changes:</p>
<blockquote>
<cfloop array="#rc.arrErrors#" index="thisError">
  <b><i>#thisError.message#</i></b><br>
</cfloop>
</blockquote>
<p>Please <a href="javascript:void(0);" ONCLICK="history.go(-1)">go back</a> and correct the errors to continue.</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</cfoutput>


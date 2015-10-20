<cfcomponent name="ssl" output="false" extends="coldbox.system.interceptor">

    <cffunction name="preEvent" access="public" returntype="void" output="false" >
        
        <!--- SSL check? --->
        <cfif getProperty('isSSLCheck')>
            <cfset sslCheck()>
        </cfif>    
        
    </cffunction>

    <cffunction name="sslCheck" access="public" returntype="void" output="false" >
         <!--- SSL check? --->
        <cfif not isSSL()>
            <!--- redirect with SSL (any post data is lost) --->
            <cflocation url="https://#cgi.server_name##cgi.script_name#?#cgi.query_string#" addtoken="no">
        </cfif>
    </cffunction>

    <cffunction name="isSSL" access="public" returntype="boolean">
        <cfset var isSSL = false>
        <!--- SSL Connection? --->
        <cfif isBoolean(cgi.server_port_secure) and cgi.server_port_secure>
            <cfset isSSL = true>
        </cfif>
        <cfreturn isSSL>
    </cffunction>
        
</cfcomponent>
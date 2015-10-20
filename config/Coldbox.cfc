<cfcomponent output="false" hint="My App Configuration">
	<cfscript>
		/**
		structures to create for configuration

		- coldbox
		- settings
		- conventions
		- environments
		- ioc
		- models
		- debugger
		- mailSettings
		- i18n
		- bugTracers
		- webservices
		- datasources
		- layoutSettings
		- layouts
		- cacheEngine
		- interceptorSettings
		- interceptors
		- modules

		Available objects in variable scope
		- controller
		- logBoxConfig
		- appMapping (auto calculated by ColdBox)

		Required Methods
		- configure() : The method ColdBox calls to configure the application.
		Optional Methods
		- detectEnvironment() : If declared the framework will call it and it must return the name of the environment you are on.
		- {environment}() : The name of the environment found and called by the framework.
		**/

		// Configure ColdBox Application
		function configure(){

			//converts the coldbox app mapping to a dot class path for instantiations, not part of a regular config
			var appMapwithDots = reReplace(appMapping,"(/|\\)",".","all");
			if (len(appMapwithDots) gt 0) {
				appMapwithDots = appMapwithDots & ".";
			}

			// coldbox directives
			coldbox = {
				//Application Setup
				appName 				= "SCTDB",

				//Development Settings
				debugMode				= false,
				debugPassword			= "",
				reinitPassword			= "",
				handlersIndexAutoReload = false,
				configAutoReload		= false,

				//Implicit Events
				defaultEvent			= "summary.index",
				requestStartHandler		= "general.onRequestStart",
				requestEndHandler		= "",
				applicationStartHandler = "",
				applicationEndHandler	= "",
				sessionStartHandler 	= "",
				sessionEndHandler		= "",
				missingTemplateHandler	= "",

				//Error/Exception Handling
				exceptionHandler		= "",
				onInvalidEvent			= "",
				customErrorTemplate		= "error.cfm",

				//Application Aspects
				handlerCaching 			= false,
				eventCaching			= false
			};

			// environment settings, create a detectEnvironment() method to detect it yourself.
			// create a function with the name of the environment so it can be executed if that environment is detected
			// the value of the environment is a list of regex patterns to match the cgi.http_host.
			environments = {
				development = "staging.ctprograms.com,testing,localhost:8500,127.0.0.1,192.168.1.114:8500",
				production = "ctprograms.com,www.ctprograms.com"
			}; //

			//Layout Settings
			layoutSettings = {
				defaultLayout = "Layout.Panel.cfm"

			};

			//Layouts
			layouts = [
				{ name="login",file="Layout.Auth.cfm",views="login",folders="general"},
				{ name="staffmap",file="Layout.CleanNoScripts.cfm",views="staffmap"}
				//{ name="reports",file="Layout.Reports.cfm",views="index",folders="reports"},
				//{ name="proposal",file="Layout.ViewProposal.cfm",views="new,view,ProposalHeading,saveProposal",folders="proposal"},
				//{ name="Overview",file="Layout.ViewProposal.cfm",views="review,amCN,fundImpMechanism,obStatus,reports",folders="proposal"}

			];

			//Register interceptors as an array, we need order
			interceptors = [
				 //Autowire
				 {class="coldbox.system.interceptors.Autowire",
				  properties={enableSetterInjection="true"}},
				 //SES
				 {class="coldbox.system.interceptors.SES"},
				 //Security Check
				 {class="#appMapwithDots#model.security.securityInterceptor"}
			];

			//Datasources
			datasources = {
				theDSN   = {name="sctdbdev", dbType="mssql"}
			};

			//LogBox DSL
			logBox = {
				// Define Appenders
				appenders = {
					coldboxTracer = { class="coldbox.system.logging.appenders.ColdboxTracerAppender" },
					coldboxFile = {
						class="coldbox.system.logging.appenders.AsyncRollingFileAppender",
						properties={filePath="logs",
						fileName=coldbox.appname,
						autoExpand=true,
						fileMaxSize=2000,
						fileMaxArchives=2}
					}
				},
				// Root Logger
				root = { levelmax="INFO", appenders="*" },
				// Implicit Level Categories
				info = [ "coldbox.system" ]
			};

			//Model Integration
			models = {
				objectCaching = true
			};

		}

		/**
		* Executed whenever the development environment is detected
		*/
		function development(){
			settings.debugMode = "true";
		}

		/**
		* Executed whenever the production environment is detected
		*/
		function production(){
			settings.debugMode = "false";
		}

	</cfscript>
</cfcomponent>
<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Date        :	10/16/2007
Description :
	This file is used by the BeanFactory plugin to read off model mappings.
	This is a great place to alias model paths into names so when you 
	refactor you can easily do this.
	
	All you need to do is call one method: addModelMapping(alias,path)
	
	Alias : The alias to create
	Path : The model class path to alias.
	
	Example:
	
	addModelMapping('FormBean',"security.test.FormBean");
	
----------------------------------------------------------------------->
<cfscript>
	/* Add all the model mappings you want */
	/* addModelMapping(alias="",path="") */
	addModelMapping(alias="workplanService",path="workplan.workplanService");
	addModelMapping(alias="workplanGateway",path="workplan.workplanGateway");
	addModelMapping(alias="workplanDAO",path="workplan.workplanDAO");
	addModelMapping(alias="workplan",path="workplan.workplan");
	addModelMapping(alias="userService",path="user.userService");
	addModelMapping(alias="userGateway",path="user.userGateway");
	addModelMapping(alias="userDAO",path="user.userDAO");
	addModelMapping(alias="user",path="user.user");
	addModelMapping(alias="activityService",path="activity.activityService");
	addModelMapping(alias="activityGateway",path="activity.activityGateway");
	addModelMapping(alias="activityDAO",path="activity.activityDAO");
	addModelMapping(alias="activity",path="activity.activity");
	addModelMapping(alias="activityExtendedService",path="activityExtended.activityExtendedService");
	addModelMapping(alias="activityExtendedGateway",path="activityExtended.activityExtendedGateway");
	addModelMapping(alias="activityExtendedDAO",path="activityExtended.activityExtendedDAO");
	addModelMapping(alias="activityIndicatorService",path="activityIndicator.activityIndicatorService");
	addModelMapping(alias="activityIndicatorGateway",path="activityIndicator.activityIndicatorGateway");
	addModelMapping(alias="activityIndicatorDAO",path="activityIndicator.activityIndicatorDAO");
	addModelMapping(alias="activityIndicator",path="activityIndicator.activityIndicator");
	addModelMapping(alias="activityLocationService",path="activityLocation.activityLocationService");
	addModelMapping(alias="activityLocationGateway",path="activityLocation.activityLocationGateway");
	addModelMapping(alias="activityLocationDAO",path="activityLocation.activityLocationDAO");
	addModelMapping(alias="activityLocation",path="activityLocation.activityLocation");
	addModelMapping(alias="CategoryService",path="Category.CategoryService");
	addModelMapping(alias="CategoryGateway",path="Category.CategoryGateway");
	addModelMapping(alias="CategoryDAO",path="Category.CategoryDAO");
	addModelMapping(alias="Category",path="Category.Category");
	addModelMapping(alias="disaggGateway",path="disagg.disaggGateway");
	addModelMapping(alias="disaggDAO",path="disagg.disaggDAO");
	addModelMapping(alias="disaggService",path="disagg.disaggService");
	addModelMapping(alias="disaggSetService",path="disaggSet.disaggSetService");
	addModelMapping(alias="disaggSetGateway",path="disaggSet.disaggSetGateway");
	addModelMapping(alias="disaggSetDAO",path="disaggSet.disaggSetDAO");
	addModelMapping(alias="disaggSetIndicatorService",path="disaggSetIndicator.disaggSetIndicatorService");
	addModelMapping(alias="disaggSetIndicatorGateway",path="disaggSetIndicator.disaggSetIndicatorGateway");
	addModelMapping(alias="disaggSetIndicatorDAO",path="disaggSetIndicator.disaggSetIndicatorDAO");
	addModelMapping(alias="indicatorService",path="indicator.indicatorService");
	addModelMapping(alias="indicatorGateway",path="indicator.indicatorGateway");
	addModelMapping(alias="indicatorDAO",path="indicator.indicatorDAO");
	addModelMapping(alias="indicator",path="indicator.indicator");
	addModelMapping(alias="locationService",path="location.locationService");
	addModelMapping(alias="locationGateway",path="location.locationGateway");
	addModelMapping(alias="locationDAO",path="location.locationDAO");
	addModelMapping(alias="location",path="location.location");
	addModelMapping(alias="measurementService",path="measurement.measurementService");
	addModelMapping(alias="measurementGateway",path="measurement.measurementGateway");
  	addModelMapping(alias="measurementDAO",path="measurement.measurementDAO");
  	addModelMapping(alias="measurement",path="measurement.measurement");
	addModelMapping(alias="NoteService",path="note.noteService");
	addModelMapping(alias="NoteGateway",path="note.noteGateway");
  	addModelMapping(alias="NoteDAO",path="note.noteDAO");
  	addModelMapping(alias="Note",path="note.note");
	addModelMapping(alias="objectCategoryService",path="objectCategory.objectCategoryService");
	addModelMapping(alias="objectCategoryGateway",path="objectCategory.objectCategoryGateway");
	addModelMapping(alias="objectCategoryDAO",path="objectCategory.objectCategoryDAO");
	addModelMapping(alias="objectCategory",path="objectCategory.objectCategory");
	addModelMapping(alias="orgService",path="org.orgService");
	addModelMapping(alias="orgGateway",path="org.orgGateway");
	addModelMapping(alias="orgDAO",path="org.orgDAO");
	addModelMapping(alias="org",path="org.org");
	addModelMapping(alias="resultsFrameworkService",path="resultsFramework.resultsFrameworkElementService");
	addModelMapping(alias="resultsFrameworkGateway",path="resultsFramework.resultsFrameworkElementGateway");
	addModelMapping(alias="resultsFrameworkElementService",path="resultsFramework.resultsFrameworkElementService");
	addModelMapping(alias="resultsFrameworkElementGateway",path="resultsFramework.resultsFrameworkElementGateway");
	addModelMapping(alias="resultsFrameworkDAO",path="resultsFramework.resultsFrameworkElementDAO");
	addModelMapping(alias="resultsFrameworkElement",path="resultsFramework.resultsFrameworkElement");
	addModelMapping(alias="resultsFrameworkExternalRelationService",path="resultsFrameworkExternalRelation.resultsFrameworkExternalRelationService");
	addModelMapping(alias="resultsFrameworkExternalRelationGateway",path="resultsFrameworkExternalRelation.resultsFrameworkExternalRelationGateway");
	addModelMapping(alias="resultsFrameworkExternalRelationDAO",path="resultsFrameworkExternalRelation.resultsFrameworkExternalRelationDAO");
	addModelMapping(alias="resultsIndicatorService",path="resultsIndicator.resultsIndicatorService");
	addModelMapping(alias="resultsIndicatorGateway",path="resultsIndicator.resultsIndicatorGateway");
	addModelMapping(alias="resultsIndicatorDAO",path="resultsIndicator.resultsIndicatorDAO");
	addModelMapping(alias="RoleService",path="Role.RoleService");
	addModelMapping(alias="RoleGateway",path="Role.RoleGateway");
	addModelMapping(alias="RoleDAO",path="Role.RoleDAO");
	addModelMapping(alias="Role",path="Role.Role");
	addModelMapping(alias="PermissionService",path="Permission.PermissionService");
	addModelMapping(alias="PermissionGateway",path="Permission.PermissionGateway");
	addModelMapping(alias="PermissionDAO",path="Permission.PermissionDAO");
	addModelMapping(alias="Permission",path="Permission.Permission");
	addModelMapping(alias="UserRoleService",path="UserRole.UserRoleService");
	addModelMapping(alias="UserRoleGateway",path="UserRole.UserRoleGateway");
	addModelMapping(alias="UserRoleDAO",path="UserRole.UserRoleDAO");
	addModelMapping(alias="UserRole",path="UserRole.UserRole");
	addModelMapping(alias="UserCategoryService",path="UserCategory.UserCategoryService");
	addModelMapping(alias="UserCategoryGateway",path="UserCategory.UserCategoryGateway");
	addModelMapping(alias="UserCategoryDAO",path="UserCategory.UserCategoryDAO");
	addModelMapping(alias="UserCategory",path="UserCategory.UserCategory");
	addModelMapping(alias="RolePermissionService",path="RolePermission.RolePermissionService");
	addModelMapping(alias="RolePermissionGateway",path="RolePermission.RolePermissionGateway");
	addModelMapping(alias="RolePermissionDAO",path="RolePermission.RolePermissionDAO");
	addModelMapping(alias="RolePermission",path="RolePermission.RolePermission");
	addModelMapping(alias="AttachedFileService",path="AttachedFile.AttachedFileService");
	addModelMapping(alias="AttachedFileGateway",path="AttachedFile.AttachedFileGateway");
	addModelMapping(alias="AttachedFileDAO",path="AttachedFile.AttachedFileDAO");
	addModelMapping(alias="AttachedFile",path="AttachedFile.AttachedFile");	
	addModelMapping(alias="ActivityAttachedFileService",path="ActivityAttachedFile.ActivityAttachedFileService");
	addModelMapping(alias="ActivityAttachedFileGateway",path="ActivityAttachedFile.ActivityAttachedFileGateway");
	addModelMapping(alias="ActivityAttachedFileDAO",path="ActivityAttachedFile.ActivityAttachedFileDAO");
	addModelMapping(alias="ActivityAttachedFile",path="ActivityAttachedFile.ActivityAttachedFile");	
	addModelMapping(alias="AttachedFileCategoryService",path="AttachedFileCategory.AttachedFileCategoryService");
	addModelMapping(alias="AttachedFileCategoryGateway",path="AttachedFileCategory.AttachedFileCategoryGateway");
	addModelMapping(alias="AttachedFileCategoryDAO",path="AttachedFileCategory.AttachedFileCategoryDAO");
	addModelMapping(alias="AttachedFileCategory",path="AttachedFileCategory.AttachedFileCategory");	
	
	/* adding more model mapping */
	addModelMapping(alias="ActivityBudget",path="ActivityBudget.ActivityBudget");
	addModelMapping(alias="ActivityBudgetDAO",path="ActivityBudget.ActivityBudgetDAO");
	addModelMapping(alias="ActivityBudgetGateway",path="ActivityBudget.ActivityBudgetGateway");
	addModelMapping(alias="ActivityBudgetService",path="ActivityBudget.ActivityBudgetService");
	addModelMapping(alias="ActivityCategoryToCategory",path="ActivityCategoryToCategory.ActivityCategoryToCategory");
	addModelMapping(alias="ActivityCategoryToCategoryDAO",path="ActivityCategoryToCategory.ActivityCategoryToCategoryDAO");
	addModelMapping(alias="ActivityCategoryToCategoryGateway",path="ActivityCategoryToCategory.ActivityCategoryToCategoryGateway");
	addModelMapping(alias="ActivityCategoryToCategoryService",path="ActivityCategoryToCategory.ActivityCategoryToCategoryService");
	addModelMapping(alias="ActivityClearance",path="ActivityClearance.ActivityClearance");
	addModelMapping(alias="ActivityClearanceDAO",path="ActivityClearance.ActivityClearanceDAO");
	addModelMapping(alias="ActivityClearanceGateway",path="ActivityClearance.ActivityClearanceGateway");
	addModelMapping(alias="ActivityClearanceService",path="ActivityClearance.ActivityClearanceService");
	addModelMapping(alias="CNClearance",path="CNClearance.CNClearance");
	addModelMapping(alias="CNClearanceDAO",path="CNClearance.CNClearanceDAO");
	addModelMapping(alias="CNClearanceGateway",path="CNClearance.CNClearanceGateway");
	addModelMapping(alias="CNClearanceService",path="CNClearance.CNClearanceService");
	addModelMapping(alias="ActivityExtendedGrantGateway",path="ActivityExtendedGrant.ActivityExtendedGrantGateway");
	addModelMapping(alias="ActivityObligation",path="ActivityObligation.ActivityObligation");
	addModelMapping(alias="ActivityObligationDAO",path="ActivityObligation.ActivityObligationDAO");
	addModelMapping(alias="ActivityObligationGateway",path="ActivityObligation.ActivityObligationGateway");
	addModelMapping(alias="ActivityObligationService",path="ActivityObligation.ActivityObligationService");
	addModelMapping(alias="ActivityOrg",path="ActivityOrg.ActivityOrg");
	addModelMapping(alias="ActivityOrgDAO",path="ActivityOrg.ActivityOrgDAO");
	addModelMapping(alias="ActivityOrgGateway",path="ActivityOrg.ActivityOrgGateway");
	addModelMapping(alias="ActivityOrgService",path="ActivityOrg.ActivityOrgService");
	addModelMapping(alias="ActivityPerson",path="ActivityPerson.ActivityPerson");
	addModelMapping(alias="ActivityPersonDAO",path="ActivityPerson.ActivityPersonDAO");
	addModelMapping(alias="ActivityPersonGateway",path="ActivityPerson.ActivityPersonGateway");
	addModelMapping(alias="ActivityPersonService",path="ActivityPerson.ActivityPersonService");

	addModelMapping(alias="activityResultsFrameworkElement",path="activityResultsFrameworkElement.activityResultsFrameworkElement");
	addModelMapping(alias="activityResultsFrameworkElementDAO",path="activityResultsFrameworkElement.activityResultsFrameworkElementDAO");
	addModelMapping(alias="activityResultsFrameworkElementGateway",path="activityResultsFrameworkElement.activityResultsFrameworkElementGateway");
	addModelMapping(alias="activityResultsFrameworkElementService",path="activityResultsFrameworkElement.activityResultsFrameworkElementService");



	addModelMapping(alias="ActivityStatus",path="ActivityStatus.ActivityStatus");
	addModelMapping(alias="ActivityStatusDAO",path="ActivityStatus.ActivityStatusDAO");
	addModelMapping(alias="ActivityStatusGateway",path="ActivityStatus.ActivityStatusGateway");
	addModelMapping(alias="ActivityStatusService",path="ActivityStatus.ActivityStatusService");
	addModelMapping(alias="ActivityStatusLog",path="ActivityStatusLog.ActivityStatusLog");
	addModelMapping(alias="ActivityStatusLogDAO",path="ActivityStatusLog.ActivityStatusLogDAO");
	addModelMapping(alias="ActivityStatusLogGateway",path="ActivityStatusLog.ActivityStatusLogGateway");
	addModelMapping(alias="ActivityStatusLogService",path="ActivityStatusLog.ActivityStatusLogService");
	addModelMapping(alias="program",path="program.Program");
	addModelMapping(alias="programDAO",path="program.ProgramDAO");
	addModelMapping(alias="programGateway",path="program.ProgramGateway");
	addModelMapping(alias="programService",path="program.ProgramService");
	addModelMapping(alias="proposalGateway",path="proposal.ProposalGateway");
	addModelMapping(alias="proposalService",path="proposal.ProposalService");
	addModelMapping(alias="ActivityLegalRecommendation",path="ActivityLegalRecommendation.ActivityLegalRecommendation");
	addModelMapping(alias="ActivityLegalRecommendationDAO",path="ActivityLegalRecommendation.ActivityLegalRecommendationDAO");
	addModelMapping(alias="ActivityLegalRecommendationGateway",path="ActivityLegalRecommendation.ActivityLegalRecommendationGateway");
	addModelMapping(alias="ActivityLegalRecommendationService",path="ActivityLegalRecommendation.ActivityLegalRecommendationService");
	
	addModelMapping(alias="CN",path="CN.CN");
	addModelMapping(alias="CNDAO",path="CN.CNDAO");
	addModelMapping(alias="CNGateway",path="CN.CNGateway");
	
</cfscript>

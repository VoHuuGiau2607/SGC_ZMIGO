@VDM.viewType: #COMPOSITE

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'GLAccount'

@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #MASTER
@ObjectModel.usageType.serviceQuality: #C

@AccessControl.authorizationCheck: #CHECK 

@Search.searchable: true
@Consumption.ranked: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.supportedCapabilities:[#CDS_MODELING_DATA_SOURCE,#SEARCHABLE_ENTITY,#VALUE_HELP_PROVIDER]
@EndUserText.label: 'GL Account - Custom Value Help' 
define view entity ZI_WM_ZMIGO_GLACCOUNT_CVH as select from I_GlAccountTextInCompanycode 
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.9
  @Search.ranking: #HIGH
  @ObjectModel.text.element: [ 'GLAccountName' ]
  //@Consumption.hidden: true
  key GLAccount, 
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH    
  key CompanyCode,

  GLAccountName
} 
where Language = $session.system_language;

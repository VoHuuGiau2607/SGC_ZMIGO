@VDM.viewType: #COMPOSITE

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'CostCenter'

@ObjectModel.modelingPattern: #VALUE_HELP_PROVIDER
@ObjectModel.supportedCapabilities: [ #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET, #VALUE_HELP_PROVIDER ]

@ObjectModel.usageType.dataClass: #ORGANIZATIONAL
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #L

@AccessControl.authorizationCheck: #CHECK  

@Search.searchable: true
@Consumption.ranked: true

@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: 'Cost Center - Custom Value Help'
define view entity ZI_WM_ZMIGO_COSTCENTER_CVH as select from I_CostCenterText {
  @ObjectModel.foreignKey.association: '_ControllingArea'
  @Search: { defaultSearchElement: true,
             fuzzinessThreshold:  0.8,
             ranking: #LOW }
  @UI.lineItem: [{importance: #HIGH, position: 20}]
  key ControllingArea,
  @ObjectModel.text.element: ['CostCenterName']
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  @Search.ranking: #HIGH
  @UI.lineItem: [{importance: #HIGH, position: 10}]
  key CostCenter,
  @Semantics.businessDate.to: true
  key ValidityEndDate,
  @Semantics.businessDate.from: true
  ValidityStartDate,
  
  CostCenterName,

  @Consumption.hidden: true
  _ControllingArea
}
where Language = $session.system_language;


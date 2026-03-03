@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'UoM Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_UNIT_VH
  as select from I_ProductUnitsOfMeasure
{
  key Product,
  key AlternativeUnit,
      _AlternativeUnit.UnitOfMeasureNumberOfDecimals as NumberOfDecimals
}

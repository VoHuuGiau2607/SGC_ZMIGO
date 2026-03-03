@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post GM - Material Document Posted'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R02_A10_MATDOC
  as select from I_MaterialDocumentItem_2  as mseg
    inner join   ZCORE_I_MATDOC_REMOVE_REV as mseg_rev on  mseg.MaterialDocument     = mseg_rev.MaterialDocument
                                                       and mseg.MaterialDocumentYear = mseg_rev.MaterialDocumentYear
                                                       and mseg.MaterialDocumentItem = mseg_rev.MaterialDocumentItem
{
  key mseg.YY1_Matdoc313_Year_MMI,
  key mseg.YY1_Matdoc313_MMI,
  key mseg.YY1_Matdoc313_Item_MMI,
      mseg.MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( mseg.QuantityInBaseUnit ) as QuantityInBaseUnit
}
where
  mseg.GoodsMovementType = '315'
group by
  mseg.YY1_Matdoc313_Year_MMI,
  mseg.YY1_Matdoc313_MMI,
  mseg.YY1_Matdoc313_Item_MMI,
  mseg.MaterialBaseUnit

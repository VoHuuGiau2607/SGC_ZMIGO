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
define view entity ZI_WM_ZMIGO_R02_A10_INB
  as select from I_DeliveryDocumentItem as lips
    inner join   I_DeliveryDocument     as likp on likp.DeliveryDocument = lips.DeliveryDocument
{
  key lips.YY1_Matdoc313_Year_DLI,
  key lips.YY1_Matdoc313_DLI,
  key lips.YY1_Matdoc313_Item_DLI,
      lips.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum( lips.ActualDeliveredQtyInBaseUnit ) as ActualDeliveredQtyInBaseUnit
}
where
      likp.OverallGoodsMovementStatus <> 'C'
  and likp.SDDocumentCategory         =  '7'
  and lips.YY1_Matdoc313_Year_DLI     is not initial
  and lips.YY1_Matdoc313_DLI          is not initial
  and lips.YY1_Matdoc313_Item_DLI     is not initial
group by
  lips.YY1_Matdoc313_Year_DLI,
  lips.YY1_Matdoc313_DLI,
  lips.YY1_Matdoc313_Item_DLI,
  lips.BaseUnit

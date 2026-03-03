@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post GM - Purchase Order Posted'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R01_POSTED
  as select from I_MaterialDocumentItem_2  as mseg
    inner join   ZCORE_I_MATDOC_REMOVE_REV as rev on  mseg.MaterialDocument     = rev.MaterialDocument
                                                  and mseg.MaterialDocumentYear = rev.MaterialDocumentYear
                                                  and mseg.MaterialDocumentItem = rev.MaterialDocumentItem
{
  key mseg.PurchaseOrder,
  key mseg.PurchaseOrderItem,
      mseg.EntryUnit,
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      sum( mseg.QuantityInEntryUnit ) as PostedQuantity
}
where
  mseg.PurchaseOrder is not initial
group by
  mseg.PurchaseOrder,
  mseg.PurchaseOrderItem,
  mseg.EntryUnit

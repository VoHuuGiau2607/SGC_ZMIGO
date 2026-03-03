@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIGO - I_MaterialStock Sum'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_MATERIALSTOCK
  as select from I_MaterialStock
{
  key Plant,
  key StorageLocation,
  key Material,
  key Batch,
  key SDDocument,
  key SDDocumentItem,
      MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlWrhsStkQtyInMatlBaseUnit ) as SumUU
}
where
  InventoryStockType = '01'
group by
  Plant,
  StorageLocation,
  Material,
  Batch,
  SDDocument,
  SDDocumentItem,
  MaterialBaseUnit

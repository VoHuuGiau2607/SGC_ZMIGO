@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Material Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_R10_STOCK
  as select from I_MaterialStock_2
{
  key Plant,
  key StorageLocation,
  key Material,
  key Batch,
  key InventorySpecialStockType,
  key SDDocument,
  key SDDocumentItem,
  key Supplier,
  key MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( cast(
      case InventoryStockType
      when '01' then MatlWrhsStkQtyInMatlBaseUnit
      else 0
      end
      as abap.quan(31,14) ) ) as UnrestrictedUse,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( cast(
      case InventoryStockType
      when '07' then MatlWrhsStkQtyInMatlBaseUnit
      else 0
      end
      as abap.quan(31,14) ) ) as BlockStock,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( cast(
      case InventoryStockType
      when '04' then MatlWrhsStkQtyInMatlBaseUnit
      when '05' then MatlWrhsStkQtyInMatlBaseUnit
      else 0
      end
      as abap.quan(31,14) ) ) as TransitandTranfer,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( cast(
      case InventoryStockType
      when '02' then MatlWrhsStkQtyInMatlBaseUnit
      else 0
      end
      as abap.quan(31,14) ) ) as QualityInspection
}
group by
  Plant,
  StorageLocation,
  Material,
  Batch,
  InventorySpecialStockType,
  SDDocument,
  SDDocumentItem,
  Supplier,
  MaterialBaseUnit

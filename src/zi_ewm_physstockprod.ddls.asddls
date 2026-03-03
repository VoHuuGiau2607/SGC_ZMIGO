@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIGO - I_EWM_PhysStockProd'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_EWM_PHYSSTOCKPROD
  as select from I_EWM_PhysStockProd
{
  key ParentHandlingUnitUUID,
  key StockItemUUID,
      EWMWarehouse,
      Product,
      EWMStockType,
      EWMStockOwner,
      EntitledToDisposeParty,
      EWMStockUsage,
      Batch,
      StockDocumentCategory,
      case StockDocumentCategory
      when 'SOS' then 'E'
      when 'PJS' then 'Q'
      else ''
      end                      as StockDocumentCategoryConv,
      ExternalStockDocumentNumber,
      StockItemNumber,
      cast( case StockDocumentCategory
      when 'SOS' then right(StockDocumentNumber, 10) else  ''
      end as abap.char( 10 ) ) as SalesOrder,
      cast( case StockDocumentCategory
      when 'SOS' then right(StockItemNumber, 6) else  '000000'
      end as abap.numc( 6 ) )  as SalesOrderItem,
      EWMWorkInProcess,
      EWMStockReferenceDocCategory,
      EWMStockReferenceDocument,
      EWMStockReferenceDocumentItem,
      StockIdentificationNumber,
      WhseQualityInspectionType,
      QualityInspectionDocument,
      EWMStorageBin,
      HandlingUnitNumber,
      EWMResource,
      TranspUnitInternalNumber,
      EWMStockIndexCode,
      ProductUUID,
      BatchUUID,
      EWMDocumentCategory,
      StockDocumentNumber,
      @Semantics.quantity.unitOfMeasure: 'EWMStockQuantityBaseUnit'
      EWMStockQuantityInBaseUnit,
      EWMStockQuantityBaseUnit,
      EWMStockQtyBaseUnitISOCode,
      EWMStockQtyBaseUnitSAPCode,
      EWMStockQuantityAltvUnit,
      EWMStockQtyAltvUnitISOCode,
      EWMStockQtyAltvUnitSAPCode,
      @Semantics.quantity.unitOfMeasure: 'EWMLoadingOrNetWeightUnit'
      EWMLoadingOrNetWeight,
      EWMLoadingOrNetWeightUnit,
      EWMLoadgOrNetWgtUntISOCode,
      EWMLoadgOrNetWgtUntSAPCode,
      @Semantics.quantity.unitOfMeasure: 'EWMLoadingOrNetVolumeUnit'
      EWMLoadingOrNetVolume,
      EWMLoadingOrNetVolumeUnit,
      EWMLoadgOrNetVolUntISOCode,
      EWMLoadgOrNetVolUntSAPCode,
      EWMStorageBinCapConsumptionVal,
      ShelfLifeExpirationDate,
      CountryOfOrigin,
      EWMBatchIsInRestrictedUseStock,
      StockSegment,
      QualityInspectionDocUUID,
      InspectionPartialLot,
      EWMStockRefDocumentUUID,
      EWMStockRefDocItemUUID,
      @Semantics.quantity.unitOfMeasure: 'EWMValuationQuantityUnit'
      EWMValuationQuantity,
      EWMValuationQuantityUnit,
      EWMValuationQtyUnitISOCode,
      EWMValuationQtyUnitSAPCode,
      EWMValuationQuantityStatus,
      EWMStockIsBlockedForInventory,
      EWMConsolidationGroup,
      SerialNumberRequiredLevel,
      EWMGoodsReceiptDateTime,
      WarehouseTimeZone,
      EWMStorageType,
      EWMStorageSection,
      EWMStorBinIsBlockedForPutaway,
      EWMStorBinIsBlockedForRemoval,
      EWMStorBinIsBlockedDueToPInv,
      EWMHghstLvlHandlingUnitNumber,
      EWMLocationType,
      EWMParentLocationIndexCode,
      /* Associations */
      _CountryText,
      _EWMDocumentCategoryText,
      _EWMEntitledToDisposePartyText,
      _EWMStockOwnerText,
      _EWMStockRefDocCategoryText,
      _EWMStockTypeText,
      _EWMStockUsageText,
      _EWMValuationQtyStatusText,
      _LocationTypeText,
      _ProductText,
      _SerialNumberRequiredLevelText,
      _StockDocCategoryText,
      _StorageSectionText,
      _StorageTypeText,
      _UnitOfMeasureAlternativeUnit,
      _UnitOfMeasureBaseUnit,
      _UnitOfMeasureNetVolumeUoM,
      _UnitOfMeasureNetWeightUoM,
      _UnitOfMeasureValnQtyUnit,
      _WarehouseText,
      _WhseQualityInspectionTypeText
}

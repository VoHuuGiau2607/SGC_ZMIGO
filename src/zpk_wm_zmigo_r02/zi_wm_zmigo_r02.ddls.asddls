@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Material Document'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R02
  with parameters
    @Consumption.valueHelpDefinition: [{
        entity: {
            name           : 'ZI_WM_ZMIGO_ACTION_VH',
            element        : 'Action'
        }
    }]
    P_Action : zde_wm_zmigo_action
  as select from    I_MaterialDocumentHeader_2   as mkpf
    inner join      I_MaterialDocumentItem_2     as mseg            on  mkpf.MaterialDocumentYear = mseg.MaterialDocumentYear
                                                                    and mkpf.MaterialDocument     = mseg.MaterialDocument
    inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth            on  Auth.Plant           = mseg.Plant
                                                                    and Auth.StorageLocation = mseg.IssuingOrReceivingStorageLoc
                                                                    and Auth.UserID          = $session.user
    inner join      ZCORE_I_MATDOC_REMOVE_REV    as rev             on  mseg.MaterialDocument     = rev.MaterialDocument
                                                                    and mseg.MaterialDocumentYear = rev.MaterialDocumentYear
                                                                    and mseg.MaterialDocumentItem = rev.MaterialDocumentItem
    left outer join ZI_WM_ZMIGO_R02_A10_POSTED   as posted_315      on  posted_315.MaterialDocumentYear = mseg.MaterialDocumentYear
                                                                    and posted_315.MaterialDocument     = mseg.MaterialDocument
                                                                    and posted_315.MaterialDocumentItem = mseg.MaterialDocumentItem
    left outer join I_Plant                      as t001w           on mseg.Plant = t001w.Plant
    left outer join I_StorageLocation            as t001l           on  mseg.Plant           = t001l.Plant
                                                                    and mseg.StorageLocation = t001l.StorageLocation
    left outer join I_Plant                      as t001w_um        on mseg.IssuingOrReceivingPlant = t001w_um.Plant
    left outer join I_StorageLocation            as t001l_um        on  mseg.IssuingOrReceivingPlant      = t001l_um.Plant
                                                                    and mseg.IssuingOrReceivingStorageLoc = t001l_um.StorageLocation
    left outer join I_ProductText                as makt            on  makt.Product  = mseg.Material
                                                                    and makt.Language = $session.system_language
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT on  Character_Z_LOT.Product        = mseg.Material
                                                                    and Character_Z_LOT.Batch          = mseg.Batch
                                                                    and Character_Z_LOT.Characteristic = 'Z_LOT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW  on  Character_Z_GW.Product        = mseg.Material
                                                                    and Character_Z_GW.Batch          = mseg.Batch
                                                                    and Character_Z_GW.Characteristic = 'Z_GW'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD on  Character_Z_HSD.Product        = mseg.Material
                                                                    and Character_Z_HSD.Batch          = mseg.Batch
                                                                    and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'
    left outer join ZCORE_I_PRODUCT_CONVERT_RATE as ConvertTHU      on  ConvertTHU.Product  = mseg.Material
                                                                    and ConvertTHU.FromUnit = mseg.EntryUnit
                                                                    and ConvertTHU.ToUnit   = 'Z1'
    left outer join I_UnitOfMeasure                                 on mseg.EntryUnit = I_UnitOfMeasure.UnitOfMeasure
    left outer join ztb_wm_zmigo_313             as Exclude313      on  mseg.MaterialDocumentYear = Exclude313.material_document_year
                                                                    and mseg.MaterialDocument     = Exclude313.material_document
                                                                    and mseg.MaterialDocumentItem = Exclude313.material_document_item
    left outer join I_BusinessUserBasic                             on(
                                  (
                                    I_BusinessUserBasic.UserID = mseg.YY1_NguoiTao_MMI
                                    and mseg.YY1_NguoiTao_MMI  is not initial
                                  )
                                  or(
                                    I_BusinessUserBasic.UserID = mkpf.CreatedByUser
                                    and mseg.YY1_NguoiTao_MMI  is initial
                                  )
                                )
    left outer join I_BusinessPartner                               on I_BusinessPartner.BusinessPartnerUUID = I_BusinessUserBasic.BusinessPartnerUUID
{
  key mkpf.MaterialDocumentYear,
  key mkpf.MaterialDocument,
  key mseg.MaterialDocumentItem,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_PlantStdVH',
              element      : 'Plant'
          }
      }]
      @ObjectModel.text.element: [ 'PlantName' ]
      mseg.Plant,
      t001w.PlantName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_WM_ZMIGO_SLOC_CVH',
              element      : 'StorageLocation'
          },
          additionalBinding: [{
              localElement   : 'Plant',
              element        : 'Plant'
          }]
      }]
      @ObjectModel.text.element: [ 'StorageLocationName' ]
      @EndUserText.label: 'Transfer Storage Location'
      mseg.StorageLocation,
      t001l.StorageLocationName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductStdVH',
              element      : 'Product'
          }
      }]
      mseg.Material,
      makt.ProductName                                                                                                                     as MaterialDescription,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductUnitsOfMeasure',
              element      : 'AlternativeUnit'
          },
          additionalBinding: [{
              localElement   : 'Material',
              element        : 'Product'
          }]
      }]
      @EndUserText.label: 'Unit'
      mseg.MaterialBaseUnit                                                                                                                as EntryUnit,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                                                        as BaseUnitNumberOfDecimal,
      @Semantics.quantity.unitOfMeasure: 'EntryUnit'
      @EndUserText.label: 'Quatity'
      case
        when posted_315.MaterialDocument is not null then mseg.QuantityInBaseUnit - posted_315.PostedQty315
        else mseg.QuantityInBaseUnit
      end                                                                                                                                  as QuantityInEntryUnit,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_BatchStdVH',
              element      : 'Batch'
          },
          additionalBinding: [{
              localElement   : 'Material',
              element        : 'Material'
          }]
      }]
      mseg.Batch,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_SalesDocumentStdVH',
              element      : 'SalesDocument'
          }
      }]
      mseg.SalesOrder,
      mseg.SalesOrderItem,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_GoodsMovementType',
              element      : 'GoodsMovementType'
          }
      }]
      '315'                                                                                                                                as GoodsMovementType,
      mseg.InventorySpecialStockType,
      mseg.WBSElementInternalID,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast( '' as abap.char(24) )                                                                                                          as WBSElementExternalID,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_PlantStdVH',
              element      : 'Plant'
          }
      }]
      @ObjectModel.text.element: [ 'IssuingOrReceivingPlantName' ]
      mseg.IssuingOrReceivingPlant,
      t001w_um.PlantName                                                                                                                   as IssuingOrReceivingPlantName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_WM_ZMIGO_SLOC_CVH',
              element      : 'StorageLocation'
          },
          additionalBinding: [{
              localElement   : 'IssuingOrReceivingPlant',
              element        : 'Plant'
          }]
      }]
      @ObjectModel.text.element: [ 'IssuingOrReceivingSLocName' ]
      @EndUserText.label: 'Storage Location'
      mseg.IssuingOrReceivingStorageLoc,
      t001l_um.StorageLocationName                                                                                                         as IssuingOrReceivingSLocName,
      mseg.IssgOrRcvgMaterial                                                                                                              as IssuingOrReceivingMaterial,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_BatchStdVH',
              element      : 'Batch'
          },
          additionalBinding: [{
              localElement   : 'IssuingOrReceivingMaterial',
              element        : 'Material'
          }]
      }]
      mseg.IssgOrRcvgBatch                                                                                                                 as IssuingOrReceivingBatch,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_CostCenterStdVH',
              element      : 'CostCenter'
          }
      }]
      mseg.CostCenter,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_GLAccountStdVH',
              element      : 'GLAccount'
          },
          additionalBinding: [{
              element        : 'CompanyCode',
              localConstant  : '2000'
          }]
      }]
      mseg.GLAccount,
      Character_Z_LOT.CharcValue                                                                                                           as LotNum,
      Character_Z_HSD.CharcFromDate                                                                                                        as ExpirationDate,
      mseg.MaterialDocumentItemText,
      //      cast( Character_Z_GW.CharcFromNumericValue  as abap.dec(16,3) )                                    as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))                                       as GrossWeight,
      ConvertTHU.ConversionRate * $projection.QuantityInEntryUnit * round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as QuantityGrossWeight,
      mkpf.CreationDate,
      mkpf.CreatedByUser,
      mseg.YY1_NguoiTao_MMI,
      I_BusinessPartner.PersonFullName
}
where
      $parameters.P_Action         =  'A10'
  and mseg.GoodsMovementType       =  '313'
  and mseg.IsAutomaticallyCreated  is initial
  and(
      posted_315.MaterialDocument  is null
    or(
      posted_315.PostedQty315      <> mseg.QuantityInBaseUnit
    )
  )
  and Exclude313.material_document is null
union select from I_MaterialDocumentHeader_2   as mkpf
  inner join      I_MaterialDocumentItem_2     as mseg                    on  mkpf.MaterialDocumentYear = mseg.MaterialDocumentYear
                                                                          and mkpf.MaterialDocument     = mseg.MaterialDocument
  inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth                    on  Auth.Plant           = mseg.Plant
                                                                          and Auth.StorageLocation = mseg.IssuingOrReceivingStorageLoc
                                                                          and Auth.UserID          = $session.user
  inner join      ZCORE_I_MATDOC_REMOVE_REV    as rev                     on  mseg.MaterialDocument     = rev.MaterialDocument
                                                                          and mseg.MaterialDocumentYear = rev.MaterialDocumentYear
                                                                          and mseg.MaterialDocumentItem = rev.MaterialDocumentItem
  inner join      ZI_WM_ZMIGO_R02_A02_POSTED   as Quantity                on  Quantity.MaterialDocument     = mseg.MaterialDocument
                                                                          and Quantity.MaterialDocumentYear = mseg.MaterialDocumentYear
                                                                          and Quantity.MaterialDocumentItem = mseg.MaterialDocumentItem
  inner join      ZI_WM_ZMIGO_R02_A02_PAID     as Invoice                 on  Invoice.MaterialDocument     = mseg.MaterialDocument
                                                                          and Invoice.MaterialDocumentYear = mseg.MaterialDocumentYear
                                                                          and Invoice.MaterialDocumentItem = mseg.MaterialDocumentItem
  left outer join I_Plant                      as t001w                   on mseg.Plant = t001w.Plant
  left outer join I_StorageLocation            as t001l                   on  mseg.Plant           = t001l.Plant
                                                                          and mseg.StorageLocation = t001l.StorageLocation
  left outer join I_Plant                      as t001w_um                on mseg.IssuingOrReceivingPlant = t001w_um.Plant
  left outer join I_StorageLocation            as t001l_um                on  mseg.IssuingOrReceivingPlant      = t001l_um.Plant
                                                                          and mseg.IssuingOrReceivingStorageLoc = t001l_um.StorageLocation
  left outer join I_ProductText                as makt                    on  makt.Product  = mseg.Material
                                                                          and makt.Language = $session.system_language
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT         on  Character_Z_LOT.Product        = mseg.Material
                                                                          and Character_Z_LOT.Batch          = mseg.Batch
                                                                          and Character_Z_LOT.Characteristic = 'Z_LOT'
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW          on  Character_Z_GW.Product        = mseg.Material
                                                                          and Character_Z_GW.Batch          = mseg.Batch
                                                                          and Character_Z_GW.Characteristic = 'Z_GW'
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD         on  Character_Z_HSD.Product        = mseg.Material
                                                                          and Character_Z_HSD.Batch          = mseg.Batch
                                                                          and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'
  left outer join ZCORE_I_PRODUCT_CONVERT_RATE as ConvertTHU              on  ConvertTHU.Product  = mseg.Material
                                                                          and ConvertTHU.FromUnit = mseg.EntryUnit
                                                                          and ConvertTHU.ToUnit   = 'Z1'
  left outer join I_UnitOfMeasure                                         on mseg.EntryUnit = I_UnitOfMeasure.UnitOfMeasure
  left outer join ztb_mm_mvt_desc              as GoodsMovementTypeConfig on GoodsMovementTypeConfig.movementtype = mseg.GoodsMovementType
  left outer join I_BusinessUserBasic                                     on(
                                        (
                                          I_BusinessUserBasic.UserID = mseg.YY1_NguoiTao_MMI
                                          and mseg.YY1_NguoiTao_MMI  is not initial
                                        )
                                        or(
                                          I_BusinessUserBasic.UserID = mkpf.CreatedByUser
                                          and mseg.YY1_NguoiTao_MMI  is initial
                                        )
                                      )
  left outer join I_BusinessPartner                                       on I_BusinessPartner.BusinessPartnerUUID = I_BusinessUserBasic.BusinessPartnerUUID
{
  key mkpf.MaterialDocumentYear,
  key mkpf.MaterialDocument,
  key mseg.MaterialDocumentItem,
      mseg.Plant,
      t001w.PlantName,
      mseg.StorageLocation,
      t001l.StorageLocationName,
      mseg.Material,
      makt.ProductName                                                                                                                     as MaterialDescription,
      mseg.EntryUnit                                                                                                                       as EntryUnit,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                                                        as BaseUnitNumberOfDecimal,
      Quantity.RemainQtyInBaseUnit                                                                                                         as QuantityInEntryUnit,
      mseg.Batch,
      mseg.SalesOrder,
      mseg.SalesOrderItem,
      '122'                                                                                                                                as GoodsMovementType,
      mseg.InventorySpecialStockType,
      mseg.WBSElementInternalID,
      cast( '' as abap.char(24) )                                                                                                          as WBSElementExternalID,
      mseg.IssuingOrReceivingPlant,
      t001w_um.PlantName                                                                                                                   as IssuingOrReceivingPlantName,
      mseg.IssuingOrReceivingStorageLoc,
      t001l_um.StorageLocationName                                                                                                         as IssuingOrReceivingSLocName,
      mseg.IssgOrRcvgMaterial                                                                                                              as IssuingOrReceivingMaterial,
      mseg.IssgOrRcvgBatch                                                                                                                 as IssuingOrReceivingBatch,
      mseg.CostCenter,
      mseg.GLAccount,
      Character_Z_LOT.CharcValue                                                                                                           as LotNum,
      Character_Z_HSD.CharcFromDate                                                                                                        as ExpirationDate,
      mseg.MaterialDocumentItemText,
      //      cast( Character_Z_GW.CharcFromNumericValue  as abap.dec(16,3) )                                    as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))                                       as GrossWeight,
      ConvertTHU.ConversionRate * $projection.QuantityInEntryUnit * round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as QuantityGrossWeight,
      mkpf.CreationDate,
      mkpf.CreatedByUser,
      mseg.YY1_NguoiTao_MMI,
      I_BusinessPartner.PersonFullName
}
where
      $parameters.P_Action   = 'A02'
  and mseg.GoodsMovementType = '101'
  and mseg.PurchaseOrder     is not initial

union select from I_MaterialDocumentHeader_2   as mkpf
  inner join      I_MaterialDocumentItem_2     as mseg                    on  mkpf.MaterialDocumentYear = mseg.MaterialDocumentYear
                                                                          and mkpf.MaterialDocument     = mseg.MaterialDocument
  inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth                    on  Auth.Plant           = mseg.Plant
                                                                          and Auth.StorageLocation = mseg.IssuingOrReceivingStorageLoc
                                                                          and Auth.UserID          = $session.user
  inner join      ZCORE_I_MATDOC_REMOVE_REV    as rev                     on  mseg.MaterialDocument     = rev.MaterialDocument
                                                                          and mseg.MaterialDocumentYear = rev.MaterialDocumentYear
                                                                          and mseg.MaterialDocumentItem = rev.MaterialDocumentItem
  left outer join I_Plant                      as t001w                   on mseg.Plant = t001w.Plant
  left outer join I_StorageLocation            as t001l                   on  mseg.Plant           = t001l.Plant
                                                                          and mseg.StorageLocation = t001l.StorageLocation
  left outer join I_Plant                      as t001w_um                on mseg.IssuingOrReceivingPlant = t001w_um.Plant
  left outer join I_StorageLocation            as t001l_um                on  mseg.IssuingOrReceivingPlant      = t001l_um.Plant
                                                                          and mseg.IssuingOrReceivingStorageLoc = t001l_um.StorageLocation
  left outer join I_ProductText                as makt                    on  makt.Product  = mseg.Material
                                                                          and makt.Language = $session.system_language
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT         on  Character_Z_LOT.Product        = mseg.Material
                                                                          and Character_Z_LOT.Batch          = mseg.Batch
                                                                          and Character_Z_LOT.Characteristic = 'Z_LOT'
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW          on  Character_Z_GW.Product        = mseg.Material
                                                                          and Character_Z_GW.Batch          = mseg.Batch
                                                                          and Character_Z_GW.Characteristic = 'Z_GW'
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD         on  Character_Z_HSD.Product        = mseg.Material
                                                                          and Character_Z_HSD.Batch          = mseg.Batch
                                                                          and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'
  left outer join ZCORE_I_PRODUCT_CONVERT_RATE as ConvertTHU              on  ConvertTHU.Product  = mseg.Material
                                                                          and ConvertTHU.FromUnit = mseg.EntryUnit
                                                                          and ConvertTHU.ToUnit   = 'Z1'
  left outer join I_UnitOfMeasure                                         on mseg.EntryUnit = I_UnitOfMeasure.UnitOfMeasure
  left outer join ztb_mm_mvt_desc              as GoodsMovementTypeConfig on GoodsMovementTypeConfig.movementtype = mseg.GoodsMovementType
  left outer join I_BusinessUserBasic                                     on(
                                        (
                                          I_BusinessUserBasic.UserID = mseg.YY1_NguoiTao_MMI
                                          and mseg.YY1_NguoiTao_MMI  is not initial
                                        )
                                        or(
                                          I_BusinessUserBasic.UserID = mkpf.CreatedByUser
                                          and mseg.YY1_NguoiTao_MMI  is initial
                                        )
                                      )
  left outer join I_BusinessPartner                                       on I_BusinessPartner.BusinessPartnerUUID = I_BusinessUserBasic.BusinessPartnerUUID
{
  key mkpf.MaterialDocumentYear,
  key mkpf.MaterialDocument,
  key mseg.MaterialDocumentItem,
      mseg.Plant,
      t001w.PlantName,
      mseg.StorageLocation,
      t001l.StorageLocationName,
      mseg.Material,
      makt.ProductName                                                                                                                     as MaterialDescription,
      mseg.MaterialBaseUnit                                                                                                                as EntryUnit,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                                                        as BaseUnitNumberOfDecimal,
      mseg.QuantityInBaseUnit                                                                                                              as QuantityInEntryUnit,
      mseg.Batch,
      mseg.SalesOrder,
      mseg.SalesOrderItem,
      GoodsMovementTypeConfig.mvtreversal                                                                                                  as GoodsMovementType,
      mseg.InventorySpecialStockType,
      mseg.WBSElementInternalID,
      cast( '' as abap.char(24) )                                                                                                          as WBSElementExternalID,
      mseg.IssuingOrReceivingPlant,
      t001w_um.PlantName                                                                                                                   as IssuingOrReceivingPlantName,
      mseg.IssuingOrReceivingStorageLoc,
      t001l_um.StorageLocationName                                                                                                         as IssuingOrReceivingSLocName,
      mseg.IssgOrRcvgMaterial                                                                                                              as IssuingOrReceivingMaterial,
      mseg.IssgOrRcvgBatch                                                                                                                 as IssuingOrReceivingBatch,
      mseg.CostCenter,
      mseg.GLAccount,
      Character_Z_LOT.CharcValue                                                                                                           as LotNum,
      Character_Z_HSD.CharcFromDate                                                                                                        as ExpirationDate,
      mseg.MaterialDocumentItemText,
      //      cast( Character_Z_GW.CharcFromNumericValue  as abap.dec(16,3) )                                    as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))                                       as GrossWeight,
      ConvertTHU.ConversionRate * $projection.QuantityInEntryUnit * round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as QuantityGrossWeight,
      mkpf.CreationDate,
      mkpf.CreatedByUser,
      mseg.YY1_NguoiTao_MMI,
      I_BusinessPartner.PersonFullName
}
where
  $parameters.P_Action = 'A03'

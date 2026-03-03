@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Outbound Delivery'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R05
  with parameters
    @Consumption.valueHelpDefinition: [{
        entity: {
            name           : 'ZI_WM_ZMIGO_ACTION_VH',
            element        : 'Action'
        }
    }]
    P_Action : zde_wm_zmigo_action
  as select from    I_OutboundDelivery           as likp
    inner join      I_OutboundDeliveryItem       as lips                   on likp.OutboundDelivery = lips.OutboundDelivery
    inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth                   on  Auth.Plant           = lips.Plant
                                                                           and Auth.StorageLocation = lips.StorageLocation
                                                                           and Auth.UserID          = $session.user
    left outer join I_SalesDocument              as vbak                   on vbak.SalesDocument = lips.ReferenceSDDocument
    left outer join I_SalesDocumentItem          as vbap                   on  vbap.SalesDocument              = lips.ReferenceSDDocument
                                                                           and vbap.SalesDocumentItem          = lips.ReferenceSDDocumentItem
                                                                           and vbap.IndependentRequirementType = 'BB6'
    left outer join ZI_WM_ZMIGO_R10_STOCK        as Stock                  on  Stock.Plant                     = lips.Plant
                                                                           and Stock.StorageLocation           = lips.StorageLocation
                                                                           and Stock.Material                  = lips.Material
                                                                           and Stock.Batch                     = lips.Batch
                                                                           and Stock.InventorySpecialStockType = lips.InventorySpecialStockType
                                                                           and (
                                                                              (
                                                                                Stock.SDDocument               = vbap.SalesDocument
                                                                                and Stock.SDDocumentItem       = vbap.SalesDocumentItem
                                                                              )
                                                                              or(
                                                                                vbap.SalesDocument             is null
                                                                                and Stock.SDDocument           = ''
                                                                                and Stock.SDDocumentItem       = '000000'
                                                                              )
                                                                            )
    left outer join I_Plant                      as t001w                  on lips.Plant = t001w.Plant
    left outer join I_StorageLocation            as t001l                  on  lips.Plant           = t001l.Plant
                                                                           and lips.StorageLocation = t001l.StorageLocation
    left outer join I_Product                    as mara                   on mara.Product = lips.Material
    left outer join I_ProductText                as makt                   on  makt.Product  = lips.Material
                                                                           and makt.Language = $session.system_language
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT        on  Character_Z_LOT.Product        = lips.Material
                                                                           and Character_Z_LOT.Batch          = lips.Batch
                                                                           and Character_Z_LOT.Characteristic = 'Z_LOT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU     on  Character_Z_GHICHU.Product        = lips.Material
                                                                           and Character_Z_GHICHU.Batch          = lips.Batch
                                                                           and Character_Z_GHICHU.Characteristic = 'Z_GHICHU'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU_PKH on  Character_Z_GHICHU_PKH.Product        = lips.Material
                                                                           and Character_Z_GHICHU_PKH.Batch          = lips.Batch
                                                                           and Character_Z_GHICHU_PKH.Characteristic = 'Z_GHICHU_PKH '
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW         on  Character_Z_GW.Product        = lips.Material
                                                                           and Character_Z_GW.Batch          = lips.Batch
                                                                           and Character_Z_GW.Characteristic = 'Z_GW'
    left outer join ZCORE_I_PRODUCT_CONVERT_RATE as ConvertTHU             on  ConvertTHU.Product  = lips.Material
                                                                           and ConvertTHU.FromUnit = lips.BaseUnit
                                                                           and ConvertTHU.ToUnit   = 'Z1'
    left outer join I_UnitOfMeasure                                        on lips.DeliveryQuantityUnit = I_UnitOfMeasure.UnitOfMeasure
{
  key likp.OutboundDelivery,
  key lips.OutboundDeliveryItem,
      cast(
      case
      when mara.IsBatchManagementRequired is initial then 'X'
      when likp.DeliveryDocumentType = 'RL' then 'X'
      when likp.DeliveryDocumentType = 'RLL' then 'X'
      else ''
      end as abap_boolean )                                                                                                                    as NotAllowEditBatch,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_PlantStdVH',
              element      : 'Plant'
          }
      }]
      @ObjectModel.text.element: [ 'PlantName' ]
      lips.Plant,
      t001w.PlantName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_Customer_VH',
              element      : 'Customer'
          }
      }]
      likp.SoldToParty,
      likp._SoldToParty.OrganizationBPName1                                                                                                    as SoldToPartyName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_Customer_VH',
              element      : 'Customer'
          }
      }]
      likp.ShipToParty,
      likp._ShipToParty.OrganizationBPName1                                                                                                    as ShipToPartyName,
      likp.PlannedGoodsIssueDate,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductStdVH',
              element      : 'Product'
          }
      }]
      lips.Material,
      makt.ProductName                                                                                                                         as MaterialDescription,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_ProductType_CVH',
              element      : 'ProductType'
          }
      }]
      @ObjectModel.text.element: [ 'MaterialTypeName' ]
      mara.ProductType                                                                                                                         as MaterialType,
      mara._ProductTypeName[1: Language=$session.system_language].MaterialTypeName,
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
      lips.DeliveryQuantityUnit,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                                                            as UnitNumberOfDecimal,
      @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
      lips.ActualDeliveryQuantity,
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
      lips.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      Stock.UnrestrictedUse,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      lips.ActualDeliveredQtyInBaseUnit,
      likp.DeliveryDate,
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
      lips.Batch,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_SalesDocumentStdVH',
              element      : 'SalesDocument'
          }
      }]
      lips.ReferenceSDDocument,
      lips.ReferenceSDDocumentItem,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_GoodsMovementType',
              element      : 'GoodsMovementType'
          }
      }]
      lips.GoodsMovementType,
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
      lips.StorageLocation,
      t001l.StorageLocationName,
      lips.InventorySpecialStockType,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_CostCenterStdVH',
              element      : 'CostCenter'
          }
      }]
      lips.CostCenter,
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
      lips.GLAccount,
      Character_Z_LOT.CharcValue                                                                                                               as LotNum,
      Character_Z_GHICHU.CharcValue                                                                                                            as BatchNote,
      Character_Z_GHICHU_PKH .CharcValue                                                                                                       as PlanDeptNote,
      //      cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,3) )                                                                 as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))                                           as GrossWeight,
      ConvertTHU.ConversionRate * lips.ActualDeliveredQtyInBaseUnit * round(cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,6) ), 3) as QuantityGrossWeight,
      likp.CreationDate,
      vbak.PurchaseOrderByCustomer
}
where
          lips.ActualDeliveryQuantity     <> 0
  and     likp.OverallGoodsMovementStatus <> 'C'
  and     $parameters.P_Action            =  'A07'
  and(
    (
          likp.Warehouse                  is initial
      and lips.Warehouse                  is initial
    )
    or(
          likp.DeliveryDocumentType       =  'RL'
      or  likp.DeliveryDocumentType       =  'RLL'
    )
  )
  and     likp.DeletionIndicator          is initial
  and     lips.InventorySpecialStockType  <> 'W'
union select from I_DeliveryDocument           as likp
  inner join      I_DeliveryDocumentItem       as lips                   on likp.DeliveryDocument = lips.DeliveryDocument
  left outer join I_SalesDocument              as vbak                   on vbak.SalesDocument = lips.ReferenceSDDocument
  inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth                   on  Auth.Plant           = lips.Plant
                                                                         and Auth.StorageLocation = lips.StorageLocation
                                                                         and Auth.UserID          = $session.user
  left outer join I_Plant                      as t001w                  on lips.Plant = t001w.Plant
  left outer join I_StorageLocation            as t001l                  on  lips.Plant           = t001l.Plant
                                                                         and lips.StorageLocation = t001l.StorageLocation
  left outer join I_Product                    as mara                   on mara.Product = lips.Material
  left outer join I_ProductText                as makt                   on  makt.Product  = lips.Material
                                                                         and makt.Language = $session.system_language
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT        on  Character_Z_LOT.Product        = lips.Material
                                                                         and Character_Z_LOT.Batch          = lips.Batch
                                                                         and Character_Z_LOT.Characteristic = 'Z_LOT'
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU     on  Character_Z_GHICHU.Product        = lips.Material
                                                                         and Character_Z_GHICHU.Batch          = lips.Batch
                                                                         and Character_Z_GHICHU.Characteristic = 'Z_GHICHU'
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU_PKH on  Character_Z_GHICHU_PKH.Product        = lips.Material
                                                                         and Character_Z_GHICHU_PKH.Batch          = lips.Batch
                                                                         and Character_Z_GHICHU_PKH.Characteristic = 'Z_GHICHU_PKH '
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW         on  Character_Z_GW.Product        = lips.Material
                                                                         and Character_Z_GW.Batch          = lips.Batch
                                                                         and Character_Z_GW.Characteristic = 'Z_GW'
  left outer join ZCORE_I_PRODUCT_CONVERT_RATE as ConvertTHU             on  ConvertTHU.Product  = lips.Material
                                                                         and ConvertTHU.FromUnit = lips.BaseUnit
                                                                         and ConvertTHU.ToUnit   = 'Z1'
  left outer join I_UnitOfMeasure                                        on lips.DeliveryQuantityUnit = I_UnitOfMeasure.UnitOfMeasure
{
  key likp.DeliveryDocument                                                                                                                   as OutboundDelivery,
  key lips.DeliveryDocumentItem                                                                                                               as OutboundDeliveryItem,
      cast( 'X' as abap_boolean)                                                                                                              as NotAllowEditBatch,
      lips.Plant,
      t001w.PlantName,
      likp.SoldToParty,
      likp._SoldToParty.OrganizationBPName1                                                                                                   as SoldToPartyName,
      likp.ShipToParty,
      likp._ShipToParty.OrganizationBPName1                                                                                                   as ShipToPartyName,
      likp.PlannedGoodsIssueDate,
      lips.Material,
      makt.ProductName                                                                                                                        as MaterialDescription,
      mara.ProductType                                                                                                                        as MaterialType,
      mara._ProductTypeName[1: Language=$session.system_language].MaterialTypeName,
      lips.DeliveryQuantityUnit,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                                                           as UnitNumberOfDecimal,
      lips.ActualDeliveryQuantity,
      lips.BaseUnit,
      0                                                                                                                                       as UnrestrictedUse,
      lips.ActualDeliveredQtyInBaseUnit,
      likp.DeliveryDate,
      lips.Batch,
      lips.ReferenceSDDocument,
      lips.ReferenceSDDocumentItem,
      lips.GoodsMovementType,
      lips.StorageLocation,
      t001l.StorageLocationName,
      lips.InventorySpecialStockType,
      lips.CostCenter,
      lips.GLAccount,
      Character_Z_LOT.CharcValue                                                                                                              as LotNum,
      Character_Z_GHICHU.CharcValue                                                                                                           as BatchNote,
      Character_Z_GHICHU_PKH .CharcValue                                                                                                      as PlanDeptNote,
      //      cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,3) )                                                                as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))                                          as GrossWeight,
      ConvertTHU.ConversionRate * lips.ActualDeliveredQtyInBaseUnit * round(cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as QuantityGrossWeight,
      likp.CreationDate,
      vbak.PurchaseOrderByCustomer
}
where
       lips.ActualDeliveryQuantity     <> 0
  and  likp.OverallGoodsMovementStatus <> 'C'
  and  $parameters.P_Action            =  'A01'
  and(
       likp.DeliveryDocumentType       =  'LR2'
    or likp.DeliveryDocumentType       =  'LR'
  )
  and  likp.DeletionIndicator          is initial

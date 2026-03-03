@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Inbound Delivery'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R04
  with parameters
    @Consumption.valueHelpDefinition: [{
        entity: {
            name           : 'ZI_WM_ZMIGO_ACTION_VH',
            element        : 'Action'
        }
    }]
    P_Action : zde_wm_zmigo_action
  as select from    I_InboundDelivery            as likp
    inner join      I_DeliveryDocument           as likp_root               on likp.InboundDelivery = likp_root.DeliveryDocument
    inner join      I_InboundDeliveryItem        as lips                    on likp.InboundDelivery = lips.InboundDelivery
  //    inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth                    on  Auth.Plant           = lips.Plant
  //                                                                            and Auth.StorageLocation = lips.StorageLocation
  //                                                                            and Auth.UserID          = $session.user
    left outer join ZI_WM_ZMIGO_R04_AUTH         as Auth                    on Auth.AddressID = likp_root.YY1_DiaChiGiaoHang_DLH
    left outer join I_Plant                      as t001w                   on lips.Plant = t001w.Plant
    left outer join I_StorageLocation            as t001l                   on  lips.Plant           = t001l.Plant
                                                                            and lips.StorageLocation = t001l.StorageLocation
    left outer join I_Product                    as mara                    on mara.Product = lips.Material
  //    left outer join I_ProductText                as makt                    on  makt.Product  = lips.Material
  //                                                                            and makt.Language = $session.system_language
    left outer join ZCORE_I_PRODUCT_CONVERT_RATE as ConvertTHU              on  ConvertTHU.Product  = lips.Material
                                                                            and ConvertTHU.FromUnit = lips.BaseUnit
                                                                            and ConvertTHU.ToUnit   = 'Z1'
    left outer join I_UnitOfMeasure                                         on lips.DeliveryQuantityUnit = I_UnitOfMeasure.UnitOfMeasure
    left outer join I_ClfnObjectClass            as ObjectClass             on  ObjectClass.ClfnObjectID    = lips.Material
                                                                            and ObjectClass.ClfnObjectTable = 'MARA'
    left outer join ztb_wm_cf_slo_wm             as Factory                 on  Factory.plant            = lips.Plant
                                                                            and Factory.storage_location = lips.StorageLocation
    left outer join I_ProfitCenterText           as ProfitCenter            on  ProfitCenter.ProfitCenter      = Factory.factory_id
                                                                            and ProfitCenter.ControllingArea   = 'A000'
                                                                            and ProfitCenter.ValidityEndDate   >= $session.system_date
                                                                            and ProfitCenter.ValidityStartDate <= $session.system_date
                                                                            and ProfitCenter.Language          = $session.system_language
    left outer join ZI_WM_ZMIGO_BATCH_PC         as Character_Z_PC          on  Character_Z_PC.Product = lips.Material
                                                                            and Character_Z_PC.Batch   = lips.Batch
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_PC     on  ClassCharacter_Z_PC.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_PC.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_PC.Characteristic  = 'Z_PC'
    left outer join I_ProfitCenterText           as BatchProfitCenter       on  BatchProfitCenter.ProfitCenter      = Character_Z_PC.ProfitCenter
                                                                            and BatchProfitCenter.ControllingArea   = 'A000'
                                                                            and BatchProfitCenter.ValidityEndDate   >= $session.system_date
                                                                            and BatchProfitCenter.ValidityStartDate <= $session.system_date
                                                                            and BatchProfitCenter.Language          = $session.system_language
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHASX       on  Character_Z_NHASX.Product        = lips.Material
                                                                            and Character_Z_NHASX.Batch          = lips.Batch
                                                                            and Character_Z_NHASX.Characteristic = 'Z_NHASX'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHASX  on  ClassCharacter_Z_NHASX.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NHASX.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NHASX.Characteristic  = 'Z_NHASX'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT         on  Character_Z_LOT.Product        = lips.Material
                                                                            and Character_Z_LOT.Batch          = lips.Batch
                                                                            and Character_Z_LOT.Characteristic = 'Z_LOT'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOT    on  ClassCharacter_Z_LOT.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_LOT.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_LOT.Characteristic  = 'Z_LOT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NCC         on  Character_Z_NCC.Product        = lips.Material
                                                                            and Character_Z_NCC.Batch          = lips.Batch
                                                                            and Character_Z_NCC.Characteristic = 'Z_NCC'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NCC    on  ClassCharacter_Z_NCC.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NCC.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NCC.Characteristic  = 'Z_NCC'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU      on  Character_Z_GHICHU.Product        = lips.Material
                                                                            and Character_Z_GHICHU.Batch          = lips.Batch
                                                                            and Character_Z_GHICHU.Characteristic = 'Z_GC'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU on  ClassCharacter_Z_GHICHU.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_GHICHU.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_GHICHU.Characteristic  = 'Z_GHICHU'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSX         on  Character_Z_NSX.Product        = lips.Material
                                                                            and Character_Z_NSX.Batch          = lips.Batch
                                                                            and Character_Z_NSX.Characteristic = 'Z_NSX'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSX    on  ClassCharacter_Z_NSX.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NSX.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NSX.Characteristic  = 'Z_NSX'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD         on  Character_Z_HSD.Product        = lips.Material
                                                                            and Character_Z_HSD.Batch          = lips.Batch
                                                                            and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSD    on  ClassCharacter_Z_HSD.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_HSD.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_HSD.Characteristic  = 'LOBM_VFDAT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSXNB       on  Character_Z_NSXNB.Product        = lips.Material
                                                                            and Character_Z_NSXNB.Batch          = lips.Batch
                                                                            and Character_Z_NSXNB.Characteristic = 'Z_NSXNB'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSXNB  on  ClassCharacter_Z_NSXNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NSXNB.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NSXNB.Characteristic  = 'Z_NSXNB'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSDNB       on  Character_Z_HSDNB.Product        = lips.Material
                                                                            and Character_Z_HSDNB.Batch          = lips.Batch
                                                                            and Character_Z_HSDNB.Characteristic = 'Z_HSDNB'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSDNB  on  ClassCharacter_Z_HSDNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_HSDNB.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_HSDNB.Characteristic  = 'Z_HSDNB'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_MTX         on  Character_Z_MTX.Product        = lips.Material
                                                                            and Character_Z_MTX.Batch          = lips.Batch
                                                                            and Character_Z_MTX.Characteristic = 'Z_MTX'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_MTX    on  ClassCharacter_Z_MTX.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_MTX.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_MTX.Characteristic  = 'Z_MTX'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_QCBG        on  Character_Z_QCBG.Product        = lips.Material
                                                                            and Character_Z_QCBG.Batch          = lips.Batch
                                                                            and Character_Z_QCBG.Characteristic = 'Z_QCBG'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_QCBG   on  ClassCharacter_Z_QCBG.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_QCBG.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_QCBG.Characteristic  = 'Z_QCBG'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NG          on  Character_Z_NG.Product        = lips.Material
                                                                            and Character_Z_NG.Batch          = lips.Batch
                                                                            and Character_Z_NG.Characteristic = 'Z_NG'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NG     on  ClassCharacter_Z_NG.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NG.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NG.Characteristic  = 'Z_NG'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW          on  Character_Z_GW.Product        = lips.Material
                                                                            and Character_Z_GW.Batch          = lips.Batch
                                                                            and Character_Z_GW.Characteristic = 'Z_GW'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GW     on  ClassCharacter_Z_GW.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_GW.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_GW.Characteristic  = 'Z_GW'
{
  key likp.InboundDelivery,
  key lips.InboundDeliveryItem,
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
              name         : 'I_Supplier_VH',
              element      : 'Supplier'
          }
      }]
      likp.Supplier,
      likp._Supplier.OrganizationBPName1                                                                                                      as SupplierName,
      likp.DeliveryDate,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductStdVH',
              element      : 'Product'
          }
      }]
      lips.Material,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast( '' as abap.char( 100 ) )                                                                                                          as MaterialDescription,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_ProductType_CVH',
              element      : 'ProductType'
          }
      }]
      @ObjectModel.text.element: [ 'MaterialTypeName' ]
      mara.ProductType                                                                                                                        as MaterialType,
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
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                                                           as UnitNumberOfDecimal,
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
      lips.ActualDeliveredQtyInBaseUnit,
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
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_Customer_VH',
              element      : 'Customer'
          }
      }]
      likp.ShipToParty,
      likp._ShipToParty.OrganizationBPName1                                                                                                   as ShipToPartyName,
      //      @Consumption.valueHelpDefinition: [{
      //          entity           : {
      //              name         : 'I_SalesDocumentStdVH',
      //              element      : 'SalesDocument'
      //          }
      //      }]
      //      case
      //      when lips.OriginSDDocument is not initial then lips.OriginSDDocument
      //      else lips.ReferenceSDDocument
      //      end                                                                                                                           as OriginSDDocument,
      //      case
      //      when lips.SDDocumentItem is not initial then lips.SDDocumentItem
      //      else lips.ReferenceSDDocumentItem
      //      end                                                                                                                           as SDDocumentItem,
      lips.InventorySpecialStockType,
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
      likp.CreationDate,
      @EndUserText.label: 'Gross Weight'
      //      cast( Character_Z_GW.CharcFromDecimalValue as abap.dec(16,3) )                                                                as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))                                          as GrossWeight,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_GW.ClassInternalID is null then '' else 'X' end as abap_boolean )                                      as GrossWeightActive,
      @EndUserText.label: 'Quantity Gross Weight'
      ConvertTHU.ConversionRate * lips.ActualDeliveredQtyInBaseUnit * round(cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as QuantityGrossWeight,
      @EndUserText.label: 'Lot Number'
      Character_Z_LOT.CharcValue                                                                                                              as LotNum,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_LOT.ClassInternalID is null then '' else 'X' end as abap_boolean )                                     as LotNumActive,
      @EndUserText.label: 'Ghi chú'
      Character_Z_GHICHU.CharcValue                                                                                                           as BatchNote,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_GHICHU.ClassInternalID is null then '' else 'X' end as abap_boolean )                                  as BatchNoteActive,
      @EndUserText.label: 'Ngày sản xuất'
      Character_Z_NSX.CharcFromDate                                                                                                           as ProductionDate,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NSX.ClassInternalID is null then '' else 'X' end as abap_boolean )                                     as ProductionDateActive,
      @EndUserText.label: 'Hạn sử dụng'
      Character_Z_HSD.CharcFromDate                                                                                                           as ExpirationDate,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_HSD.ClassInternalID is null then '' else 'X' end as abap_boolean )                                     as ExpirationDateActive,
      @EndUserText.label: 'Nguồn gốc'
      Character_Z_NG.CharcValue                                                                                                               as Origin,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NG.ClassInternalID is null then '' else 'X' end as abap_boolean )                                      as OriginActive,
      @EndUserText.label: 'Nhà cung cấp'
      Character_Z_NCC.CharcValue                                                                                                              as BatchSupplier,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NCC.ClassInternalID is null then '' else 'X' end as abap_boolean )                                     as BatchSupplierActive,
      @EndUserText.label: 'Nhà sản xuất'
      Character_Z_NHASX.CharcValue                                                                                                            as Manufacturer,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NHASX.ClassInternalID is null then '' else 'X' end as abap_boolean )                                   as ManufacturerActive,
      @EndUserText.label: 'Ngày sản xuất nội bộ'
      Character_Z_NSXNB.CharcFromDate                                                                                                         as ProductionDateInternal,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NSXNB.ClassInternalID is null then '' else 'X' end as abap_boolean )                                   as ProductionDateInternalActive,
      @EndUserText.label: 'Hạn sử dụng nội bộ'
      Character_Z_HSDNB.CharcFromDate                                                                                                         as ExpirationDateInternal,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_HSDNB.ClassInternalID is null then '' else 'X' end as abap_boolean )                                   as ExpirationDateInternalActive,
      @EndUserText.label: 'Mã truy xuất'
      Character_Z_MTX.CharcValue                                                                                                              as AccessCode,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_MTX.ClassInternalID is null then '' else 'X' end as abap_boolean )                                     as AccessCodeActive,
      @EndUserText.label: 'Quy cách bao gói'
      Character_Z_QCBG.CharcValue                                                                                                             as PackagingSpec,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_QCBG.ClassInternalID is null then '' else 'X' end as abap_boolean )                                    as PackagingSpecActive,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZCORE_I_PROFITCENTER_CVH',
              element      : 'ProfitCenter'
          }
      }]
      case when BatchProfitCenter.ProfitCenter is initial or BatchProfitCenter.ProfitCenter is null
      then ProfitCenter.ProfitCenter
      else BatchProfitCenter.ProfitCenter
      end                                                                                                                                     as ProfitCenter,
      case when BatchProfitCenter.ProfitCenter is initial or BatchProfitCenter.ProfitCenter is null
      then ProfitCenter.ProfitCenterName
      else BatchProfitCenter.ProfitCenterName
      end                                                                                                                                     as ProfitCenterName,
      cast( case when ClassCharacter_Z_PC.ClassInternalID is null then '' else 'X' end as abap_boolean )                                      as ProfitCenterActive,
      likp_root.YY1_DiaChiGiaoHang_DLH                                                                                                        as DiaChiGiaoHang
}
where
       lips.ActualDeliveryQuantity      <> 0
  and  likp.OverallGoodsMovementStatus  <> 'C'
  and  likp.Warehouse                   is initial
  and  lips.Warehouse                   is initial
  and  likp.DeletionIndicator           is initial
  and  lips.GoodsMovementType           =  '101'
  and(
       Auth.AddressID                   is not null
    or likp_root.YY1_DiaChiGiaoHang_DLH is initial
  )

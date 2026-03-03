@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Post Goods Movement - Material Stock'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZI_WM_ZMIGO_R10
  with parameters
    @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_WM_ZMIGO_ACTION_VH', element: 'Action' } } ]
    P_Action : zde_wm_zmigo_action

  as select from    ZI_WM_ZMIGO_R10_STOCK        as Stock

    inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth
      on  Auth.Plant           = Stock.Plant
      and Auth.StorageLocation = Stock.StorageLocation
      and Auth.UserID          = $session.user

    left outer join I_Plant                      as t001w
      on Stock.Plant = t001w.Plant

    left outer join I_StorageLocation            as t001l
      on  Stock.Plant           = t001l.Plant
      and Stock.StorageLocation = t001l.StorageLocation

    left outer join I_Product                    as mara
      on mara.Product = Stock.Material

    left outer join I_SalesDocument              as vbak
      on Stock.SDDocument = vbak.SalesDocument

    left outer join I_SalesDocumentItem          as vbap
      on  Stock.SDDocument     = vbap.SalesDocument
      and Stock.SDDocumentItem = vbap.SalesDocumentItem

    left outer join ZCORE_I_PRODUCT_CONVERT_RATE as ConvertTHU
      on  ConvertTHU.Product  = Stock.Material
      and ConvertTHU.FromUnit = Stock.MaterialBaseUnit
      and ConvertTHU.ToUnit   = 'Z1'

    left outer join I_ProductStorage_2
      on I_ProductStorage_2.Product = Stock.Material

    left outer join I_UnitOfMeasure
      on Stock.MaterialBaseUnit = I_UnitOfMeasure.UnitOfMeasure

    left outer join I_ClfnObjectClass            as ObjectClass
      on  ObjectClass.ClfnObjectID    = Stock.Material
      and ObjectClass.ClfnObjectTable = 'MARA'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT
      on  Character_Z_LOT.Product        = Stock.Material
      and Character_Z_LOT.Batch          = Stock.Batch
      and Character_Z_LOT.Characteristic = 'Z_LOT'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOT
      on  ClassCharacter_Z_LOT.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_LOT.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_LOT.Characteristic   = 'Z_LOT'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU
      on  Character_Z_GHICHU.Product        = Stock.Material
      and Character_Z_GHICHU.Batch          = Stock.Batch
      and Character_Z_GHICHU.Characteristic = 'Z_GHICHU'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU
      on  ClassCharacter_Z_GHICHU.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_GHICHU.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_GHICHU.Characteristic   = 'Z_GHICHU'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GCQC
      on  Character_Z_GCQC.Product        = Stock.Material
      and Character_Z_GCQC.Batch          = Stock.Batch
      and Character_Z_GCQC.Characteristic = 'Z_GCQC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GCQC
      on  ClassCharacter_Z_GCQC.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_GCQC.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_GCQC.Characteristic   = 'Z_GCQC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSX
      on  Character_Z_NSX.Product        = Stock.Material
      and Character_Z_NSX.Batch          = Stock.Batch
      and Character_Z_NSX.Characteristic = 'Z_NSX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSX
      on  ClassCharacter_Z_NSX.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_NSX.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_NSX.Characteristic   = 'Z_NSX'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD
      on  Character_Z_HSD.Product        = Stock.Material
      and Character_Z_HSD.Batch          = Stock.Batch
      and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSD
      on  ClassCharacter_Z_HSD.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_HSD.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_HSD.Characteristic   = 'LOBM_VFDAT'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NG
      on  Character_Z_NG.Product        = Stock.Material
      and Character_Z_NG.Batch          = Stock.Batch
      and Character_Z_NG.Characteristic = 'Z_NG'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NG
      on  ClassCharacter_Z_NG.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_NG.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_NG.Characteristic   = 'Z_NG'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GRD
      on  Character_Z_GRD.Product        = Stock.Material
      and Character_Z_GRD.Batch          = Stock.Batch
      and Character_Z_GRD.Characteristic = 'Z_GRD'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GRD
      on  ClassCharacter_Z_GRD.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_GRD.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_GRD.Characteristic   = 'Z_GRD'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NCC
      on  Character_Z_NCC.Product        = Stock.Material
      and Character_Z_NCC.Batch          = Stock.Batch
      and Character_Z_NCC.Characteristic = 'Z_NCC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NCC
      on  ClassCharacter_Z_NCC.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_NCC.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_NCC.Characteristic   = 'Z_NCC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHASX
      on  Character_Z_NHASX.Product        = Stock.Material
      and Character_Z_NHASX.Batch          = Stock.Batch
      and Character_Z_NHASX.Characteristic = 'Z_NHASX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHASX
      on  ClassCharacter_Z_NHASX.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_NHASX.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_NHASX.Characteristic   = 'Z_NHASX'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSXNB
      on  Character_Z_NSXNB.Product        = Stock.Material
      and Character_Z_NSXNB.Batch          = Stock.Batch
      and Character_Z_NSXNB.Characteristic = 'Z_NSXNB'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSXNB
      on  ClassCharacter_Z_NSXNB.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_NSXNB.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_NSXNB.Characteristic   = 'Z_NSXNB'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSDNB
      on  Character_Z_HSDNB.Product        = Stock.Material
      and Character_Z_HSDNB.Batch          = Stock.Batch
      and Character_Z_HSDNB.Characteristic = 'Z_HSDNB'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSDNB
      on  ClassCharacter_Z_HSDNB.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_HSDNB.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_HSDNB.Characteristic   = 'Z_HSDNB'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_MTX
      on  Character_Z_MTX.Product        = Stock.Material
      and Character_Z_MTX.Batch          = Stock.Batch
      and Character_Z_MTX.Characteristic = 'Z_MTX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_MTX
      on  ClassCharacter_Z_MTX.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_MTX.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_MTX.Characteristic   = 'Z_MTX'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_QCBG
      on  Character_Z_QCBG.Product        = Stock.Material
      and Character_Z_QCBG.Batch          = Stock.Batch
      and Character_Z_QCBG.Characteristic = 'Z_QCBG'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_QCBG
      on  ClassCharacter_Z_QCBG.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_QCBG.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_QCBG.Characteristic   = 'Z_QCBG'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_PC
      on  Character_Z_PC.Product        = Stock.Material
      and Character_Z_PC.Batch          = Stock.Batch
      and Character_Z_PC.Characteristic = 'Z_PC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_PC
      on  ClassCharacter_Z_PC.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_PC.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_PC.Characteristic   = 'Z_PC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHC
      on  Character_Z_NHC.Product        = Stock.Material
      and Character_Z_NHC.Batch          = Stock.Batch
      and Character_Z_NHC.Characteristic = 'Z_NHC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHC
      on  ClassCharacter_Z_NHC.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_NHC.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_NHC.Characteristic   = 'Z_NHC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOCATION
      on  Character_Z_LOCATION.Product        = Stock.Material
      and Character_Z_LOCATION.Batch          = Stock.Batch
      and Character_Z_LOCATION.Characteristic = 'Z_LOCATION'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOCATION
      on  ClassCharacter_Z_LOCATION.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_LOCATION.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_LOCATION.Characteristic   = 'Z_LOCATION'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW
      on  Character_Z_GW.Product        = Stock.Material
      and Character_Z_GW.Batch          = Stock.Batch
      and Character_Z_GW.Characteristic = 'Z_GW'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GW
      on  ClassCharacter_Z_GW.ClassInternalID  = ObjectClass.ClassInternalID
      and ClassCharacter_Z_GW.ValidityEndDate >= $session.system_date
      and ClassCharacter_Z_GW.Characteristic   = 'Z_GW'

{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PlantStdVH', element: 'Plant' } } ]
      @ObjectModel.text.element: [ 'PlantName' ]
  key Stock.Plant,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_WM_ZMIGO_SLOC_CVH', element: 'StorageLocation' },
                                            additionalBinding: [ { localElement: 'Plant', element: 'Plant' } ] } ]
      @ObjectModel.text.element: [ 'StorageLocationName' ]
  key Stock.StorageLocation,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductStdVH', element: 'Product' } } ]
  key Stock.Material,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BatchStdVH', element: 'Batch' },
                                            additionalBinding: [ { localElement: 'Material', element: 'Material' } ] } ]
  key Stock.Batch,

  key Stock.InventorySpecialStockType,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesDocumentStdVH', element: 'SalesDocument' } } ]
  key Stock.SDDocument                                                                                                  as SalesOrder,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesOrderItemStdVH', element: 'SalesOrderItem' },
                                            additionalBinding: [ { element: 'SalesDocument', localElement: 'SalesOrder' } ] } ]
  key Stock.SDDocumentItem                                                                                              as SalesOrderItem,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Supplier', element: 'Supplier' } } ]
  key Stock.Supplier                                                                                                    as OutsourcingSupplier,

      t001w.PlantName,
      t001l.StorageLocationName,
      mara._Text[1: Language = $session.system_language].ProductName                                                    as MaterialDescription,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_ProductType_CVH', element: 'ProductType' } } ]
      @ObjectModel.text.element: [ 'MaterialTypeName' ]
      mara.ProductType                                                                                                  as MaterialType,

      mara._ProductTypeName[1: Language = $session.system_language].MaterialTypeName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductUnitsOfMeasure', element: 'AlternativeUnit' },
                                            additionalBinding: [ { localElement: 'Material', element: 'Product' } ] } ]
      Stock.MaterialBaseUnit,

      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                                     as BaseUnitNumberOfDecimal,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      Stock.UnrestrictedUse,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      Stock.BlockStock,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      Stock.TransitandTranfer,

      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      Stock.QualityInspection,

      vbak.PurchaseOrderByCustomer,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer_VH', element: 'Customer' } } ]
      vbak.SoldToParty,

      vbak._SoldToParty.OrganizationBPName1                                                                             as SoldToPartyName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer_VH', element: 'Customer' } } ]
      vbap.ShipToParty,

      vbap._ShipToParty.OrganizationBPName1                                                                             as ShipToPartyName,
      Character_Z_LOT.CharcValue                                                                                        as LotNum,

      cast(case when ClassCharacter_Z_LOT.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                else 'X' end as abap_boolean)                                                                           as LotNumActive,

      Character_Z_GHICHU.CharcValue                                                                                     as BatchNote,

      cast(case when ClassCharacter_Z_GHICHU.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as BatchNoteActive,

      Character_Z_GCQC.CharcValue                                                                                       as QCNote,

      cast(case when ClassCharacter_Z_GCQC.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as QCNoteActive,

      Character_Z_NSX.CharcFromDate                                                                                     as ProductionDate,

      cast(case when ClassCharacter_Z_NSX.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as ProductionDateActive,

      Character_Z_HSD.CharcFromDate                                                                                     as ExpirationDate,

      cast(case when ClassCharacter_Z_HSD.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as ExpirationDateActive,

      Character_Z_NG.CharcValue                                                                                         as Origin,

      cast(case when ClassCharacter_Z_NG.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as OriginActive,

      Character_Z_GRD.CharcFromDate                                                                                     as GoodsReceiptDate,

      cast(case when ClassCharacter_Z_GRD.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as GoodsReceiptDateActive,

      Character_Z_NCC.CharcValue                                                                                        as BatchSupplier,

      cast(case when ClassCharacter_Z_NCC.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as BatchSupplierActive,

      Character_Z_NHASX.CharcValue                                                                                      as Manufacturer,

      cast(case when ClassCharacter_Z_NHASX.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as ManufacturerActive,

      Character_Z_NSXNB.CharcFromDate                                                                                   as ProductionDateInternal,

      cast(case when ClassCharacter_Z_NSXNB.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as ProductionDateInternalActive,

      Character_Z_HSDNB.CharcFromDate                                                                                   as ExpirationDateInternal,

      cast(case when ClassCharacter_Z_HSDNB.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as ExpirationDateInternalActive,

      Character_Z_MTX.CharcValue                                                                                        as AccessCode,

      cast(case when ClassCharacter_Z_MTX.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as AccessCodeActive,

      Character_Z_QCBG.CharcValue                                                                                       as PackagingSpec,

      cast(case when ClassCharacter_Z_QCBG.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as PackagingSpecActive,

      Character_Z_PC.CharcValue                                                                                         as ProfitCenter,

      cast(case when ClassCharacter_Z_PC.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as ProfitCenterActive,

      Character_Z_NHC.CharcValue                                                                                        as CalibrationLocation,

      cast(case when ClassCharacter_Z_NHC.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as CalibrationLocationActive,


      Character_Z_LOCATION.CharcValue                                                                                   as WhereToUse,

      cast(case when ClassCharacter_Z_LOCATION.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as WhereToUseActive,

      //      cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,3) )                                                      as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))                    as GrossWeight,

      cast(case when ClassCharacter_Z_GW.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                                                          as GrossWeightActive,

      Stock.UnrestrictedUse * ConvertTHU.ConversionRate * round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3)
                                                                                                                        as UnrestrictedUseTHU,

      Stock.BlockStock * ConvertTHU.ConversionRate * round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3)
                                                                                                                        as BlockStockTHU,

      Stock.TransitandTranfer * ConvertTHU.ConversionRate * round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3)
                                                                                                                        as TransitandTranferTHU,

      Stock.QualityInspection * ConvertTHU.ConversionRate * round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3)
                                                                                                                        as QualityInspectionTHU,

      cast(case
      when Character_Z_HSD.CharcFromDate is null then 0
      when I_ProductStorage_2.TotalShelfLife > 0 then
      dats_days_between(
      $session.system_date,
      Character_Z_HSD.CharcFromDate
      ) * 100 / I_ProductStorage_2.TotalShelfLife
      else 0
      end as abap.dec(10,2))                                                                                            as ExpirationDateRemainingPerc,

      case when Character_Z_HSD.CharcFromDate is null then 0 else
      dats_days_between(
      $session.system_date,
      Character_Z_HSD.CharcFromDate
      ) end                                                                                                             as ExpirationDateRemaining,

      case
      when Character_Z_HSD.CharcFromDate is null then 'Hết hạn'
      when $projection.ExpirationDateRemaining <= 0 then 'Hết hạn'
      when $projection.ExpirationDateRemaining <= 180 then 'Gần hết hạn'
      else 'Bình thường'
      end                                                                                                               as Warning,

      case
      when Character_Z_HSD.CharcFromDate is null then 1
      when $projection.ExpirationDateRemaining <= 0 then 1
      when $projection.ExpirationDateRemaining <= 180 then 2
      else 3
      end                                                                                                               as WarningCriticality
}

where Stock.InventorySpecialStockType <> 'T'
  and Stock.InventorySpecialStockType <> 'W'
  and Stock.UnrestrictedUse + Stock.BlockStock + Stock.TransitandTranfer + Stock.QualityInspection <> 0

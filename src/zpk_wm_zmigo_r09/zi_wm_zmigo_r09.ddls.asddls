@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Post Goods Movement - Reservation'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZI_WM_ZMIGO_R09
  with parameters
    @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_WM_ZMIGO_ACTION_VH', element: 'Action' } } ]
    P_Action : zde_wm_zmigo_action

  as select from    ztb_wm_rkpf                  as rkpf

  //    inner join      ztb_wm_resb                  as resb               on rkpf.rsnum = resb.rsnum
    inner join      ZWM_R_ReservationItem        as resb                    on rkpf.rsnum = resb.Reservation

    inner join      ztb_rsnum_mvtatp             as condition               on  condition.bwart  = rkpf.bwart
                                                                            and condition.action = $parameters.P_Action

    left outer join ZI_WM_ZMIGO_R09_QTY_OUTB     as resb_qty_outb           on  resb.Reservation     = resb_qty_outb.Reservation
                                                                            and resb.ReservationItem = resb_qty_outb.ReservationItem

    left outer join ZI_WM_ZMIGO_R09_QTY_MATDOC   as resb_qty_matdoc         on  resb.Reservation     = resb_qty_matdoc.Reservation
                                                                            and resb.ReservationItem = resb_qty_matdoc.ReservationItem

    left outer join I_Plant                      as t001w                   on resb.Plant = t001w.Plant

    left outer join I_StorageLocation            as t001l                   on  resb.Plant           = t001l.Plant
                                                                            and resb.StorageLocation = t001l.StorageLocation

    left outer join I_Plant                      as t001w_um                on resb.IssuingOrReceivingPlant = t001w_um.Plant

    left outer join I_StorageLocation            as t001l_um                on  resb.IssuingOrReceivingPlant      = t001l_um.Plant
                                                                            and resb.IssuingOrReceivingStorageLoc = t001l_um.StorageLocation

    left outer join I_Product                    as mara                    on mara.Product = resb.Product

    left outer join I_ProductText                as makt                    on  makt.Product  = resb.Product
                                                                            and makt.Language = $session.system_language

    left outer join I_ProductTypeText_2          as t134t                   on  t134t.ProductType = mara.ProductType
                                                                            and t134t.Language    = $session.system_language

    left outer join I_ClfnObjectClass            as ObjectClass             on  ObjectClass.ClfnObjectID    = resb.Product
                                                                            and ObjectClass.ClfnObjectTable = 'MARA'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT         on  Character_Z_LOT.Product        = resb.Product
                                                                            and Character_Z_LOT.Batch          = resb.Batch
                                                                            and Character_Z_LOT.Characteristic = 'Z_LOT'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOT    on  ClassCharacter_Z_LOT.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_LOT.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_LOT.Characteristic  = 'Z_LOT'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU      on  Character_Z_GHICHU.Product        = resb.Product
                                                                            and Character_Z_GHICHU.Batch          = resb.Batch
                                                                            and Character_Z_GHICHU.Characteristic = 'Z_GHICHU'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU on  ClassCharacter_Z_GHICHU.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_GHICHU.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_GHICHU.Characteristic  = 'Z_GHICHU'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GCQC        on  Character_Z_GCQC.Product        = resb.Product
                                                                            and Character_Z_GCQC.Batch          = resb.Batch
                                                                            and Character_Z_GCQC.Characteristic = 'Z_GCQC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GCQC   on  ClassCharacter_Z_GCQC.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_GCQC.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_GCQC.Characteristic  = 'Z_GCQC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSX         on  Character_Z_NSX.Product        = resb.Product
                                                                            and Character_Z_NSX.Batch          = resb.Batch
                                                                            and Character_Z_NSX.Characteristic = 'Z_NSX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSX    on  ClassCharacter_Z_NSX.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NSX.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NSX.Characteristic  = 'Z_NSX'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD         on  Character_Z_HSD.Product        = resb.Product
                                                                            and Character_Z_HSD.Batch          = resb.Batch
                                                                            and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSD    on  ClassCharacter_Z_HSD.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_HSD.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_HSD.Characteristic  = 'LOBM_VFDAT'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NG          on  Character_Z_NG.Product        = resb.Product
                                                                            and Character_Z_NG.Batch          = resb.Batch
                                                                            and Character_Z_NG.Characteristic = 'Z_NG'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NG     on  ClassCharacter_Z_NG.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NG.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NG.Characteristic  = 'Z_NG'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NNK         on  Character_Z_NNK.Product        = resb.Product
                                                                            and Character_Z_NNK.Batch          = resb.Batch
                                                                            and Character_Z_NNK.Characteristic = 'Z_GRD'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NCC         on  Character_Z_NCC.Product        = resb.Product
                                                                            and Character_Z_NCC.Batch          = resb.Batch
                                                                            and Character_Z_NCC.Characteristic = 'Z_NCC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NCC    on  ClassCharacter_Z_NCC.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NCC.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NCC.Characteristic  = 'Z_NCC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHASX       on  Character_Z_NHASX.Product        = resb.Product
                                                                            and Character_Z_NHASX.Batch          = resb.Batch
                                                                            and Character_Z_NHASX.Characteristic = 'Z_NHASX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHASX  on  ClassCharacter_Z_NHASX.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NHASX.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NHASX.Characteristic  = 'Z_NHASX'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSXNB       on  Character_Z_NSXNB.Product        = resb.Product
                                                                            and Character_Z_NSXNB.Batch          = resb.Batch
                                                                            and Character_Z_NSXNB.Characteristic = 'Z_NSXNB'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSXNB  on  ClassCharacter_Z_NSXNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_NSXNB.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_NSXNB.Characteristic  = 'Z_NSXNB'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSDNB       on  Character_Z_HSDNB.Product        = resb.Product
                                                                            and Character_Z_HSDNB.Batch          = resb.Batch
                                                                            and Character_Z_HSDNB.Characteristic = 'Z_HSDNB'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSDNB  on  ClassCharacter_Z_HSDNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_HSDNB.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_HSDNB.Characteristic  = 'Z_HSDNB'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_MTX         on  Character_Z_MTX.Product        = resb.Product
                                                                            and Character_Z_MTX.Batch          = resb.Batch
                                                                            and Character_Z_MTX.Characteristic = 'Z_MTX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_MTX    on  ClassCharacter_Z_MTX.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_MTX.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_MTX.Characteristic  = 'Z_MTX'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_QCBG        on  Character_Z_QCBG.Product        = resb.Product
                                                                            and Character_Z_QCBG.Batch          = resb.Batch
                                                                            and Character_Z_QCBG.Characteristic = 'Z_QCBG'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_QCBG   on  ClassCharacter_Z_QCBG.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_QCBG.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_QCBG.Characteristic  = 'Z_QCBG'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_PC          on  Character_Z_PC.Product        = resb.Product
                                                                            and Character_Z_PC.Batch          = resb.Batch
                                                                            and Character_Z_PC.Characteristic = 'Z_PC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_PC     on  ClassCharacter_Z_PC.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_PC.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_PC.Characteristic  = 'Z_PC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHC         on  Character_Z_NHC.Product        = resb.Product
                                                                            and Character_Z_NHC.Batch          = resb.Batch
                                                                            and Character_Z_NHC.Characteristic = 'Z_NHC'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOCATION    on  Character_Z_LOCATION.Product        = resb.Product
                                                                            and Character_Z_LOCATION.Batch          = resb.Batch
                                                                            and Character_Z_LOCATION.Characteristic = 'Z_LOCATION'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU_PKH  on  Character_Z_GHICHU_PKH.Product        = resb.Product
                                                                            and Character_Z_GHICHU_PKH.Batch          = resb.Batch
                                                                            and Character_Z_GHICHU_PKH.Characteristic = 'Z_GHICHU_PKH '

    left outer join ZI_WM_ZMIGO_MAT_GWEIGHT      as Character_Z_GW          on Character_Z_GW.Product      = resb.Product
                                                                            and(
                                                                              Character_Z_GW.LotNum        = Character_Z_LOT.CharcValue
                                                                              or(
                                                                                Character_Z_LOT.CharcValue is null
                                                                                and Character_Z_GW.LotNum  is initial
                                                                              )
                                                                            )

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GW     on  ClassCharacter_Z_GW.ClassInternalID = ObjectClass.ClassInternalID
                                                                            and ClassCharacter_Z_GW.ValidityEndDate >= $session.system_date
                                                                            and ClassCharacter_Z_GW.Characteristic  = 'Z_GW'

    left outer join ZI_WM_MATERIALSTOCK          as Stock                   on  Stock.Plant           = resb.Plant
                                                                            and Stock.StorageLocation = resb.StorageLocation
                                                                            and Stock.Material        = resb.Product
                                                                            and Stock.Batch           = resb.Batch
                                                                            and Stock.SDDocument      = resb.SalesOrder
                                                                            and Stock.SDDocumentItem  = resb.SalesOrderItem

    left outer join ztb_wm_show_gw               as ShowGW                  on  ShowGW.werks = resb.Plant
                                                                            and ShowGW.lgort = resb.StorageLocation
                                                                            and ShowGW.umwrk = resb.IssuingOrReceivingPlant
                                                                            and ShowGW.umlgo = resb.IssuingOrReceivingStorageLoc
                                                                            and ShowGW.mtart = mara.ProductType
                                                                            and ShowGW.bwart = rkpf.bwart

    left outer join I_UnitOfMeasure                                         on resb.BaseUnit = I_UnitOfMeasure.UnitOfMeasure

    left outer join I_EWM_PlantStorLocMapToWhse  as T320                    on  T320.Plant           = resb.Plant
                                                                            and T320.StorageLocation = resb.StorageLocation
                                                                            and T320.Plant           = resb.IssuingOrReceivingPlant
                                                                            and T320.StorageLocation = resb.IssuingOrReceivingStorageLoc

    left outer join I_CostCenterText                                        on  I_CostCenterText.CostCenter      = rkpf.kostl
                                                                            and I_CostCenterText.ControllingArea = 'A000'
                                                                            and I_CostCenterText.Language        = $session.system_language

    left outer join ZI_WM_ZMIGO_SLOC_AUTH        as AuthSource              on  AuthSource.Plant           = resb.Plant
                                                                            and AuthSource.StorageLocation = resb.StorageLocation
                                                                            and AuthSource.UserID          = $session.user

    left outer join ZI_WM_ZMIGO_SLOC_AUTH        as AuthDest                on  AuthDest.Plant           = resb.IssuingOrReceivingPlant
                                                                            and AuthDest.StorageLocation = resb.IssuingOrReceivingStorageLoc
                                                                            and AuthDest.UserID          = $session.user

{
  key rkpf.rsnum                                                                         as Reservation,
  key resb.ReservationItem                                                               as ReservationItem,
  key resb.RecordType                                                                    as RecordType,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PlantStdVH', element: 'Plant' } } ]
      @ObjectModel.text.element: [ 'PlantName' ]
      resb.Plant                                                                         as Plant,

      t001w.PlantName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_WM_ZMIGO_SLOC_CVH', element: 'StorageLocation' },
                                            additionalBinding: [ { localElement: 'Plant', element: 'Plant' } ] } ]
      @ObjectModel.text.element: [ 'StorageLocationName' ]
      resb.StorageLocation                                                               as StorageLocation,

      t001l.StorageLocationName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductStdVH', element: 'Product' } } ]
      resb.Product                                                                       as Material,

      makt.ProductName                                                                   as MaterialDescription,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductUnitsOfMeasure', element: 'AlternativeUnit' },
                                            additionalBinding: [ { localElement: 'Material', element: 'Product' } ] } ]
      resb.BaseUnit                                                                      as BaseUnit,

      @UI.hidden: true
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                      as BaseUnitNumberOfDecimal,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BatchStdVH', element: 'Batch' },
                                            additionalBinding: [ { localElement: 'Material', element: 'Material' } ] } ]
      resb.Batch                                                                         as Batch,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_GoodsMovementType', element: 'GoodsMovementType' } } ]
      rkpf.bwart                                                                         as GoodsMovementType,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      //      resb.Quantity - resb.SoLuongDaXuat                                                   as Quantity,
      cast(resb.Quantity
      - case when resb_qty_outb.QuantityNotCompletelyDelivered is not null
             then resb_qty_outb.QuantityNotCompletelyDelivered else 0 end
      - case when resb_qty_matdoc.QuantityMatdocPosted is not null
             then resb_qty_matdoc.QuantityMatdocPosted else 0 end  as zde_enmng)         as Quantity,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      @UI.hidden: true
      cast(case when resb_qty_outb.QuantityNotCompletelyDelivered is not null
            then resb_qty_outb.QuantityNotCompletelyDelivered else 0 end
      + case when resb_qty_matdoc.QuantityMatdocPosted is not null
             then resb_qty_matdoc.QuantityMatdocPosted else 0 end as zde_enmng)          as SoLuongDaXuat,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      Stock.SumUU                                                                        as UnrestrictedUse,

      cast(
      case
        when ShowGW.bwart is not null then 'X'
        else ' '
      end as abap_boolean)                                                               as ShowGrossWeight,

      cast(
      case
        when ShowGW.bwart is null       then ' '
        when Character_Z_GW.GWeight > 0 then ' '
        else 'X'
      end as abap_boolean)                                                               as IsAllowEditGrossWeight,

      cast(case when $parameters.P_Action = 'A08' and $projection.IsAllowEditGrossWeight = 'X' then 'X'
                 else '' end as abap_boolean)                                            as IsRequiredGrossWeight,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PlantStdVH', element: 'Plant' } } ]
      @ObjectModel.text.element: [ 'IssuingOrReceivingPlantName' ]
      resb.IssuingOrReceivingPlant                                                       as IssuingOrReceivingPlant,

      t001w_um.PlantName                                                                 as IssuingOrReceivingPlantName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_WM_ZMIGO_SLOC_CVH', element: 'StorageLocation' },
                                            additionalBinding: [ { localElement: 'IssuingOrReceivingPlant',
                                                                   element: 'Plant' } ] } ]
      @ObjectModel.text.element: [ 'IssuingOrReceivingSLocName' ]
      resb.IssuingOrReceivingStorageLoc                                                  as IssuingOrReceivingSLoc,

      t001l_um.StorageLocationName                                                       as IssuingOrReceivingSLocName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesDocumentStdVH', element: 'SalesDocument' } } ]
      resb.SalesOrder                                                                    as SalesOrder,

      resb.SalesOrderItem                                                                as SalesOrderItem,
      rkpf.aufnr                                                                         as OrderNumber,
      resb.AmountLC                                                                      as AmountLC,
      resb.InventorySpecialStockType                                                     as InventorySpecialStockType,
      //      @ObjectModel.text.element: ['WBSElementExternalID']
      //      @Consumption.valueHelpDefinition: [
      //        {
      //          entity: {
      //              name:'ZWM_I_WBS_SH' ,
      //              element: 'wbselement_internal_id'
      //          }
      //        }
      //      ]
      //      rkpf.ps_psp_pnr                                                                      as WBSElementInternalID,
      //      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      //      cast( '' as abap.char(24) )                                                          as WBSElementExternalID,
      rkpf.ps_psp_pnr                                                                    as WBSElementExternalID,
      rkpf.ncc_gia_cong                                                                  as NCCGiaCong,
      cast(case when T320.EWMWarehouse is not null then 'X' else '' end as abap_boolean) as IsWarehouseManagement,
      T320.EWMWarehouse                                                                  as WarehouseNumber,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(20))                                                          as HandlingUnitNumber,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(18))                                                          as StorageBin,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(32))                                                          as ParentHandlingUnitUUID,

      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(32))                                                          as StockItemUUID,

      //      EWMStock.HandlingUnitNumber,
      //      EWMStock.EWMStorageBin,
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_SalesDocumentStdVH', element: 'SalesDocument' } } ]
      resb.IssgOrRcvgSalesOrder                                                          as IssgOrRcvgSalesOrder,

      resb.IssgOrRcvgSalesOrderItem                                                      as IssgOrRcvgSalesOrderItem,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductStdVH', element: 'Product' } } ]
      resb.IssgOrRcvgMaterial                                                            as IssgOrRcvgMaterial,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_BatchStdVH', element: 'Batch' },
                                            additionalBinding: [ { localElement: 'IssgOrRcvgMaterial',
                                                                   element: 'Material' } ] } ]
      resb.IssgOrRcvgBatch                                                               as IssgOrRcvgBatch,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_CostCenterStdVH', element: 'CostCenter' } } ]
      rkpf.kostl                                                                         as CostCenter,

      I_CostCenterText.CostCenterName                                                    as CostCenterName,

      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_GLAccountStdVH', element: 'GLAccount' },
                                            additionalBinding: [ { element: 'CompanyCode', localConstant: '2000' } ] } ]
      resb.GLAccount                                                                     as GLAccount,

      rkpf.note                                                                          as Note,

      @ObjectModel.text.element: [ 'ProductTypeName' ]
      mara.ProductType,

      t134t.ProductTypeName,
      rkpf.crt_date                                                                      as CreationDate,
      rkpf.rsdat                                                                         as ReservationDate,

      @UI.hidden: true
      resb.StatusReservation                                                             as Status,

      Character_Z_LOT.CharcValue                                                         as LotNum,

      cast(case when ClassCharacter_Z_LOT.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                else 'X' end as abap_boolean)                                            as LotNumActive,

      Character_Z_GHICHU.CharcValue                                                      as BatchNote,

      cast(case when ClassCharacter_Z_GHICHU.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as BatchNoteActive,

      Character_Z_GCQC.CharcValue                                                        as QCNote,

      cast(case when ClassCharacter_Z_GCQC.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as QCNoteActive,

      Character_Z_NSX.CharcFromDate                                                      as ProductionDate,

      cast(case when ClassCharacter_Z_NSX.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as ProductionDateActive,

      Character_Z_HSD.CharcFromDate                                                      as ExpirationDate,

      cast(case when ClassCharacter_Z_HSD.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as ExpirationDateActive,

      Character_Z_NG.CharcValue                                                          as Origin,

      cast(case when ClassCharacter_Z_NG.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as OriginActive,

      Character_Z_NNK.CharcFromDate                                                      as GoodsReceiptDate,
      Character_Z_NCC.CharcValue                                                         as BatchSupplier,

      cast(case when ClassCharacter_Z_NCC.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as BatchSupplierActive,

      Character_Z_NHASX.CharcValue                                                       as Manufacturer,

      cast(case when ClassCharacter_Z_NHASX.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as ManufacturerActive,

      Character_Z_NSXNB.CharcFromDate                                                    as ProductionDateInternal,

      cast(case when ClassCharacter_Z_NSXNB.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as ProductionDateInternalActive,

      Character_Z_HSDNB.CharcFromDate                                                    as ExpirationDateInternal,

      cast(case when ClassCharacter_Z_HSDNB.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as ExpirationDateInternalActive,

      Character_Z_MTX.CharcValue                                                         as AccessCode,

      cast(case when ClassCharacter_Z_MTX.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as AccessCodeActive,

      Character_Z_QCBG.CharcValue                                                        as PackagingSpec,

      cast(case when ClassCharacter_Z_QCBG.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as PackagingSpecActive,

      Character_Z_PC.CharcValue                                                          as ProfitCenter,

      cast(case when ClassCharacter_Z_PC.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as ProfitCenterActive,

      Character_Z_NHC.CharcValue                                                         as CalibrationLocation,
      Character_Z_LOCATION.CharcValue                                                    as WhereToUse,
      Character_Z_GHICHU_PKH .CharcValue                                                 as PlanDeptNote,
      cast(round(cast(Character_Z_GW.GWeight as abap.dec(16,6)), 3) as abap.dec(16,3))   as GrossWeight,

      cast(case when ClassCharacter_Z_GW.ClassInternalID is null then ''
                when $parameters.P_Action = 'A07' then ''
                when $parameters.P_Action = 'A08' then ''
                 else 'X' end as abap_boolean)                                           as GrossWeightActive
}

where
  (
           resb.StatusReservation =  '1'
    or     resb.StatusReservation =  '4'
  )
  and(
    (
      (
           AuthSource.UserID      is not null
        or AuthDest.UserID        is not null
      )
      and  rkpf.bwart             <> '313'
    )
    or(
           AuthSource.UserID      is not null
      and  rkpf.bwart             =  '313'
    )
  )

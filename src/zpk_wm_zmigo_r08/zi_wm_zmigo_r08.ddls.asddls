@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Production Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R08
  with parameters
    @Consumption.valueHelpDefinition: [{
        entity: {
            name           : 'ZI_WM_ZMIGO_ACTION_VH',
            element        : 'Action'
        }
    }]
    P_Action : zde_wm_zmigo_action
  as select from    I_ManufacturingOrder         as aufk
    inner join      I_ManufacturingOrderItem     as afpo                        on aufk.ManufacturingOrder = afpo.ManufacturingOrder
    inner join      ZI_WM_ZMIGO_SLOC_AUTH        as Auth                        on  Auth.Plant           = afpo.ProductionPlant
                                                                                and Auth.StorageLocation = afpo.StorageLocation
                                                                                and Auth.UserID          = $session.user
    left outer join I_Plant                      as t001w                       on afpo.ProductionPlant = t001w.Plant
    left outer join I_StorageLocation            as t001l                       on  afpo.ProductionPlant = t001l.Plant
                                                                                and afpo.StorageLocation = t001l.StorageLocation
    left outer join I_SalesDocument              as vbak                        on afpo.SalesOrder = vbak.SalesDocument
    left outer join I_SalesDocumentItem          as vbap                        on  afpo.SalesOrder     = vbap.SalesDocument
                                                                                and afpo.SalesOrderItem = vbap.SalesDocumentItem
    left outer join I_Product                    as mara                        on mara.Product = afpo.Material
    left outer join I_ProductText                as makt                        on  makt.Product  = afpo.Material
                                                                                and makt.Language = $session.system_language
    left outer join I_UnitOfMeasure                                             on afpo.ProductionUnit = I_UnitOfMeasure.UnitOfMeasure
    left outer join I_ClfnObjectClass            as ObjectClass                 on  ObjectClass.ClfnObjectID    = afpo.Material
                                                                                and ObjectClass.ClfnObjectTable = 'MARA'
  //    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT         on  Character_Z_LOT.Product        = afpo.Material
  //                                                                            and Character_Z_LOT.Batch          = afpo.Batch
  //                                                                            and Character_Z_LOT.Characteristic = 'Z_LOT'
  //    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOT    on  ClassCharacter_Z_LOT.ClassInternalID = ObjectClass.ClassInternalID
  //                                                                            and ClassCharacter_Z_LOT.ValidityEndDate >= $session.system_date
  //                                                                            and ClassCharacter_Z_LOT.Characteristic  = 'Z_LOT'
  //    left outer join ztb_wm_req_fld               as Config_Z_LOT            on  Config_Z_LOT.field_name = 'Z_LOT'
  //                                                                            and Config_Z_LOT.reference  = 'R08'
  //                                                                            and Config_Z_LOT.action     = $parameters.P_Action
  //                                                                            and Config_Z_LOT.mtart      = mara.ProductType

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU          on  Character_Z_GHICHU.Product        = afpo.Material
                                                                                and Character_Z_GHICHU.Batch          = afpo.Batch
                                                                                and Character_Z_GHICHU.Characteristic = 'Z_GHICHU'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU     on  ClassCharacter_Z_GHICHU.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_GHICHU.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_GHICHU.Characteristic  = 'Z_GHICHU'
    left outer join ztb_wm_req_fld               as Config_Z_GHICHU             on  Config_Z_GHICHU.field_name = 'Z_GHICHU'
                                                                                and Config_Z_GHICHU.reference  = 'R08'
                                                                                and Config_Z_GHICHU.action     = $parameters.P_Action
                                                                                and Config_Z_GHICHU.mtart      = mara.ProductType
                                                                                and Config_Z_GHICHU.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GCQC            on  Character_Z_GCQC.Product        = afpo.Material
                                                                                and Character_Z_GCQC.Batch          = afpo.Batch
                                                                                and Character_Z_GCQC.Characteristic = 'Z_GCQC'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GCQC       on  ClassCharacter_Z_GCQC.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_GCQC.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_GCQC.Characteristic  = 'Z_GCQC'
    left outer join ztb_wm_req_fld               as Config_Z_GCQC               on  Config_Z_GCQC.field_name = 'Z_GCQC'
                                                                                and Config_Z_GCQC.reference  = 'R08'
                                                                                and Config_Z_GCQC.action     = $parameters.P_Action
                                                                                and Config_Z_GCQC.mtart      = mara.ProductType
                                                                                and Config_Z_GCQC.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSX             on  Character_Z_NSX.Product        = afpo.Material
                                                                                and Character_Z_NSX.Batch          = afpo.Batch
                                                                                and Character_Z_NSX.Characteristic = 'Z_NSX'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSX        on  ClassCharacter_Z_NSX.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_NSX.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_NSX.Characteristic  = 'Z_NSX'
    left outer join ztb_wm_req_fld               as Config_Z_NSX                on  Config_Z_NSX.field_name = 'Z_NSX'
                                                                                and Config_Z_NSX.reference  = 'R08'
                                                                                and Config_Z_NSX.action     = $parameters.P_Action
                                                                                and Config_Z_NSX.mtart      = mara.ProductType
                                                                                and Config_Z_NSX.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD             on  Character_Z_HSD.Product        = afpo.Material
                                                                                and Character_Z_HSD.Batch          = afpo.Batch
                                                                                and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSD        on  ClassCharacter_Z_HSD.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_HSD.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_HSD.Characteristic  = 'LOBM_VFDAT'
    left outer join ztb_wm_req_fld               as Config_Z_HSD                on  Config_Z_HSD.field_name = 'LOBM_VFDAT'
                                                                                and Config_Z_HSD.reference  = 'R08'
                                                                                and Config_Z_HSD.action     = $parameters.P_Action
                                                                                and Config_Z_HSD.mtart      = mara.ProductType
                                                                                and Config_Z_HSD.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NG              on  Character_Z_NG.Product        = afpo.Material
                                                                                and Character_Z_NG.Batch          = afpo.Batch
                                                                                and Character_Z_NG.Characteristic = 'Z_NG'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NG         on  ClassCharacter_Z_NG.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_NG.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_NG.Characteristic  = 'Z_NG'
    left outer join ztb_wm_req_fld               as Config_Z_NG                 on  Config_Z_NG.field_name = 'Z_NG'
                                                                                and Config_Z_NG.reference  = 'R08'
                                                                                and Config_Z_NG.action     = $parameters.P_Action
                                                                                and Config_Z_NG.mtart      = mara.ProductType
                                                                                and Config_Z_NG.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NNK             on  Character_Z_NNK.Product        = afpo.Material
                                                                                and Character_Z_NNK.Batch          = afpo.Batch
                                                                                and Character_Z_NNK.Characteristic = 'Z_GRD'
    left outer join ztb_wm_req_fld               as Config_Z_NNK                on  Config_Z_NNK.field_name = 'Z_GRD'
                                                                                and Config_Z_NNK.reference  = 'R08'
                                                                                and Config_Z_NNK.action     = $parameters.P_Action
                                                                                and Config_Z_NNK.mtart      = mara.ProductType
                                                                                and Config_Z_NNK.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NCC             on  Character_Z_NCC.Product        = afpo.Material
                                                                                and Character_Z_NCC.Batch          = afpo.Batch
                                                                                and Character_Z_NCC.Characteristic = 'Z_NCC'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NCC        on  ClassCharacter_Z_NCC.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_NCC.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_NCC.Characteristic  = 'Z_NCC'
    left outer join ztb_wm_req_fld               as Config_Z_NCC                on  Config_Z_NCC.field_name = 'Z_NCC'
                                                                                and Config_Z_NCC.reference  = 'R08'
                                                                                and Config_Z_NCC.action     = $parameters.P_Action
                                                                                and Config_Z_NCC.mtart      = mara.ProductType
                                                                                and Config_Z_NCC.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHASX           on  Character_Z_NHASX.Product        = afpo.Material
                                                                                and Character_Z_NHASX.Batch          = afpo.Batch
                                                                                and Character_Z_NHASX.Characteristic = 'Z_NHASX'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHASX      on  ClassCharacter_Z_NHASX.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_NHASX.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_NHASX.Characteristic  = 'Z_NHASX'
    left outer join ztb_wm_req_fld               as Config_Z_NHASX              on  Config_Z_NHASX.field_name = 'Z_NHASX'
                                                                                and Config_Z_NHASX.reference  = 'R08'
                                                                                and Config_Z_NHASX.action     = $parameters.P_Action
                                                                                and Config_Z_NHASX.mtart      = mara.ProductType
                                                                                and Config_Z_NHASX.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSXNB           on  Character_Z_NSXNB.Product        = afpo.Material
                                                                                and Character_Z_NSXNB.Batch          = afpo.Batch
                                                                                and Character_Z_NSXNB.Characteristic = 'Z_NSXNB'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSXNB      on  ClassCharacter_Z_NSXNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_NSXNB.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_NSXNB.Characteristic  = 'Z_NSXNB'
    left outer join ztb_wm_req_fld               as Config_Z_NSXNB              on  Config_Z_NSXNB.field_name = 'Z_NSXNB'
                                                                                and Config_Z_NSXNB.reference  = 'R08'
                                                                                and Config_Z_NSXNB.action     = $parameters.P_Action
                                                                                and Config_Z_NSXNB.mtart      = mara.ProductType
                                                                                and Config_Z_NSXNB.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSDNB           on  Character_Z_HSDNB.Product        = afpo.Material
                                                                                and Character_Z_HSDNB.Batch          = afpo.Batch
                                                                                and Character_Z_HSDNB.Characteristic = 'Z_HSDNB'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSDNB      on  ClassCharacter_Z_HSDNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_HSDNB.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_HSDNB.Characteristic  = 'Z_HSDNB'
    left outer join ztb_wm_req_fld               as Config_Z_HSDNB              on  Config_Z_HSDNB.field_name = 'Z_HSDNB'
                                                                                and Config_Z_HSDNB.reference  = 'R08'
                                                                                and Config_Z_HSDNB.action     = $parameters.P_Action
                                                                                and Config_Z_HSDNB.mtart      = mara.ProductType
                                                                                and Config_Z_HSDNB.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_MTX             on  Character_Z_MTX.Product        = afpo.Material
                                                                                and Character_Z_MTX.Batch          = afpo.Batch
                                                                                and Character_Z_MTX.Characteristic = 'Z_MTX'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_MTX        on  ClassCharacter_Z_MTX.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_MTX.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_MTX.Characteristic  = 'Z_MTX'
    left outer join ztb_wm_req_fld               as Config_Z_MTX                on  Config_Z_MTX.field_name = 'Z_MTX'
                                                                                and Config_Z_MTX.reference  = 'R08'
                                                                                and Config_Z_MTX.action     = $parameters.P_Action
                                                                                and Config_Z_MTX.mtart      = mara.ProductType
                                                                                and Config_Z_MTX.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_QCBG            on  Character_Z_QCBG.Product        = afpo.Material
                                                                                and Character_Z_QCBG.Batch          = afpo.Batch
                                                                                and Character_Z_QCBG.Characteristic = 'Z_QCBG'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_QCBG       on  ClassCharacter_Z_QCBG.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_QCBG.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_QCBG.Characteristic  = 'Z_QCBG'
    left outer join ztb_wm_req_fld               as Config_Z_QCBG               on  Config_Z_QCBG.field_name = 'Z_QCBG'
                                                                                and Config_Z_QCBG.reference  = 'R08'
                                                                                and Config_Z_QCBG.action     = $parameters.P_Action
                                                                                and Config_Z_QCBG.mtart      = mara.ProductType
                                                                                and Config_Z_QCBG.bwart      = '101'

  //    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_PC          on  Character_Z_PC.Product        = afpo.Material
  //                                                                            and Character_Z_PC.Batch          = afpo.Batch
  //                                                                            and Character_Z_PC.Characteristic = 'Z_PC'
  //    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_PC     on  ClassCharacter_Z_PC.ClassInternalID = ObjectClass.ClassInternalID
  //                                                                            and ClassCharacter_Z_PC.ValidityEndDate >= $session.system_date
  //                                                                            and ClassCharacter_Z_PC.Characteristic  = 'Z_PC'
  //    left outer join ztb_wm_req_fld               as Config_Z_PC             on  Config_Z_PC.field_name = 'Z_PC'
  //                                                                            and Config_Z_PC.reference  = 'R08'
  //                                                                            and Config_Z_PC.action     = $parameters.P_Action
  //                                                                            and Config_Z_PC.mtart      = mara.ProductType

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHC             on  Character_Z_NHC.Product        = afpo.Material
                                                                                and Character_Z_NHC.Batch          = afpo.Batch
                                                                                and Character_Z_NHC.Characteristic = 'Z_NHC'
    left outer join ztb_wm_req_fld               as Config_Z_NHC                on  Config_Z_NHC.field_name = 'Z_NHC'
                                                                                and Config_Z_NHC.reference  = 'R08'
                                                                                and Config_Z_NHC.action     = $parameters.P_Action
                                                                                and Config_Z_NHC.mtart      = mara.ProductType
                                                                                and Config_Z_NHC.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOCATION        on  Character_Z_LOCATION.Product        = afpo.Material
                                                                                and Character_Z_LOCATION.Batch          = afpo.Batch
                                                                                and Character_Z_LOCATION.Characteristic = 'Z_LOCATION'
    left outer join ztb_wm_req_fld               as Config_Z_LOCATION           on  Config_Z_LOCATION.field_name = 'Z_LOCATION'
                                                                                and Config_Z_LOCATION.reference  = 'R08'
                                                                                and Config_Z_LOCATION.action     = $parameters.P_Action
                                                                                and Config_Z_LOCATION.mtart      = mara.ProductType
                                                                                and Config_Z_LOCATION.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW              on  Character_Z_GW.Product        = afpo.Material
                                                                                and Character_Z_GW.Batch          = afpo.Batch
                                                                                and Character_Z_GW.Characteristic = 'Z_GW'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GW         on  ClassCharacter_Z_GW.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_GW.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_GW.Characteristic  = 'Z_GW'
    left outer join ztb_wm_req_fld               as Config_Z_GW                 on  Config_Z_GW.field_name = 'Z_GW'
                                                                                and Config_Z_GW.reference  = 'R08'
                                                                                and Config_Z_GW.action     = $parameters.P_Action
                                                                                and Config_Z_GW.mtart      = mara.ProductType
                                                                                and Config_Z_GW.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_SLBTPKT         on  Character_Z_SLBTPKT.Product        = afpo.Material
                                                                                and Character_Z_SLBTPKT.Batch          = afpo.Batch
                                                                                and Character_Z_SLBTPKT.Characteristic = 'Z_SLBTPKT'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_SLBTPKT    on  ClassCharacter_Z_SLBTPKT.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_SLBTPKT.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_SLBTPKT.Characteristic  = 'Z_SLBTPKT'
    left outer join ztb_wm_req_fld               as Config_Z_SLBTPKT            on  Config_Z_SLBTPKT.field_name = 'Z_SLBTPKT'
                                                                                and Config_Z_SLBTPKT.reference  = 'R08'
                                                                                and Config_Z_SLBTPKT.action     = $parameters.P_Action
                                                                                and Config_Z_SLBTPKT.mtart      = mara.ProductType
                                                                                and Config_Z_SLBTPKT.bwart      = '101'

    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_SLTPKT          on  Character_Z_SLTPKT.Product        = afpo.Material
                                                                                and Character_Z_SLTPKT.Batch          = afpo.Batch
                                                                                and Character_Z_SLTPKT.Characteristic = 'Z_SLTPKT'
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_SLTPKT     on  ClassCharacter_Z_SLTPKT.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_SLTPKT.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_SLTPKT.Characteristic  = 'Z_SLTPKT'
    left outer join ztb_wm_req_fld               as Config_Z_SLTPKT             on  Config_Z_SLTPKT.field_name = 'Z_SLTPKT'
                                                                                and Config_Z_SLTPKT.reference  = 'R08'
                                                                                and Config_Z_SLTPKT.action     = $parameters.P_Action
                                                                                and Config_Z_SLTPKT.mtart      = mara.ProductType
                                                                                and Config_Z_SLTPKT.bwart      = '101'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU_PKH      on  Character_Z_GHICHU_PKH.Product        = afpo.Material
                                                                                and Character_Z_GHICHU_PKH.Batch          = afpo.Batch
                                                                                and Character_Z_GHICHU_PKH.Characteristic = 'Z_GHICHU_PKH '
    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU_PKH on  ClassCharacter_Z_GHICHU_PKH.ClassInternalID = ObjectClass.ClassInternalID
                                                                                and ClassCharacter_Z_GHICHU_PKH.ValidityEndDate >= $session.system_date
                                                                                and ClassCharacter_Z_GHICHU_PKH.Characteristic  = 'Z_GHICHU_PKH '
    left outer join ztb_wm_req_fld               as Config_Z_GHICHU_PKH         on  Config_Z_GHICHU_PKH.field_name = 'Z_GHICHU_PKH '
                                                                                and Config_Z_GHICHU_PKH.reference  = 'R08'
                                                                                and Config_Z_GHICHU_PKH.action     = $parameters.P_Action
                                                                                and Config_Z_GHICHU_PKH.mtart      = mara.ProductType
                                                                                and Config_Z_GHICHU_PKH.bwart      = '101'
{
      //      @Consumption.valueHelpDefinition: [{
      //          entity           : {
      //              name         : 'I_ManufacturingOrder',
      //              element      : 'ManufacturingOrder'
      //          }
      //      }]
  key aufk.ManufacturingOrder,
  key afpo.ManufacturingOrderItem,
  key cast('0000000000' as abap.numc( 10 ))                                                               as Reservation,
  key cast('0000' as abap.numc( 4 ))                                                                      as ReservationItem,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_PlantStdVH',
              element      : 'Plant'
          }
      }]
      @ObjectModel.text.element: [ 'PlantName' ]
      afpo.ProductionPlant                                                                                as Plant,
      t001w.PlantName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_Customer_VH',
              element      : 'Customer'
          }
      }]
      vbak.SoldToParty,
      vbak._SoldToParty.OrganizationBPName1                                                               as SoldToPartyName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_Customer_VH',
              element      : 'Customer'
          }
      }]
      vbap.ShipToParty,
      vbap._ShipToParty.OrganizationBPName1                                                               as ShipToPartyName,
      aufk.MfgOrderScheduledStartDate,
      aufk.MfgOrderPlannedEndDate,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductStdVH',
              element      : 'Product'
          }
      }]
      afpo.Material,
      makt.ProductName                                                                                    as MaterialDescription,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_ProductType_CVH',
              element      : 'ProductType'
          }
      }]
      @ObjectModel.text.element: [ 'MaterialTypeName' ]
      mara.ProductType                                                                                    as MaterialType,
      mara._ProductTypeName[1: Language=$session.system_language].MaterialTypeName,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      aufk.MfgOrderPlannedTotalQty                                                                        as TargetQuantity,
      aufk.ProductionVersion,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      afpo.MfgOrderItemGoodsReceiptQty                                                                    as GoodsReceiptQty,
      @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
      case when aufk.MfgOrderPlannedTotalQty < afpo.MfgOrderItemGoodsReceiptQty then cast( 0 as abap.quan(13,3) ) else
      aufk.MfgOrderPlannedTotalQty - afpo.MfgOrderItemGoodsReceiptQty end                                 as RemainingQuantity,
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
      afpo.ProductionUnit,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                       as UnitNumberOfDecimal,
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
      afpo.Batch,
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
      afpo.StorageLocation,
      t001l.StorageLocationName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_SalesDocumentStdVH',
              element      : 'SalesDocument'
          }
      }]
      afpo.SalesOrder,
      afpo.SalesOrderItem,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_GoodsMovementType',
              element      : 'GoodsMovementType'
          }
      }]
      '101'                                                                                               as GoodsMovementType,
      afpo.InventorySpecialStockType,
      //      cast( afpo.WBSElementInternalID as abap.char(8) )               as WBSElementInternalID,
      vbak.PurchaseOrderByCustomer,
      aufk.YY1_LotNo_ORD                                                                                  as LotNum,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(100))                                                                          as LongText,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProfitCenterStdVH',
              element      : 'ProfitCenter'
          }
      }]
      aufk.ProfitCenter,
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
      mara.BaseUnit,
      cast( 'X' as abap_boolean )                                                                         as IsCompletelyDelivered,
      aufk.CreationDate,
      //      Character_Z_LOT.CharcValue                                               as LotNum,
      //      cast( case when ClassCharacter_Z_LOT.ClassInternalID is null then ''
      //                 when Config_Z_LOT.disable_field = 'X' then '' end as abap_boolean )         as LotNumActive,
      //      Config_Z_LOT.require_field                                               as LotNumRequired,

      Character_Z_GHICHU.CharcValue                                                                       as BatchNote,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_GHICHU.ClassInternalID is null then ''
                 when Config_Z_GHICHU.disable_field = 'X' then ''
                 else 'X'  end as abap_boolean )                                                          as BatchNoteActive,
      @UI.hidden: true
      Config_Z_GHICHU.require_field                                                                       as BatchNoteRequired,

      Character_Z_GCQC.CharcValue                                                                         as QCNote,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_GCQC.ClassInternalID is null then ''
                 when Config_Z_GCQC.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as QCNoteActive,
      @UI.hidden: true
      Config_Z_GCQC.require_field                                                                         as QCNoteRequired,

      Character_Z_NSX.CharcFromDate                                                                       as ProductionDate,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NSX.ClassInternalID is null then ''
                 when Config_Z_NSX.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ProductionDateActive,
      @UI.hidden: true
      Config_Z_NSX.require_field                                                                          as ProductionDateRequired,

      Character_Z_HSD.CharcFromDate                                                                       as ExpirationDate,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_HSD.ClassInternalID is null then ''
                 when Config_Z_HSD.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ExpirationDateActive,
      @UI.hidden: true
      Config_Z_HSD.require_field                                                                          as ExpirationDateRequired,

      Character_Z_NG.CharcValue                                                                           as Origin,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NG.ClassInternalID is null then ''
                 when Config_Z_NG.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as OriginActive,
      @UI.hidden: true
      Config_Z_NG.require_field                                                                           as OriginRequired,

      Character_Z_NNK.CharcFromDate                                                                       as GoodsReceiptDate,
      @UI.hidden: true
      cast( case when Character_Z_NNK.CharcValue is null then ''
                 when Config_Z_NNK.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as GoodsReceiptDateActive,
      @UI.hidden: true
      Config_Z_NNK.require_field                                                                          as GoodsReceiptDateRequired,

      Character_Z_NCC.CharcValue                                                                          as BatchSupplier,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NCC.ClassInternalID is null then ''
                 when Config_Z_NCC.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as BatchSupplierActive,
      @UI.hidden: true
      Config_Z_NCC.require_field                                                                          as BatchSupplierRequired,

      Character_Z_NHASX.CharcValue                                                                        as Manufacturer,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NHASX.ClassInternalID is null then ''
                 when Config_Z_NHASX.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ManufacturerActive,
      @UI.hidden: true
      Config_Z_NHASX.require_field                                                                        as ManufacturerRequired,

      Character_Z_NSXNB.CharcFromDate                                                                     as ProductionDateInternal,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_NSXNB.ClassInternalID is null then ''
                 when Config_Z_NSXNB.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ProductionDateInternalActive,
      @UI.hidden: true
      Config_Z_NSXNB.require_field                                                                        as ProductionDateInternalRequired,

      Character_Z_HSDNB.CharcFromDate                                                                     as ExpirationDateInternal,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_HSDNB.ClassInternalID is null then ''
                 when Config_Z_HSDNB.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ExpirationDateInternalActive,
      @UI.hidden: true
      Config_Z_HSDNB.require_field                                                                        as ExpirationDateInternalRequired,

      Character_Z_MTX.CharcValue                                                                          as AccessCode,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_MTX.ClassInternalID is null then ''
                 when Config_Z_MTX.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as AccessCodeActive,
      @UI.hidden: true
      Config_Z_MTX.require_field                                                                          as AccessCodeRequired,

      Character_Z_QCBG.CharcValue                                                                         as PackagingSpec,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_QCBG.ClassInternalID is null then ''
                 when Config_Z_QCBG.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as PackagingSpecActive,
      @UI.hidden: true
      Config_Z_QCBG.require_field                                                                         as PackagingSpecRequired,

      //      Character_Z_PC.CharcValue                                             as ProfitCenter,
      //      cast( case when ClassCharacter_Z_PC.ClassInternalID is null then ''
      //                 when Config_Z_PC.disable_field = 'X' then '' end as abap_boolean )       as ProfitCenterActive,
      //      Config_Z_PC.require_field                                             as ProfitCenterRequired,

      Character_Z_NHC.CharcValue                                                                          as CalibrationLocation,
      @UI.hidden: true
      cast( case when Character_Z_NHC.CharcValue is null then ''
                 when Config_Z_NHC.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as CalibrationLocationActive,
      @UI.hidden: true
      Config_Z_NHC.require_field                                                                          as CalibrationLocationRequired,

      Character_Z_LOCATION.CharcValue                                                                     as WhereToUse,
      @UI.hidden: true
      cast( case when Character_Z_LOCATION.CharcValue is null then ''
                 when Config_Z_LOCATION.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as WhereToUseActive,
      @UI.hidden: true
      Config_Z_LOCATION.require_field                                                                     as WhereToUseRequired,

      //      cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,3) )      as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))      as GrossWeight,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_GW.ClassInternalID is null then ''
                 when Config_Z_GW.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as GrossWeightActive,
      @UI.hidden: true
      Config_Z_GW.require_field                                                                           as GrossWeightRequired,

      //      cast( Character_Z_SLBTPKT.CharcFromNumericValue as abap.dec(16,3) )                            as QuantityBTP,
      cast(round(cast(Character_Z_SLBTPKT.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3)) as QuantityBTP,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_SLBTPKT.ClassInternalID is null then ''
                 when Config_Z_SLBTPKT.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as QuantityBTPActive,
      @UI.hidden: true
      Config_Z_SLBTPKT.require_field                                                                      as QuantityBTPRequired,


      //      cast( Character_Z_SLTPKT.CharcFromNumericValue as abap.dec(16,3) )                             as QuantityTP,
      cast(round(cast(Character_Z_SLTPKT.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))  as QuantityTP,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_SLTPKT.ClassInternalID is null then ''
                 when Config_Z_SLTPKT.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as QuantityTPActive,
      @UI.hidden: true
      Config_Z_SLTPKT.require_field                                                                       as QuantityTPRequired,

      //      Character_Z_GHICHU_PKH.CharcValue                                                                   as PlanDeptNote,
      aufk.YY1_GCPKH_ORD                                                                                  as PlanDeptNote,
      @UI.hidden: true
      cast( case when ClassCharacter_Z_GHICHU_PKH .ClassInternalID is null then ''
                 when Config_Z_GHICHU_PKH .disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as PlanDeptNoteActive,
      @UI.hidden: true
      Config_Z_GHICHU_PKH .require_field                                                                  as PlanDeptNoteRequired
}
where
  (
    $parameters.P_Action = 'A01'
    //    and afpo.IsCompletelyDelivered is initial
  )

union select from I_ManufacturingOrder         as aufk
  inner join      I_ManufacturingOrderItem     as afpo                        on aufk.ManufacturingOrder = afpo.ManufacturingOrder
//inner join      I_ReservationDocumentHeader as rkpf  on afpo.Reservation = rkpf.Reservation
  inner join      I_ReservationDocumentItem    as resb                        on afpo.Reservation = resb.Reservation
  left outer join I_Plant                      as t001w                       on afpo.ProductionPlant = t001w.Plant
  left outer join I_StorageLocation            as t001l                       on  afpo.ProductionPlant = t001l.Plant
                                                                              and resb.StorageLocation = t001l.StorageLocation
  left outer join I_SalesDocument              as vbak                        on afpo.SalesOrder = vbak.SalesDocument
  left outer join I_SalesDocumentItem          as vbap                        on  afpo.SalesOrder     = vbap.SalesDocument
                                                                              and afpo.SalesOrderItem = vbap.SalesDocumentItem
  left outer join I_Product                    as mara                        on mara.Product = resb.Product
  left outer join I_ProductText                as makt                        on  makt.Product  = resb.Product
                                                                              and makt.Language = $session.system_language
  left outer join I_UnitOfMeasure                                             on afpo.ProductionUnit = I_UnitOfMeasure.UnitOfMeasure

  left outer join I_ClfnObjectClass            as ObjectClass                 on  ObjectClass.ClfnObjectID    = resb.Product
                                                                              and ObjectClass.ClfnObjectTable = 'MARA'
//  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT         on  Character_Z_LOT.Product        = resb.Product
//                                                                          and Character_Z_LOT.Batch          = resb.Batch
//                                                                          and Character_Z_LOT.Characteristic = 'Z_LOT'
//  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOT    on  ClassCharacter_Z_LOT.ClassInternalID = ObjectClass.ClassInternalID
//                                                                          and ClassCharacter_Z_LOT.ValidityEndDate >= $session.system_date
//                                                                          and ClassCharacter_Z_LOT.Characteristic  = 'Z_LOT'
//  left outer join ztb_wm_req_fld               as Config_Z_LOT            on  Config_Z_LOT.field_name = 'Z_LOT'
//                                                                          and Config_Z_LOT.reference  = 'R08'
//                                                                          and Config_Z_LOT.action     = $parameters.P_Action
//                                                                          and Config_Z_LOT.mtart      = mara.ProductType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU          on  Character_Z_GHICHU.Product        = resb.Product
                                                                              and Character_Z_GHICHU.Batch          = resb.Batch
                                                                              and Character_Z_GHICHU.Characteristic = 'Z_GHICHU'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU     on  ClassCharacter_Z_GHICHU.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GHICHU.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GHICHU.Characteristic  = 'Z_GHICHU'
  left outer join ztb_wm_req_fld               as Config_Z_GHICHU             on  Config_Z_GHICHU.field_name = 'Z_GHICHU'
                                                                              and Config_Z_GHICHU.reference  = 'R08'
                                                                              and Config_Z_GHICHU.action     = $parameters.P_Action
                                                                              and Config_Z_GHICHU.mtart      = mara.ProductType
                                                                              and Config_Z_GHICHU.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GCQC            on  Character_Z_GCQC.Product        = resb.Product
                                                                              and Character_Z_GCQC.Batch          = resb.Batch
                                                                              and Character_Z_GCQC.Characteristic = 'Z_GCQC'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GCQC       on  ClassCharacter_Z_GCQC.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GCQC.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GCQC.Characteristic  = 'Z_GCQC'
  left outer join ztb_wm_req_fld               as Config_Z_GCQC               on  Config_Z_GCQC.field_name = 'Z_GCQC'
                                                                              and Config_Z_GCQC.reference  = 'R08'
                                                                              and Config_Z_GCQC.action     = $parameters.P_Action
                                                                              and Config_Z_GCQC.mtart      = mara.ProductType
                                                                              and Config_Z_GCQC.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSX             on  Character_Z_NSX.Product        = resb.Product
                                                                              and Character_Z_NSX.Batch          = resb.Batch
                                                                              and Character_Z_NSX.Characteristic = 'Z_NSX'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSX        on  ClassCharacter_Z_NSX.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NSX.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NSX.Characteristic  = 'Z_NSX'
  left outer join ztb_wm_req_fld               as Config_Z_NSX                on  Config_Z_NSX.field_name = 'Z_NSX'
                                                                              and Config_Z_NSX.reference  = 'R08'
                                                                              and Config_Z_NSX.action     = $parameters.P_Action
                                                                              and Config_Z_NSX.mtart      = mara.ProductType
                                                                              and Config_Z_NSX.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD             on  Character_Z_HSD.Product        = resb.Product
                                                                              and Character_Z_HSD.Batch          = resb.Batch
                                                                              and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSD        on  ClassCharacter_Z_HSD.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_HSD.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_HSD.Characteristic  = 'LOBM_VFDAT'
  left outer join ztb_wm_req_fld               as Config_Z_HSD                on  Config_Z_HSD.field_name = 'LOBM_VFDAT'
                                                                              and Config_Z_HSD.reference  = 'R08'
                                                                              and Config_Z_HSD.action     = $parameters.P_Action
                                                                              and Config_Z_HSD.mtart      = mara.ProductType
                                                                              and Config_Z_HSD.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NG              on  Character_Z_NG.Product        = resb.Product
                                                                              and Character_Z_NG.Batch          = resb.Batch
                                                                              and Character_Z_NG.Characteristic = 'Z_NG'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NG         on  ClassCharacter_Z_NG.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NG.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NG.Characteristic  = 'Z_NG'
  left outer join ztb_wm_req_fld               as Config_Z_NG                 on  Config_Z_NG.field_name = 'Z_NG'
                                                                              and Config_Z_NG.reference  = 'R08'
                                                                              and Config_Z_NG.action     = $parameters.P_Action
                                                                              and Config_Z_NG.mtart      = mara.ProductType
                                                                              and Config_Z_NG.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NNK             on  Character_Z_NNK.Product        = resb.Product
                                                                              and Character_Z_NNK.Batch          = resb.Batch
                                                                              and Character_Z_NNK.Characteristic = 'Z_GRD'
  left outer join ztb_wm_req_fld               as Config_Z_NNK                on  Config_Z_NNK.field_name = 'Z_GRD'
                                                                              and Config_Z_NNK.reference  = 'R08'
                                                                              and Config_Z_NNK.action     = $parameters.P_Action
                                                                              and Config_Z_NNK.mtart      = mara.ProductType
                                                                              and Config_Z_NNK.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NCC             on  Character_Z_NCC.Product        = resb.Product
                                                                              and Character_Z_NCC.Batch          = resb.Batch
                                                                              and Character_Z_NCC.Characteristic = 'Z_NCC'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NCC        on  ClassCharacter_Z_NCC.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NCC.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NCC.Characteristic  = 'Z_NCC'
  left outer join ztb_wm_req_fld               as Config_Z_NCC                on  Config_Z_NCC.field_name = 'Z_NCC'
                                                                              and Config_Z_NCC.reference  = 'R08'
                                                                              and Config_Z_NCC.action     = $parameters.P_Action
                                                                              and Config_Z_NCC.mtart      = mara.ProductType
                                                                              and Config_Z_NCC.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHASX           on  Character_Z_NHASX.Product        = resb.Product
                                                                              and Character_Z_NHASX.Batch          = resb.Batch
                                                                              and Character_Z_NHASX.Characteristic = 'Z_NHASX'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHASX      on  ClassCharacter_Z_NHASX.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NHASX.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NHASX.Characteristic  = 'Z_NHASX'
  left outer join ztb_wm_req_fld               as Config_Z_NHASX              on  Config_Z_NHASX.field_name = 'Z_NHASX'
                                                                              and Config_Z_NHASX.reference  = 'R08'
                                                                              and Config_Z_NHASX.action     = $parameters.P_Action
                                                                              and Config_Z_NHASX.mtart      = mara.ProductType
                                                                              and Config_Z_NHASX.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSXNB           on  Character_Z_NSXNB.Product        = resb.Product
                                                                              and Character_Z_NSXNB.Batch          = resb.Batch
                                                                              and Character_Z_NSXNB.Characteristic = 'Z_NSXNB'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSXNB      on  ClassCharacter_Z_NSXNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NSXNB.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NSXNB.Characteristic  = 'Z_NSXNB'
  left outer join ztb_wm_req_fld               as Config_Z_NSXNB              on  Config_Z_NSXNB.field_name = 'Z_NSXNB'
                                                                              and Config_Z_NSXNB.reference  = 'R08'
                                                                              and Config_Z_NSXNB.action     = $parameters.P_Action
                                                                              and Config_Z_NSXNB.mtart      = mara.ProductType
                                                                              and Config_Z_NSXNB.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSDNB           on  Character_Z_HSDNB.Product        = resb.Product
                                                                              and Character_Z_HSDNB.Batch          = resb.Batch
                                                                              and Character_Z_HSDNB.Characteristic = 'Z_HSDNB'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSDNB      on  ClassCharacter_Z_HSDNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_HSDNB.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_HSDNB.Characteristic  = 'Z_HSDNB'
  left outer join ztb_wm_req_fld               as Config_Z_HSDNB              on  Config_Z_HSDNB.field_name = 'Z_HSDNB'
                                                                              and Config_Z_HSDNB.reference  = 'R08'
                                                                              and Config_Z_HSDNB.action     = $parameters.P_Action
                                                                              and Config_Z_HSDNB.mtart      = mara.ProductType
                                                                              and Config_Z_HSDNB.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_MTX             on  Character_Z_MTX.Product        = resb.Product
                                                                              and Character_Z_MTX.Batch          = resb.Batch
                                                                              and Character_Z_MTX.Characteristic = 'Z_MTX'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_MTX        on  ClassCharacter_Z_MTX.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_MTX.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_MTX.Characteristic  = 'Z_MTX'
  left outer join ztb_wm_req_fld               as Config_Z_MTX                on  Config_Z_MTX.field_name = 'Z_MTX'
                                                                              and Config_Z_MTX.reference  = 'R08'
                                                                              and Config_Z_MTX.action     = $parameters.P_Action
                                                                              and Config_Z_MTX.mtart      = mara.ProductType
                                                                              and Config_Z_MTX.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_QCBG            on  Character_Z_QCBG.Product        = resb.Product
                                                                              and Character_Z_QCBG.Batch          = resb.Batch
                                                                              and Character_Z_QCBG.Characteristic = 'Z_QCBG'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_QCBG       on  ClassCharacter_Z_QCBG.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_QCBG.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_QCBG.Characteristic  = 'Z_QCBG'
  left outer join ztb_wm_req_fld               as Config_Z_QCBG               on  Config_Z_QCBG.field_name = 'Z_QCBG'
                                                                              and Config_Z_QCBG.reference  = 'R08'
                                                                              and Config_Z_QCBG.action     = $parameters.P_Action
                                                                              and Config_Z_QCBG.mtart      = mara.ProductType
                                                                              and Config_Z_QCBG.bwart      = resb.GoodsMovementType

//  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_PC          on  Character_Z_PC.Product        = resb.Product
//                                                                          and Character_Z_PC.Batch          = resb.Batch
//                                                                          and Character_Z_PC.Characteristic = 'Z_PC'
//  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_PC     on  ClassCharacter_Z_PC.ClassInternalID = ObjectClass.ClassInternalID
//                                                                          and ClassCharacter_Z_PC.ValidityEndDate >= $session.system_date
//                                                                          and ClassCharacter_Z_PC.Characteristic  = 'Z_PC'
//  left outer join ztb_wm_req_fld               as Config_Z_PC             on  Config_Z_PC.field_name = 'Z_PC'
//                                                                          and Config_Z_PC.reference  = 'R08'
//                                                                          and Config_Z_PC.action     = $parameters.P_Action
//                                                                          and Config_Z_PC.mtart      = mara.ProductType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHC             on  Character_Z_NHC.Product        = resb.Product
                                                                              and Character_Z_NHC.Batch          = resb.Batch
                                                                              and Character_Z_NHC.Characteristic = 'Z_NHC'
  left outer join ztb_wm_req_fld               as Config_Z_NHC                on  Config_Z_NHC.field_name = 'Z_NHC'
                                                                              and Config_Z_NHC.reference  = 'R08'
                                                                              and Config_Z_NHC.action     = $parameters.P_Action
                                                                              and Config_Z_NHC.mtart      = mara.ProductType
                                                                              and Config_Z_NHC.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOCATION        on  Character_Z_LOCATION.Product        = resb.Product
                                                                              and Character_Z_LOCATION.Batch          = resb.Batch
                                                                              and Character_Z_LOCATION.Characteristic = 'Z_LOCATION'
  left outer join ztb_wm_req_fld               as Config_Z_LOCATION           on  Config_Z_LOCATION.field_name = 'Z_LOCATION'
                                                                              and Config_Z_LOCATION.reference  = 'R08'
                                                                              and Config_Z_LOCATION.action     = $parameters.P_Action
                                                                              and Config_Z_LOCATION.mtart      = mara.ProductType
                                                                              and Config_Z_LOCATION.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW              on  Character_Z_GW.Product        = resb.Product
                                                                              and Character_Z_GW.Batch          = resb.Batch
                                                                              and Character_Z_GW.Characteristic = 'Z_GW'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GW         on  ClassCharacter_Z_GW.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GW.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GW.Characteristic  = 'Z_GW'
  left outer join ztb_wm_req_fld               as Config_Z_GW                 on  Config_Z_GW.field_name = 'Z_GW'
                                                                              and Config_Z_GW.reference  = 'R08'
                                                                              and Config_Z_GW.action     = $parameters.P_Action
                                                                              and Config_Z_GW.mtart      = mara.ProductType
                                                                              and Config_Z_GW.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_SLBTPKT         on  Character_Z_SLBTPKT.Product        = resb.Product
                                                                              and Character_Z_SLBTPKT.Batch          = resb.Batch
                                                                              and Character_Z_SLBTPKT.Characteristic = 'Z_SLBTPKT'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_SLBTPKT    on  ClassCharacter_Z_SLBTPKT.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_SLBTPKT.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_SLBTPKT.Characteristic  = 'Z_SLBTPKT'
  left outer join ztb_wm_req_fld               as Config_Z_SLBTPKT            on  Config_Z_SLBTPKT.field_name = 'Z_SLBTPKT'
                                                                              and Config_Z_SLBTPKT.reference  = 'R08'
                                                                              and Config_Z_SLBTPKT.action     = $parameters.P_Action
                                                                              and Config_Z_SLBTPKT.mtart      = mara.ProductType
                                                                              and Config_Z_SLBTPKT.bwart      = resb.GoodsMovementType

  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_SLTPKT          on  Character_Z_SLTPKT.Product        = resb.Product
                                                                              and Character_Z_SLTPKT.Batch          = resb.Batch
                                                                              and Character_Z_SLTPKT.Characteristic = 'Z_SLTPKT'
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_SLTPKT     on  ClassCharacter_Z_SLTPKT.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_SLTPKT.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_SLTPKT.Characteristic  = 'Z_SLTPKT'
  left outer join ztb_wm_req_fld               as Config_Z_SLTPKT             on  Config_Z_SLTPKT.field_name = 'Z_SLTPKT'
                                                                              and Config_Z_SLTPKT.reference  = 'R08'
                                                                              and Config_Z_SLTPKT.action     = $parameters.P_Action
                                                                              and Config_Z_SLTPKT.mtart      = mara.ProductType
                                                                              and Config_Z_SLTPKT.bwart      = resb.GoodsMovementType
  left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU_PKH      on  Character_Z_GHICHU_PKH.Product        = afpo.Material
                                                                              and Character_Z_GHICHU_PKH.Batch          = afpo.Batch
                                                                              and Character_Z_GHICHU_PKH.Characteristic = 'Z_GHICHU_PKH '
  left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU_PKH on  ClassCharacter_Z_GHICHU_PKH.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GHICHU_PKH.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GHICHU_PKH.Characteristic  = 'Z_GHICHU_PKH '
  left outer join ztb_wm_req_fld               as Config_Z_GHICHU_PKH         on  Config_Z_GHICHU_PKH.field_name = 'Z_GHICHU_PKH '
                                                                              and Config_Z_GHICHU_PKH.reference  = 'R08'
                                                                              and Config_Z_GHICHU_PKH.action     = $parameters.P_Action
                                                                              and Config_Z_GHICHU_PKH.mtart      = mara.ProductType
                                                                              and Config_Z_GHICHU_PKH.bwart      = resb.GoodsMovementType
//  left outer join ZI_WM_ZMIGO_R08_A07_POSTED   as Posted                   on  Posted.ManufacturingOrder     = aufk.ManufacturingOrder
//                                                                           and Posted.ManufacturingOrderItem = aufk.ManufacturingOrderItem
//                                                                           and Posted.Material               = resb.Product
//                                                                           and Posted.GoodsMovementType      = resb.GoodsMovementType
{
  key aufk.ManufacturingOrder,
  key afpo.ManufacturingOrderItem,
  key resb.Reservation,
  key resb.ReservationItem,
      afpo.ProductionPlant                                                                                as Plant,
      t001w.PlantName,
      vbak.SoldToParty,
      vbak._SoldToParty.OrganizationBPName1                                                               as SoldToPartyName,
      vbap.ShipToParty,
      vbap._ShipToParty.OrganizationBPName1                                                               as ShipToPartyName,
      aufk.MfgOrderScheduledStartDate,
      aufk.MfgOrderPlannedEndDate,
      resb.Product                                                                                        as Material,
      makt.ProductName                                                                                    as MaterialDescription,
      mara.ProductType                                                                                    as MaterialType,
      mara._ProductTypeName[1: Language=$session.system_language].MaterialTypeName,
      resb.ResvnItmRequiredQtyInBaseUnit                                                                  as TargetQuantity,
      ''                                                                                                  as ProductionVersion,
      resb.ResvnItmWithdrawnQtyInBaseUnit                                                                 as GoodsReceiptQty,

      case when resb.ResvnItmRequiredQtyInBaseUnit < resb.ResvnItmWithdrawnQtyInBaseUnit then cast( 0 as abap.quan(13,3) ) else
      resb.ResvnItmRequiredQtyInBaseUnit - resb.ResvnItmWithdrawnQtyInBaseUnit end                        as RemainingQuantity,
      resb.EntryUnit                                                                                      as ProductionUnit,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                       as UnitNumberOfDecimal,
      resb.Batch,
      resb.StorageLocation,
      t001l.StorageLocationName,
      vbap.SalesDocument                                                                                  as SalesOrder,
      vbap.SalesDocumentItem                                                                              as SalesOrderItem,
      resb.GoodsMovementType,
      resb.InventorySpecialStockType,
      //      rkpf.WBSElementInternalID,
      vbak.PurchaseOrderByCustomer,
      aufk.YY1_LotNo_ORD                                                                                  as LotNum,
      cast('' as abap.char(100))                                                                          as LongText,
      aufk.ProfitCenter,
      mara.BaseUnit,
      cast( 'X' as abap_boolean )                                                                         as IsCompletelyDelivered,
      aufk.CreationDate,
      //      Character_Z_LOT.CharcValue                                               as LotNum,
      //      cast( case when ClassCharacter_Z_LOT.ClassInternalID is null then ''
      //                 when Config_Z_LOT.disable_field end as abap_boolean )         as LotNumActive,
      //      Config_Z_LOT.require_field                                               as LotNumRequired,

      Character_Z_GHICHU.CharcValue                                                                       as BatchNote,
      cast( case when ClassCharacter_Z_GHICHU.ClassInternalID is null then ''
                 when Config_Z_GHICHU.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as BatchNoteActive,
      Config_Z_GHICHU.require_field                                                                       as BatchNoteRequired,

      Character_Z_GCQC.CharcValue                                                                         as QCNote,
      cast( case when ClassCharacter_Z_GCQC.ClassInternalID is null then ''
                 when Config_Z_GCQC.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as QCNoteActive,
      Config_Z_GCQC.require_field                                                                         as QCNoteRequired,

      Character_Z_NSX.CharcFromDate                                                                       as ProductionDate,
      cast( case when ClassCharacter_Z_NSX.ClassInternalID is null then ''
                 when Config_Z_NSX.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ProductionDateActive,
      Config_Z_NSX.require_field                                                                          as ProductionDateRequired,

      Character_Z_HSD.CharcFromDate                                                                       as ExpirationDate,
      cast( case when ClassCharacter_Z_HSD.ClassInternalID is null then ''
                 when Config_Z_HSD.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ExpirationDateActive,
      Config_Z_HSD.require_field                                                                          as ExpirationDateRequired,

      Character_Z_NG.CharcValue                                                                           as Origin,
      cast( case when ClassCharacter_Z_NG.ClassInternalID is null then ''
                 when Config_Z_NG.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as OriginActive,
      Config_Z_NG.require_field                                                                           as OriginRequired,

      Character_Z_NNK.CharcFromDate                                                                       as GoodsReceiptDate,
      cast( case when Character_Z_NNK.CharcValue is null then ''
                 when Config_Z_NNK.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as GoodsReceiptDateActive,
      Config_Z_NNK.require_field                                                                          as GoodsReceiptDateRequired,

      Character_Z_NCC.CharcValue                                                                          as BatchSupplier,
      cast( case when ClassCharacter_Z_NCC.ClassInternalID is null then ''
                 when Config_Z_NCC.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as BatchSupplierActive,
      Config_Z_NCC.require_field                                                                          as BatchSupplierRequired,

      Character_Z_NHASX.CharcValue                                                                        as Manufacturer,
      cast( case when ClassCharacter_Z_NHASX.ClassInternalID is null then ''
                 when Config_Z_NHASX.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ManufacturerActive,
      Config_Z_NHASX.require_field                                                                        as ManufacturerRequired,

      Character_Z_NSXNB.CharcFromDate                                                                     as ProductionDateInternal,
      cast( case when ClassCharacter_Z_NSXNB.ClassInternalID is null then ''
                 when Config_Z_NSXNB.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ProductionDateInternalActive,
      Config_Z_NSXNB.require_field                                                                        as ProductionDateInternalRequired,

      Character_Z_HSDNB.CharcFromDate                                                                     as ExpirationDateInternal,
      cast( case when ClassCharacter_Z_HSDNB.ClassInternalID is null then ''
                 when Config_Z_HSDNB.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as ExpirationDateInternalActive,
      Config_Z_HSDNB.require_field                                                                        as ExpirationDateInternalRequired,

      Character_Z_MTX.CharcValue                                                                          as AccessCode,
      cast( case when ClassCharacter_Z_MTX.ClassInternalID is null then ''
                 when Config_Z_MTX.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as AccessCodeActive,
      Config_Z_MTX.require_field                                                                          as AccessCodeRequired,

      Character_Z_QCBG.CharcValue                                                                         as PackagingSpec,
      cast( case when ClassCharacter_Z_QCBG.ClassInternalID is null then ''
                 when Config_Z_QCBG.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as PackagingSpecActive,
      Config_Z_QCBG.require_field                                                                         as PackagingSpecRequired,

      //      Character_Z_PC.CharcValue                                             as ProfitCenter,
      //      cast( case when ClassCharacter_Z_PC.ClassInternalID is null then ''
      //                 when Config_Z_PC.disable_field = 'X' then '' end as abap_boolean )       as ProfitCenterActive,
      //      Config_Z_PC.require_field                                             as ProfitCenterRequired,

      Character_Z_NHC.CharcValue                                                                          as CalibrationLocation,
      cast( case when Character_Z_NHC.CharcValue is null then ''
                 when Config_Z_NHC.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as CalibrationLocationActive,
      Config_Z_NHC.require_field                                                                          as CalibrationLocationRequired,

      Character_Z_LOCATION.CharcValue                                                                     as WhereToUse,
      cast( case when Character_Z_LOCATION.CharcValue is null then ''
                 when Config_Z_LOCATION.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as WhereToUseActive,
      Config_Z_LOCATION.require_field                                                                     as WhereToUseRequired,

      //      cast( Character_Z_GW.CharcFromNumericValue as abap.dec(16,3) )               as GrossWeight,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))      as GrossWeight,
      cast( case when ClassCharacter_Z_GW.ClassInternalID is null then ''
                 when Config_Z_GW.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as GrossWeightActive,
      Config_Z_GW.require_field                                                                           as GrossWeightRequired,

      //      cast( Character_Z_SLBTPKT.CharcFromNumericValue as abap.dec(16,3) )                            as QuantityBTP,
      cast(round(cast(Character_Z_SLBTPKT.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3)) as QuantityBTP,
      cast( case when ClassCharacter_Z_SLBTPKT.ClassInternalID is null then ''
                 when Config_Z_SLBTPKT.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as QuantityBTPActive,
      Config_Z_SLBTPKT.require_field                                                                      as QuantityBTPRequired,


      //      cast( Character_Z_SLTPKT.CharcFromNumericValue as abap.dec(16,3) )                             as QuantityTP,
      cast(round(cast(Character_Z_SLTPKT.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))  as QuantityTP,
      cast( case when ClassCharacter_Z_SLTPKT.ClassInternalID is null then ''
                 when Config_Z_SLTPKT.disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as QuantityTPActive,
      Config_Z_SLTPKT.require_field                                                                       as QuantityTPRequired,

      //      Character_Z_GHICHU_PKH .CharcValue                                                                  as PlanDeptNote,
      aufk.YY1_GCPKH_ORD                                                                                  as PlanDeptNote,
      cast( case when ClassCharacter_Z_GHICHU_PKH .ClassInternalID is null then ''
                 when Config_Z_GHICHU_PKH .disable_field = 'X' then ''
                 else 'X' end as abap_boolean )                                                           as PlanDeptNoteActive,
      Config_Z_GHICHU_PKH .require_field                                                                  as PlanDeptNoteRequired

}
where
  (
    $parameters.P_Action = 'A07'
    //    and resb.ReservationItemIsFinallyIssued is initial
  )

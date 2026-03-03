@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Characteristics'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_PRODUCT_CHARACTERISTIC
  as select from    I_Batch
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT        on  Character_Z_LOT.Product        = I_Batch.Material
                                                                           and Character_Z_LOT.Batch          = I_Batch.Batch
                                                                           and Character_Z_LOT.Characteristic = 'Z_LOT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU     on  Character_Z_GHICHU.Product        = I_Batch.Material
                                                                           and Character_Z_GHICHU.Batch          = I_Batch.Batch
                                                                           and Character_Z_GHICHU.Characteristic = 'Z_GHICHU'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GCQC       on  Character_Z_GCQC.Product        = I_Batch.Material
                                                                           and Character_Z_GCQC.Batch          = I_Batch.Batch
                                                                           and Character_Z_GCQC.Characteristic = 'Z_GCQC'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSX        on  Character_Z_NSX.Product        = I_Batch.Material
                                                                           and Character_Z_NSX.Batch          = I_Batch.Batch
                                                                           and Character_Z_NSX.Characteristic = 'Z_NSX'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSD        on  Character_Z_HSD.Product        = I_Batch.Material
                                                                           and Character_Z_HSD.Batch          = I_Batch.Batch
                                                                           and Character_Z_HSD.Characteristic = 'LOBM_VFDAT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NG         on  Character_Z_NG.Product        = I_Batch.Material
                                                                           and Character_Z_NG.Batch          = I_Batch.Batch
                                                                           and Character_Z_NG.Characteristic = 'Z_NG'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NNK        on  Character_Z_NNK.Product        = I_Batch.Material
                                                                           and Character_Z_NNK.Batch          = I_Batch.Batch
                                                                           and Character_Z_NNK.Characteristic = 'Z_GRD'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NCC        on  Character_Z_NCC.Product        = I_Batch.Material
                                                                           and Character_Z_NCC.Batch          = I_Batch.Batch
                                                                           and Character_Z_NCC.Characteristic = 'Z_NCC'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHASX      on  Character_Z_NHASX.Product        = I_Batch.Material
                                                                           and Character_Z_NHASX.Batch          = I_Batch.Batch
                                                                           and Character_Z_NHASX.Characteristic = 'Z_NHASX'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NSXNB      on  Character_Z_NSXNB.Product        = I_Batch.Material
                                                                           and Character_Z_NSXNB.Batch          = I_Batch.Batch
                                                                           and Character_Z_NSXNB.Characteristic = 'Z_NSXNB'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_HSDNB      on  Character_Z_HSDNB.Product        = I_Batch.Material
                                                                           and Character_Z_HSDNB.Batch          = I_Batch.Batch
                                                                           and Character_Z_HSDNB.Characteristic = 'Z_HSDNB'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_MTX        on  Character_Z_MTX.Product        = I_Batch.Material
                                                                           and Character_Z_MTX.Batch          = I_Batch.Batch
                                                                           and Character_Z_MTX.Characteristic = 'Z_MTX'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_QCBG       on  Character_Z_QCBG.Product        = I_Batch.Material
                                                                           and Character_Z_QCBG.Batch          = I_Batch.Batch
                                                                           and Character_Z_QCBG.Characteristic = 'Z_QCBG'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_PC         on  Character_Z_PC.Product        = I_Batch.Material
                                                                           and Character_Z_PC.Batch          = I_Batch.Batch
                                                                           and Character_Z_PC.Characteristic = 'Z_PC'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_NHC        on  Character_Z_NHC.Product        = I_Batch.Material
                                                                           and Character_Z_NHC.Batch          = I_Batch.Batch
                                                                           and Character_Z_NHC.Characteristic = 'Z_NHC'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOCATION   on  Character_Z_LOCATION.Product        = I_Batch.Material
                                                                           and Character_Z_LOCATION.Batch          = I_Batch.Batch
                                                                           and Character_Z_LOCATION.Characteristic = 'Z_LOCATION'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GW         on  Character_Z_GW.Product        = I_Batch.Material
                                                                           and Character_Z_GW.Batch          = I_Batch.Batch
                                                                           and Character_Z_GW.Characteristic = 'Z_GW'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_SLBTPKT    on  Character_Z_SLBTPKT.Product        = I_Batch.Material
                                                                           and Character_Z_SLBTPKT.Batch          = I_Batch.Batch
                                                                           and Character_Z_SLBTPKT.Characteristic = 'Z_SLBTPKT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_SLTPKT     on  Character_Z_SLTPKT.Product        = I_Batch.Material
                                                                           and Character_Z_SLTPKT.Batch          = I_Batch.Batch
                                                                           and Character_Z_SLTPKT.Characteristic = 'Z_SLTPKT'
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_GHICHU_PKH on  Character_Z_GHICHU_PKH.Product        = I_Batch.Material
                                                                           and Character_Z_GHICHU_PKH.Batch          = I_Batch.Batch
                                                                           and Character_Z_GHICHU_PKH.Characteristic = 'Z_GHICHU_PKH '
{
  key I_Batch.Material                                                                                    as Product,
  key I_Batch.Batch                                                                                       as Batch,
      Character_Z_LOT.CharcValue                                                                          as LotNum,
      Character_Z_GHICHU.CharcValue                                                                       as BatchNote,
      Character_Z_GCQC.CharcValue                                                                         as QCNote,
      Character_Z_NSX.CharcFromDate                                                                       as ProductionDate,
      Character_Z_HSD.CharcFromDate                                                                       as ExpirationDate,
      Character_Z_NG.CharcValue                                                                           as Origin,
      Character_Z_NNK.CharcFromDate                                                                       as GoodsReceiptDate,
      Character_Z_NCC.CharcValue                                                                          as BatchSupplier,
      Character_Z_NHASX.CharcValue                                                                        as Manufacturer,
      Character_Z_NSXNB.CharcFromDate                                                                     as ProductionDateInternal,
      Character_Z_HSDNB.CharcFromDate                                                                     as ExpirationDateInternal,
      Character_Z_MTX.CharcValue                                                                          as AccessCode,
      Character_Z_QCBG.CharcValue                                                                         as PackagingSpec,
      Character_Z_PC.CharcValue                                                                           as ProfitCenter,
      Character_Z_NHC.CharcValue                                                                          as CalibrationLocation,
      Character_Z_LOCATION.CharcValue                                                                     as WhereToUse,
      cast(round(cast(Character_Z_GW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))      as GrossWeight,
      cast(round(cast(Character_Z_SLBTPKT.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3)) as QuantityBTP,
      cast(round(cast(Character_Z_SLTPKT.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))  as QuantityTP,
      Character_Z_GHICHU_PKH.CharcValue                                                                   as PlanDeptNote
}
where
  I_Batch.Plant is initial

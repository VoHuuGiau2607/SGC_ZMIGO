@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIGO - Material Gross Weight'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_MAT_GWEIGHT
  as select distinct from ZCORE_I_BATCH_CHARACTERISTIC as CharGW
    inner join            ZCORE_I_BATCH_CHARACTERISTIC as CharLot on  CharLot.Product        = CharGW.Product
                                                                  and CharLot.Batch          = CharGW.Batch
                                                                  and CharLot.Characteristic = 'Z_LOT'
{
  key CharGW.Product,
  key cast( case when CharLot.CharcValue is null then '' else CharLot.CharcValue end as abap.char(70)) as LotNum,

      cast(round(cast(CharGW.CharcFromNumericValue as abap.dec(16,6)), 3) as abap.dec(16,3))           as GWeight
}
where
      CharGW.Characteristic        = 'Z_GW'
  and CharGW.CharcFromDecimalValue is not initial

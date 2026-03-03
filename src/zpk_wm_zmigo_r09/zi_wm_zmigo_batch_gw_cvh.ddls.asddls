@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIGO - Batch Gross Weight - CVH'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #C,
    sizeCategory: #L,
    dataClass: #MASTER
}
define view entity ZI_WM_ZMIGO_BATCH_GW_CVH
  as select from    I_BatchStdVH
    left outer join ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_LOT on  Character_Z_LOT.Product        = I_BatchStdVH.Material
                                                                    and Character_Z_LOT.Batch          = I_BatchStdVH.Batch
                                                                    and Character_Z_LOT.Characteristic = 'Z_LOT'
    left outer join ZI_WM_ZMIGO_MAT_GWEIGHT      as Character_Z_GW  on  Character_Z_GW.Product = I_BatchStdVH.Material
                                                                    and Character_Z_GW.LotNum  = Character_Z_LOT.CharcValue
{
  key I_BatchStdVH.Plant,
  key I_BatchStdVH.Material,
  key I_BatchStdVH.Batch,
      Character_Z_LOT.CharcValue as LotNum,
      Character_Z_GW.GWeight     as GrossWeight

}

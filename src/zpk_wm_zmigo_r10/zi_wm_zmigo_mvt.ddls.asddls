@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - List mvt'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_MVT
  as select from ztb_rsnum_mvtatp
    inner join   I_GoodsMovementTypeT on  I_GoodsMovementTypeT.GoodsMovementType = ztb_rsnum_mvtatp.bwart
                                      and I_GoodsMovementTypeT.Language          = $session.system_language
{
  key ztb_rsnum_mvtatp.action as Action,
  key ztb_rsnum_mvtatp.bwart  as GoodsMovementType,
      I_GoodsMovementTypeT.GoodsMovementTypeName
}

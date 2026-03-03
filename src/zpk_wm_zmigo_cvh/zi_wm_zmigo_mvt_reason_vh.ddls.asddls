@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'UoM Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_MVT_REASON_VH
  as select from I_GoodsMovementReasonCodeText
{
  key GoodsMovementType,
  key GoodsMovementReasonCode,
      GoodsMovementReasonName
}
where
  Language = $session.system_language

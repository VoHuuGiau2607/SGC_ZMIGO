@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Other - Field Conf'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_R10_FIELD
  as select from ztb_rsnum_mvtreq
{
  key bwart         as GoodsMovementType,
  key fieldname     as FieldName,
      hidden_field  as IsHiddenField,
      disable_field as IsDisableField,
      require_field as IsRequiredField,
      copy_data     as IsCopyData
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post GM - Storage Location - Auth'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_SLOC_AUTH
  as select from ztb_wm_cf_us_slo
{
  key plant            as Plant,
  key storage_location as StorageLocation,
  key userid           as UserID
}

union select distinct from ztb_wm_cf_us_slo
{
  key plant  as Plant,
  key ''     as StorageLocation,
  key userid as UserID
}

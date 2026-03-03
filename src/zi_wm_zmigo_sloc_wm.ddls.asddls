@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List Sloc - Xưởng/Nhà máy'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_SLOC_WM
  as select from ztb_wm_cf_slo_wm
{
  key plant            as Plant,
  key storage_location as StorageLocation,
      factory_id       as FactoryId,
      factory_name     as FactoryName
}

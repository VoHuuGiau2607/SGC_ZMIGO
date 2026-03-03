@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Factory ID - Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_FACTORY_VH
  as select distinct from ztb_wm_cf_slo_wm
{
         @ObjectModel.text.element:[ 'FactoryName' ]
  key    factory_id   as FactoryId,
         @UI.lineItem: [{ position: 10 }]
         factory_name as FactoryName
}

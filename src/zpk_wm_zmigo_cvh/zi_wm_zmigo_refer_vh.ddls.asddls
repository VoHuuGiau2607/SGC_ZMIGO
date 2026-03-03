@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reference Document - Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_WM_ZMIGO_REFER_VH
  as select from ztb_wm_map_actn                             as Mapping
    inner join   DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                       p_domain_name : 'ZDO_WM_ZMIGO_REFER') as Text on Mapping.reference = Text.value_low
{
         @UI.hidden: true
  key    Text.domain_name,
         @UI.hidden: true
  key    Text.value_position,
         @UI.hidden: true
  key    Text.language,
         @UI.hidden: true
  key    Mapping.action as Action,
         @ObjectModel.text.element:[ 'Text' ]
         @EndUserText.label: 'Reference'
  key    Text.value_low as Reference,
         @UI.lineItem: [{ position: 10 }]
         @EndUserText.label: 'Text'
         Text.text      as Text
}

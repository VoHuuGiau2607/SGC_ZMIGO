@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Action - Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_WM_ZMIGO_ACTION_VH
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                   p_domain_name : 'ZDO_WM_ZMIGO_ACTION')
{
         @UI.hidden: true
  key    domain_name,
         @UI.hidden: true
  key    value_position,
         @UI.hidden: true
  key    language,
         @ObjectModel.text.element:[ 'Text' ]
         @EndUserText.label: 'Action'
  key    value_low as Action,
         @UI.lineItem: [{ position: 10 }]
         @EndUserText.label: 'Text'
         text      as Text
}

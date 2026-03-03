@EndUserText.label: 'ZMIGO - Required Field Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'ZmigoRequiredFieAll'
  }
}
define root view entity ZI_ZmigoRequiredField_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_ZMIGOREQUIREDFIELD'
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_ZmigoRequiredField as _ZmigoRequiredField
{
  @UI.facet: [ {
    id: 'ZI_ZmigoRequiredField', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'ZMIGO - Required Field', 
    position: 1 , 
    targetElement: '_ZmigoRequiredField'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _ZmigoRequiredField,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  @ObjectModel.text.association: '_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 1 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  _ABAPTransportRequestText
}
where I_Language.Language = $session.system_language

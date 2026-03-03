@EndUserText.label: 'Khai báo thông tin hiển thị Gross Weight'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'KhaiBOThNgTinHiNAll'
  }
}
define root view entity ZI_KhaiBOThNgTinHiNThG_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_KHAIBOTHNGTINHINTHG'
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_KhaiBOThNgTinHiNThG as _KhaiBOThNgTinHiNThG
{
  @UI.facet: [ {
    id: 'ZI_KhaiBOThNgTinHiNThG', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Khai báo thông tin hiển thị Gross Weight', 
    position: 1 , 
    targetElement: '_KhaiBOThNgTinHiNThG'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _KhaiBOThNgTinHiNThG,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  @ObjectModel.text.association: '_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 2 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  _ABAPTransportRequestText
  
}
where I_Language.Language = $session.system_language

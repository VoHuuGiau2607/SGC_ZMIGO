@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZTBWM_ZMIGO_313'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_TBWM_ZMIGO_313
  provider contract transactional_query
  as projection on ZR_TBWM_ZMIGO_313
  association [1..1] to ZR_TBWM_ZMIGO_313 as _BaseEntity on  $projection.MaterialDocumentYear = _BaseEntity.MaterialDocumentYear
                                                         and $projection.MaterialDocument     = _BaseEntity.MaterialDocument
                                                         and $projection.MaterialDocumentItem = _BaseEntity.MaterialDocumentItem
{
  key MaterialDocumentYear,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name    : 'I_MaterialDocumentItem_2',
              element : 'MaterialDocument'
          },
          additionalBinding: [
              {
                  localElement : 'MaterialDocumentYear',
                  element      : 'MaterialDocumentYear'
              },
              {
                  localElement : 'MaterialDocumentItem',
                  element      : 'MaterialDocumentItem'
              }
         ]
      }]
  key MaterialDocument,
  key MaterialDocumentItem,
      @Semantics: {
        user.createdBy: true
      }
      LocalCreatedBy,
      @Semantics: {
        systemDateTime.createdAt: true
      }
      LocalCreatedAt,
      @Semantics: {
        user.localInstanceLastChangedBy: true
      }
      LocalLastChangedBy,
      @Semantics: {
        systemDateTime.localInstanceLastChangedAt: true
      }
      LocalLastChangedAt,
      @Semantics: {
        systemDateTime.lastChangedAt: true
      }
      LastChangedAt,
      _BaseEntity
}

@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZTBWM_ZMIGO_313'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_TBWM_ZMIGO_313
  as select from ZTB_WM_ZMIGO_313
{
  key material_document_year as MaterialDocumentYear,
  key material_document as MaterialDocument,
  key material_document_item as MaterialDocumentItem,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}

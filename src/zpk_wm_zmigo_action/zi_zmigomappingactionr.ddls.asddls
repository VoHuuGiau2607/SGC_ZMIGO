@EndUserText.label: 'ZMIGO - Mapping Action Reference'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_ZmigoMappingActionR
  as select from ZTB_WM_MAP_ACTN
  association to parent ZI_ZmigoMappingActionR_S as _ZmigoMappingActiAll on $projection.SingletonID = _ZmigoMappingActiAll.SingletonID
{
  key ACTION as Action,
  key REFERENCE as Reference,
  @Consumption.hidden: true
  1 as SingletonID,
  _ZmigoMappingActiAll
  
}

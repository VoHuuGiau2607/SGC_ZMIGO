@EndUserText.label: 'ZMIGO - Required Field'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_ZmigoRequiredField
  as select from ztb_wm_req_fld
  association to parent ZI_ZmigoRequiredField_S as _ZmigoRequiredFieAll on $projection.SingletonID = _ZmigoRequiredFieAll.SingletonID
{
      @Consumption.valueHelpDefinition: [{
          entity: {
              name           : 'ZI_WM_ZMIGO_ACTION_VH',
              element        : 'Action'
          }
      }]
  key action        as Action,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name           : 'ZI_WM_ZMIGO_REFER_VH',
              element        : 'Reference'
          },
            additionalBinding: [{
              localElement : 'Action',
              element        : 'Action'
            }]
      }]
  key reference     as Reference,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name           : 'I_ProductType_2',
              element        : 'ProductType'
          }
      }]
  key mtart         as Mtart,
      @Consumption.valueHelpDefinition: [{
          entity: {
              name           : 'I_GoodsMovementType',
              element        : 'GoodsMovementType'
          }
      }]
  key bwart         as Bwart,
  key field_name    as FieldName,
      disable_field as DisableField,
      require_field as RequireField,
      @Consumption.hidden: true
      1             as SingletonID,
      _ZmigoRequiredFieAll
}

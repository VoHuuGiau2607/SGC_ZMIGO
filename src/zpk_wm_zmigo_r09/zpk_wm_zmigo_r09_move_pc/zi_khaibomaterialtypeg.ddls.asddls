@EndUserText.label: 'Khai báo Material Type giữ nguyên PC khi'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_KhaiBOMaterialTypeG
  as select from ztb_wm_mattyp_pc
  association to parent ZI_KhaiBOMaterialTypeG_S as _KhaiBOMaterialTyAll on $projection.SingletonID = _KhaiBOMaterialTyAll.SingletonID
{
      @Consumption.valueHelpDefinition: [{
          entity: {
              name           : 'I_ProductType_2',
              element        : 'ProductType'
          }
      }]
  key mtart      as Mtart,
      is_keep_pc as IsKeepPc,
      @Consumption.hidden: true
      1          as SingletonID,
      _KhaiBOMaterialTyAll
}

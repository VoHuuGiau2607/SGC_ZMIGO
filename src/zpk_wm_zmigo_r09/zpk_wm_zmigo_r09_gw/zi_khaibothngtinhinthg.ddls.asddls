@EndUserText.label: 'Khai báo thông tin hiển thị Gross Weight'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZI_KhaiBOThNgTinHiNThG
  as select from ztb_wm_show_gw
  association to parent ZI_KhaiBOThNgTinHiNThG_S as _KhaiBOThNgTinHiNAll on $projection.SingletonID = _KhaiBOThNgTinHiNAll.SingletonID
{
      @Consumption.valueHelpDefinition: [
        {
            entity: { name: 'I_GoodsMovementType', element: 'GoodsMovementType' }
        }
      ]
  key bwart as Bwart,
      @Consumption.valueHelpDefinition: [
        {
            entity: { name: 'I_Plant', element: 'Plant' }
        }
      ]
  key werks as Werks,
      @Consumption.valueHelpDefinition: [
        {
            entity: { name: 'I_StorageLocation', element: 'StorageLocation' },
            additionalBinding: [{ element: 'Plant', localElement: 'Werks' }]
        }
      ]
  key lgort as Lgort,
      @Consumption.valueHelpDefinition: [
        {
            entity: { name: 'I_Plant', element: 'Plant' }
        }
      ]
  key umwrk as Umwrk,
      @Consumption.valueHelpDefinition: [
        {
            entity: { name: 'I_StorageLocation', element: 'StorageLocation' },
            additionalBinding: [{ element: 'Plant', localElement: 'Umwrk' }]
        }
      ]
  key umlgo as Umlgo,
      @Consumption.valueHelpDefinition: [
        {
            entity: { name: 'I_Producttype', element: 'ProductType' }
        }
      ]
  key mtart as Mtart,
      @Consumption.hidden: true
      1     as SingletonID,
      _KhaiBOThNgTinHiNAll

}

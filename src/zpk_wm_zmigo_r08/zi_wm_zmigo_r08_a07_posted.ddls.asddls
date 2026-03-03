@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Số lượng đã nhập/xuất'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_WM_ZMIGO_R08_A07_POSTED
  as select from I_MaterialDocumentItem_2
{
  key Reservation,
  key ReservationItem, 
  key GoodsMovementType,
      MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( QuantityInBaseUnit ) as QuantityInBaseUnit
}
group by
  Reservation,
  ReservationItem, 
  GoodsMovementType,
  MaterialBaseUnit

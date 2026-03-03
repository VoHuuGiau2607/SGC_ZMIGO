@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Số lượng đã post'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_R09_QTY_OUTB
  as select from ztb_wm_resb            as RESB
    inner join   I_DeliveryDocumentItem as LIPS on  LIPS.YY1_MM_Zreservation_DLI    = RESB.rsnum
                                                and LIPS.YY1_MM_ZreservationIte_DLI = RESB.rspos
{
  key RESB.rsnum                               as Reservation,
  key RESB.rspos                               as ReservationItem,
      RESB.meins                               as BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum( LIPS.ActualDeliveredQtyInBaseUnit ) as QuantityNotCompletelyDelivered
}
where
  //      LIPS.IsCompletelyDelivered is initial
  LIPS.GoodsMovementStatus <> 'C'
group by
  RESB.rsnum,
  RESB.rspos,
  RESB.meins

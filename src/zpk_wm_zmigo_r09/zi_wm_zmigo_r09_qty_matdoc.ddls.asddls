@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Số lượng đã post'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_R09_QTY_MATDOC
  as select from ztb_wm_resb               as RESB
    inner join   I_MaterialDocumentItem_2  as MSEG    on  MSEG.YY1_MM_Zreservation_MMI    = RESB.rsnum
                                                      and MSEG.YY1_MM_ZreservationIte_MMI = RESB.rspos
    inner join   ZCORE_I_MATDOC_REMOVE_REV as MSEG_RV on  MSEG_RV.MaterialDocument     = MSEG.MaterialDocument
                                                      and MSEG_RV.MaterialDocumentYear = MSEG.MaterialDocumentYear
                                                      and MSEG_RV.MaterialDocumentItem = MSEG.MaterialDocumentItem
{
  key RESB.rsnum                      as Reservation,
  key RESB.rspos                      as ReservationItem,
      RESB.meins                      as BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum( MSEG.QuantityInBaseUnit  ) as QuantityMatdocPosted
}
where
  MSEG.IsAutomaticallyCreated is initial
group by
  RESB.rsnum,
  RESB.rspos,
  RESB.meins

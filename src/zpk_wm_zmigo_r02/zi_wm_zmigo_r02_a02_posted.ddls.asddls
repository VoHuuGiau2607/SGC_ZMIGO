@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Post GM - Material Document Posted'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZI_WM_ZMIGO_R02_A02_POSTED
  as select from    I_MaterialDocumentItem_2 as mseg

    left outer join I_PurchaseOrderItemAPI01 as ekpo    on  ekpo.PurchaseOrder     = mseg.PurchaseOrder
                                                        and ekpo.PurchaseOrderItem = mseg.PurchaseOrderItem

    left outer join I_InboundDeliveryItem    as lips_ib on  lips_ib.PurchaseOrder       = ekpo.PurchaseOrder
                                                        and lips_ib.PurchaseOrderItem   = ekpo.PurchaseOrderItem
                                                        and lips_ib.InboundDelivery     = mseg.DeliveryDocument
                                                        and lips_ib.InboundDeliveryItem = mseg.DeliveryDocumentItem

    left outer join ZI_WM_ZMIGO_R02_A02_OUTB as lips_od on  lips_od.PurchaseOrder     = ekpo.PurchaseOrder
                                                        and lips_od.PurchaseOrderItem = ekpo.PurchaseOrderItem
                                                        and lips_od.InboundDelivery   = lips_ib.InboundDelivery

{
  key mseg.MaterialDocument,
  key mseg.MaterialDocumentYear,
  key mseg.MaterialDocumentItem,

      lips_ib.BaseUnit,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      lips_ib.ActualDeliveredQtyInBaseUnit                                            as InboundDeliveredQtyInBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      lips_od.ActualDeliveredQtyInBaseUnit                                            as OutboundDeliveredQtyInBaseUnit,

      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      case when lips_od.ActualDeliveredQtyInBaseUnit is null then lips_ib.ActualDeliveredQtyInBaseUnit else
      lips_ib.ActualDeliveredQtyInBaseUnit - lips_od.ActualDeliveredQtyInBaseUnit end as RemainQtyInBaseUnit
}

where
  (
       lips_ib.ActualDeliveredQtyInBaseUnit <> lips_od.ActualDeliveredQtyInBaseUnit
    or lips_od.ActualDeliveredQtyInBaseUnit is null
  )
  and  mseg.GoodsMovementType               =  '101'
  and  mseg.PurchaseOrder                   is not initial

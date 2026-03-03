@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post GM - Material Document Posted'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R02_A02_OUTB
  as select from I_OutboundDeliveryItem as lips
    inner join   I_OutboundDelivery     as likp on  likp.OutboundDelivery     = lips.OutboundDelivery
                                                and likp.DeliveryDocumentType = 'RLL'
{
  key lips.PurchaseOrder,
  key lips.PurchaseOrderItem,
  key likp.DeliveryDocumentBySupplier          as InboundDelivery,
      lips.BaseUnit,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      sum( lips.ActualDeliveredQtyInBaseUnit ) as ActualDeliveredQtyInBaseUnit
}
where
  lips.PurchaseOrder is not initial
group by
  lips.PurchaseOrder,
  lips.PurchaseOrderItem,
  likp.DeliveryDocumentBySupplier,
  lips.BaseUnit

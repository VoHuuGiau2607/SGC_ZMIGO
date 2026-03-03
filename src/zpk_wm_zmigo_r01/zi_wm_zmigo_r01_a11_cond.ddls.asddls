@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Purchase Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_WM_ZMIGO_R01_A11_COND
  as select distinct from I_PurchaseOrderAPI01     as ekko
    inner join            I_PurchaseOrderItemAPI01 as ekpo     on ekko.PurchaseOrder = ekpo.PurchaseOrder
    inner join            I_MaterialDocumentItem_2 as mseg     on  mseg.PurchaseOrder     = ekpo.PurchaseOrder
                                                               and mseg.PurchaseOrderItem = ekpo.PurchaseOrderItem
    left outer join       I_MaterialDocumentItem_2 as mseg_rev on  mseg.MaterialDocument     = mseg_rev.ReversedMaterialDocument
                                                               and mseg.MaterialDocumentItem = mseg_rev.ReversedMaterialDocument
                                                               and mseg.MaterialDocumentYear = mseg_rev.ReversedMaterialDocument

{
  key ekko.PurchaseOrder,
  key ekpo.PurchaseOrderItem 
}
where
      ekko.PurchasingDocumentDeletionCode is initial
  and ekpo.PurchasingDocumentDeletionCode is initial
  and ekko.PurchasingProcessingStatus     = '05'
  and ekpo.PurchaseOrderItemCategory      = '3'
  and mseg.GoodsMovementRefDocType        = 'B'
  and mseg.ReversedMaterialDocument       is initial
  and mseg_rev.MaterialDocument           is null

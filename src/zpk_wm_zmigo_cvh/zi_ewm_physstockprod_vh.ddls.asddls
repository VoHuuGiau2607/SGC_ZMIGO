@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIGO - I_EWM_PhysStockProd'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_EWM_PHYSSTOCKPROD_VH
  as select from I_EWM_PhysStockProd  as physstock
    inner join   I_EWM_AvailableStock as availstock on  physstock.StockItemUUID          = availstock.StockItemUUID
                                                    and physstock.ParentHandlingUnitUUID = availstock.ParentHandlingUnitUUID
{
  key physstock.ParentHandlingUnitUUID,
  key physstock.StockItemUUID,
      physstock.EWMWarehouse,
      physstock.Product,
      physstock.Batch,
      case physstock.StockDocumentCategory
      when 'SOS' then 'E'
      when 'PJS' then 'Q'
      else ''
      end                      as StockDocCatConv,
      cast( case physstock.StockDocumentCategory
      when 'SOS' then right(physstock.StockDocumentNumber, 10) else  ''
      end as abap.char( 10 ) ) as SalesOrder,
      cast( case physstock.StockDocumentCategory
      when 'SOS' then right(physstock.StockItemNumber, 6) else  '000000'
      end as abap.numc( 6 ) )  as SalesOrderItem,
      availstock.EWMStorageBin,
      availstock.HandlingUnitNumber
}

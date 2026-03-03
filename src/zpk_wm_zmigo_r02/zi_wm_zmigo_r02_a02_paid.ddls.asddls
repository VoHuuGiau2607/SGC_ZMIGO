@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Post GM - Material Document Posted'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZI_WM_ZMIGO_R02_A02_PAID
  as select distinct from I_MaterialDocumentItem_2 as mseg
    left outer join       C_SupplierInvoiceItemDEX as invoice     on  invoice.PrmtHbReferenceDocument       = mseg.MaterialDocument
                                                                  and invoice.PrmtHbReferenceDocumentFsclYr = mseg.MaterialDocumentYear
                                                                  and invoice.PrmtHbReferenceDocumentItem   = mseg.MaterialDocumentItem
    left outer join       C_SupplierInvoiceItemDEX as invoice_rev on  invoice_rev.SupplierInvoice = invoice.ReverseDocument
                                                                  and invoice_rev.FiscalYear      = invoice.ReverseDocumentFiscalYear
{
  key mseg.MaterialDocument,
  key mseg.MaterialDocumentYear,
  key mseg.MaterialDocumentItem
}

where
          mseg.GoodsMovementType      = '101'
  and     mseg.PurchaseOrder          is not initial
  and(
          invoice.SupplierInvoice     is null
    or(
          invoice.SupplierInvoice     is not null
      and invoice_rev.SupplierInvoice is not null
    )
  )

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
define view entity ZI_WM_ZMIGO_R02_A10_POSTED
  as select from    I_MaterialDocumentItem_2   as MSEG
    left outer join ZI_WM_ZMIGO_R02_A10_INB    as LIPS_315 on  LIPS_315.YY1_Matdoc313_Year_DLI = MSEG.MaterialDocumentYear
                                                           and LIPS_315.YY1_Matdoc313_DLI      = MSEG.MaterialDocument
                                                           and LIPS_315.YY1_Matdoc313_Item_DLI = MSEG.MaterialDocumentItem
    left outer join ZI_WM_ZMIGO_R02_A10_MATDOC as MSEG_315 on  MSEG_315.YY1_Matdoc313_Year_MMI = MSEG.MaterialDocumentYear
                                                           and MSEG_315.YY1_Matdoc313_MMI      = MSEG.MaterialDocument
                                                           and MSEG_315.YY1_Matdoc313_Item_MMI = MSEG.MaterialDocumentItem
{
  key MSEG.MaterialDocumentYear,
  key MSEG.MaterialDocument,
  key MSEG.MaterialDocumentItem,
      MSEG.MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(
      case
        when LIPS_315.YY1_Matdoc313_Year_DLI is not null
        then LIPS_315.ActualDeliveredQtyInBaseUnit
        else cast( 0 as abap.quan( 13, 3 ) )
      end
      +
      case
        when MSEG_315.YY1_Matdoc313_Year_MMI is not null
        then MSEG_315.QuantityInBaseUnit
        else cast( 0 as abap.quan( 13, 3 ) )
      end ) as PostedQty315
}
group by
  MSEG.MaterialDocumentYear,
  MSEG.MaterialDocument,
  MSEG.MaterialDocumentItem,
  MSEG.MaterialBaseUnit

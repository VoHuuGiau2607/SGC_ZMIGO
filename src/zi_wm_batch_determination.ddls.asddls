@EndUserText.label: 'Batch Determination'
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_WM_ZMIGO_CUSTOM_ENTITY'
    }
}
define custom entity ZI_WM_BATCH_DETERMINATION
  with parameters
    Type                      : zde_wm_zmigo_bd_type,
    Material                  : matnr,
    Plant                     : werks_d,
    StorageLocation           : lgort_d,
    InventorySpecialStockType : sobkz,
    SalesOrder                : vbeln_va,
    SalesOrderItem            : posnr_va,
    Supplier                  : lifnr,
    EntryDate                 : zde_wm_zmigo_bd_entry_date,
    EntryUnit                 : zde_wm_zmigo_bd_entry_unit,
    EntryQuantity             : zde_wm_zmigo_bd_entry_qty
{
  key ExpirationDate      : abap.dats;
  key Batch               : charg_d;
  key Unit                : zde_wm_zmigo_bd_entry_unit;
      @Semantics.quantity.unitOfMeasure : 'Unit'
      AvailableQuantity   : zde_wm_zmigo_bd_entry_qty;
      @Semantics.quantity.unitOfMeasure : 'Unit'
      SplitQuantity       : zde_wm_zmigo_bd_entry_qty;
      UnitNumberOfDecimal : abap.int2(5);
}

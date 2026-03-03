@EndUserText.label: 'Post Goods Movement - Filter'

@ObjectModel.query.implementedBy: 'ABAP:ZCL_WM_ZMIGO_FILTER'

@UI.headerInfo: {
    typeName: 'Post Goods Movements',
    typeNamePlural: 'Post Goods Movements',
    title: {
        type: #STANDARD,
        label: 'Post Goods Movements'
    }
}

define custom entity ZI_WM_ZMIGO_FILTER
  with parameters
    @Consumption.valueHelpDefinition: [{
        entity: {
            name           : 'ZI_WM_ZMIGO_ACTION_VH',
            element        : 'Action'
        }
    }]
    P_Action : zde_wm_zmigo_action,
    @Consumption.valueHelpDefinition: [{
        entity: {
            name           : 'ZI_WM_ZMIGO_REFER_VH',
            element        : 'Reference'
        },
          additionalBinding: [{
            localParameter : 'P_Action',
            element        : 'Action'
          }]
    }]
    P_Refer  : zde_wm_zmigo_refer
{
      @Consumption.filter  : { multipleSelections: false, selectionType: #SINGLE }
      @UI.selectionField   : [{ position: 1 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZCORE_I_PURCHASEORDER_CVH',
              element      : 'PurchaseOrder'
          }
      }]
  key PurchaseOrder        : ebeln;
      @Consumption.filter  : { multipleSelections: false, selectionType: #SINGLE }
      @UI.selectionField   : [{ position: 2 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZCORE_I_MATERIALDOCUMENT_CVH',
              element      : 'MaterialDocument'
          },
          additionalBinding: [{
            localElement   : 'MaterialDocumentYear',
            element        : 'MaterialDocumentYear'
          }]
      }]
  key MaterialDocument     : mblnr;
      @Consumption.filter  : { multipleSelections: false, selectionType: #SINGLE }
      @UI.selectionField   : [{ position: 3 }]
  key MaterialDocumentYear : mjahr;
      @Consumption.filter  : { multipleSelections: false, selectionType: #SINGLE }
      @UI.selectionField   : [{ position: 4 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZCORE_I_INBOUNDDELIVERY_CVH',
              element      : 'InboundDelivery'
          }
      }]
      @EndUserText.label   : 'Inbound Delivery'
  key InboundDelivery      : vbeln_vl;
      @Consumption.filter  : { multipleSelections: false, selectionType: #SINGLE }
      @UI.selectionField   : [{ position: 5 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZCORE_I_OUTBOUNDDELIVERY_CVH_2',
              element      : 'OutboundDelivery'
          }
      }]
      @EndUserText.label   : 'Outbound Delivery'
  key OutboundDelivery     : vbeln;
      @Consumption.filter  : { multipleSelections: false, selectionType: #SINGLE }
      @UI.selectionField   : [{ position: 6 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_MfgOrderStdVH',
              element      : 'ManufacturingOrder'
          }
      }]
  key ManufacturingOrder   : aufnr;
      @Consumption.filter  : { multipleSelections: false, selectionType: #SINGLE }
      @UI.selectionField   : [{ position: 7 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_WM_RESERVATION_VH',
              element      : 'Reservation'
          }
      }]
  key Reservation          : rsnum;
      @Consumption.filter.selectionType: #INTERVAL
      @UI.selectionField   : [{ position: 9 }]
      @UI.lineItem         : [{ position: 1 }]
      CreationDate         : aedat;
      @UI.selectionField   : [{ position: 10 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_WM_ZMIGO_SLOC_CVH',
              element      : 'StorageLocation'
          }
      }]
      StorageLocation      : lgort_d;
      @UI.selectionField   : [{ position: 11 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_WM_ZMIGO_FACTORY_VH',
              element      : 'FactoryId'
          }
      }]
      @EndUserText.label   : 'ID Xưởng/Nhà máy'
      FactoryId            : zde_wm_factory_id;
      @Consumption.filter.selectionType: #INTERVAL
      @UI.selectionField   : [{ position: 12 }]
      @EndUserText.label   : 'Delivery Date'
      DeliveryDate         : abap.dats;
      @UI.selectionField   : [{ position: 13 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductStdVH',
              element      : 'Product'
          }
      }]
      Material             : matnr;
      @UI.selectionField   : [{ position: 14 }]
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_BatchStdVH',
              element      : 'Batch'
          },
          additionalBinding: [{
            element        : 'Material',
            localElement   : 'Material'
          },{
            element        : 'Plant',
            localConstant  : ''
          }]
      }]
      Batch                : charg_d;
}

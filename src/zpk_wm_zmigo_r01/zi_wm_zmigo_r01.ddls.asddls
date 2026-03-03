@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Purchase Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZI_WM_ZMIGO_R01
  with parameters
    @Consumption.valueHelpDefinition: [{
        entity: {
            name           : 'ZI_WM_ZMIGO_ACTION_VH',
            element        : 'Action'
        }
    }]
    P_Action : zde_wm_zmigo_action
  as select from    I_PurchaseOrderAPI01           as ekko
    inner join      I_PurchaseOrderItemAPI01       as ekpo            on ekko.PurchaseOrder = ekpo.PurchaseOrder
    inner join      ZI_WM_ZMIGO_SLOC_AUTH          as Auth            on  Auth.Plant           = ekpo.Plant
                                                                      and Auth.StorageLocation = ekpo.StorageLocation
                                                                      and Auth.UserID          = $session.user
    left outer join I_PurchasingDocumentTypeText   as t161t           on  t161t.PurchasingDocumentType     = ekko.PurchaseOrderType
                                                                      and t161t.PurchasingDocumentCategory = ekpo.PurchaseOrderCategory
                                                                      and t161t.Language                   = $session.system_language
    left outer join I_PurOrdScheduleLineAPI01      as eket            on  ekpo.PurchaseOrder     = eket.PurchaseOrder
                                                                      and ekpo.PurchaseOrderItem = eket.PurchaseOrderItem
    left outer join I_POSubcontractingCompAPI01    as comp            on  eket.PurchaseOrder             = comp.PurchaseOrder
                                                                      and eket.PurchaseOrderItem         = comp.PurchaseOrderItem
                                                                      and eket.PurchaseOrderScheduleLine = comp.PurchaseOrderScheduleLine
    left outer join I_PurOrdAccountAssignmentAPI01 as ekkn            on  ekpo.PurchaseOrder     = ekkn.PurchaseOrder
                                                                      and ekpo.PurchaseOrderItem = ekkn.PurchaseOrderItem
    left outer join I_ProductText                  as comp_makt       on  comp_makt.Product  = comp.Material
                                                                      and comp_makt.Language = $session.system_language
    left outer join ZIM_C_CLFOCVDEX                as Character_Z_LOT on  Character_Z_LOT.Matnr          = comp.Material
                                                                      and Character_Z_LOT.Batch          = comp.Batch
                                                                      and Character_Z_LOT.Characteristic = 'Z_LOT'
    left outer join I_Plant                        as t001w           on ekpo.Plant = t001w.Plant
    left outer join I_StorageLocation              as t001l           on  ekpo.Plant           = t001l.Plant
                                                                      and ekpo.StorageLocation = t001l.StorageLocation
    left outer join ZCORE_I_PROFILE_SUPPLIER                          on ekko.Supplier = ZCORE_I_PROFILE_SUPPLIER.Supplier
    left outer join I_User                                            on I_User.UserID = ekko.CreatedByUser
    left outer join I_BusinessPartner                                 on I_User.BusinessPartnerUUID = I_BusinessPartner.BusinessPartnerUUID
    left outer join ZI_WM_ZMIGO_R01_A11_COND       as A11Cond         on  ekpo.PurchaseOrder     = A11Cond.PurchaseOrder
                                                                      and ekpo.PurchaseOrderItem = A11Cond.PurchaseOrderItem
    left outer join I_UnitOfMeasure                                   on ekpo.PurchaseOrderQuantityUnit = I_UnitOfMeasure.UnitOfMeasure
    left outer join I_UnitOfMeasure                as UoMComponent    on comp.BaseUnit = UoMComponent.UnitOfMeasure
    left outer join ZI_WM_ZMIGO_R01_POSTED         as Posted          on  ekpo.PurchaseOrder             = Posted.PurchaseOrder
                                                                      and ekpo.PurchaseOrderItem         = Posted.PurchaseOrderItem
                                                                      and ekpo.PurchaseOrderQuantityUnit = Posted.EntryUnit
{
  key ekko.PurchaseOrder,
  key ekpo.PurchaseOrderItem,
  key case when eket.PurchaseOrderScheduleLine is null then '0000' else eket.PurchaseOrderScheduleLine end as PurchaseOrderScheduleLine,
  key case when comp.ReservationItem is null then '0000' else comp.ReservationItem end                     as ReservationItem,
  key case when comp.RecordType is null then '' else comp.RecordType end                                   as RecordType,
  key case when ekkn.AccountAssignmentNumber is null then '00' else ekkn.AccountAssignmentNumber end       as AccountAssignmentNumber,
      @ObjectModel.text.element: [ 'PurchasingDocumentTypeName' ]
      ekko.PurchaseOrderType,
      @UI.hidden: true
      t161t.PurchasingDocumentTypeName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_PlantStdVH',
              element      : 'Plant'
          }
      }]
      @ObjectModel.text.element: [ 'PlantName' ]
      ekpo.Plant,
      t001w.PlantName,
      cast( case ekpo.AccountAssignmentCategory
      when 'K' then ' '
      when 'A' then ' '
      when 'P' then ' '
      else case when $parameters.P_Action = 'A11' then ' ' else 'X' end
      end as abap_boolean )                                                                                as IsAllowEditStorageLocation,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'ZI_WM_ZMIGO_SLOC_CVH',
              element      : 'StorageLocation'
          },
          additionalBinding: [{
            localElement   : 'Plant',
            element        : 'Plant'
          }]
      }]
      @ObjectModel.text.element: [ 'StorageLocationName' ]
      ekpo.StorageLocation,
      t001l.StorageLocationName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductStdVH',
              element      : 'Product'
          }
      }]
      ekpo.Material,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(100))                                                                           as MaterialDescription,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_BatchStdVH',
              element      : 'Batch'
          },
          additionalBinding: [{
            localElement   : 'Material',
            element        : 'Material'
          }]
      }]
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast( '' as charg_d )                                                                                as Batch,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductUnitsOfMeasure',
              element      : 'AlternativeUnit'
          },
          additionalBinding: [{
            localElement   : 'Material',
            element        : 'Product'
          }]
      }]
      @EndUserText.label: 'Unit'
      ekpo.PurchaseOrderQuantityUnit                                                                       as UnitofMeasure,
      I_UnitOfMeasure.UnitOfMeasureNumberOfDecimals                                                        as UnitNumberOfDecimal,
      @Semantics.quantity.unitOfMeasure: 'UnitofMeasure'
      @UI.hidden: true
      ekpo.OrderQuantity                                                                                   as Quantity,
      @Semantics.quantity.unitOfMeasure: 'UnitofMeasure'
      @UI.hidden: true
      Posted.PostedQuantity                                                                                as PostedQuantity,
      @Semantics.quantity.unitOfMeasure: 'UnitofMeasure'
      @EndUserText.label: 'Quantity'
      case
      when Posted.PostedQuantity is null then ekpo.OrderQuantity
      when $parameters.P_Action = 'A11' then ekpo.OrderQuantity
      else ekpo.OrderQuantity - Posted.PostedQuantity
      end                                                                                                  as RemainingQuantity,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductGroup_2',
              element      : 'ProductGroup'
          }
      }]
      ekpo.MaterialGroup,
      cast( case when ekpo.PurchaseOrderItemCategory = '3' then 'X' else ' ' end  as abap_boolean)         as IsAllowEditComponent,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductStdVH',
              element      : 'Product'
          }
      }]
      comp.Material                                                                                        as Component,
      comp_makt.ProductName                                                                                as ComponentName,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_ProductUnitsOfMeasure',
              element      : 'AlternativeUnit'
          },
          additionalBinding: [{
            localElement   : 'Component',
            element        : 'Product'
          }]
      }]
      comp.BaseUnit                                                                                        as ComponentUoM,
      UoMComponent.UnitOfMeasureNumberOfDecimals                                                           as ComponentUnitNumberOfDecimal,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_BatchStdVH',
              element      : 'Batch'
          },
          additionalBinding: [{
            localElement   : 'Component',
            element        : 'Material'
          }]
      }]
      comp.Batch                                                                                           as ComponentBatch,
      Character_Z_LOT.CharcValue                                                                           as ComponentLotNum,
      @Semantics.quantity.unitOfMeasure: 'ComponentUoM'
      comp.RequiredQuantity                                                                                as ComponentQuantity,
      @Consumption.valueHelpDefinition: [{
          entity           : {
              name         : 'I_Supplier',
              element      : 'Supplier'
          }
      }]
      ekko.Supplier,
      ZCORE_I_PROFILE_SUPPLIER.SupplierFullName,
      ekpo.AccountAssignmentCategory,
      case ekpo.AccountAssignmentCategory
      when 'A' then ekkn.MasterFixedAsset
      else ''
      end                                                                                                  as Asset,
      case ekpo.AccountAssignmentCategory
      when 'K' then ekkn.CostCenter
      else ''
      end                                                                                                  as CostCenter,
      case ekpo.AccountAssignmentCategory
      when 'K' then ekkn.GLAccount
      when 'A' then ekkn.GLAccount
      when 'P' then ekkn.GLAccount
      else ''
      end                                                                                                  as GLAccount,
      case ekpo.AccountAssignmentCategory
      when 'P' then ekkn.WBSElementInternalID_2
      else '00000000'
      end                                                                                                  as WBSElementInternal,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(24))                                                                            as WBSElementExternal,
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_WM_ZMIGO_VE'
      cast('' as abap.char(100))                                                                           as HeaderText,
      case when ekko.YY1_Nguoilapphieu_PDH is initial or ekko.YY1_Nguoilapphieu_PDH is null
        then I_BusinessPartner.PersonFullName
        else ekko.YY1_Nguoilapphieu_PDH
      end                                                                                                  as NguoiMuaHang,
      ekko.CreationDate
}
where
           ekko.PurchasingDocumentDeletionCode is initial
  and      ekpo.PurchasingDocumentDeletionCode is initial
  and      ekko.PurchasingProcessingStatus     = '05'
  and(
    (
           $parameters.P_Action                = 'A01'
      and(
           ekpo.AccountAssignmentCategory      = 'K'
        or ekpo.AccountAssignmentCategory      = 'A'
        or ekpo.AccountAssignmentCategory      = 'P'
      )
      and  ekpo.IsCompletelyDelivered          is initial
      and  ekpo.SupplierConfirmationControlKey is initial

    )
    or(
           $parameters.P_Action                = 'A08'
      and  ekpo.PurchaseOrderItemCategory      = '3'
      and  ekpo.IsCompletelyDelivered          is initial
    )
    or(
           $parameters.P_Action                = 'A11'
      and  ekpo.PurchaseOrderItemCategory      = '3'
      and  A11Cond.PurchaseOrderItem           is not initial
    )
  )

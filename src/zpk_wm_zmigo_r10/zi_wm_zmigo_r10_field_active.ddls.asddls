@AbapCatalog.viewEnhancementCategory: [ #NONE ]

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Post Goods Movement - Material Stock'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.usageType: { serviceQuality: #X, sizeCategory: #S, dataClass: #MIXED }

define view entity ZI_WM_ZMIGO_R10_FIELD_ACTIVE
  as select from    I_Product

    left outer join I_ClfnObjectClass            as ObjectClass               on  ObjectClass.ClfnObjectID    = I_Product.Product
                                                                              and ObjectClass.ClfnObjectTable = 'MARA'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOT      on  ClassCharacter_Z_LOT.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_LOT.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_LOT.Characteristic  = 'Z_LOT'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GHICHU   on  ClassCharacter_Z_GHICHU.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GHICHU.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GHICHU.Characteristic  = 'Z_GHICHU'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GCQC     on  ClassCharacter_Z_GCQC.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GCQC.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GCQC.Characteristic  = 'Z_GCQC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSX      on  ClassCharacter_Z_NSX.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NSX.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NSX.Characteristic  = 'Z_NSX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSD      on  ClassCharacter_Z_HSD.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_HSD.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_HSD.Characteristic  = 'LOBM_VFDAT'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NG       on  ClassCharacter_Z_NG.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NG.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NG.Characteristic  = 'Z_NG'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GRD      on  ClassCharacter_Z_GRD.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GRD.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GRD.Characteristic  = 'Z_GRD'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NCC      on  ClassCharacter_Z_NCC.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NCC.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NCC.Characteristic  = 'Z_NCC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHASX    on  ClassCharacter_Z_NHASX.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NHASX.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NHASX.Characteristic  = 'Z_NHASX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NSXNB    on  ClassCharacter_Z_NSXNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NSXNB.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NSXNB.Characteristic  = 'Z_NSXNB'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_HSDNB    on  ClassCharacter_Z_HSDNB.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_HSDNB.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_HSDNB.Characteristic  = 'Z_HSDNB'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_MTX      on  ClassCharacter_Z_MTX.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_MTX.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_MTX.Characteristic  = 'Z_MTX'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_QCBG     on  ClassCharacter_Z_QCBG.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_QCBG.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_QCBG.Characteristic  = 'Z_QCBG'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_PC       on  ClassCharacter_Z_PC.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_PC.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_PC.Characteristic  = 'Z_PC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_NHC      on  ClassCharacter_Z_NHC.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_NHC.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_NHC.Characteristic  = 'Z_NHC'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_LOCATION on  ClassCharacter_Z_LOCATION.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_LOCATION.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_LOCATION.Characteristic  = 'Z_LOCATION'

    left outer join ZCORE_I_BATCH_CLASSIFICATION as ClassCharacter_Z_GW       on  ClassCharacter_Z_GW.ClassInternalID = ObjectClass.ClassInternalID
                                                                              and ClassCharacter_Z_GW.ValidityEndDate >= $session.system_date
                                                                              and ClassCharacter_Z_GW.Characteristic  = 'Z_GW'

{
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ProductStdVH', element: 'Product' } } ]
  key I_Product.Product,

      cast(case when ClassCharacter_Z_LOT.ClassInternalID is null then ''
                else 'X' end as abap_boolean)  as LotNumActive,

      cast(case when ClassCharacter_Z_GHICHU.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as BatchNoteActive,

      cast(case when ClassCharacter_Z_GCQC.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as QCNoteActive,

      cast(case when ClassCharacter_Z_NSX.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as ProductionDateActive,

      cast(case when ClassCharacter_Z_HSD.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as ExpirationDateActive,

      cast(case when ClassCharacter_Z_NG.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as OriginActive,

      cast(case when ClassCharacter_Z_GRD.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as GoodsReceiptDateActive,

      cast(case when ClassCharacter_Z_NCC.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as BatchSupplierActive,

      cast(case when ClassCharacter_Z_NHASX.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as ManufacturerActive,

      cast(case when ClassCharacter_Z_NSXNB.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as ProductionDateInternalActive,

      cast(case when ClassCharacter_Z_HSDNB.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as ExpirationDateInternalActive,

      cast(case when ClassCharacter_Z_MTX.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as AccessCodeActive,

      cast(case when ClassCharacter_Z_QCBG.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as PackagingSpecActive,

      cast(case when ClassCharacter_Z_PC.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as ProfitCenterActive,

      cast(case when ClassCharacter_Z_NHC.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as CalibrationLocationActive,

      cast(case when ClassCharacter_Z_LOCATION.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as WhereToUseActive,

      cast(case when ClassCharacter_Z_GW.ClassInternalID is null then ''
                 else 'X' end as abap_boolean) as GrossWeightActive
}

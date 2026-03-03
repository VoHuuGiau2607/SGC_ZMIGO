@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Post Goods Movement - Inbound Delivery'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
} 
define view entity ZI_WM_ZMIGO_R04_AUTH
  as select distinct from ZI_WM_ZMIGO_SLOC_AUTH as Auth
    inner join            ztb_wm_cf_slo_wm      as Addr on  Auth.Plant           = Addr.plant
                                                        and Auth.StorageLocation = Addr.storage_location
{
  key Addr.address_id as AddressID
}
where
  Auth.UserID = $session.user;

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Profit Center - Characteristic'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_WM_ZMIGO_BATCH_PC
  as select from    ZCORE_I_BATCH_CHARACTERISTIC as Character_Z_PC
    left outer join I_ProfitCenter               as ProfitCenter on  ProfitCenter.ProfitCenter      = Character_Z_PC.CharcValue
                                                                 and ProfitCenter.ControllingArea   = 'A000'
                                                                 and ProfitCenter.ValidityEndDate   >= $session.system_date
                                                                 and ProfitCenter.ValidityStartDate <= $session.system_date
{
  key Character_Z_PC.Product,
  key Character_Z_PC.Batch,
      Character_Z_PC.CharcInternalID,
      case when ProfitCenter.ProfitCenter is null
      then concat( '000000', cast( Character_Z_PC.CharcValue as abap.char(4)))
      else ProfitCenter.ProfitCenter
      end as ProfitCenter
}
where
  Character_Z_PC.Characteristic = 'Z_PC'

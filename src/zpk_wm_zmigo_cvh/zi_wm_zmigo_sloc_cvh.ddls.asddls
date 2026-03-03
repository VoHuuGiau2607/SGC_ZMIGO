@VDM.viewType: #BASIC

@ObjectModel.dataCategory: #VALUE_HELP

@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE,
                                     #CDS_MODELING_DATA_SOURCE,
                                     #CDS_MODELING_ASSOCIATION_TARGET,
                                     #VALUE_HELP_PROVIDER,
                                     #SEARCHABLE_ENTITY]
@ObjectModel.modelingPattern:#NONE
@ObjectModel.usageType.serviceQuality: #B
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER

@AccessControl.authorizationCheck: #CHECK

@Search.searchable: true

@Metadata.ignorePropagatedAnnotations: true

@EndUserText.label: 'Post GM - Storage Location - CVH'
@Consumption.ranked: true
@Consumption.dbHints: [ 'USE_HEX_PLAN' ]
define view entity ZI_WM_ZMIGO_SLOC_CVH
  as select from I_StorageLocation
    inner join   I_Plant                       on I_StorageLocation.Plant = I_Plant.Plant
    inner join   ZI_WM_ZMIGO_SLOC_AUTH as Auth on  Auth.Plant           = I_StorageLocation.Plant
                                               and Auth.StorageLocation = I_StorageLocation.StorageLocation
                                               and Auth.UserID          = $session.user
{
      @ObjectModel.text.element: ['PlantName']
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #LOW
      @Consumption.valueHelpDefinition: [
        {
          entity:
            { name: 'I_PlantStdVH',
              element: 'Plant'
            }
        }
        ]
      @UI.lineItem:[{position:30}]
      @Consumption.valueHelpDefault.binding.usage: #FILTER_AND_RESULT
  key I_StorageLocation.Plant,

      @ObjectModel.text.element: ['StorageLocationName']
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @UI.lineItem:[{position:10}]
      @Consumption.valueHelpDefault.binding.usage: #FILTER_AND_RESULT
  key I_StorageLocation.StorageLocation,

      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #LOW
      @UI.lineItem:[{position:20}]
      I_StorageLocation.StorageLocationName,
      @UI.hidden: true
      I_Plant.PlantName
}

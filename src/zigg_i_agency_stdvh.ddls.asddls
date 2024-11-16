@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Agency ValueHelp'
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZIGG_I_AGENCY_STDVH
  as select from /DMO/I_Agency as Agency
{
      @ObjectModel.text.element: ['Name']
  key AgencyID,
      Name
}

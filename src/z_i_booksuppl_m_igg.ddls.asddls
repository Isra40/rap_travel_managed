@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_I_BookSuppl_M_IGG
  as select from zbooksuppl_m_igg as BookingSupplement
  association        to parent Z_I_BOOKING_M_IGG as _Booking        on  $projection.travel_id  = _Booking.travel_id
                                                                    and $projection.booking_id = _Booking.booking_id
  association [1..1] to Z_I_TRAVEL_M_IGG         as _Travel         on  $projection.travel_id = _Travel.travel_id
  association [1..1] to /DMO/I_Supplement        as _Product        on  $projection.supplement_id = _Product.SupplementID
  association [1..*] to /DMO/I_SupplementText    as _SupplementText on  $projection.supplement_id = _SupplementText.SupplementID
{
  key travel_id,
  key booking_id,
  key booking_supplement_id,
      supplement_id,
      @Semantics.amount.currencyCode: 'currency_code'
      price,
      currency_code,
      //local ETag field --> OData ETag
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,

      /* Associations */
      _Booking,
      _Travel,
      _Product,
      _SupplementText
}

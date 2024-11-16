@EndUserText.label: 'Booking projection view'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity Z_C_Booking_Approver_M_IGG
  as projection on Z_I_BOOKING_M_IGG
{
  key travel_id                 as TravelID,
  key booking_id                as BookingID,
      booking_date              as BookingDate,
      customer_id               as CustomerID,
      _Customer.LastName        as CustomerName,
      carrier_id                as CarrierID,
      _Carrier.Name             as CarrierName,
      connection_id             as ConnectionID,
      flight_date               as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price              as FlightPrice,
      currency_code             as CurrencyCode,
      booking_status            as BookingStatus,

      @UI.hidden: true
      _BookingStatus._Text.Text as BookingStatusText : localized,

      /* Admininstrative fields */
      @UI.hidden: true
      last_changed_at           as LastChangedAt,

      /* Associations */
      _Travel : redirected to parent Z_C_Travel_Approver_M_IGG,
      _Customer,
      _Carrier,
      _BookingStatus
}

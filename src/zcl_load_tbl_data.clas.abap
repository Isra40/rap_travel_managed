CLASS zcl_load_tbl_data DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS zcl_load_tbl_data IMPLEMENTATION.

 METHOD if_oo_adt_classrun~main.

    data it_hub type STANDARD TABLE OF zigg_hub.
    data it_market type STANDARD TABLE OF zigg_market.

    out->write( 'Starting Data Generation' ) ##NO_TEXT.
    out->write( 'Initializing Z Tables' ) ##NO_TEXT.
    DELETE FROM zigg_hub.
    DELETE FROM zigg_market.

    it_hub = VALUE #( ( hubcode = 'H001' hubtxt  = 'Hub 001')
                      ( hubcode = 'H002' hubtxt  = 'Hub 002')
                      ( hubcode = 'H003' hubtxt  = 'Hub 003')
                      ( hubcode = 'H004' hubtxt  = 'Hub 004') ).

    it_market = VALUE #( ( hubcode = 'H001' market = 'ES' market_txt = 'Market_ES' )
                         ( hubcode = 'H001' market = 'PT' market_txt = 'Market_PT' )
                         ( hubcode = 'H002' market = 'IE' market_txt = 'Market_IE' )
                         ( hubcode = 'H003' market = 'IT' market_txt = 'Market_IT' ) ).

    INSERT zigg_hub FROM TABLE @it_hub.
    INSERT zigg_market FROM TABLE @it_market.

    data(lv_hub_lines) = lines( it_hub ).
    data(lv_market_lines) = lines( it_market ).

    out->write( |Z Hub Entries: { lv_hub_lines }| ).
    out->write( |Z Market Entries: { lv_market_lines }| ).

    out->write( 'Finished Data Generation' ) ##NO_TEXT.
  ENDMETHOD.

ENDCLASS.

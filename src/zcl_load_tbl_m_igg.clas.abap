CLASS zcl_load_tbl_m_igg DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_load_tbl_m_igg IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    data it_travel type STANDARD TABLE OF ztravel_m_igg.
    data it_booking type STANDARD TABLE OF zbooking_m_igg.
    data it_book_suppl type STANDARD TABLE OF zbooksuppl_m_igg.

    out->write( 'Starting Data Generation' ) ##NO_TEXT.
    out->write( 'Initializing Travel Tables' ) ##NO_TEXT.
    DELETE FROM ztravel_m_igg.
    DELETE FROM zbooking_m_igg.
    DELETE FROM zbooksuppl_m_igg.

    out->write( 'Reading Travel /DMO/ data' ) ##NO_TEXT.
    SELECT * FROM /dmo/travel
      INTO CORRESPONDING FIELDS OF TABLE @it_travel.

    SELECT * FROM /dmo/booking
           INTO CORRESPONDING FIELDS OF TABLE @it_booking.

    SELECT * FROM /dmo/book_suppl
           INTO CORRESPONDING FIELDS OF TABLE @it_book_suppl.

    describe table it_travel lines data(lv_travel_read_lines).
    describe table it_booking lines data(lv_booking_read_lines).
    describe table it_book_suppl lines data(lv_book_suppl_read_lines).

    out->write( |/DMO/Travel Entries: { lv_travel_read_lines }| ).
    out->write( |/DMO/Booking Entries: { lv_booking_read_lines }| ).
    out->write( |/DMO/Supplement Entries: { lv_book_suppl_read_lines }| ).

    LOOP AT it_travel ASSIGNING FIELD-SYMBOL(<fs_travel>).

      DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
      DATA(lv_time) = cl_abap_context_info=>get_system_time( ).

      CONVERT DATE lv_date
              TIME lv_time
              INTO TIME STAMP DATA(lv_time_stamp) TIME ZONE 'UTC'.

      <fs_travel>-created_by      = cl_abap_context_info=>get_user_alias( ).

      <fs_travel>-created_at      = lv_time_stamp.
      <fs_travel>-last_changed_by = cl_abap_context_info=>get_user_alias( ).
      <fs_travel>-last_changed_at = lv_time_stamp.
      MODIFY ztravel_m_igg FROM <fs_travel>.

    ENDLOOP.

    LOOP AT it_booking ASSIGNING FIELD-SYMBOL(<fs_booking>).

      lv_date = cl_abap_context_info=>get_system_date( ).
      lv_time = cl_abap_context_info=>get_system_time( ).

      CONVERT DATE lv_date
              TIME lv_time
              INTO TIME STAMP lv_time_stamp TIME ZONE 'UTC'.

      <fs_booking>-last_changed_at = lv_time_stamp.
      MODIFY zbooking_m_igg FROM <fs_booking>.

    ENDLOOP.

    LOOP AT it_book_suppl ASSIGNING FIELD-SYMBOL(<fs_book_suppl>).

      lv_date = cl_abap_context_info=>get_system_date( ).
      lv_time = cl_abap_context_info=>get_system_time( ).

      CONVERT DATE lv_date
              TIME lv_time
              INTO TIME STAMP lv_time_stamp TIME ZONE 'UTC'.

      <fs_book_suppl>-last_changed_at = lv_time_stamp.
      MODIFY zbooksuppl_m_igg FROM <fs_book_suppl>.

    ENDLOOP.

    refresh it_travel[].
    refresh it_booking[].
    refresh it_book_suppl[].

    SELECT * FROM ztravel_m_igg
      INTO CORRESPONDING FIELDS OF TABLE @it_travel.

    SELECT * FROM zbooking_m_igg
      INTO CORRESPONDING FIELDS OF TABLE @it_booking.

    SELECT * FROM zbooksuppl_m_igg
      INTO CORRESPONDING FIELDS OF TABLE @it_book_suppl.

    describe table it_travel lines lv_travel_read_lines.
    describe table it_booking lines lv_booking_read_lines.
    describe table it_book_suppl lines lv_book_suppl_read_lines.

    out->write( |Z Travel Entries: { lv_travel_read_lines }| ).
    out->write( |Z Booking Entries: { lv_booking_read_lines }| ).
    out->write( |Z Supplement Entries: { lv_book_suppl_read_lines }| ).

    out->write( 'Finished Data Generation' ) ##NO_TEXT.
  ENDMETHOD.
ENDCLASS.

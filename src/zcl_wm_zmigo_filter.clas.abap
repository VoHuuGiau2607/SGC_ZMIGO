CLASS zcl_wm_zmigo_filter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WM_ZMIGO_FILTER IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA: lt_data_response TYPE TABLE OF zi_wm_zmigo_filter.

    " get list field requested ----------------------
    DATA(lt_reqs_element) = io_request->get_requested_elements( ).
    DATA(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).
    IF lt_aggr_element IS NOT INITIAL.
      LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<lfs_aggr_elements>).
        DELETE lt_reqs_element WHERE table_line = <lfs_aggr_elements>-result_element.
        DATA(lv_aggr) = |{ <lfs_aggr_elements>-aggregation_method }( { <lfs_aggr_elements>-input_element } ) as { <lfs_aggr_elements>-result_element }|.
        APPEND lv_aggr TO lt_reqs_element.
      ENDLOOP.
    ENDIF.

    DATA(lv_reqs_element) = concat_lines_of( table = lt_reqs_element sep = `, ` ).
    " get list field requested ----------------------

    " get list field ordered ------------------------
    DATA(lt_sort) = io_request->get_sort_elements( ).

    DATA(lt_sort_criteria) = VALUE string_table( FOR ls_sort IN lt_sort ( ls_sort-element_name && COND #( WHEN ls_sort-descending = abap_true THEN ` descending`
                                                                                                                                              ELSE ` ascending` ) ) ).

    DATA(lv_sort_element) = COND #( WHEN lt_sort_criteria IS INITIAL THEN `CreationDate` ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
    " get list field ordered ------------------------

    " get range of row data -------------------------
    DATA(lv_top)      = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)     = io_request->get_paging( )->get_offset( ).
    DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0
                                ELSE lv_top ).
    IF lv_max_rows = -1 .
      lv_max_rows = 1.
    ENDIF.
    " get range of row data -------------------------

    DATA: lt_data TYPE TABLE OF zi_wm_zmigo_filter.

    SELECT (lv_reqs_element)
        FROM @lt_data AS data
        ORDER BY (lv_sort_element)
        INTO CORRESPONDING FIELDS OF TABLE @lt_data_response
        OFFSET @lv_skip UP TO @lv_max_rows ROWS.
    "get data --------------------------------------

    " response data ---------------------------------
    IF io_request->is_data_requested( ).
      io_response->set_data( lt_data_response ).
    ENDIF.
    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( lines( lt_data ) ).
    ENDIF.
    " response data ---------------------------------
  ENDMETHOD.
ENDCLASS.

CLASS zcl_wm_zmigo_custom_entity DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
    TYPES: tt_data_bd    TYPE TABLE OF zi_wm_batch_determination.

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS get_data_bd
      IMPORTING
        io_request TYPE REF TO if_rap_query_request
      EXPORTING
        et_data    TYPE tt_data_bd.
ENDCLASS.



CLASS ZCL_WM_ZMIGO_CUSTOM_ENTITY IMPLEMENTATION.


  METHOD get_data_bd.
    DATA: lv_where      TYPE string,
          lv_type       TYPE c LENGTH 1,
          lv_entry_date TYPE dats,
          lv_entry_unit TYPE meins,
          lv_entry_quan TYPE p LENGTH 16 DECIMALS 3.

    " get parameter -----------------------
    DATA(lt_param) = io_request->get_parameters( ).
    LOOP AT lt_param INTO DATA(ls_param).
      CASE ls_param-parameter_name.
        WHEN 'TYPE'.
          lv_type       = ls_param-value.
          CONTINUE.
        WHEN 'ENTRYDATE'.
          lv_entry_date = ls_param-value.
          CONTINUE.
        WHEN 'ENTRYUNIT'.
          lv_entry_unit = ls_param-value.
          CONTINUE.
        WHEN 'ENTRYQUANTITY'.
          lv_entry_quan = ls_param-value.
          CONTINUE.
        WHEN 'MATERIAL'.
          ls_param-parameter_name = 'MATERIAL'.
        WHEN 'PLANT'.
          ls_param-parameter_name = 'PLANT'.
        WHEN 'STORAGELOCATION'.
          ls_param-parameter_name = 'STORAGELOCATION'.
        WHEN 'INVENTORYSPECIALSTOCKTYPE'.
          ls_param-parameter_name = 'INVENTORYSPECIALSTOCKTYPE'.
        WHEN 'SALESORDER'.
          ls_param-parameter_name = 'SDDOCUMENT'.
        WHEN 'SALESORDERITEM'.
          ls_param-parameter_name = 'SDDOCUMENTITEM'.
        WHEN 'SUPPLIER'.
          ls_param-parameter_name = 'SUPPLIER'.
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
      IF lv_where IS NOT INITIAL.
        CONCATENATE lv_where 'AND' INTO lv_where SEPARATED BY space.
      ENDIF.
      CONCATENATE `'` ls_param-value `'` INTO ls_param-value.
      CONCATENATE lv_where ls_param-parameter_name `= ` ls_param-value INTO lv_where SEPARATED BY space.
    ENDLOOP.

    SELECT
      stock~batch,
      convert_rate~conversionrate,
      character_z_hsd~charcfromdate                 AS hsd,
      character_z_nsx~charcfromdate                 AS nsx,
      stock~materialbaseunit                        AS unit,
      i_unitofmeasure~unitofmeasurenumberofdecimals AS unitnumberofdecimal,
      SUM( stock~matlwrhsstkqtyinmatlbaseunit )     AS availablequantity
      FROM i_materialstock AS stock
      LEFT OUTER JOIN zcore_i_batch_characteristic AS character_z_hsd
      ON  character_z_hsd~product        = stock~material
      AND character_z_hsd~batch          = stock~batch
      AND character_z_hsd~characteristic = 'LOBM_VFDAT'
      LEFT OUTER JOIN zcore_i_batch_characteristic AS character_z_nsx
      ON  character_z_nsx~product        = stock~material
      AND character_z_nsx~batch          = stock~batch
      AND character_z_nsx~characteristic = 'Z_NSX'
      LEFT OUTER JOIN zcore_i_product_convert_rate AS convert_rate
      ON  convert_rate~product           = stock~material
      AND convert_rate~fromunit          = stock~materialbaseunit
      AND convert_rate~tounit            = @lv_entry_unit
      LEFT OUTER JOIN i_unitofmeasure
      ON stock~materialbaseunit = i_unitofmeasure~unitofmeasure
      WHERE inventorystocktype = '01'
        AND (lv_where)
      GROUP BY
      stock~batch,
      convert_rate~conversionrate,
      character_z_hsd~charcfromdate,
      character_z_nsx~charcfromdate,
      stock~materialbaseunit,
      i_unitofmeasure~unitofmeasurenumberofdecimals
      HAVING
      SUM( stock~matlwrhsstkqtyinmatlbaseunit ) > 0
      INTO TABLE @DATA(lt_stock).

    CHECK sy-subrc EQ 0.
    DATA: ls_data LIKE LINE OF et_data.

    LOOP AT lt_stock INTO DATA(ls_stock).
      MOVE-CORRESPONDING ls_stock TO ls_data.
      ls_data-expirationdate = ls_stock-hsd.

      IF ls_stock-conversionrate IS INITIAL.
      ELSE.
        ls_data-availablequantity *= ls_stock-conversionrate.
        ls_data-unit               = lv_entry_unit.
      ENDIF.

      IF lv_type EQ '2'.
        IF ls_stock-hsd = sy-datum.

        ELSEIF ls_stock-hsd = ls_stock-nsx.

        ELSE.
          DATA(lv_percent) = ( ls_stock-hsd - sy-datum ) / ( ls_stock-hsd - ls_stock-nsx ) * 100.
          IF lv_percent >= 70.
            APPEND ls_data TO et_data.
          ELSE.

          ENDIF.
        ENDIF.
      ELSE.
        APPEND ls_data TO et_data.
      ENDIF.
    ENDLOOP.

    SORT et_data BY expirationdate batch.

    LOOP AT et_data ASSIGNING FIELD-SYMBOL(<lfs_data>).
      IF <lfs_data>-availablequantity <= lv_entry_quan.
        <lfs_data>-splitquantity = <lfs_data>-availablequantity.
        lv_entry_quan           -= <lfs_data>-availablequantity.
      ELSE.
        <lfs_data>-splitquantity = lv_entry_quan.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD if_rap_query_provider~select.
    CASE io_request->get_entity_id( ).
      WHEN 'ZI_WM_BATCH_DETERMINATION'.
        DATA: lt_data_bd_response TYPE TABLE OF zi_wm_batch_determination.

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

        DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
        DATA(lv_grouping) = concat_lines_of( table = lt_grouped_element sep = `, ` ).

        " get list field ordered ------------------------
        DATA(lt_sort) = io_request->get_sort_elements( ).

        DATA(lt_sort_criteria) = VALUE string_table( FOR ls_sort IN lt_sort ( ls_sort-element_name && COND #( WHEN ls_sort-descending = abap_true THEN ` descending`
                                                                                                                                                  ELSE ` ascending` ) ) ).

        DATA(lv_sort_element) = COND #( WHEN lt_sort_criteria IS INITIAL AND lv_grouping IS NOT INITIAL
                                        THEN lv_grouping
                                        WHEN lt_sort_criteria IS INITIAL
                                        THEN `ExpirationDate ASCENDING, Batch ASCENDING`
                                        ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
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

        " get data --------------------------------------
        get_data_bd(
            EXPORTING io_request = io_request
            IMPORTING et_data    = DATA(lt_data_bd) ).

        SELECT (lv_reqs_element)
          FROM @lt_data_bd AS data
          GROUP BY (lv_grouping)
          ORDER BY (lv_sort_element)
          INTO CORRESPONDING FIELDS OF TABLE @lt_data_bd_response
          OFFSET @lv_skip UP TO @lv_max_rows ROWS.
        " get data --------------------------------------

        " response data ---------------------------------
        IF io_request->is_data_requested( ).
          io_response->set_data( lt_data_bd_response ).
        ENDIF.
        IF io_request->is_total_numb_of_rec_requested( ).
          io_response->set_total_number_of_records( lines( lt_data_bd ) ).
        ENDIF.
        " response data ---------------------------------
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

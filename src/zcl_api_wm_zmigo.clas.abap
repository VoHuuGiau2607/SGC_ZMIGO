CLASS zcl_api_wm_zmigo DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_http_service_extension.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS: BEGIN OF cs_message_status,
                 error   TYPE c LENGTH 10 VALUE 'Error',
                 success TYPE c LENGTH 10 VALUE 'Success',
               END OF cs_message_status.

    TYPES: BEGIN OF ty_request_item_raw,
             ref_doc                  TYPE string,
             ref_year                 TYPE string,
             ref_item                 TYPE string,

             is_component             TYPE string,
             short_receipt_value      TYPE string,

             goods_move_type          TYPE string,
             item_text                TYPE string,
             special_stock_type       TYPE string,

             plant                    TYPE string,
             batch                    TYPE string,
             material                 TYPE string,
             storage_location         TYPE string,
             sales_ord                TYPE string,
             sales_ord_item           TYPE string,

             move_plant               TYPE string,
             move_batch               TYPE string,
             move_material            TYPE string,
             move_storage_location    TYPE string,
             move_sales_ord           TYPE string,
             move_sales_ord_item      TYPE string,

             entry_uom                TYPE string,
             entry_quantity           TYPE string,

             customer                 TYPE string,
             supplier                 TYPE string,
             vendor                   TYPE string,

             amount_lc                TYPE string,

             gl_account               TYPE string,
             cost_center              TYPE string,
             wbs_element              TYPE string,
             asset                    TYPE string,
             manufacturing_order      TYPE string,

             gross_weight             TYPE string,

             profit_center            TYPE string,
             manufacturer             TYPE string,
             lot_num                  TYPE string,
             batch_note               TYPE string,
             qc_note                  TYPE string,
             goods_receipt_date       TYPE string,
             production_date          TYPE string,
             expiration_date          TYPE string,
             production_date_internal TYPE string,
             expiration_date_internal TYPE string,
             access_code              TYPE string,
             packaging_spec           TYPE string,
             origin                   TYPE string,
             batch_supplier           TYPE string,
             quantity_btp             TYPE string,
             quantity_tp              TYPE string,
             plan_dept_note           TYPE string,

             parenthandlingunituuid   TYPE string,
             stockitemuuid            TYPE string,

             stock_type               TYPE string,
             movement_reason          TYPE string,
           END OF ty_request_item_raw,
           BEGIN OF ty_request_raw,
             document_date        TYPE string,
             posting_date         TYPE string,
             document_header_text TYPE string,
             items                TYPE STANDARD TABLE OF ty_request_item_raw WITH EMPTY KEY,
           END OF ty_request_raw,
           BEGIN OF ty_request_item,
             ref_doc                  TYPE string,
             ref_year                 TYPE string,
             ref_item                 TYPE string,

             is_component             TYPE string,
             short_receipt_value      TYPE string,

             goods_move_type          TYPE string,
             item_text                TYPE string,
             special_stock_type       TYPE string,

             plant                    TYPE werks_d,
             batch                    TYPE charg_d,
             material                 TYPE matnr,
             storage_location         TYPE lgort_d,
             sales_ord                TYPE vbeln_va,
             sales_ord_item           TYPE posnr_va,

             move_plant               TYPE werks_d,
             move_batch               TYPE charg_d,
             move_material            TYPE matnr,
             move_storage_location    TYPE lgort_d,
             move_sales_ord           TYPE vbeln_va,
             move_sales_ord_item      TYPE posnr_va,

             entry_uom                TYPE string,
             entry_quantity           TYPE string,

             customer                 TYPE string,
             supplier                 TYPE string,
             vendor                   TYPE string,

             amount_lc                TYPE string,

             gl_account               TYPE string,
             cost_center              TYPE string,
             wbs_element              TYPE string,
             asset                    TYPE string,
             manufacturing_order      TYPE string,

             gross_weight             TYPE string,

             profit_center            TYPE string,
             manufacturer             TYPE string,
             lot_num                  TYPE string,
             batch_note               TYPE string,
             qc_note                  TYPE string,
             goods_receipt_date       TYPE string,
             production_date          TYPE string,
             expiration_date          TYPE string,
             production_date_internal TYPE string,
             expiration_date_internal TYPE string,
             access_code              TYPE string,
             packaging_spec           TYPE string,
             origin                   TYPE string,
             batch_supplier           TYPE string,
             quantity_btp             TYPE string,
             quantity_tp              TYPE string,
             plan_dept_note           TYPE string,

             parenthandlingunituuid   TYPE string,
             stockitemuuid            TYPE string,

             stock_type               TYPE string,
             movement_reason          TYPE string,
           END OF ty_request_item,
           BEGIN OF ty_request,
             document_date        TYPE string,
             posting_date         TYPE string,
             document_header_text TYPE string,
             items                TYPE STANDARD TABLE OF ty_request_item WITH EMPTY KEY,
           END OF ty_request,
           BEGIN OF ty_message,
             type TYPE c LENGTH 1,
             text TYPE string,
           END OF ty_message,
           BEGIN OF ty_response,
             status  TYPE c LENGTH 10,
             message TYPE STANDARD TABLE OF ty_message WITH EMPTY KEY,
           END OF ty_response,
           BEGIN OF ty_matdoc_incl_eew_ps_id,
             line_id TYPE n LENGTH 6.
             INCLUDE TYPE   matdoc_incl_eew_ps.
    TYPES: END OF ty_matdoc_incl_eew_ps_id.
    TYPES ty_quantity TYPE menge_d.
    TYPES: BEGIN OF ty_inbound_change,
             inbounddelivery          TYPE vbeln_vl,
             inbounddeliveryitem      TYPE posnr_vl,
             storagelocation          TYPE lgort_d,
             batch                    TYPE charg_d,
             deliveryquantityunit     TYPE meins,
             actualdeliveryquantity   TYPE ty_quantity,
             inbounddeliveryitem_new  TYPE posnr_vl,
             higherlvlitmofbatspltitm TYPE posnr_vl,
           END OF ty_inbound_change,
           tty_inbound_change TYPE STANDARD TABLE OF ty_inbound_change WITH EMPTY KEY.
    TYPES: BEGIN OF ty_outbound_change,
             outbounddelivery         TYPE vbeln_vl,
             outbounddeliveryitem     TYPE posnr_vl,
             storagelocation          TYPE lgort_d,
             batch                    TYPE charg_d,
             deliveryquantityunit     TYPE meins,
             actualdeliveryquantity   TYPE ty_quantity,
             outbounddeliveryitem_new TYPE posnr_vl,
             higherlvlitmofbatspltitm TYPE posnr_vl,
           END OF ty_outbound_change,
           tty_outbound_change TYPE STANDARD TABLE OF ty_outbound_change WITH EMPTY KEY.
    TYPES: BEGIN OF ty_return_dlv_change,
             customerreturndelivery         TYPE vbeln_vl,
             customerreturndeliveryitem     TYPE posnr_vl,
             storagelocation                TYPE lgort_d,
             batch                          TYPE charg_d,
             deliveryquantityunit           TYPE meins,
             actualdeliveryquantity         TYPE ty_quantity,
             customerreturndeliveryitem_new TYPE posnr_vl,
             higherlvlitmofbatspltitm       TYPE posnr_vl,
           END OF ty_return_dlv_change,
           tty_return_dlv_change TYPE STANDARD TABLE OF ty_return_dlv_change WITH EMPTY KEY.

    METHODS process_rounter
      IMPORTING iv_action          TYPE zde_wm_zmigo_action
                iv_reference       TYPE string
                is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS create_destination
      CHANGING  cs_response    TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(eo_dest) TYPE REF TO if_rfc_dest.

    METHODS call_bapi_goodsmvt_create
      IMPORTING is_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code
                is_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01
                is_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print
                is_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm
                iv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun
      EXPORTING es_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret
                ev_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr
                ev_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr
      CHANGING  ct_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex
                ct_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create
                ct_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create
                ct_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber
                ct_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat
                ct_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2
                cs_response                TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS process_a01_r01
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a01_r01
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a01_r01
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a08_r01
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a08_r01
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a08_r01
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a11_r01
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a11_r01
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a11_r01
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a02_r02
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a02_r02
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a02_r02
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a10_r02
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a10_r02
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a10_r02
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a01_r04
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a01_r04
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a01_r04
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a01_r05
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a01_r05
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a01_r05
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a07_r05
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a07_r05
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a07_r05
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a01_r08
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a01_r08
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a01_r08
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  cs_request      TYPE zcl_api_wm_zmigo=>ty_request OPTIONAL
                es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_a07_r08
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_a07_r08
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_a07_r08
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_r09
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
                iv_action          TYPE zde_wm_zmigo_action
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_r09
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
                iv_action        TYPE zde_wm_zmigo_action
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_r09
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
                iv_action       TYPE zde_wm_zmigo_action
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS process_r10
      IMPORTING is_request_raw     TYPE zcl_api_wm_zmigo=>ty_request_raw
                iv_action          TYPE zde_wm_zmigo_action
      RETURNING VALUE(rs_response) TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS check_data_r10
      IMPORTING is_request_raw   TYPE zcl_api_wm_zmigo=>ty_request_raw
                iv_action        TYPE zde_wm_zmigo_action
      CHANGING  es_response      TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rs_result) TYPE zcl_api_wm_zmigo=>ty_request.

    METHODS post_r10
      IMPORTING is_request      TYPE zcl_api_wm_zmigo=>ty_request
                iv_action       TYPE zde_wm_zmigo_action
                iv_no_upd_batch TYPE abap_boolean OPTIONAL
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE mblnr.

    METHODS create_batch
      IMPORTING iv_material                 TYPE matnr
                iv_expiration_date          TYPE string
                iv_production_date          TYPE string
                iv_profit_center            TYPE string
                iv_manufacturer             TYPE string
                iv_lot_num                  TYPE string
                iv_batch_supplier           TYPE string
                iv_batch_note               TYPE string
                iv_qc_note                  TYPE string
                iv_production_date_internal TYPE string
                iv_expiration_date_internal TYPE string
                iv_access_code              TYPE string
                iv_packaging_spec           TYPE string
                iv_origin                   TYPE string
                iv_gross_weight             TYPE string
                iv_quantity_btp             TYPE string
                iv_quantity_tp              TYPE string
                iv_plan_dept_note           TYPE string
      CHANGING  ev_batch                    TYPE charg_d
                es_response                 TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_batch
      IMPORTING iv_material                 TYPE matnr
                iv_batch                    TYPE charg_d
                iv_expiration_date          TYPE string
                iv_production_date          TYPE string
                iv_profit_center            TYPE string
                iv_manufacturer             TYPE string
                iv_lot_num                  TYPE string
                iv_batch_supplier           TYPE string
                iv_batch_note               TYPE string
                iv_qc_note                  TYPE string
                iv_production_date_internal TYPE string
                iv_expiration_date_internal TYPE string
                iv_access_code              TYPE string
                iv_packaging_spec           TYPE string
                iv_origin                   TYPE string
                iv_gross_weight             TYPE string
                iv_quantity_btp             TYPE string
                iv_quantity_tp              TYPE string
                iv_plan_dept_note           TYPE string
      CHANGING  es_response                 TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_gross_weight
      IMPORTING iv_material     TYPE matnr
                iv_batch        TYPE charg_d
                iv_gross_weight TYPE string
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS read_batch
      IMPORTING iv_material                 TYPE matnr
                iv_batch                    TYPE charg_d
      CHANGING  ev_expiration_date          TYPE string
                ev_production_date          TYPE string
                ev_profit_center            TYPE string
                ev_manufacturer             TYPE string
                ev_lot_num                  TYPE string
                ev_batch_supplier           TYPE string
                ev_batch_note               TYPE string
                ev_qc_note                  TYPE string
                ev_production_date_internal TYPE string
                ev_expiration_date_internal TYPE string
                ev_access_code              TYPE string
                ev_packaging_spec           TYPE string
                ev_origin                   TYPE string
                ev_gross_weight             TYPE string
                ev_quantity_btp             TYPE string
                ev_quantity_tp              TYPE string
                ev_plan_dept_note           TYPE string
                es_response                 TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_inbound
      IMPORTING iv_is_wm       TYPE abap_boolean
                it_data        TYPE tty_inbound_change
      CHANGING  es_response    TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(et_data) TYPE tty_inbound_change.

    METHODS update_outbound
      IMPORTING iv_is_wm       TYPE abap_boolean
                iv_pstng_date  TYPE dats
                it_data        TYPE tty_outbound_change
      CHANGING  es_response    TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(et_data) TYPE tty_outbound_change.

    METHODS update_return_dlv
      IMPORTING iv_is_wm        TYPE abap_boolean
                it_data         TYPE zcl_api_wm_zmigo=>tty_return_dlv_change
      CHANGING  es_response     TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(r_result) TYPE zcl_api_wm_zmigo=>tty_return_dlv_change.

    METHODS create_batch_split_inbound
      IMPORTING iv_etag                   TYPE string
                iv_inbounddelivery        TYPE vbeln_vl
                iv_inbounddeliveryitem    TYPE posnr_vl
                iv_batch                  TYPE charg_d
                iv_deliveryquantityunit   TYPE meins
                iv_actualdeliveryquantity TYPE menge_d
                iv_storagelocation        TYPE lgort_d
      CHANGING  es_response               TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rv_posnr)           TYPE posnr_vl.

    METHODS create_batch_split_outbound
      IMPORTING iv_is_wm                  TYPE abap_boolean
                iv_etag                   TYPE string
                iv_outbounddelivery       TYPE vbeln_vl
                iv_outbounddeliveryitem   TYPE posnr_vl
                iv_batch                  TYPE charg_d
                iv_deliveryquantityunit   TYPE meins
                iv_actualdeliveryquantity TYPE menge_d
      CHANGING  es_response               TYPE zcl_api_wm_zmigo=>ty_response
      RETURNING VALUE(rv_posnr)           TYPE posnr_vl.

    METHODS get_etag_inbound_item
      IMPORTING iv_inbounddelivery     TYPE vbeln_vl
                iv_inbounddeliveryitem TYPE posnr_vl
      RETURNING VALUE(rv_etag)         TYPE string.

    METHODS get_etag_outbound
      IMPORTING iv_outbounddelivery TYPE vbeln_vl
      RETURNING VALUE(rv_etag)      TYPE string.

    METHODS get_etag_outbound_item
      IMPORTING iv_outbounddelivery     TYPE vbeln_vl
                iv_outbounddeliveryitem TYPE posnr_vl
      RETURNING VALUE(rv_etag)          TYPE string.

    METHODS get_etag_return_dlv
      IMPORTING iv_customerreturndelivery TYPE vbeln_vl
      RETURNING VALUE(rv_etag)            TYPE string.

    METHODS get_etag_return_dlv_item
      IMPORTING iv_customerreturndelivery     TYPE vbeln_vl
                iv_customerreturndeliveryitem TYPE posnr_vl
      RETURNING VALUE(rv_etag)                TYPE string.

    METHODS update_inbound_item
      IMPORTING iv_etag                TYPE string
                iv_inbounddelivery     TYPE vbeln_vl
                iv_inbounddeliveryitem TYPE posnr_vl
                iv_storagelocation     TYPE lgort_d
      CHANGING  es_response            TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_outbound_item
      IMPORTING iv_etag                 TYPE string
                iv_outbounddelivery     TYPE vbeln_vl
                iv_outbounddeliveryitem TYPE posnr_vl
                iv_storagelocation      TYPE lgort_d
      CHANGING  es_response             TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS clear_batch_sloc_outbound_item
      IMPORTING iv_etag                 TYPE string
                iv_outbounddelivery     TYPE vbeln_vl
                iv_outbounddeliveryitem TYPE posnr_vl
      CHANGING  es_response             TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_return_dlv_item
      IMPORTING iv_etag                       TYPE string
                iv_customerreturndelivery     TYPE vbeln_vl
                iv_customerreturndeliveryitem TYPE posnr_vl
                iv_storagelocation            TYPE lgort_d
      CHANGING  es_response                   TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_custom_field_inb_item
      IMPORTING iv_inbounddelivery     TYPE vbeln_vl
                iv_inbounddeliveryitem TYPE posnr_vl
                iv_createby            TYPE zde_user
      CHANGING  es_response            TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_custom_field_out_item
      IMPORTING iv_outbounddelivery     TYPE vbeln_vl
                iv_outbounddeliveryitem TYPE posnr_vl
                iv_createby             TYPE zde_user
      CHANGING  es_response             TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS update_custom_field_redlv_item
      IMPORTING iv_customerreturndelivery     TYPE vbeln_vl
                iv_customerreturndeliveryitem TYPE posnr_vl
                iv_createby                   TYPE zde_user
      CHANGING  es_response                   TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS delete_inbound_item
      IMPORTING iv_etag                TYPE string
                iv_inbounddelivery     TYPE vbeln_vl
                iv_inbounddeliveryitem TYPE posnr_vl
      CHANGING  es_response            TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS delete_outbound_item
      IMPORTING iv_etag                 TYPE string
                iv_outbounddelivery     TYPE vbeln_vl
                iv_outbounddeliveryitem TYPE posnr_vl
      CHANGING  es_response             TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS pick_outbound_item
      IMPORTING iv_etag                 TYPE string
                iv_outbounddelivery     TYPE vbeln_vl
                iv_outbounddeliveryitem TYPE posnr_vl
*          iv_deliveryquantityunit   TYPE meins
*          iv_actualdeliveryquantity TYPE menge_d
      CHANGING  es_response             TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS putaway_return_dlv
      IMPORTING iv_etag     TYPE string
                iv_vbeln    TYPE vbeln_vl
      CHANGING  es_response TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS post_goods_issue_oubound
      IMPORTING iv_etag     TYPE string
                iv_vbeln    TYPE vbeln_vl
      CHANGING  es_response TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS post_goods_receipt_return_dlv
      IMPORTING iv_etag        TYPE string
                iv_vbeln       TYPE vbeln_vl
                iv_gm_datetime TYPE timestamp
      CHANGING  es_response    TYPE zcl_api_wm_zmigo=>ty_response.

    METHODS convert_entry_quantity
      IMPORTING iv_entry_quantity        TYPE string
      RETURNING VALUE(rv_entry_quantity) TYPE zsc_bapi_goodsmvt_create=>erfmg.

    CLASS-METHODS fill_container_c
      IMPORTING  im_value     TYPE any
      EXPORTING  ex_container TYPE csequence
      EXCEPTIONS illegal_parameter_type.
ENDCLASS.



CLASS ZCL_API_WM_ZMIGO IMPLEMENTATION.


  METHOD call_bapi_goodsmvt_create."
    DATA dest TYPE REF TO if_rfc_dest.
    DATA myobj TYPE REF TO zsc_bapi_goodsmvt_create.

    CHECK cs_response-status NE cs_message_status-error.

    TRY.
        dest = create_destination( CHANGING cs_response = cs_response ).

        CREATE OBJECT myobj
          EXPORTING
            destination = dest.

        myobj->bapi_goodsmvt_create(
          EXPORTING
            goodsmvt_code              = is_goodsmvt_code
            goodsmvt_header            = is_goodsmvt_header
            goodsmvt_print_ctrl        = is_goodsmvt_print_ctrl
            goodsmvt_ref_ewm           = is_goodsmvt_ref_ewm
            testrun                    = iv_testrun
          IMPORTING
            goodsmvt_headret           = es_goodsmvt_headret
            matdocumentyear            = ev_matdocumentyear
            materialdocument           = ev_materialdocument
          CHANGING
            extensionin                = ct_extensionin
            goodsmvt_item              = ct_goodsmvt_item
            goodsmvt_item_cwm          = ct_goodsmvt_item_cwm
            goodsmvt_serialnumber      = ct_goodsmvt_serialnumber
            goodsmvt_serv_part_data    = ct_goodsmvt_serv_part_data
            return                     = ct_return
        ).

        DATA(lv_dest) = dest->get_destination_name( ).

        LOOP AT ct_return TRANSPORTING NO FIELDS
          WHERE type = 'E' OR
                type = 'A'.
          EXIT.
        ENDLOOP.
        IF sy-subrc EQ 0.
          cs_response-status = cs_message_status-error.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK' DESTINATION lv_dest.
        ELSEIF iv_testrun EQ 'X'.
          cs_response-status = cs_message_status-success.
          APPEND VALUE ty_message( type = 'S' text = 'Check create Material Document successful!' ) TO cs_response-message.
          CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK' DESTINATION lv_dest.
        ELSE.
          cs_response-status = cs_message_status-success.
          IF ev_materialdocument IS NOT INITIAL.
            CLEAR: cs_response-message.
            APPEND VALUE ty_message(
              type = 'S'
              text = |Material Document { ev_materialdocument } { ev_matdocumentyear } created!|
            ) TO cs_response-message.
          ELSE.
            LOOP AT ct_return INTO DATA(ls_return)
              WHERE id     = 'L9'
                AND number = '514'.
              APPEND VALUE ty_message(
                type = 'S'
                text = ls_return-message
              ) TO cs_response-message.


              DATA: lt_postd TYPE TABLE OF ztb_wm_dlv_pstdt,
                    lv_vbeln TYPE vbeln.

              lv_vbeln = |{ ls_return-message_v1 ALPHA = IN }|.

              SELECT COUNT(*)
                FROM ztb_wm_dlv_pstdt
                WHERE vbeln = @lv_vbeln.
              IF sy-subrc EQ 0.
                UPDATE ztb_wm_dlv_pstdt SET budat = @is_goodsmvt_header-pstng_date,
                                            bktxt = @is_goodsmvt_header-header_txt
                 WHERE vbeln = @lv_vbeln.
              ELSE.
                APPEND VALUE #( vbeln = lv_vbeln
                                budat = is_goodsmvt_header-pstng_date
                                bktxt = is_goodsmvt_header-header_txt ) TO lt_postd.
                MODIFY ztb_wm_dlv_pstdt FROM TABLE @lt_postd.
              ENDIF.

              COMMIT WORK AND WAIT.
            ENDLOOP.
          ENDIF.
*          IF sy-uname NE 'CB9980000000'.
          CALL FUNCTION 'BAPI_TRANSACTION_COMMIT' DESTINATION lv_dest
            EXPORTING
              wait = 'X'.
*          ENDIF.
        ENDIF.

      CATCH  cx_aco_communication_failure INTO DATA(lcx_comm).
        APPEND VALUE ty_message( type = 'E' text = lcx_comm->get_text( ) ) TO cs_response-message.
      CATCH cx_aco_system_failure INTO DATA(lcx_sys).
        APPEND VALUE ty_message( type = 'E' text = lcx_sys->get_text( ) ) TO cs_response-message.
      CATCH cx_aco_application_exception INTO DATA(lcx_appl).
        APPEND VALUE ty_message( type = 'E' text = lcx_appl->get_text( ) ) TO cs_response-message.
      CATCH cx_rfc_dest_provider_error INTO DATA(lcx_rfc_dest).
        APPEND VALUE ty_message( type = 'E' text = lcx_rfc_dest->get_text( ) ) TO cs_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD check_data_a01_r01."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD post_a01_r04. "
    DATA ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code.
    DATA ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01.
    DATA ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print.
    DATA ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm.
    DATA lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr.
    DATA lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex.
    DATA ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create.
    DATA lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create.
    DATA lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create.
    DATA lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber.
    DATA lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat.
    DATA lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA lv_matnr18                 TYPE n LENGTH 18.

    DATA lv_line_id                 TYPE zsc_bapi_goodsmvt_create=>mb_line_id.
*    DATA ls_matdoc_incl_eew_ps_id TYPE ty_matdoc_incl_eew_ps_id.

    TYPES:
      BEGIN OF lty_inbound_input,
        ref_doc             TYPE string,
        ref_item            TYPE string,
        inbounddelivery     TYPE vbeln_vl,
        inbounddeliveryitem TYPE posnr_vl,
        plant               TYPE werks_d,
        storage_location    TYPE lgort_d,
      END OF lty_inbound_input.

    DATA lt_inbound_input  TYPE TABLE OF lty_inbound_input.
    DATA lt_inbound_change TYPE tty_inbound_change.
    DATA lv_is_wm          TYPE abap_boolean.
    DATA lv_vbeln          TYPE vbeln_vl.
    DATA lv_posnr          TYPE posnr_vl.
    DATA lv_message        TYPE string.

    CHECK es_response-status <> cs_message_status-error.

    DATA(lt_request_item) = is_request-items.

    MOVE-CORRESPONDING lt_request_item TO lt_inbound_input.

    LOOP AT lt_inbound_input ASSIGNING FIELD-SYMBOL(<lfs_inbound_input>).
      <lfs_inbound_input>-inbounddelivery     = |{ <lfs_inbound_input>-ref_doc ALPHA = IN }|.
      <lfs_inbound_input>-inbounddeliveryitem = |{ <lfs_inbound_input>-ref_item ALPHA = IN }|.
      <lfs_inbound_input>-plant               = <lfs_inbound_input>-plant.
      <lfs_inbound_input>-storage_location    = <lfs_inbound_input>-storage_location.
    ENDLOOP.

    SELECT COUNT(*) FROM i_ewm_plantstorlocmaptowhse
      FOR ALL ENTRIES IN @lt_inbound_input
      WHERE plant           = @lt_inbound_input-plant
        AND storagelocation = @lt_inbound_input-storage_location.
    IF sy-subrc = 0.
      lv_is_wm = 'X'.
    ENDIF.

    SORT lt_inbound_input BY ref_doc
                             ref_item.

    SELECT inbounddelivery,
           inbounddeliveryitem,
           storagelocation,
           batch,
           deliveryquantityunit,
           actualdeliveryquantity,
           higherlvlitmofbatspltitm
      FROM i_inbounddeliveryitem
      FOR ALL ENTRIES IN @lt_inbound_input
      WHERE inbounddelivery     = @lt_inbound_input-inbounddelivery
        AND inbounddeliveryitem = @lt_inbound_input-inbounddeliveryitem
      INTO TABLE @DATA(lt_inbound).
    IF sy-subrc = 0.
      SORT lt_inbound BY inbounddelivery
                         inbounddeliveryitem.
    ENDIF.

    LOOP AT lt_request_item ASSIGNING FIELD-SYMBOL(<lfs_request_item>).
      IF <lfs_request_item>-material IS INITIAL.
*
*      ELSEIF <lfs_request_item>-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ <lfs_request_item>-material ALPHA = IN }|.
        <lfs_request_item>-material = lv_matnr18.
      ENDIF.

      READ TABLE lt_inbound_input INTO DATA(ls_inbound_input)
           WITH KEY ref_doc  = <lfs_request_item>-ref_doc
                    ref_item = <lfs_request_item>-ref_item BINARY SEARCH.
      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      READ TABLE lt_inbound INTO DATA(ls_inbound)
           WITH KEY inbounddelivery     = ls_inbound_input-inbounddelivery
                    inbounddeliveryitem = ls_inbound_input-inbounddeliveryitem BINARY SEARCH.
      IF sy-subrc = 0.
        IF    <lfs_request_item>-batch <> ls_inbound-batch
           OR <lfs_request_item>-batch IS INITIAL.
          IF     <lfs_request_item>-batch IS NOT INITIAL
             AND ls_inbound-batch         IS NOT INITIAL.
            es_response-status = cs_message_status-error.

            APPEND VALUE ty_message(
                type = 'E'
                text = |Delivery Item { ls_inbound_input-inbounddelivery } { ls_inbound_input-inbounddeliveryitem }: can't change batch| )
                   TO es_response-message.
          ELSEIF <lfs_request_item>-batch IS INITIAL.
            create_batch( EXPORTING iv_material                 = <lfs_request_item>-material
                                    iv_expiration_date          = <lfs_request_item>-expiration_date
                                    iv_production_date          = <lfs_request_item>-production_date
                                    iv_profit_center            = <lfs_request_item>-profit_center
                                    iv_manufacturer             = <lfs_request_item>-manufacturer
                                    iv_lot_num                  = <lfs_request_item>-lot_num
                                    iv_batch_supplier           = <lfs_request_item>-batch_supplier
                                    iv_batch_note               = <lfs_request_item>-batch_note
                                    iv_qc_note                  = <lfs_request_item>-qc_note
                                    iv_production_date_internal = <lfs_request_item>-production_date_internal
                                    iv_expiration_date_internal = <lfs_request_item>-expiration_date_internal
                                    iv_access_code              = <lfs_request_item>-access_code
                                    iv_packaging_spec           = <lfs_request_item>-packaging_spec
                                    iv_origin                   = <lfs_request_item>-origin
                                    iv_gross_weight             = <lfs_request_item>-gross_weight
                                    iv_quantity_btp             = '' "<lfs_request_item>-quantity_btp
                                    iv_quantity_tp              = '' "<lfs_request_item>-quantity_tp
                                    iv_plan_dept_note           = '' "<lfs_request_item>-plan_dept_note
                          CHANGING  ev_batch                    = <lfs_request_item>-batch
                                    es_response                 = es_response ).
          ELSE.
            update_batch( EXPORTING iv_material                 = <lfs_request_item>-material
                                    iv_batch                    = <lfs_request_item>-batch
                                    iv_expiration_date          = <lfs_request_item>-expiration_date
                                    iv_production_date          = <lfs_request_item>-production_date
                                    iv_profit_center            = <lfs_request_item>-profit_center
                                    iv_manufacturer             = <lfs_request_item>-manufacturer
                                    iv_lot_num                  = <lfs_request_item>-lot_num
                                    iv_batch_supplier           = <lfs_request_item>-batch_supplier
                                    iv_batch_note               = <lfs_request_item>-batch_note
                                    iv_qc_note                  = <lfs_request_item>-qc_note
                                    iv_production_date_internal = <lfs_request_item>-production_date_internal
                                    iv_expiration_date_internal = <lfs_request_item>-expiration_date_internal
                                    iv_access_code              = <lfs_request_item>-access_code
                                    iv_packaging_spec           = <lfs_request_item>-packaging_spec
                                    iv_origin                   = <lfs_request_item>-origin
                                    iv_gross_weight             = <lfs_request_item>-gross_weight
                                    iv_quantity_btp             = '' "<lfs_request_item>-quantity_btp
                                    iv_quantity_tp              = '' "<lfs_request_item>-quantity_tp
                                    iv_plan_dept_note           = '' "<lfs_request_item>-plan_dept_note
                          CHANGING  es_response                 = es_response ).
          ENDIF.
        ELSE.
          update_batch( EXPORTING iv_material                 = <lfs_request_item>-material
                                  iv_batch                    = <lfs_request_item>-batch
                                  iv_expiration_date          = <lfs_request_item>-expiration_date
                                  iv_production_date          = <lfs_request_item>-production_date
                                  iv_profit_center            = <lfs_request_item>-profit_center
                                  iv_manufacturer             = <lfs_request_item>-manufacturer
                                  iv_lot_num                  = <lfs_request_item>-lot_num
                                  iv_batch_supplier           = <lfs_request_item>-batch_supplier
                                  iv_batch_note               = <lfs_request_item>-batch_note
                                  iv_qc_note                  = <lfs_request_item>-qc_note
                                  iv_production_date_internal = <lfs_request_item>-production_date_internal
                                  iv_expiration_date_internal = <lfs_request_item>-expiration_date_internal
                                  iv_access_code              = <lfs_request_item>-access_code
                                  iv_packaging_spec           = <lfs_request_item>-packaging_spec
                                  iv_origin                   = <lfs_request_item>-origin
                                  iv_gross_weight             = <lfs_request_item>-gross_weight
                                  iv_quantity_btp             = '' "<lfs_request_item>-quantity_btp
                                  iv_quantity_tp              = '' "<lfs_request_item>-quantity_tp
                                  iv_plan_dept_note           = '' "<lfs_request_item>-plan_dept_note
                        CHANGING  es_response                 = es_response ).
        ENDIF.

        APPEND VALUE #( inbounddelivery          = ls_inbound_input-inbounddelivery
                        inbounddeliveryitem      = ls_inbound_input-inbounddeliveryitem
                        storagelocation          = <lfs_request_item>-storage_location
                        batch                    = <lfs_request_item>-batch
                        deliveryquantityunit     = <lfs_request_item>-entry_uom
                        actualdeliveryquantity   = <lfs_request_item>-entry_quantity
                        higherlvlitmofbatspltitm = ls_inbound-higherlvlitmofbatspltitm )
               TO lt_inbound_change. " ASSIGNING FIELD-SYMBOL(<lfs_inbound_change>).
      ELSE.
        es_response-status = cs_message_status-error.

        APPEND VALUE ty_message(
            type = 'E'
            text = |Delivery Item { ls_inbound_input-inbounddelivery } { ls_inbound_input-inbounddeliveryitem } not found| )
               TO es_response-message.
      ENDIF.
    ENDLOOP.

    IF es_response-status = cs_message_status-error.
      RETURN.
    ENDIF.

    DATA(lt_data_inbound_new) = update_inbound( EXPORTING iv_is_wm    = lv_is_wm
                                                          it_data     = lt_inbound_change
                                                CHANGING  es_response = es_response ).

    IF es_response-status = cs_message_status-error.
      RETURN.
    ENDIF.

    IF lv_is_wm = 'X'.
      DATA lt_postd TYPE TABLE OF ztb_wm_dlv_pstdt.

      SELECT COUNT(*) FROM ztb_wm_dlv_pstdt
        WHERE vbeln = @ls_inbound_input-inbounddelivery.
      IF sy-subrc = 0.
        UPDATE ztb_wm_dlv_pstdt SET budat = @is_request-document_date,
                                    bktxt = @is_request-document_header_text
         WHERE vbeln = @ls_inbound_input-inbounddelivery.
      ELSE.
        APPEND VALUE #( vbeln = ls_inbound_input-inbounddelivery
                        budat = is_request-document_date
                        bktxt = is_request-document_header_text ) TO lt_postd.
        MODIFY ztb_wm_dlv_pstdt FROM TABLE @lt_postd.
      ENDIF.

      COMMIT WORK AND WAIT.

      CLEAR es_response-message.

      es_response-status = cs_message_status-success.
      lv_message = |Save IB { ls_inbound_input-inbounddelivery ALPHA = OUT } successful!|.
      APPEND VALUE #( type = 'S'
                      text = lv_message ) TO es_response-message.
      RETURN.
    ENDIF.

    SORT lt_data_inbound_new BY inbounddelivery
                                inbounddeliveryitem
                                batch
                                deliveryquantityunit
                                actualdeliveryquantity.

    LOOP AT lt_request_item ASSIGNING <lfs_request_item>.
      lv_vbeln = |{ <lfs_request_item>-ref_doc ALPHA = IN }|.
      lv_posnr = |{ <lfs_request_item>-ref_item ALPHA = IN }|.
      READ TABLE lt_data_inbound_new INTO DATA(ls_data_inbound_new)
           WITH KEY inbounddelivery        = lv_vbeln
                    inbounddeliveryitem    = lv_posnr
                    batch                  = <lfs_request_item>-batch
                    deliveryquantityunit   = <lfs_request_item>-entry_uom
                    actualdeliveryquantity = <lfs_request_item>-entry_quantity BINARY SEARCH.
      IF sy-subrc = 0 AND ls_data_inbound_new-inbounddeliveryitem_new IS NOT INITIAL.
        <lfs_request_item>-ref_item = ls_data_inbound_new-inbounddeliveryitem_new.
      ENDIF.
    ENDLOOP.

    IF es_response-status = cs_message_status-error.
      RETURN.
    ENDIF.

    ls_goodsmvt_header-pstng_date = is_request-posting_date.
    ls_goodsmvt_header-doc_date   = is_request-document_date.
    ls_goodsmvt_header-header_txt = is_request-document_header_text.
    ls_goodsmvt_code-gm_code      = '01'.

    LOOP AT lt_request_item INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id   = lv_line_id.

      ls_goodsmvt_item-material  = ls_request_item-material.
      ls_goodsmvt_item-batch     = ls_request_item-batch.
      ls_goodsmvt_item-plant     = ls_request_item-plant.
      ls_goodsmvt_item-stge_loc  = ls_request_item-storage_location.
      ls_goodsmvt_item-entry_qnt = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
      ls_goodsmvt_item-move_type            = ls_request_item-goods_move_type.
      ls_goodsmvt_item-mvt_ind              = 'B'.

      ls_goodsmvt_item-deliv_numb           = |{ ls_request_item-ref_doc ALPHA = IN }|.
      ls_goodsmvt_item-deliv_item           = |{ ls_request_item-ref_item ALPHA = IN }|.

      ls_goodsmvt_item-deliv_numb_to_search = ls_goodsmvt_item-deliv_numb.
      ls_goodsmvt_item-deliv_item_to_search = ls_goodsmvt_item-deliv_item.

      ls_goodsmvt_header-ref_doc_no = ls_goodsmvt_item-deliv_numb.

      SELECT SINGLE i_inbounddeliveryitem~purchaseorder,
                    i_inbounddeliveryitem~purchaseorderitem,
                    i_inbounddeliveryitem~batchbysupplier,
                    i_inbounddelivery~supplier,
                    i_purchaseorderitemapi01~purchaseorderitemcategory
        FROM i_inbounddelivery
             INNER JOIN i_inbounddeliveryitem         ON i_inbounddelivery~inbounddelivery = i_inbounddeliveryitem~inbounddelivery
             LEFT OUTER JOIN i_purchaseorderitemapi01 ON  i_inbounddeliveryitem~purchaseorder     = i_purchaseorderitemapi01~purchaseorder
                                                      AND i_inbounddeliveryitem~purchaseorderitem = i_purchaseorderitemapi01~purchaseorderitem
        WHERE i_inbounddeliveryitem~inbounddelivery     = @ls_goodsmvt_item-deliv_numb
          AND i_inbounddeliveryitem~inbounddeliveryitem = @ls_goodsmvt_item-deliv_item
        INTO ( @ls_goodsmvt_item-po_number,
               @ls_goodsmvt_item-po_item,
               @ls_goodsmvt_item-vendrbatch,
               @ls_goodsmvt_item-vendor,
               @DATA(lt_item_cat) ).

      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR ls_goodsmvt_item.

*      ls_matdoc_incl_eew_ps_id-line_id             = lv_line_id.
*      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi    = sy-uname.
*
*      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.
*      APPEND ls_extensionin TO lt_extensionin.
*      CLEAR: ls_extensionin, ls_matdoc_incl_eew_ps_id.

      IF lt_item_cat = '3'.
        " xử lý batch component
      ENDIF.
    ENDLOOP.

    call_bapi_goodsmvt_create( EXPORTING is_goodsmvt_code           = ls_goodsmvt_code
                                         is_goodsmvt_header         = ls_goodsmvt_header
                                         is_goodsmvt_print_ctrl     = ls_goodsmvt_print_ctrl
                                         is_goodsmvt_ref_ewm        = ls_goodsmvt_ref_ewm
                                         iv_testrun                 = lv_testrun
                               IMPORTING es_goodsmvt_headret        = ls_goodsmvt_headret
                                         ev_matdocumentyear         = lv_matdocumentyear
                                         ev_materialdocument        = lv_materialdocument
                               CHANGING  ct_extensionin             = lt_extensionin
                                         ct_goodsmvt_item           = lt_goodsmvt_item
                                         ct_goodsmvt_item_cwm       = lt_goodsmvt_item_cwm
                                         ct_goodsmvt_serialnumber   = lt_goodsmvt_serialnumber
                                         ct_goodsmvt_serv_part_data = lt_goodsmvt_serv_part_data
                                         ct_return                  = lt_return
                                         cs_response                = es_response ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD process_r10."
    DATA(ls_request) = check_data_r10(
      EXPORTING
        is_request_raw  = is_request_raw
        iv_action       = iv_action
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_r10(
      EXPORTING
        is_request  = ls_request
        iv_action   = iv_action
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD delete_inbound_item."
    DATA:
      ls_entity_key    TYPE zsc_api_inbound_delivery_srv=>tys_a_inb_delivery_item_type,
      ls_business_data TYPE zsc_api_inbound_delivery_srv=>tys_a_inb_delivery_item_type,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_delete,
      lv_message       TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_INBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_INBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        "Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_inbounddelivery
          delivery_document_item  = iv_inbounddeliveryitem
        ).

        "Navigate to the resource and create a request for the delete operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_INB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_delete( ).

        " ETag is needed
        " You need to retrieve it and then set it here
        lo_request->set_if_match( iv_etag ).

        " Execute the request
        lo_request->execute( ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD create_batch_split_inbound."
    DATA:
      ls_parameter         TYPE zsc_api_inbound_delivery_srv=>tys_parameters_8,
      la_business_data     TYPE zsc_api_inbound_delivery_srv=>tys_created_delivery_item,
      lo_http_client       TYPE REF TO if_web_http_client,
      lo_client_proxy      TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_function_request  TYPE REF TO /iwbep/if_cp_request_function,
      lo_function          TYPE REF TO /iwbep/if_cp_resource_function,
      lo_function_response TYPE REF TO /iwbep/if_cp_response_function,
      lv_message           TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    SELECT COUNT(*)
      FROM i_inbounddeliveryitem
      INNER JOIN i_product
      ON i_inbounddeliveryitem~material = i_product~product
      WHERE i_inbounddeliveryitem~inbounddelivery       = @iv_inbounddelivery
        AND i_inbounddeliveryitem~inbounddeliveryitem   = @iv_inbounddeliveryitem
        AND i_product~isbatchmanagementrequired         = 'X'.
    IF sy-subrc NE 0.
      rv_posnr = iv_inbounddeliveryitem.
      RETURN.
    ENDIF.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_INBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_INBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        " prepare parameter
        ls_parameter = VALUE #(
          manufacture_date            = sy-datum && sy-uzeit
          shelf_life_expiration_date  = sy-datum && sy-uzeit
          delivery_document           = iv_inbounddelivery
          delivery_document_item      = iv_inbounddeliveryitem
          batch                       = iv_batch
          delivery_quantity_unit      = iv_deliveryquantityunit
          actual_delivery_quantity    = iv_actualdeliveryquantity
        ).

        " Navigate to the resource and create a request for the create operation
        lo_function = lo_client_proxy->create_resource_for_function( 'CREATE_BATCH_SPLIT_ITEM' ).
        lo_function->set_parameter(  is_parameter = ls_parameter ).
        lo_function_request = lo_function->create_request( ).

        lo_function_request->set_if_match( iv_etag ).
        lo_function_request->set_http_method( iv_http_method = /iwbep/if_cp_request_function=>gcs_http_method-post ).

        " Execute the request
        lo_function_response = lo_function_request->execute( ).

        " Get the after image
        lo_function_response->get_business_data( IMPORTING ea_response_data = la_business_data ).

        rv_posnr = la_business_data-delivery_document_item.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD .


  METHOD post_a01_r05."
    TYPES:
      BEGIN OF lty_return_dlv_input,
        ref_doc                    TYPE string,
        ref_item                   TYPE string,
        customerreturndelivery     TYPE vbeln_vl,
        customerreturndeliveryitem TYPE posnr_vl,
        plant                      TYPE werks_d,
        storage_location           TYPE lgort_d,
      END OF lty_return_dlv_input.

    DATA: lt_return_dlv_input  TYPE TABLE OF lty_return_dlv_input,
          lt_return_dlv_change TYPE tty_return_dlv_change,
          lv_is_wm             TYPE abap_boolean,
          lv_message           TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    DATA(lt_request_item) = is_request-items.

    MOVE-CORRESPONDING lt_request_item TO lt_return_dlv_input.

    LOOP AT lt_return_dlv_input ASSIGNING FIELD-SYMBOL(<lfs_return_dlv_input>).
      <lfs_return_dlv_input>-customerreturndelivery     = |{ <lfs_return_dlv_input>-ref_doc ALPHA = IN }|.
      <lfs_return_dlv_input>-customerreturndeliveryitem = |{ <lfs_return_dlv_input>-ref_item ALPHA = IN }|.
      <lfs_return_dlv_input>-plant                      = <lfs_return_dlv_input>-plant.
      <lfs_return_dlv_input>-storage_location           = <lfs_return_dlv_input>-storage_location.
    ENDLOOP.

    SELECT DISTINCT
      ewmwarehouse
      FROM i_ewm_plantstorlocmaptowhse
      FOR ALL ENTRIES IN @lt_return_dlv_input
      WHERE plant           = @lt_return_dlv_input-plant
        AND storagelocation = @lt_return_dlv_input-storage_location
      INTO TABLE @DATA(lt_t320).
    IF sy-subrc EQ 0.
      lv_is_wm = 'X'.
    ENDIF.

    SORT lt_return_dlv_input BY ref_doc ref_item.

    SELECT
      customerreturndelivery,
      customerreturndeliveryitem,
      storagelocation,
      batch,
      deliveryquantityunit,
      actualdeliveryquantity,
      higherlvlitmofbatspltitm
      FROM i_customerreturndeliveryitem
      FOR ALL ENTRIES IN @lt_return_dlv_input
      WHERE customerreturndelivery     = @lt_return_dlv_input-customerreturndelivery
        AND customerreturndeliveryitem = @lt_return_dlv_input-customerreturndeliveryitem
      INTO TABLE @DATA(lt_return_dlv).
    IF sy-subrc EQ 0.
      SORT lt_return_dlv BY customerreturndelivery customerreturndeliveryitem.
    ENDIF.

    LOOP AT lt_request_item ASSIGNING FIELD-SYMBOL(<lfs_request_item>).
      READ TABLE lt_return_dlv_input INTO DATA(ls_return_dlv_input)
        WITH KEY ref_doc  = <lfs_request_item>-ref_doc
                 ref_item = <lfs_request_item>-ref_item BINARY SEARCH.
      IF sy-subrc EQ 0.
        READ TABLE lt_return_dlv INTO DATA(ls_return_dlv)
          WITH KEY customerreturndelivery     = ls_return_dlv_input-customerreturndelivery
                   customerreturndeliveryitem = ls_return_dlv_input-customerreturndeliveryitem BINARY SEARCH.
        IF sy-subrc EQ 0.
          APPEND VALUE #(
            customerreturndelivery         = ls_return_dlv_input-customerreturndelivery
            customerreturndeliveryitem     = ls_return_dlv_input-customerreturndeliveryitem
            storagelocation          = <lfs_request_item>-storage_location
            batch                    = <lfs_request_item>-batch
            deliveryquantityunit     = <lfs_request_item>-entry_uom
            actualdeliveryquantity   = <lfs_request_item>-entry_quantity
            higherlvlitmofbatspltitm = ls_return_dlv-higherlvlitmofbatspltitm
          ) TO lt_return_dlv_change.
        ELSE.
          es_response-status = cs_message_status-error.

          APPEND VALUE ty_message(
            type = 'E'
            text = |Delivery Item { ls_return_dlv_input-customerreturndelivery } { ls_return_dlv_input-customerreturndeliveryitem } not found|
          ) TO es_response-message.
        ENDIF.
      ENDIF.
    ENDLOOP.

    CHECK es_response-status NE cs_message_status-error.

    DATA: lt_postd TYPE TABLE OF ztb_wm_dlv_pstdt.

    DATA(lv_vbeln) = lt_return_dlv_change[ 1 ]-customerreturndelivery.

    SELECT COUNT(*)
      FROM ztb_wm_dlv_pstdt
      WHERE vbeln = @lv_vbeln.
    IF sy-subrc EQ 0.
      UPDATE ztb_wm_dlv_pstdt SET budat = @is_request-document_date,
                                  bktxt = @is_request-document_header_text
       WHERE vbeln = @lv_vbeln.
    ELSE.
      APPEND VALUE #( vbeln = lv_vbeln
                      budat = is_request-document_date
                      bktxt = is_request-document_header_text ) TO lt_postd.
      MODIFY ztb_wm_dlv_pstdt FROM TABLE @lt_postd.
    ENDIF.

    COMMIT WORK AND WAIT.

    DATA(lt_data_return_dlv_new) = update_return_dlv(
      EXPORTING
        iv_is_wm    = lv_is_wm
        it_data     = lt_return_dlv_change
      CHANGING
        es_response = es_response
    ).

    CHECK es_response-status NE cs_message_status-error.

    IF lv_is_wm EQ 'X'.
      es_response-status = cs_message_status-success.
      lv_message = |OD { ls_return_dlv_input-customerreturndelivery ALPHA = OUT } has been synchronized to warehouse { lt_t320[ 1 ]-ewmwarehouse }!|.
      APPEND VALUE #( type = 'S' text = lv_message ) TO es_response-message.
      RETURN.
    ENDIF.

    DATA(lv_etag) = get_etag_return_dlv(
      iv_customerreturndelivery = ls_return_dlv_input-customerreturndelivery
    ).

*    putaway_return_dlv(
*      EXPORTING
*        iv_etag     = lv_etag
*        iv_vbeln    = ls_return_dlv_input-customerreturndelivery
*      CHANGING
*        es_response = es_response
*    ).
*
*    lv_etag = get_etag_return_dlv(
*      iv_customerreturndelivery = ls_return_dlv_input-customerreturndelivery
*    ).

    post_goods_receipt_return_dlv(
      EXPORTING
        iv_etag         = lv_etag
        iv_vbeln        = ls_return_dlv_input-customerreturndelivery
        iv_gm_datetime  = COND #( WHEN is_request-posting_date IS NOT INITIAL THEN is_request-posting_date && '000000'
                                  ELSE sy-datum && sy-uzeit )
      CHANGING
        es_response     = es_response
    ).
  ENDMETHOD.


  METHOD post_a02_r02."
    DATA: ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code,
          ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01,
          ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print,
          ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm,
          lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun,
          ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret,
          lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr,
          lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr,
          lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex,
          ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex,
          ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create,
          lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create,
          lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create,
          lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber,
          lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat,
          lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA: lv_matnr18 TYPE n LENGTH 18.

    DATA: lv_line_id               TYPE zsc_bapi_goodsmvt_create=>mb_line_id,
          ls_matdoc_incl_eew_ps_id TYPE ty_matdoc_incl_eew_ps_id.

    CHECK es_response-status NE cs_message_status-error.

    ls_goodsmvt_header-pstng_date   = is_request-posting_date.
    ls_goodsmvt_header-doc_date     = is_request-document_date.
    ls_goodsmvt_header-header_txt   = is_request-document_header_text.
    ls_goodsmvt_code-gm_code        = '01'.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id          = lv_line_id.

      ls_goodsmvt_item-material       = ls_request_item-material.
      ls_goodsmvt_item-batch          = ls_request_item-batch.
      ls_goodsmvt_item-plant          = ls_request_item-plant.
      ls_goodsmvt_item-stge_loc       = ls_request_item-storage_location.
      ls_goodsmvt_item-entry_qnt      = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure
        FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
      ls_goodsmvt_item-move_type      = ls_request_item-goods_move_type.
      ls_goodsmvt_item-ref_doc_yr     = ls_request_item-ref_year.
      ls_goodsmvt_item-ref_doc        = ls_request_item-ref_doc.
      ls_goodsmvt_item-ref_doc_it     = ls_request_item-ref_item.


*      ls_goodsmvt_item-po_number      = ls_request_item-ref_doc.
*      ls_goodsmvt_item-po_item        = |{ ls_request_item-ref_item ALPHA = IN }|.
      ls_goodsmvt_item-mvt_ind        = 'B'.

      SELECT SINGLE
        supplier,
        purchaseorder,
        purchaseorderitem,
        deliverydocument
        FROM i_materialdocumentitem_2
        WHERE materialdocumentyear  = @ls_goodsmvt_item-ref_doc_yr
          AND materialdocument      = @ls_goodsmvt_item-ref_doc
          AND materialdocumentitem  = @ls_goodsmvt_item-ref_doc_it
        INTO ( @ls_goodsmvt_item-vendor,
               @ls_goodsmvt_item-po_number,
               @ls_goodsmvt_item-po_item,
               @ls_goodsmvt_header-ref_doc_no ).
      ls_goodsmvt_item-move_reas = '0001'.
      ls_goodsmvt_item-create_delivery = 'X'.

*      ls_goodsmvt_item-gl_account     = ls_request_item-gl_account.
*      ls_goodsmvt_item-costcenter     = ls_request_item-cost_center.
*      ls_goodsmvt_item-wbs_elem       = ls_request_item-wbs_element.
*      ls_goodsmvt_item-asset_no       = ls_request_item-asset.

      ls_goodsmvt_item-stck_type = ls_request_item-stock_type.
      ls_goodsmvt_item-move_reas = ls_request_item-movement_reason.

      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR: ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id             = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi    = sy-uname.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c(
        EXPORTING
          im_value     = ls_matdoc_incl_eew_ps_id
        IMPORTING
          ex_container = DATA(lv_container)
      ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin, ls_matdoc_incl_eew_ps_id.
    ENDLOOP.

    call_bapi_goodsmvt_create(
      EXPORTING
        is_goodsmvt_code              = ls_goodsmvt_code
        is_goodsmvt_header            = ls_goodsmvt_header
        is_goodsmvt_print_ctrl        = ls_goodsmvt_print_ctrl
        is_goodsmvt_ref_ewm           = ls_goodsmvt_ref_ewm
        iv_testrun                    = lv_testrun
      IMPORTING
        es_goodsmvt_headret           = ls_goodsmvt_headret
        ev_matdocumentyear            = lv_matdocumentyear
        ev_materialdocument           = lv_materialdocument
      CHANGING
        ct_extensionin                = lt_extensionin
        ct_goodsmvt_item              = lt_goodsmvt_item
        ct_goodsmvt_item_cwm          = lt_goodsmvt_item_cwm
        ct_goodsmvt_serialnumber      = lt_goodsmvt_serialnumber
        ct_goodsmvt_serv_part_data    = lt_goodsmvt_serv_part_data
        ct_return                     = lt_return
        cs_response                   = es_response
    ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD check_data_a08_r01."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD post_a10_r02."
    DATA: ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code,
          ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01,
          ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print,
          ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm,
          lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun,
          ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret,
          lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr,
          lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr,
          lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex,
          ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex,
          ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create,
          lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create,
          lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create,
          lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber,
          lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat,
          lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA: lv_matnr18 TYPE n LENGTH 18.

    DATA: lv_line_id               TYPE zsc_bapi_goodsmvt_create=>mb_line_id,
          ls_matdoc_incl_eew_ps_id TYPE ty_matdoc_incl_eew_ps_id.

    CHECK es_response-status NE cs_message_status-error.

    ls_goodsmvt_header-pstng_date   = is_request-posting_date.
    ls_goodsmvt_header-doc_date     = is_request-document_date.
    ls_goodsmvt_header-header_txt   = is_request-document_header_text.
    ls_goodsmvt_code-gm_code        = '05'.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id          = lv_line_id.

      ls_goodsmvt_item-material       = ls_request_item-material.
      ls_goodsmvt_item-batch          = ls_request_item-move_batch.
      ls_goodsmvt_item-plant          = ls_request_item-move_plant.
      ls_goodsmvt_item-stge_loc       = ls_request_item-move_storage_location.
      ls_goodsmvt_item-entry_qnt      = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure
        FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
      ls_goodsmvt_item-move_type      = ls_request_item-goods_move_type.
      ls_goodsmvt_item-ref_doc_yr     = ls_request_item-ref_year.
      ls_goodsmvt_item-ref_doc        = ls_request_item-ref_doc.
      ls_goodsmvt_item-ref_doc_it     = ls_request_item-ref_item.

      ls_goodsmvt_item-spec_stock     = ls_request_item-special_stock_type.

      ls_goodsmvt_item-val_sales_ord  = |{ ls_request_item-sales_ord ALPHA = IN }|.
      ls_goodsmvt_item-val_s_ord_item = |{ ls_request_item-sales_ord_item ALPHA = IN }|.

      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR: ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id             = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi    = sy-uname.

      IF ls_request_item-goods_move_type = '315'.
        ls_matdoc_incl_eew_ps_id-yy1_matdoc313_mmi      = ls_request_item-ref_doc.
        ls_matdoc_incl_eew_ps_id-yy1_matdoc313_year_mmi = ls_request_item-ref_year.
        ls_matdoc_incl_eew_ps_id-yy1_matdoc313_item_mmi = |{ ls_request_item-ref_item ALPHA = IN }| .
      ENDIF.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c(
        EXPORTING
          im_value     = ls_matdoc_incl_eew_ps_id
        IMPORTING
          ex_container = DATA(lv_container)
      ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin, ls_matdoc_incl_eew_ps_id.
    ENDLOOP.

    call_bapi_goodsmvt_create(
      EXPORTING
        is_goodsmvt_code              = ls_goodsmvt_code
        is_goodsmvt_header            = ls_goodsmvt_header
        is_goodsmvt_print_ctrl        = ls_goodsmvt_print_ctrl
        is_goodsmvt_ref_ewm           = ls_goodsmvt_ref_ewm
        iv_testrun                    = lv_testrun
      IMPORTING
        es_goodsmvt_headret           = ls_goodsmvt_headret
        ev_matdocumentyear            = lv_matdocumentyear
        ev_materialdocument           = lv_materialdocument
      CHANGING
        ct_extensionin                = lt_extensionin
        ct_goodsmvt_item              = lt_goodsmvt_item
        ct_goodsmvt_item_cwm          = lt_goodsmvt_item_cwm
        ct_goodsmvt_serialnumber      = lt_goodsmvt_serialnumber
        ct_goodsmvt_serv_part_data    = lt_goodsmvt_serv_part_data
        ct_return                     = lt_return
        cs_response                   = es_response
    ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD check_data_a11_r01."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD check_data_r09."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSEIF ls_result_item-goods_move_type = '313'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

*        IF NOT ( ls_result_item-move_plant IS INITIAL AND
*           ls_result_item-move_storage_location IS INITIAL ).
*          READ TABLE lt_auth TRANSPORTING NO FIELDS
*            WITH KEY plant           = ls_result_item-move_plant
*                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
*          IF sy-subrc NE 0.
*            es_response-status = cs_message_status-error.
*            APPEND VALUE #(
*              type = 'E'
*              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
*            ) TO es_response-message.
*            RETURN.
*          ENDIF.
*        ENDIF.
      ENDIF.
    ENDLOOP.

    CHECK es_response-status NE cs_message_status-error.

    TYPES: BEGIN OF lty_data,
             ref_doc        TYPE zde_wm_rsnum,
             ref_item       TYPE rspos,
             entry_uom      TYPE meins,
             entry_quantity TYPE zde_enmng,
           END OF lty_data,
           lty_resb_upd TYPE ztb_wm_resb WITH INDICATORS col_ind TYPE abap_bool.
    DATA: lt_data     TYPE TABLE OF lty_data,
          lt_resb_upd TYPE TABLE OF lty_resb_upd,
          lv_amount   TYPE zde_enmng.

    MOVE-CORRESPONDING is_request_raw-items TO lt_data.

    SELECT
      ref_doc,
      ref_item,
      entry_uom,
      SUM( entry_quantity ) AS entry_quantity
      FROM @lt_data AS data
      GROUP BY
      ref_doc,
      ref_item,
      entry_uom
      ORDER BY
      ref_doc,
      ref_item,
      entry_uom
      INTO TABLE @DATA(lt_data_sum).

    SELECT
      resb~reservation      AS rsnum,
      resb~reservationitem  AS rspos,
*      resb~rsart,
      resb~material         AS matnr,
      resb~baseunit         AS meins,
      resb~quantity         AS enmng
*      resb~soluongdaxuat,
*      resb~status
      FROM zi_wm_zmigo_r09( p_action = @iv_action ) AS resb
      INNER JOIN @lt_data_sum AS data
      ON  resb~reservation     = data~ref_doc
      AND resb~reservationitem = data~ref_item
      INTO TABLE @DATA(lt_resb).
    IF sy-subrc EQ 0.
      SORT lt_resb BY rsnum rspos.
    ENDIF.

    LOOP AT is_request_raw-items INTO DATA(ls_item_raw).
      SELECT SINGLE unitofmeasure
        FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_item_raw-entry_uom
        INTO @ls_item_raw-entry_uom.
      READ TABLE lt_resb INTO DATA(ls_resb)
        WITH KEY rsnum = ls_item_raw-ref_doc
                 rspos = ls_item_raw-ref_item BINARY SEARCH.
      IF sy-subrc EQ 0.
        lv_amount = ls_item_raw-entry_quantity.
        IF ls_resb-meins NE ls_item_raw-entry_uom.
          SELECT SINGLE
            afterunit~quantitynumerator   AS quantitynumerator_after,
            afterunit~quantitydenominator AS quantitydenominator_after,
            unit~quantitynumerator        AS quantitynumerator_entry,
            unit~quantitydenominator      AS quantitydenominator_entry
          FROM i_productunitsofmeasure AS unit
          INNER JOIN i_productunitsofmeasure AS afterunit
            ON unit~product = afterunit~product
          WHERE unit~product              = @ls_resb-matnr
            AND afterunit~alternativeunit = @ls_resb-meins
            AND unit~alternativeunit      = @ls_item_raw-entry_uom
          INTO @DATA(ls_marm).

          IF sy-subrc = 0 AND
             ls_marm-quantitynumerator_after     > 0 AND
             ls_marm-quantitydenominator_after   > 0 AND
             ls_marm-quantitynumerator_entry     > 0 AND
             ls_marm-quantitydenominator_entry   > 0.

            lv_amount *= (
              ( ls_marm-quantitynumerator_after * ls_marm-quantitydenominator_entry ) /
              ( ls_marm-quantitydenominator_after * ls_marm-quantitynumerator_entry )
            ).
          ENDIF.
        ENDIF.
        IF ls_resb-enmng < lv_amount.
          es_response-status = cs_message_status-error.
          APPEND VALUE #(
            type = 'E'
            text = |Reservation { ls_item_raw-ref_doc } { ls_item_raw-ref_item } does not exists|
          ) TO es_response-message.
        ENDIF.
      ELSE.
        es_response-status = cs_message_status-error.
        APPEND VALUE #(
          type = 'E'
          text = |Reservation { ls_item_raw-ref_doc } { ls_item_raw-ref_item } does not exists|
        ) TO es_response-message.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD fill_container_c.
    DATA: l_type_value     TYPE c,
          l_type_container TYPE c,
          l_len_value      TYPE i,
          l_len_container  TYPE i,
          l_ref            TYPE REF TO data,
          lo_element       TYPE REF TO cl_abap_typedescr.

    FIELD-SYMBOLS: <xvalue>     TYPE x,
                   <xcontainer> TYPE x,
                   <ccontainer> TYPE c.

*    DESCRIBE FIELD im_value TYPE l_type_value.
    lo_element ?= cl_abap_elemdescr=>describe_by_data( im_value ).
    l_type_value = lo_element->type_kind.

    CASE l_type_value.
      WHEN 'u'.
*        DESCRIBE FIELD ex_container TYPE l_type_container.
        lo_element ?= cl_abap_elemdescr=>describe_by_data( ex_container ).
        l_type_container = lo_element->type_kind.

        CASE l_type_container.
          WHEN 'C'.
            ASSIGN im_value     TO <xvalue>     CASTING.
            ASSIGN ex_container TO <xcontainer> CASTING.
            <xcontainer> = <xvalue>.
          WHEN 'g'.
*            DESCRIBE FIELD im_value LENGTH l_len_value IN BYTE MODE.
            lo_element ?= cl_abap_elemdescr=>describe_by_data( im_value ).
            l_len_value = lo_element->length.

            l_len_container =
              l_len_value DIV cl_abap_char_utilities=>charsize +
              sign( l_len_value MOD cl_abap_char_utilities=>charsize ).
            CREATE DATA l_ref TYPE c LENGTH l_len_container.
            ASSIGN l_ref->* TO <xcontainer> CASTING.
            ASSIGN im_value TO <xvalue>     CASTING.
            <xcontainer> = <xvalue>.
            ASSIGN l_ref->* TO <ccontainer>.
            CONCATENATE space space INTO ex_container SEPARATED BY <ccontainer>.
          WHEN OTHERS.
        ENDCASE.
      WHEN 'h' OR 'v' OR 'r' OR 'l'. " table, deep struc, object
        " referenc, data reference
        RAISE illegal_parameter_type.
      WHEN OTHERS.   " single field
        ex_container = im_value.
    ENDCASE.
  ENDMETHOD.


  METHOD create_destination."
    DATA lr_cscn_range  TYPE if_com_scenario_factory=>ty_query-cscn_id_range.

    lr_cscn_range  = VALUE #( ( sign = 'I' option = 'EQ' low = 'ZCORE_CS_SAP' ) ).

    DATA(lo_factory) = cl_com_arrangement_factory=>create_instance( ).
    lo_factory->query_ca(
          EXPORTING
            is_query = VALUE #( cscn_id_range = lr_cscn_range  )
          IMPORTING
            et_com_arrangement = DATA(lt_com_arrangement)
       ).
    IF lt_com_arrangement IS INITIAL.
      EXIT.
    ENDIF.

    READ TABLE lt_com_arrangement INTO DATA(ls_com_arrangement) INDEX 1.

    TRY.
        eo_dest = cl_rfc_destination_provider=>create_by_comm_arrangement(
          EXPORTING
            comm_scenario  = 'ZCORE_CS_SAP'
            service_id     = 'Z_API_SAP_SRFC'
            comm_system_id = ls_com_arrangement->get_comm_system_id( )
            ).
      CATCH  cx_aco_communication_failure INTO DATA(lcx_comm).
        APPEND VALUE ty_message( type = 'E' text = lcx_comm->get_text( ) ) TO cs_response-message.
      CATCH cx_aco_system_failure INTO DATA(lcx_sys).
        APPEND VALUE ty_message( type = 'E' text = lcx_sys->get_text( ) ) TO cs_response-message.
      CATCH cx_aco_application_exception INTO DATA(lcx_appl).
        APPEND VALUE ty_message( type = 'E' text = lcx_appl->get_text( ) ) TO cs_response-message.
      CATCH cx_rfc_dest_provider_error INTO DATA(lcx_rfc_dest).
        APPEND VALUE ty_message( type = 'E' text = lcx_rfc_dest->get_text( ) ) TO cs_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD if_http_service_extension~handle_request.
    DATA: ls_request_raw TYPE ty_request_raw,
          ls_response    TYPE ty_response,
          lv_action      TYPE zde_wm_zmigo_action.

    DATA(lv_request_method) = request->get_header_field( i_name = '~request_method' ).
    DATA(lv_request_body)   = request->get_text( ).
    xco_cp_json=>data->from_string( lv_request_body )->apply(
      VALUE #( ( xco_cp_json=>transformation->camel_case_to_underscore ) )
    )->write_to( REF #( ls_request_raw ) ).
    CASE lv_request_method.
      WHEN 'POST'.
        lv_action = request->get_form_field( i_name = 'Action' ).
        DATA(lv_reference) = request->get_form_field( i_name = 'Reference' ).
        ls_response = process_rounter( iv_action        = lv_action
                                       iv_reference     = lv_reference
                                       is_request_raw   = ls_request_raw ).
    ENDCASE.

    IF ls_response-status = cs_message_status-error.
      response->set_status( '400' ).
    ENDIF.
    DATA(lv_response_body) = xco_cp_json=>data->from_abap( ls_response )->apply(
      VALUE #( ( xco_cp_json=>transformation->underscore_to_camel_case ) )
    )->to_string( ).
    response->set_text( i_text = lv_response_body ).
  ENDMETHOD.


  METHOD post_a01_r01."
    DATA: ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code,
          ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01,
          ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print,
          ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm,
          lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun,
          ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret,
          lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr,
          lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr,
          lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex,
          ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex,
          ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create,
          lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create,
          lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create,
          lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber,
          lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat,
          lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA: lv_matnr18 TYPE n LENGTH 18.

    DATA: lv_line_id               TYPE zsc_bapi_goodsmvt_create=>mb_line_id,
          ls_matdoc_incl_eew_ps_id TYPE ty_matdoc_incl_eew_ps_id.

    CHECK es_response-status NE cs_message_status-error.

    ls_goodsmvt_header-pstng_date   = is_request-posting_date.
    ls_goodsmvt_header-doc_date     = is_request-document_date.
    ls_goodsmvt_header-header_txt   = is_request-document_header_text.
    ls_goodsmvt_code-gm_code        = '01'.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id          = lv_line_id.

      ls_goodsmvt_item-material       = ls_request_item-material.
      ls_goodsmvt_item-batch          = ls_request_item-batch.
      ls_goodsmvt_item-plant          = ls_request_item-plant.
      ls_goodsmvt_item-stge_loc       = ls_request_item-storage_location.
      ls_goodsmvt_item-entry_qnt      = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure
        FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
      ls_goodsmvt_item-move_type      = '101'.
      ls_goodsmvt_item-po_number      = ls_request_item-ref_doc.
      ls_goodsmvt_item-po_item        = |{ ls_request_item-ref_item ALPHA = IN }|.
      ls_goodsmvt_item-mvt_ind        = 'B'.
      ls_goodsmvt_item-gl_account     = ls_request_item-gl_account.
      ls_goodsmvt_item-costcenter     = ls_request_item-cost_center.
      ls_goodsmvt_item-wbs_elem       = ls_request_item-wbs_element.
      ls_goodsmvt_item-asset_no       = ls_request_item-asset.
      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR: ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id             = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi    = sy-uname.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c(
        EXPORTING
          im_value     = ls_matdoc_incl_eew_ps_id
        IMPORTING
          ex_container = DATA(lv_container)
      ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin, ls_matdoc_incl_eew_ps_id.
    ENDLOOP.

    call_bapi_goodsmvt_create(
      EXPORTING
        is_goodsmvt_code              = ls_goodsmvt_code
        is_goodsmvt_header            = ls_goodsmvt_header
        is_goodsmvt_print_ctrl        = ls_goodsmvt_print_ctrl
        is_goodsmvt_ref_ewm           = ls_goodsmvt_ref_ewm
        iv_testrun                    = lv_testrun
      IMPORTING
        es_goodsmvt_headret           = ls_goodsmvt_headret
        ev_matdocumentyear            = lv_matdocumentyear
        ev_materialdocument           = lv_materialdocument
      CHANGING
        ct_extensionin                = lt_extensionin
        ct_goodsmvt_item              = lt_goodsmvt_item
        ct_goodsmvt_item_cwm          = lt_goodsmvt_item_cwm
        ct_goodsmvt_serialnumber      = lt_goodsmvt_serialnumber
        ct_goodsmvt_serv_part_data    = lt_goodsmvt_serv_part_data
        ct_return                     = lt_return
        cs_response                   = es_response
    ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD process_a01_r04."
    DATA(ls_request) = check_data_a01_r04(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a01_r04(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD post_r10. "
    DATA ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code.
    DATA ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01.
    DATA ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print.
    DATA ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm.
    DATA lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr.
    DATA ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex.
    DATA lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex.
    DATA ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create.
    DATA lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create.
    DATA lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create.
    DATA lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber.
    DATA lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat.
    DATA lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA lv_line_id                 TYPE zsc_bapi_goodsmvt_create=>mb_line_id.
    DATA ls_matdoc_incl_eew_ps_id   TYPE ty_matdoc_incl_eew_ps_id.

    DATA lv_matnr18                 TYPE n LENGTH 18.

    CHECK es_response-status <> cs_message_status-error.

    ls_goodsmvt_header-pstng_date = is_request-posting_date.
    ls_goodsmvt_header-doc_date   = is_request-document_date.
    ls_goodsmvt_header-header_txt = is_request-document_header_text.
    CASE iv_action.
      WHEN 'A01'.
        ls_goodsmvt_code-gm_code = '05'.
      WHEN 'A07'.
        ls_goodsmvt_code-gm_code = '03'.
      WHEN 'A08'.
        ls_goodsmvt_code-gm_code = '04'.
    ENDCASE.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      IF ls_request_item-move_material IS INITIAL.
*
*      ELSEIF ls_request_item-move_material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-move_material ALPHA = IN }|.
        ls_request_item-move_material = lv_matnr18.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id  = lv_line_id.

      ls_goodsmvt_item-material = ls_request_item-material.

      " If action <> A07 (goods issue), create or update batch
      IF iv_no_upd_batch IS INITIAL.
        IF iv_action <> 'A07'.
          IF ls_request_item-batch IS INITIAL.
            create_batch( EXPORTING iv_material                 = ls_request_item-material
                                    iv_expiration_date          = ls_request_item-expiration_date
                                    iv_production_date          = ls_request_item-production_date
                                    iv_profit_center            = ls_request_item-profit_center
                                    iv_manufacturer             = ls_request_item-manufacturer
                                    iv_lot_num                  = ls_request_item-lot_num
                                    iv_batch_supplier           = ls_request_item-batch_supplier
                                    iv_batch_note               = ls_request_item-batch_note
                                    iv_qc_note                  = ls_request_item-qc_note
                                    iv_production_date_internal = ls_request_item-production_date_internal
                                    iv_expiration_date_internal = ls_request_item-expiration_date_internal
                                    iv_access_code              = ls_request_item-access_code
                                    iv_packaging_spec           = ls_request_item-packaging_spec
                                    iv_origin                   = ls_request_item-origin
                                    iv_gross_weight             = ls_request_item-gross_weight
                                    iv_quantity_btp             = '' " ls_request_item-quantity_btp
                                    iv_quantity_tp              = '' " ls_request_item-quantity_tp
                                    iv_plan_dept_note           = '' " ls_request_item-plan_dept_note
                          CHANGING  ev_batch                    = ls_request_item-batch
                                    es_response                 = es_response ).
          ELSE.
            update_batch( EXPORTING iv_material                 = ls_request_item-material
                                    iv_batch                    = ls_request_item-batch
                                    iv_expiration_date          = ls_request_item-expiration_date
                                    iv_production_date          = ls_request_item-production_date
                                    iv_profit_center            = ls_request_item-profit_center
                                    iv_manufacturer             = ls_request_item-manufacturer
                                    iv_lot_num                  = ls_request_item-lot_num
                                    iv_batch_supplier           = ls_request_item-batch_supplier
                                    iv_batch_note               = ls_request_item-batch_note
                                    iv_qc_note                  = ls_request_item-qc_note
                                    iv_production_date_internal = ls_request_item-production_date_internal
                                    iv_expiration_date_internal = ls_request_item-expiration_date_internal
                                    iv_access_code              = ls_request_item-access_code
                                    iv_packaging_spec           = ls_request_item-packaging_spec
                                    iv_origin                   = ls_request_item-origin
                                    iv_gross_weight             = ls_request_item-gross_weight
                                    iv_quantity_btp             = '' " ls_request_item-quantity_btp
                                    iv_quantity_tp              = '' " ls_request_item-quantity_tp
                                    iv_plan_dept_note           = '' " ls_request_item-plan_dept_note
                          CHANGING  es_response                 = es_response ).
          ENDIF.
        ENDIF.
      ENDIF.

      ls_goodsmvt_item-batch     = ls_request_item-batch.
      ls_goodsmvt_item-plant     = ls_request_item-plant.
      ls_goodsmvt_item-stge_loc  = ls_request_item-storage_location.
      ls_goodsmvt_item-batch     = ls_request_item-batch.
      ls_goodsmvt_item-entry_qnt = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt        = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom  = ls_request_item-entry_uom.

      ls_goodsmvt_item-move_type      = ls_request_item-goods_move_type.
      ls_goodsmvt_item-item_text      = ls_request_item-item_text.
      ls_goodsmvt_item-spec_stock     = ls_request_item-special_stock_type.

      ls_goodsmvt_item-val_sales_ord  = |{ ls_request_item-sales_ord ALPHA = IN }|.
      ls_goodsmvt_item-val_s_ord_item = |{ ls_request_item-sales_ord_item ALPHA = IN }|.

      ls_goodsmvt_item-amount_lc      = ls_request_item-amount_lc.
      ls_goodsmvt_item-gl_account     = |{ ls_request_item-gl_account ALPHA = IN }|.
      ls_goodsmvt_item-costcenter     = ls_request_item-cost_center.
      IF ls_request_item-wbs_element <> '0'.
        ls_goodsmvt_item-wbs_elem = ls_request_item-wbs_element.
      ENDIF.

      ls_goodsmvt_item-vendor     = |{ ls_request_item-vendor ALPHA = IN }|.
      ls_goodsmvt_item-customer   = |{ ls_request_item-customer ALPHA = IN }|.
      ls_goodsmvt_item-suppl_vend = |{ ls_request_item-supplier ALPHA = IN }|.

      ls_goodsmvt_item-orderid    = |{ ls_request_item-manufacturing_order ALPHA = IN }|.

      CASE ls_request_item-goods_move_type.
        WHEN '542'.
          CLEAR ls_goodsmvt_item-spec_stock.
          ls_goodsmvt_item-stge_loc   = ls_request_item-move_storage_location.
        WHEN OTHERS.
          ls_goodsmvt_item-move_plant = ls_request_item-move_plant.
          ls_goodsmvt_item-move_mat   = ls_request_item-move_material.
          ls_goodsmvt_item-move_stloc = ls_request_item-move_storage_location.
          ls_goodsmvt_item-move_batch = ls_request_item-move_batch.
          ls_goodsmvt_item-sales_ord  = |{ ls_request_item-move_sales_ord ALPHA = IN }|.
          ls_goodsmvt_item-s_ord_item = |{ ls_request_item-move_sales_ord_item ALPHA = IN }|.
      ENDCASE.

      IF ls_request_item-stockitemuuid IS NOT INITIAL.
        DATA lv_parenthandlingunituuid TYPE x LENGTH 16.
        DATA lv_stockitemuuid          TYPE x LENGTH 16.

        lv_parenthandlingunituuid = ls_request_item-parenthandlingunituuid.
        lv_stockitemuuid          = ls_request_item-stockitemuuid.

        SELECT SINGLE ewmwarehouse,
                      ewmstoragebin,
                      handlingunitnumber,
                      qualityinspectiondocuuid
          FROM zi_ewm_physstockprod
          WHERE parenthandlingunituuid = @lv_parenthandlingunituuid
            AND stockitemuuid          = @lv_stockitemuuid
          INTO @DATA(ls_stock).
        IF sy-subrc = 0.
          ls_goodsmvt_item-warehouse_ewm     = ls_stock-ewmwarehouse.
          ls_goodsmvt_item-stge_bin_ewm      = ls_stock-ewmstoragebin.
          ls_goodsmvt_item-target_bin_ewm    = ls_stock-ewmstoragebin.
          ls_goodsmvt_item-ewm_handling_unit = ls_stock-handlingunitnumber.
          ls_goodsmvt_item-ewm_inspuuid      = ls_stock-qualityinspectiondocuuid.

          ls_goodsmvt_header-ext_wms = 3.
        ENDIF.
      ENDIF.

      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id          = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi = sy-uname.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c( EXPORTING im_value     = ls_matdoc_incl_eew_ps_id
                        IMPORTING ex_container = DATA(lv_container) ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin,
             ls_matdoc_incl_eew_ps_id.
    ENDLOOP.

    call_bapi_goodsmvt_create( EXPORTING is_goodsmvt_code           = ls_goodsmvt_code
                                         is_goodsmvt_header         = ls_goodsmvt_header
                                         is_goodsmvt_print_ctrl     = ls_goodsmvt_print_ctrl
                                         is_goodsmvt_ref_ewm        = ls_goodsmvt_ref_ewm
                                         iv_testrun                 = lv_testrun
                               IMPORTING es_goodsmvt_headret        = ls_goodsmvt_headret
                                         ev_matdocumentyear         = lv_matdocumentyear
                                         ev_materialdocument        = lv_materialdocument
                               CHANGING  ct_extensionin             = lt_extensionin
                                         ct_goodsmvt_item           = lt_goodsmvt_item
                                         ct_goodsmvt_item_cwm       = lt_goodsmvt_item_cwm
                                         ct_goodsmvt_serialnumber   = lt_goodsmvt_serialnumber
                                         ct_goodsmvt_serv_part_data = lt_goodsmvt_serv_part_data
                                         ct_return                  = lt_return
                                         cs_response                = es_response ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD check_data_a01_r05."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD update_inbound."
    DATA: lt_delivery_item_update TYPE TABLE FOR UPDATE i_inbounddeliveryitemtp.

    CHECK es_response-status NE cs_message_status-error.

    CHECK it_data IS NOT INITIAL.

    DATA(lt_data) = it_data.

    SORT lt_data BY inbounddelivery inbounddeliveryitem.

    " delete all batch split
    LOOP AT lt_data INTO DATA(ls_data) WHERE higherlvlitmofbatspltitm IS NOT INITIAL.
      DATA(lv_etag) = get_etag_inbound_item(
        iv_inbounddelivery     = ls_data-inbounddelivery
        iv_inbounddeliveryitem = ls_data-inbounddeliveryitem
      ).

      delete_inbound_item(
        EXPORTING
          iv_etag                = lv_etag
          iv_inbounddelivery     = ls_data-inbounddelivery
          iv_inbounddeliveryitem = ls_data-inbounddeliveryitem
        CHANGING
          es_response            = es_response
      ).
    ENDLOOP.

    SELECT
      i_inbounddeliveryitem~inbounddelivery,
      i_inbounddeliveryitem~inbounddeliveryitem,
      i_product~isbatchmanagementrequired,
      i_inbounddeliveryitem~storagelocation,
      i_inbounddeliveryitem~batch
      FROM i_inbounddeliveryitem
      INNER JOIN i_product
      ON  i_inbounddeliveryitem~material = i_product~product
      FOR ALL ENTRIES IN @lt_data
      WHERE i_inbounddeliveryitem~inbounddelivery     = @lt_data-inbounddelivery
        AND i_inbounddeliveryitem~inbounddeliveryitem = @lt_data-inbounddeliveryitem
      INTO TABLE @DATA(lt_inbound).
    IF sy-subrc EQ 0.
      SORT lt_inbound BY inbounddelivery inbounddeliveryitem.
    ENDIF.

    LOOP AT lt_data INTO ls_data.
      IF ls_data-higherlvlitmofbatspltitm IS NOT INITIAL.
        ls_data-inbounddeliveryitem = ls_data-higherlvlitmofbatspltitm.
      ENDIF.
      READ TABLE lt_inbound INTO DATA(ls_inbound)
        WITH KEY inbounddelivery     = ls_data-inbounddelivery
                 inbounddeliveryitem = ls_data-inbounddeliveryitem BINARY SEARCH.
      IF sy-subrc EQ 0.
        READ TABLE lt_delivery_item_update ASSIGNING FIELD-SYMBOL(<lfs_delivery_item_update>)
          WITH KEY inbounddelivery     = ls_data-inbounddelivery
                   inbounddeliveryitem = ls_data-inbounddeliveryitem BINARY SEARCH.
        IF sy-subrc NE 0.
          APPEND VALUE #(
            inbounddelivery     = ls_data-inbounddelivery
            inbounddeliveryitem = ls_data-inbounddeliveryitem
          ) TO lt_delivery_item_update ASSIGNING <lfs_delivery_item_update>.
          SORT lt_delivery_item_update BY inbounddelivery inbounddeliveryitem.

          " only update storage location and batch if WM is not active for material
          IF iv_is_wm IS INITIAL.
            IF ls_inbound-storagelocation NE ls_data-storagelocation.
              <lfs_delivery_item_update>-storagelocation          = ls_data-storagelocation.
              <lfs_delivery_item_update>-%control-storagelocation = cl_abap_behv=>flag_changed.
            ENDIF.
            IF ls_inbound-isbatchmanagementrequired EQ 'X' AND
               ls_inbound-batch IS NOT INITIAL.
              <lfs_delivery_item_update>-%control-batch           = cl_abap_behv=>flag_changed.
            ENDIF.
          ENDIF.
        ENDIF.
        <lfs_delivery_item_update>-actualdeliveredqtyinorderunit          += ls_data-actualdeliveryquantity.
        <lfs_delivery_item_update>-%control-actualdeliveredqtyinorderunit = cl_abap_behv=>flag_changed.

        SELECT SINGLE unitofmeasure
          FROM i_unitofmeasure
          WHERE unitofmeasure_e = @ls_data-deliveryquantityunit
          INTO @<lfs_delivery_item_update>-orderquantityunit .
*        <lfs_delivery_item_update>-orderquantityunit                      = ls_data-deliveryquantityunit.
        <lfs_delivery_item_update>-%control-orderquantityunit             = cl_abap_behv=>flag_changed.
      ENDIF.
    ENDLOOP.

    SORT lt_delivery_item_update BY inbounddelivery inbounddeliveryitem.
    DELETE ADJACENT DUPLICATES FROM lt_delivery_item_update COMPARING inbounddelivery inbounddeliveryitem.

    CHECK es_response-status NE cs_message_status-error.

    DELETE lt_delivery_item_update WHERE %control IS INITIAL.

    MODIFY ENTITIES OF i_inbounddeliverytp
      ENTITY inbounddeliveryitem
        UPDATE SET FIELDS
        WITH lt_delivery_item_update
      FAILED   DATA(lt_failed_update)
      REPORTED DATA(lt_reported_update).

    IF lt_failed_update IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT lt_reported_update-inbounddelivery INTO DATA(ls_reported_delivery).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_delivery-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT lt_reported_update-inbounddeliveryitem INTO DATA(ls_reported_delivery_item).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_delivery_item-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
    ENDIF.

    CHECK es_response-status NE cs_message_status-error.

    " create batch split
    LOOP AT lt_data INTO ls_data.
      APPEND ls_data TO et_data ASSIGNING FIELD-SYMBOL(<lfs_data_out>).
      IF ls_data-higherlvlitmofbatspltitm IS NOT INITIAL.
        ls_data-inbounddeliveryitem = ls_data-higherlvlitmofbatspltitm.
      ENDIF.

*      lv_etag = get_etag_inbound_item(
*        iv_inbounddelivery       = ls_data-inbounddelivery
*        iv_inbounddeliveryitem   = ls_data-inbounddeliveryitem
*      ).
*
*      update_inbound_item(
*        EXPORTING
*          iv_etag                 = lv_etag
*          iv_inbounddelivery      = ls_data-inbounddelivery
*          iv_inbounddeliveryitem  = ls_data-inbounddeliveryitem
*          iv_storagelocation      = ls_data-storagelocation
*        CHANGING
*          es_response             = es_response
*      ).

      lv_etag = get_etag_inbound_item(
        iv_inbounddelivery       = ls_data-inbounddelivery
        iv_inbounddeliveryitem   = ls_data-inbounddeliveryitem
      ).

      DATA(lv_posnr_new) = create_batch_split_inbound(
        EXPORTING
          iv_etag                   = lv_etag
          iv_inbounddelivery        = ls_data-inbounddelivery
          iv_inbounddeliveryitem    = ls_data-inbounddeliveryitem
          iv_batch                  = ls_data-batch
          iv_deliveryquantityunit   = ls_data-deliveryquantityunit
          iv_actualdeliveryquantity = ls_data-actualdeliveryquantity
          iv_storagelocation        = ls_data-storagelocation
        CHANGING
          es_response               = es_response
      ).

      update_custom_field_inb_item(
        EXPORTING
          iv_inbounddelivery        = ls_data-inbounddelivery
          iv_inbounddeliveryitem    = lv_posnr_new
          iv_createby               = sy-uname
        CHANGING
          es_response               = es_response
      ).

      <lfs_data_out>-inbounddeliveryitem_new = lv_posnr_new.
    ENDLOOP.
  ENDMETHOD.


  METHOD update_return_dlv."
    CHECK es_response-status NE cs_message_status-error.

    CHECK it_data IS NOT INITIAL.

    DATA(lt_data) = it_data.

    SORT lt_data BY customerreturndelivery customerreturndeliveryitem.

    " delete all batch split
*    LOOP AT lt_data INTO DATA(ls_data) WHERE higherlvlitmofbatspltitm IS NOT INITIAL.
*      DATA(lv_etag) = get_etag_return_dlv_item(
*        iv_customerreturndelivery     = ls_data-customerreturndelivery
*        iv_customerreturndeliveryitem = ls_data-customerreturndeliveryitem
*      ).
*
*      delete_return_dlv_item(
*        EXPORTING
*          iv_etag                   = lv_etag
*          iv_customerreturndelivery       = ls_data-customerreturndelivery
*          iv_customerreturndeliveryitem   = ls_data-customerreturndeliveryitem
*        CHANGING
*          es_response               = es_response
*      ).
*    ENDLOOP.

    " create batch split
    LOOP AT lt_data INTO DATA(ls_data).
*      IF ls_data-higherlvlitmofbatspltitm IS NOT INITIAL.
*        ls_data-customerreturndeliveryitem = ls_data-higherlvlitmofbatspltitm.
*      ENDIF.
*
*      lv_etag = get_etag_return_dlv_item(
*        iv_customerreturndelivery       = ls_data-customerreturndelivery
*        iv_customerreturndeliveryitem   = ls_data-customerreturndeliveryitem
*      ).
*
*      DATA(lv_posnr_new) = create_batch_split_return_dlv(
*        EXPORTING
*          iv_is_wm                  = iv_is_wm
*          iv_etag                   = lv_etag
*          iv_customerreturndelivery       = ls_data-customerreturndelivery
*          iv_customerreturndeliveryitem   = ls_data-customerreturndeliveryitem
*          iv_batch                  = ls_data-batch
*          iv_deliveryquantityunit   = ls_data-deliveryquantityunit
*          iv_actualdeliveryquantity = ls_data-actualdeliveryquantity
*        CHANGING
*          es_response               = es_response
*      ).

      update_custom_field_redlv_item(
        EXPORTING
          iv_customerreturndelivery     = ls_data-customerreturndelivery
          iv_customerreturndeliveryitem = ls_data-customerreturndeliveryitem
          iv_createby                   = sy-uname
        CHANGING
          es_response                   = es_response
      ).

      DATA(lv_etag) = get_etag_return_dlv_item(
        iv_customerreturndelivery       = ls_data-customerreturndelivery
        iv_customerreturndeliveryitem   = ls_data-customerreturndeliveryitem
      ).

      update_return_dlv_item(
        EXPORTING
          iv_etag                       = lv_etag
          iv_customerreturndelivery     = ls_data-customerreturndelivery
          iv_customerreturndeliveryitem = ls_data-customerreturndeliveryitem
          iv_storagelocation            = ls_data-storagelocation
        CHANGING
          es_response                   = es_response
      ).
    ENDLOOP.
  ENDMETHOD.


  METHOD process_a02_r02."
    DATA(ls_request) = check_data_a02_r02(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a02_r02(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD post_a08_r01."
    DATA: ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code,
          ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01,
          ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print,
          ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm,
          lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun,
          ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret,
          lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr,
          lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr,
          lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex,
          ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex,
          ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create,
          lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create,
          lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create,
          lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber,
          lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat,
          lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA: lv_matnr18 TYPE n LENGTH 18.

    DATA: lv_line_id               TYPE zsc_bapi_goodsmvt_create=>mb_line_id,
          ls_matdoc_incl_eew_ps_id TYPE ty_matdoc_incl_eew_ps_id.

    CHECK es_response-status NE cs_message_status-error.

    ls_goodsmvt_header-pstng_date   = is_request-posting_date.
    ls_goodsmvt_header-doc_date     = is_request-document_date.
    ls_goodsmvt_header-header_txt   = is_request-document_header_text.
    ls_goodsmvt_code-gm_code        = '04'.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id          = lv_line_id.

      ls_goodsmvt_item-material       = ls_request_item-material.
      ls_goodsmvt_item-batch          = ls_request_item-batch.
      ls_goodsmvt_item-plant          = ls_request_item-plant.
      ls_goodsmvt_item-stge_loc       = ls_request_item-storage_location.
      ls_goodsmvt_item-entry_qnt      = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure
        FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
      IF ls_request_item-move_material IS INITIAL.
*
*      ELSEIF ls_request_item-move_material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-move_material ALPHA = IN }|.
        ls_request_item-move_material = lv_matnr18.
      ENDIF.

      ls_goodsmvt_item-move_mat       = ls_request_item-move_material.
      ls_goodsmvt_item-move_batch     = ls_request_item-move_batch.
*      ls_goodsmvt_item-move_plant     = ls_request_item-move_plant.
*      ls_goodsmvt_item-move_stloc     = ls_request_item-move_storage_location.

      ls_goodsmvt_item-move_type      = '541'.
      ls_goodsmvt_item-po_number      = ls_request_item-ref_doc.
      ls_goodsmvt_item-po_item        = ''.
      ls_goodsmvt_item-vendor         = |{ ls_request_item-vendor ALPHA = IN }|.
      ls_goodsmvt_item-mvt_ind        = ''.
      ls_goodsmvt_item-gl_account     = ''.
      ls_goodsmvt_item-costcenter     = ''.
      ls_goodsmvt_item-wbs_elem       = ''.
      ls_goodsmvt_item-asset_no       = ''.
      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR: ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id             = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi    = sy-uname.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c(
        EXPORTING
          im_value     = ls_matdoc_incl_eew_ps_id
        IMPORTING
          ex_container = DATA(lv_container)
      ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin, ls_matdoc_incl_eew_ps_id.
    ENDLOOP.

    call_bapi_goodsmvt_create(
      EXPORTING
        is_goodsmvt_code              = ls_goodsmvt_code
        is_goodsmvt_header            = ls_goodsmvt_header
        is_goodsmvt_print_ctrl        = ls_goodsmvt_print_ctrl
        is_goodsmvt_ref_ewm           = ls_goodsmvt_ref_ewm
        iv_testrun                    = lv_testrun
      IMPORTING
        es_goodsmvt_headret           = ls_goodsmvt_headret
        ev_matdocumentyear            = lv_matdocumentyear
        ev_materialdocument           = lv_materialdocument
      CHANGING
        ct_extensionin                = lt_extensionin
        ct_goodsmvt_item              = lt_goodsmvt_item
        ct_goodsmvt_item_cwm          = lt_goodsmvt_item_cwm
        ct_goodsmvt_serialnumber      = lt_goodsmvt_serialnumber
        ct_goodsmvt_serv_part_data    = lt_goodsmvt_serv_part_data
        ct_return                     = lt_return
        cs_response                   = es_response
    ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD process_a10_r02."
    DATA(ls_request) = check_data_a10_r02(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a10_r02(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD post_a11_r01."

    DATA: ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code,
          ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01,
          ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print,
          ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm,
          lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun,
          ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret,
          lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr,
          lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr,
          lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex,
          ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex,
          ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create,
          lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create,
          lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create,
          lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber,
          lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat,
          lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA: lv_matnr18   TYPE n LENGTH 18,
          lv_parent_id TYPE zsc_bapi_goodsmvt_create=>mb_parent_id.

    DATA: lv_line_id               TYPE zsc_bapi_goodsmvt_create=>mb_line_id,
          ls_matdoc_incl_eew_ps_id TYPE ty_matdoc_incl_eew_ps_id.

    CHECK es_response-status NE cs_message_status-error.

    ls_goodsmvt_header-pstng_date   = is_request-posting_date.
    ls_goodsmvt_header-doc_date     = is_request-document_date.
    ls_goodsmvt_header-header_txt   = is_request-document_header_text.
    ls_goodsmvt_code-gm_code        = '07'.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      ls_goodsmvt_item-material       = ls_request_item-material.
      ls_goodsmvt_item-batch          = ls_request_item-batch.
      ls_goodsmvt_item-plant          = ls_request_item-plant.
      ls_goodsmvt_item-stge_loc       = ls_request_item-storage_location.
      IF ls_request_item-is_component IS INITIAL.
        ls_goodsmvt_item-move_type      = '121'.
        lv_line_id += 1.
        lv_parent_id = lv_line_id.
        ls_goodsmvt_item-line_id        = lv_line_id.
        ls_goodsmvt_item-parent_id      = '000000'.
      ELSEIF ls_request_item-short_receipt_value IS INITIAL.
        ls_goodsmvt_item-entry_qnt      = convert_entry_quantity( ls_request_item-entry_quantity ).
*        ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
        SELECT SINGLE unitofmeasure
          FROM i_unitofmeasure
          WHERE unitofmeasure_e = @ls_request_item-entry_uom
          INTO @ls_goodsmvt_item-entry_uom.
*        ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
        ls_goodsmvt_item-move_type      = '543'.
        lv_line_id += 1.
        ls_goodsmvt_item-line_id        = lv_line_id.
        ls_goodsmvt_item-parent_id      = lv_parent_id.
      ELSE.
        ls_goodsmvt_item-entry_qnt      = convert_entry_quantity( ls_request_item-entry_quantity ).
*        ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
        SELECT SINGLE unitofmeasure
          FROM i_unitofmeasure
          WHERE unitofmeasure_e = @ls_request_item-entry_uom
          INTO @ls_goodsmvt_item-entry_uom.
*        ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
        ls_goodsmvt_item-move_type      = '544'.
        lv_line_id += 1.
        ls_goodsmvt_item-line_id        = lv_line_id.
        ls_goodsmvt_item-parent_id      = lv_parent_id.
      ENDIF.
      ls_goodsmvt_item-po_number      = ls_request_item-ref_doc.
      ls_goodsmvt_item-po_item        = |{ ls_request_item-ref_item ALPHA = IN }|.
      ls_goodsmvt_item-mvt_ind        = 'O'.
      ls_goodsmvt_item-vendor         = |{ ls_request_item-supplier ALPHA = IN }|.
      ls_goodsmvt_item-gl_account     = ''.
      ls_goodsmvt_item-costcenter     = ''.
      ls_goodsmvt_item-wbs_elem       = ''.
      ls_goodsmvt_item-asset_no       = ''.
      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR: ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id             = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi    = sy-uname.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c(
        EXPORTING
          im_value     = ls_matdoc_incl_eew_ps_id
        IMPORTING
          ex_container = DATA(lv_container)
      ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin, ls_matdoc_incl_eew_ps_id.
    ENDLOOP.

    call_bapi_goodsmvt_create(
      EXPORTING
        is_goodsmvt_code              = ls_goodsmvt_code
        is_goodsmvt_header            = ls_goodsmvt_header
        is_goodsmvt_print_ctrl        = ls_goodsmvt_print_ctrl
        is_goodsmvt_ref_ewm           = ls_goodsmvt_ref_ewm
        iv_testrun                    = lv_testrun
      IMPORTING
        es_goodsmvt_headret           = ls_goodsmvt_headret
        ev_matdocumentyear            = lv_matdocumentyear
        ev_materialdocument           = lv_materialdocument
      CHANGING
        ct_extensionin                = lt_extensionin
        ct_goodsmvt_item              = lt_goodsmvt_item
        ct_goodsmvt_item_cwm          = lt_goodsmvt_item_cwm
        ct_goodsmvt_serialnumber      = lt_goodsmvt_serialnumber
        ct_goodsmvt_serv_part_data    = lt_goodsmvt_serv_part_data
        ct_return                     = lt_return
        cs_response                   = es_response
    ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD post_r09. "
    DATA ls_goodsmvt_code            TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code.
    DATA ls_goodsmvt_header          TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01.
    DATA ls_goodsmvt_print_ctrl      TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print.
    DATA ls_goodsmvt_ref_ewm         TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm.
    DATA lv_testrun                  TYPE zsc_bapi_goodsmvt_create=>testrun.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA ls_goodsmvt_headret         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_matdocumentyear          TYPE zsc_bapi_goodsmvt_create=>mjahr.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_materialdocument         TYPE zsc_bapi_goodsmvt_create=>mblnr.
    DATA ls_extensionin              TYPE zsc_bapi_goodsmvt_create=>bapiparex.
    DATA lt_extensionin              TYPE zsc_bapi_goodsmvt_create=>_bapiparex.
    DATA ls_goodsmvt_item            TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create.
    DATA lt_goodsmvt_item            TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create.
    DATA lt_goodsmvt_item_cwm        TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create.
    DATA lt_goodsmvt_serialnumber    TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber.
    DATA lt_goodsmvt_serv_part_data  TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat.
    DATA lt_return                   TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA lv_line_id                  TYPE zsc_bapi_goodsmvt_create=>mb_line_id.
    DATA ls_matdoc_incl_eew_ps_id    TYPE ty_matdoc_incl_eew_ps_id.

    DATA lv_matnr18                  TYPE n LENGTH 18.

    DATA lv_expiration_date          TYPE string.
    DATA lv_production_date          TYPE string.
    DATA lv_profit_center            TYPE string.
    DATA lv_manufacturer             TYPE string.
    DATA lv_lot_num                  TYPE string.
    DATA lv_batch_supplier           TYPE string.
    DATA lv_batch_note               TYPE string.
    DATA lv_qc_note                  TYPE string.
    DATA lv_production_date_internal TYPE string.
    DATA lv_expiration_date_internal TYPE string.
    DATA lv_access_code              TYPE string.
    DATA lv_packaging_spec           TYPE string.
    DATA lv_origin                   TYPE string.
    DATA lv_gross_weight             TYPE string.
    DATA lv_quantity_btp             TYPE string.
    DATA lv_quantity_tp              TYPE string.
    DATA lv_plan_dept_note           TYPE string.

    CHECK es_response-status <> cs_message_status-error.

    ls_goodsmvt_header-pstng_date = is_request-posting_date.
    ls_goodsmvt_header-doc_date   = is_request-document_date.
    ls_goodsmvt_header-header_txt = is_request-document_header_text.
    CASE iv_action.
      WHEN 'A01'.
        ls_goodsmvt_code-gm_code = '05'.
      WHEN 'A07'.
        ls_goodsmvt_code-gm_code = '03'.
      WHEN 'A08'.
        ls_goodsmvt_code-gm_code = '04'.
    ENDCASE.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      IF ls_request_item-move_material IS INITIAL.
*
*      ELSEIF ls_request_item-move_material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-move_material ALPHA = IN }|.
        ls_request_item-move_material = lv_matnr18.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id   = lv_line_id.

      ls_goodsmvt_item-plant     = ls_request_item-plant.
      ls_goodsmvt_item-batch     = ls_request_item-batch.

      ls_goodsmvt_item-material  = ls_request_item-material.
      ls_goodsmvt_item-stge_loc  = ls_request_item-storage_location.
      ls_goodsmvt_item-batch     = ls_request_item-batch.
      ls_goodsmvt_item-entry_qnt = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt        = ls_request_item-entry_quantity.
      SELECT SINGLE UnitOfMeasure FROM I_UnitOfMeasure
        WHERE UnitOfMeasure_E = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom  = ls_request_item-entry_uom.

      ls_goodsmvt_item-move_type      = ls_request_item-goods_move_type.
*      ls_goodsmvt_item-item_text        = ls_request_item-item_text.
      ls_goodsmvt_item-spec_stock     = ls_request_item-special_stock_type.

      ls_goodsmvt_item-val_sales_ord  = |{ ls_request_item-sales_ord ALPHA = IN }|.
      ls_goodsmvt_item-val_s_ord_item = |{ ls_request_item-sales_ord_item ALPHA = IN }|.

      ls_goodsmvt_item-gl_account     = |{ ls_request_item-gl_account ALPHA = IN }|.
      ls_goodsmvt_item-costcenter     = ls_request_item-cost_center.

      ls_goodsmvt_item-amount_lc      = ls_request_item-amount_lc.

      SELECT SINGLE ps_psp_pnr FROM ztb_wm_rkpf
        WHERE rsnum = @ls_request_item-ref_doc
        INTO @DATA(lv_ps_psp_pnr).
      IF sy-subrc = 0.
        IF lv_ps_psp_pnr <> '00000000' AND lv_ps_psp_pnr IS NOT INITIAL.
          ls_goodsmvt_item-wbs_elem = lv_ps_psp_pnr.
        ENDIF.
      ENDIF.
*      IF ls_request_item-wbs_element NE '0' AND ls_request_item-wbs_element IS NOT INITIAL AND ls_request_item-wbs_element  NE '00000000'.
*        ls_goodsmvt_item-wbs_elem         = ls_request_item-wbs_element.
*      ENDIF.

      ls_goodsmvt_item-vendor     = |{ ls_request_item-vendor ALPHA = IN }|.
      ls_goodsmvt_item-customer   = |{ ls_request_item-customer ALPHA = IN }|.
      ls_goodsmvt_item-suppl_vend = |{ ls_request_item-supplier ALPHA = IN }|.

      CASE ls_request_item-goods_move_type.
        WHEN '542'.
          CLEAR ls_goodsmvt_item-spec_stock.
          ls_goodsmvt_item-stge_loc   = ls_request_item-move_storage_location.
        WHEN OTHERS.
          ls_goodsmvt_item-move_plant = ls_request_item-move_plant.
          ls_goodsmvt_item-move_mat   = ls_request_item-move_material.
          ls_goodsmvt_item-move_stloc = ls_request_item-move_storage_location.
          ls_goodsmvt_item-move_batch = ls_request_item-move_batch.
          ls_goodsmvt_item-sales_ord  = |{ ls_request_item-move_sales_ord ALPHA = IN }|.
          ls_goodsmvt_item-s_ord_item = |{ ls_request_item-move_sales_ord_item ALPHA = IN }|.
      ENDCASE.

      " cho TH action = a08 + r09
      IF iv_action = 'A08'.
        SELECT SINGLE factory_id FROM ztb_wm_cf_slo_wm
          WHERE plant            = @ls_request_item-plant
            AND storage_location = @ls_request_item-storage_location
          INTO @DATA(lv_fac_id_s).
        SELECT SINGLE factory_id FROM ztb_wm_cf_slo_wm
          WHERE plant            = @ls_request_item-move_plant
            AND storage_location = @ls_request_item-move_storage_location
          INTO @DATA(lv_fac_id_d).
        " xét theo sloc xuất + id nhà máy xuất và sloc nhận + id nhà máy nhận --> nếu id nhà máy xuất # id nhà máy nhận
        IF lv_fac_id_d <> lv_fac_id_s.
          read_batch( EXPORTING iv_material                 = ls_request_item-material
                                iv_batch                    = ls_request_item-batch
                      CHANGING  ev_expiration_date          = lv_expiration_date
                                ev_production_date          = lv_production_date
                                ev_profit_center            = lv_profit_center
                                ev_manufacturer             = lv_manufacturer
                                ev_lot_num                  = lv_lot_num
                                ev_batch_supplier           = lv_batch_supplier
                                ev_batch_note               = lv_batch_note
                                ev_qc_note                  = lv_qc_note
                                ev_production_date_internal = lv_production_date_internal
                                ev_expiration_date_internal = lv_expiration_date_internal
                                ev_access_code              = lv_access_code
                                ev_packaging_spec           = lv_packaging_spec
                                ev_origin                   = lv_origin
                                ev_gross_weight             = lv_gross_weight
                                ev_quantity_btp             = lv_quantity_btp
                                ev_quantity_tp              = lv_quantity_tp
                                ev_plan_dept_note           = lv_plan_dept_note
                                es_response                 = es_response ).

          " Đối với Profit Center: Xét dựa trên Material Type (Tham chiếu chỉ tiêu 4 MATERIAL
          " --> Truyền vô CDs View I_PRODUCT - PRODUCT --> Lấy ra PRODUCTTYPE).
          " Xét bảng bên cạnh,
          " nếu Material Type được tick "Giữ nguyên PC"
          " --> Profit Center giữ nguyên.
          " Nếu Material Type chưa được khai báo hoặc k được tick "Giữ nguyên PC"
          " --> Profit Center ăn theo sloc nhận
          SELECT COUNT( * )
            FROM i_product
                 INNER JOIN ztb_wm_mattyp_pc ON i_product~ProductType = ztb_wm_mattyp_pc~mtart
            WHERE i_product~Product            = @ls_request_item-material
              AND ztb_wm_mattyp_pc~is_keep_pc IS NOT INITIAL.
          IF sy-subrc <> 0.
            CLEAR lv_profit_center.
            SELECT SINGLE factory_id FROM ztb_wm_cf_slo_wm
              WHERE plant            = @ls_request_item-move_plant
                AND storage_location = @ls_request_item-move_storage_location
              INTO @lv_profit_center.
            IF sy-subrc = 0.
              lv_profit_center = |{ lv_profit_center ALPHA = OUT }|.
            ENDIF.
          ENDIF.
          update_batch( EXPORTING iv_material                 = ls_request_item-move_material
                                  iv_batch                    = ls_request_item-move_batch
                                  iv_expiration_date          = lv_expiration_date
                                  iv_production_date          = lv_production_date
                                  iv_profit_center            = lv_profit_center
                                  iv_manufacturer             = lv_manufacturer
                                  iv_lot_num                  = lv_lot_num
                                  iv_batch_supplier           = lv_batch_supplier
                                  iv_batch_note               = lv_batch_note
                                  iv_qc_note                  = lv_qc_note
                                  iv_production_date_internal = lv_production_date_internal
                                  iv_expiration_date_internal = lv_expiration_date_internal
                                  iv_access_code              = lv_access_code
                                  iv_packaging_spec           = lv_packaging_spec
                                  iv_origin                   = lv_origin
                                  iv_gross_weight             = lv_gross_weight
                                  iv_quantity_btp             = lv_quantity_btp
                                  iv_quantity_tp              = lv_quantity_tp
                                  iv_plan_dept_note           = lv_plan_dept_note
                        CHANGING  es_response                 = es_response ).
        ELSE.
          update_gross_weight( EXPORTING iv_material     = ls_request_item-material
                                         iv_batch        = ls_request_item-batch
                                         iv_gross_weight = ls_request_item-gross_weight
                               CHANGING  es_response     = es_response ).
        ENDIF.
      ELSEIF iv_action = 'A01'.
        update_batch( EXPORTING iv_material                 = ls_request_item-material
                                iv_batch                    = ls_request_item-batch
                                iv_expiration_date          = ls_request_item-expiration_date
                                iv_production_date          = ls_request_item-production_date
                                iv_profit_center            = ls_request_item-profit_center
                                iv_manufacturer             = ls_request_item-manufacturer
                                iv_lot_num                  = ls_request_item-lot_num
                                iv_batch_supplier           = ls_request_item-batch_supplier
                                iv_batch_note               = ls_request_item-batch_note
                                iv_qc_note                  = ls_request_item-qc_note
                                iv_production_date_internal = ls_request_item-production_date_internal
                                iv_expiration_date_internal = ls_request_item-expiration_date_internal
                                iv_access_code              = ls_request_item-access_code
                                iv_packaging_spec           = ls_request_item-packaging_spec
                                iv_origin                   = ls_request_item-origin
                                iv_gross_weight             = ls_request_item-gross_weight
                                iv_quantity_btp             = ls_request_item-quantity_btp
                                iv_quantity_tp              = ls_request_item-quantity_tp
                                iv_plan_dept_note           = ls_request_item-plan_dept_note
                      CHANGING  es_response                 = es_response ).
      ENDIF.

      IF ls_request_item-stockitemuuid IS NOT INITIAL.
        DATA lv_parenthandlingunituuid TYPE x LENGTH 16.
        DATA lv_stockitemuuid          TYPE x LENGTH 16.

        lv_parenthandlingunituuid = ls_request_item-parenthandlingunituuid.
        lv_stockitemuuid          = ls_request_item-stockitemuuid.

        SELECT SINGLE EWMWarehouse,
                      EWMStorageBin,
                      HandlingUnitNumber,
                      QualityInspectionDocUUID
          FROM zi_ewm_physstockprod
          WHERE ParentHandlingUnitUUID = @lv_parenthandlingunituuid
            AND StockItemUUID          = @lv_stockitemuuid
          INTO @DATA(ls_stock).
        IF sy-subrc = 0.
          ls_goodsmvt_item-warehouse_ewm     = ls_stock-EWMWarehouse.
          ls_goodsmvt_item-stge_bin_ewm      = ls_stock-EWMStorageBin.
          ls_goodsmvt_item-target_bin_ewm    = ls_stock-EWMStorageBin.
          ls_goodsmvt_item-ewm_handling_unit = ls_stock-HandlingUnitNumber.
          ls_goodsmvt_item-ewm_inspuuid      = ls_stock-QualityInspectionDocUUID.

          ls_goodsmvt_header-ext_wms = 3.
        ENDIF.
      ENDIF.

      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id                    = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi           = sy-uname.
      ls_matdoc_incl_eew_ps_id-yy1_mm_zreservation_mmi    = ls_request_item-ref_doc.
      ls_matdoc_incl_eew_ps_id-yy1_mm_zreservationite_mmi = |{ ls_request_item-ref_item ALPHA = IN }|.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c( EXPORTING im_value     = ls_matdoc_incl_eew_ps_id
                        IMPORTING ex_container = DATA(lv_container) ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin,
             ls_matdoc_incl_eew_ps_id,
             lv_expiration_date,
             lv_production_date,
             lv_profit_center,
             lv_manufacturer,
             lv_lot_num,
             lv_batch_supplier,
             lv_batch_note,
             lv_qc_note,
             lv_production_date_internal,
             lv_expiration_date_internal,
             lv_access_code,
             lv_packaging_spec,
             lv_origin,
             lv_gross_weight,
             lv_quantity_btp,
             lv_quantity_tp,
             lv_plan_dept_note.
    ENDLOOP.

    call_bapi_goodsmvt_create( EXPORTING is_goodsmvt_code           = ls_goodsmvt_code
                                         is_goodsmvt_header         = ls_goodsmvt_header
                                         is_goodsmvt_print_ctrl     = ls_goodsmvt_print_ctrl
                                         is_goodsmvt_ref_ewm        = ls_goodsmvt_ref_ewm
                                         iv_testrun                 = lv_testrun
                               IMPORTING es_goodsmvt_headret        = ls_goodsmvt_headret
                                         ev_matdocumentyear         = lv_matdocumentyear
                                         ev_materialdocument        = lv_materialdocument
                               CHANGING  ct_extensionin             = lt_extensionin
                                         ct_goodsmvt_item           = lt_goodsmvt_item
                                         ct_goodsmvt_item_cwm       = lt_goodsmvt_item_cwm
                                         ct_goodsmvt_serialnumber   = lt_goodsmvt_serialnumber
                                         ct_goodsmvt_serv_part_data = lt_goodsmvt_serv_part_data
                                         ct_return                  = lt_return
                                         cs_response                = es_response ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.

    IF es_response-status = cs_message_status-success.
      TYPES: BEGIN OF lty_data,
               ref_doc        TYPE zde_wm_rsnum,
               ref_item       TYPE rspos,
               entry_uom      TYPE meins,
               entry_quantity TYPE zde_enmng,
               material       TYPE matnr,
               batch          TYPE charg_d,
               gross_weight   TYPE c LENGTH 20,
             END OF lty_data.
      TYPES lty_resb_upd TYPE ztb_wm_resb WITH INDICATORS col_ind TYPE abap_bool.
      DATA lt_data     TYPE TABLE OF lty_data.
      DATA lt_resb_upd TYPE TABLE OF lty_resb_upd.
      DATA lv_atinn    TYPE atinn_no_conv.

      MOVE-CORRESPONDING is_request-items TO lt_data.

      SELECT SINGLE CharcInternalID FROM I_ClfnCharacteristic
        WHERE Characteristic = 'Z_GW'
        INTO @lv_atinn.

      SELECT DISTINCT data~material,
                      data~batch,
                      data~gross_weight
        FROM zi_wm_zmigo_r09( p_action = @iv_action )
             INNER JOIN @lt_data AS data              ON  zi_wm_zmigo_r09~reservation     = data~ref_doc
                                                      AND zi_wm_zmigo_r09~reservationitem = data~ref_item
                                                      AND zi_wm_zmigo_r09~showgrossweight = 'X'
        INTO TABLE @DATA(lt_grossweight).
      IF sy-subrc = 0.
        LOOP AT lt_grossweight ASSIGNING FIELD-SYMBOL(<lfs_grossweight>).
          lv_matnr18 = |{ <lfs_grossweight>-material ALPHA = IN }|.
          <lfs_grossweight>-material = lv_matnr18.
        ENDLOOP.

        SELECT product,
               batch
          FROM zcore_i_batch_characteristic
          FOR ALL ENTRIES IN @lt_grossweight
          WHERE product        = @lt_grossweight-material
            AND batch          = @lt_grossweight-batch
            AND characteristic = 'Z_GW'
          INTO TABLE @DATA(lt_grossweight_exits).
        IF sy-subrc = 0.
          SORT lt_grossweight_exits BY product
                                       batch.
        ENDIF.

        LOOP AT lt_grossweight INTO DATA(ls_grossweight).
          READ TABLE lt_grossweight_exits TRANSPORTING NO FIELDS
               WITH KEY product = ls_grossweight-material
                        batch   = ls_grossweight-batch BINARY SEARCH.
          IF sy-subrc = 0.
            CONTINUE.
          ENDIF.

          " TODO: variable is assigned but never used (ABAP cleaner)
          DATA lv_string TYPE string.
          lv_string = ls_grossweight-gross_weight.

          MODIFY ENTITIES OF i_batchtp_2
                 ENTITY batchcharacteristic
                 CREATE BY \_batchcharacteristicvaluetp
                 AUTO FILL CID
                 WITH VALUE #(
                     ( Material        = ls_grossweight-material
                       Batch           = ls_grossweight-batch
                       CharcInternalID = lv_atinn
                       %target         = VALUE #( ( Material                        = ls_grossweight-material
                                                    Batch                           = ls_grossweight-batch
                                                    CharcInternalID                 = lv_atinn
                                                    CharcValueIntervalType          = 1
                                                    CharcFromNumericValue           = ls_grossweight-gross_weight
                                                    %control-Material               = cl_abap_behv=>flag_changed
                                                    %control-Batch                  = cl_abap_behv=>flag_changed
                                                    %control-CharcInternalID        = cl_abap_behv=>flag_changed
                                                    %control-CharcValueIntervalType = cl_abap_behv=>flag_changed
                                                    %control-CharcFromNumericValue  = cl_abap_behv=>flag_changed ) ) ) )
                 " TODO: variable is assigned but never used (ABAP cleaner)
                 MAPPED   DATA(ls_mapped)
                 FAILED   DATA(ls_failed)
                 REPORTED DATA(ls_reported).
          IF ls_failed IS INITIAL.
            COMMIT ENTITIES.
          ELSE.
            es_response-status = cs_message_status-error.
            LOOP AT ls_reported-batch INTO DATA(ls_reported_batch).
              APPEND VALUE #( type = 'E'
                              text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
            ENDLOOP.
            ROLLBACK ENTITIES.
            RETURN.
          ENDIF.
        ENDLOOP.
      ENDIF.

      SELECT ref_doc,
             ref_item,
             entry_uom,
             SUM( entry_quantity ) AS entry_quantity
        FROM @lt_data AS data
        GROUP BY ref_doc,
                 ref_item,
                 entry_uom
        ORDER BY ref_doc,
                 ref_item,
                 entry_uom
        INTO TABLE @DATA(lt_data_sum).
      IF sy-subrc <> 0.
        RETURN.
      ENDIF.

      SELECT resb~reservation     AS rsnum,
             resb~reservationitem AS rspos,
             resb~recordtype      AS rsart,
             resb~material        AS matnr,
             resb~baseunit        AS meins,
             resb~quantity        AS enmng,
             resb~soluongdaxuat,
             resb~status
        FROM zi_wm_zmigo_r09( p_action = @iv_action ) AS resb
             INNER JOIN @lt_data_sum                  AS data ON  resb~reservation     = data~ref_doc
                                                              AND resb~reservationitem = data~ref_item
        INTO TABLE @DATA(lt_resb).
      IF sy-subrc <> 0.
        RETURN.
      ENDIF.

      LOOP AT lt_resb INTO DATA(ls_resb).
        " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
        READ TABLE lt_data_sum INTO DATA(ls_data_sum)
             WITH KEY ref_doc  = ls_resb-rsnum
                      ref_item = ls_resb-rspos BINARY SEARCH.
        IF sy-subrc <> 0.
          CONTINUE.
        ENDIF.

*          SELECT SINGLE unitofmeasure
*            FROM i_unitofmeasure
*            WHERE unitofmeasure_e = @ls_data_sum-entry_uom
*            INTO @ls_data_sum-entry_uom.
*          IF ls_resb-meins NE ls_data_sum-entry_uom.
*            SELECT SINGLE
*              afterunit~quantitynumerator   AS quantitynumerator_after,
*              afterunit~quantitydenominator AS quantitydenominator_after,
*              unit~quantitynumerator        AS quantitynumerator_entry,
*              unit~quantitydenominator      AS quantitydenominator_entry
*            FROM i_productunitsofmeasure AS unit
*            INNER JOIN i_productunitsofmeasure AS afterunit
*              ON unit~product = afterunit~product
*            WHERE unit~product              = @ls_resb-matnr
*              AND afterunit~alternativeunit = @ls_resb-meins
*              AND unit~alternativeunit      = @ls_data_sum-entry_uom
*            INTO @DATA(ls_marm).
*
*            IF sy-subrc = 0 AND
*               ls_marm-quantitynumerator_after     > 0 AND
*               ls_marm-quantitydenominator_after   > 0 AND
*               ls_marm-quantitynumerator_entry     > 0 AND
*               ls_marm-quantitydenominator_entry   > 0.
*
*              ls_data_sum-entry_quantity *= (
*                ( ls_marm-quantitynumerator_after * ls_marm-quantitydenominator_entry ) /
*                ( ls_marm-quantitydenominator_after * ls_marm-quantitynumerator_entry )
*              ).
*            ENDIF.
*          ENDIF.
*
*          ls_data_sum-entry_quantity += ls_resb-soluongdaxuat.

        APPEND VALUE #( rsnum         = ls_resb-rsnum
                        rspos         = ls_resb-rspos
                        rsart         = ls_resb-rsart
                        soluongdaxuat = ls_resb-soluongdaxuat
                        soluongconlai = ls_resb-enmng - ls_resb-soluongdaxuat
*                        status        = COND #( WHEN ls_resb-soluongdaxuat = ls_resb-enmng
*                                                    THEN '0'
*                                                  ELSE ls_resb-status )
                        col_ind       = VALUE #( soluongdaxuat = abap_true
                                                 soluongconlai = abap_true
*                                                 status        = abap_true
                                                 ) ) TO lt_resb_upd.
      ENDLOOP.

      UPDATE ztb_wm_resb FROM TABLE @lt_resb_upd INDICATORS SET STRUCTURE col_ind.
    ENDIF.
  ENDMETHOD.


  METHOD process_a01_r01."
    DATA(ls_request) = check_data_a01_r01(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a01_r01(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD process_a07_r05."
    DATA(ls_request) = check_data_a07_r05(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a07_r05(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD update_custom_field_inb_item."
    MODIFY ENTITIES OF i_inbounddeliverytp
      ENTITY inbounddeliveryitem
        UPDATE
        FIELDS ( yy1_nguoitao_dli )
        WITH VALUE #( ( %key-inbounddelivery         = iv_inbounddelivery
                        %key-inbounddeliveryitem     = iv_inbounddeliveryitem
                        yy1_nguoitao_dli             = iv_createby ) )
      FAILED   DATA(ls_failed_update)
      REPORTED DATA(ls_reported_update).
    IF ls_failed_update IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported_update-inbounddeliveryitem INTO DATA(ls_reported_inb_item).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_inb_item-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD update_inbound_item."
    DATA:
      ls_business_data TYPE zsc_api_inbound_delivery_srv=>tys_a_inb_delivery_item_type,
      ls_entity_key    TYPE zsc_api_inbound_delivery_srv=>tys_a_inb_delivery_item_type,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lv_message       TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_INBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_INBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_inbounddelivery
          delivery_document_item  = iv_inbounddeliveryitem
        ).

        " Prepare the business data
        ls_business_data = VALUE #(
          delivery_document       = iv_inbounddelivery
          delivery_document_item  = iv_inbounddeliveryitem
          storage_location        = iv_storagelocation
        ).

        " Navigate to the resource and create a request for the update operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_INB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-patch ).

        " ETag is needed
        " You need to retrieve it and then set it here
        lo_request->set_if_match( iv_etag ).

        lo_request->set_business_data(
          is_business_data = ls_business_data
          it_provided_property = VALUE #(
            ( |DELIVERY_DOCUMENT| )
            ( |DELIVERY_DOCUMENT_ITEM| )
            ( |STORAGE_LOCATION| )
          )
        ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).

        " Get updated entity
*        CLEAR ls_business_data.
*        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD check_data_a07_r05."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.

    " check hạn mức tính dụng
    TYPES: BEGIN OF lty_deliverydocument,
             ref_doc TYPE vbeln_vl,
           END OF lty_deliverydocument.
    DATA: lt_deliverydocument TYPE TABLE OF lty_deliverydocument.

    LOOP AT rs_result-items INTO ls_result_item.
      APPEND VALUE #( ref_doc = |{ ls_result_item-ref_doc ALPHA = IN }| ) TO lt_deliverydocument.
    ENDLOOP.

    SELECT
      deliverydocument,
      totalcreditcheckstatus
      FROM i_deliverydocument
      FOR ALL ENTRIES IN @lt_deliverydocument
      WHERE deliverydocument = @lt_deliverydocument-ref_doc
      INTO TABLE @DATA(lt_likp).
    IF sy-subrc EQ 0.
      LOOP AT lt_likp INTO DATA(ls_likp).
        IF ls_likp-totalcreditcheckstatus = 'B' OR
           ls_likp-totalcreditcheckstatus = 'C'.
          es_response-status = cs_message_status-error.
          APPEND VALUE #(
            type = 'E'
            text = |OD { ls_likp-deliverydocument }: Không thể xuất kho, lỗi vượt quá hạn mức tín dụng!|
          ) TO es_response-message.
        ENDIF.
      ENDLOOP.
    ELSE.
      es_response-status = cs_message_status-error.
      APPEND VALUE #(
        type = 'E'
        text = |OD { ls_likp-deliverydocument } does not exist!|
      ) TO es_response-message.
    ENDIF.
  ENDMETHOD.


  METHOD process_a01_r05."
    DATA(ls_request) = check_data_a01_r05(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a01_r05(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD check_data_a10_r02."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
*        IF NOT ( ls_result_item-plant IS INITIAL AND
*           ls_result_item-storage_location IS INITIAL ).
*          READ TABLE lt_auth TRANSPORTING NO FIELDS
*            WITH KEY plant           = ls_result_item-plant
*                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
*          IF sy-subrc NE 0.
*            es_response-status = cs_message_status-error.
*            APPEND VALUE #(
*              type = 'E'
*              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
*            ) TO es_response-message.
*            RETURN.
*          ENDIF.
*        ENDIF.
        " only checjk move plant and storage location with case A10 R02
        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD process_a08_r01."
    DATA(ls_request) = check_data_a08_r01(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a08_r01(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD check_data_a01_r04."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD process_a11_r01."
    DATA(ls_request) = check_data_a11_r01(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a11_r01(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD process_r09."
    DATA(ls_request) = check_data_r09(
      EXPORTING
        is_request_raw  = is_request_raw
        iv_action       = iv_action
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_r09(
      EXPORTING
        is_request  = ls_request
        iv_action   = iv_action
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD update_gross_weight.
    DATA lt_characteristic_create TYPE TABLE FOR CREATE i_batchcharacteristictp_2\_batchcharacteristicvaluetp.
    DATA lt_characteristic_update TYPE TABLE FOR UPDATE i_batchcharacteristicvaluetp_2.
    DATA lv_atflv                 TYPE atflv.

    CHECK es_response-status <> cs_message_status-error.

    SELECT COUNT(*) FROM i_product
      WHERE product                   = @iv_material
        AND isbatchmanagementrequired = 'X'.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    SELECT i_clfnobjectclass~classinternalid,
           i_clfncharacteristic~characteristic,
           i_clfncharacteristic~charcinternalid
      FROM i_clfnobjectclass
           INNER JOIN i_clfnclasscharacteristicdex ON  i_clfnclasscharacteristicdex~classinternalid  = i_clfnobjectclass~classinternalid
                                                   AND i_clfnclasscharacteristicdex~validityenddate >= @sy-datum
           INNER JOIN i_clfncharacteristic         ON i_clfncharacteristic~charcinternalid = i_clfnclasscharacteristicdex~charcinternalid
      WHERE i_clfnobjectclass~clfnobjectid       = @iv_material
        AND i_clfnobjectclass~clfnobjecttable    = 'MARA'
        AND i_clfncharacteristic~characteristic IN ( 'Z_GW' )
      INTO TABLE @DATA(lt_atinn).

    CHECK lt_atinn IS NOT INITIAL.

    SELECT product                      AS material,
           batch,
           charcinternalid,
           clfncharcvaluepositionnumber
      FROM zcore_i_batch_characteristic
      FOR ALL ENTRIES IN @lt_atinn
      WHERE product         = @iv_material
        AND batch           = @iv_batch
        AND charcinternalid = @lt_atinn-charcinternalid
      INTO TABLE @DATA(lt_batch_character).

    READ ENTITIES OF i_batchtp_2
         ENTITY batchcharacteristicvalue
         ALL FIELDS
         WITH VALUE #( FOR ls_batch_character IN lt_batch_character
                       ( material                     = ls_batch_character-material
                         batch                        = ls_batch_character-batch
                         charcinternalid              = ls_batch_character-charcinternalid
                         clfncharcvaluepositionnumber = ls_batch_character-clfncharcvaluepositionnumber ) )
         RESULT   DATA(lt_characteristic_read)
         FAILED   DATA(ls_failed)
         REPORTED DATA(ls_reported).

    SORT lt_characteristic_read BY charcinternalid.

    LOOP AT lt_atinn INTO DATA(ls_atinn).
      CASE ls_atinn-characteristic.
        WHEN 'Z_GW'.
          IF iv_gross_weight IS INITIAL.
            CONTINUE.
          ENDIF.
          lv_atflv = iv_gross_weight.
          IF lv_atflv IS INITIAL.
            CONTINUE.
          ENDIF.
      ENDCASE.

      READ TABLE lt_characteristic_read INTO DATA(ls_characteristic_read)
           WITH KEY material        = iv_material
                    batch           = iv_batch
                    charcinternalid = ls_atinn-charcinternalid BINARY SEARCH.
      IF sy-subrc = 0.
        APPEND VALUE #( material                     = ls_characteristic_read-material
                        batch                        = ls_characteristic_read-batch
                        charcinternalid              = ls_characteristic_read-charcinternalid
                        clfncharcvaluepositionnumber = ls_characteristic_read-clfncharcvaluepositionnumber )
               TO lt_characteristic_update ASSIGNING FIELD-SYMBOL(<lfs_characteristic_update>).
        CASE ls_atinn-characteristic.
          WHEN 'Z_GW'.
            <lfs_characteristic_update>-charcvalueintervaltype = 1.
            <lfs_characteristic_update>-charcfromnumericvalue  = iv_gross_weight.
            <lfs_characteristic_update>-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
            <lfs_characteristic_update>-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        ENDCASE.
      ELSE.
        APPEND VALUE #( material        = iv_material
                        batch           = iv_batch
                        charcinternalid = ls_atinn-charcinternalid
                        %target         = VALUE #( ( material                 = iv_material
                                                     batch                    = iv_batch
                                                     charcinternalid          = ls_atinn-charcinternalid
                                                     %control-material        = cl_abap_behv=>flag_changed
                                                     %control-batch           = cl_abap_behv=>flag_changed
                                                     %control-charcinternalid = cl_abap_behv=>flag_changed ) ) )
               TO lt_characteristic_create ASSIGNING FIELD-SYMBOL(<lfs_characteristic_create>).
        CASE ls_atinn-characteristic.
          WHEN 'Z_GW'.
            <lfs_characteristic_create>-%target[ 1 ]-charcvalueintervaltype          = 1.
            <lfs_characteristic_create>-%target[ 1 ]-charcfromnumericvalue           = iv_gross_weight.
            <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
            <lfs_characteristic_create>-%target[ 1 ]-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        ENDCASE.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF i_batchtp_2
           ENTITY batchcharacteristic
           CREATE BY \_batchcharacteristicvaluetp
           AUTO FILL CID
           WITH lt_characteristic_create
           ENTITY batchcharacteristicvalue
           UPDATE
           FROM lt_characteristic_update
           MAPPED   DATA(ls_mapped)
           FAILED   ls_failed
           REPORTED ls_reported.
    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported-batch INTO DATA(ls_reported_batch).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-batchcharacteristic INTO DATA(ls_reported_batchcharc).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharc-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-batchcharacteristicvalue INTO DATA(ls_reported_batchcharcvalue).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharcvalue-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD process_rounter."
    CASE iv_action.
      WHEN 'A01'.
        CASE iv_reference.
          WHEN 'R01'.
            rs_response = process_a01_r01( is_request_raw = is_request_raw ).
          WHEN 'R04'.
            rs_response = process_a01_r04( is_request_raw = is_request_raw ).
          WHEN 'R05'.
            rs_response = process_a01_r05( is_request_raw = is_request_raw ).
          WHEN 'R08'.
            rs_response = process_a01_r08( is_request_raw = is_request_raw ).
          WHEN 'R09'.
            rs_response = process_r09( is_request_raw = is_request_raw iv_action = iv_action ).
          WHEN 'R10'.
            rs_response = process_r10( is_request_raw = is_request_raw iv_action = iv_action ).
          WHEN OTHERS.
            rs_response-status = cs_message_status-error.
            APPEND VALUE ty_message( type = 'E' text = |Refercence { iv_reference } with Action { iv_action } not allow| ) TO rs_response-message.
        ENDCASE.
      WHEN 'A02'.
        CASE iv_reference.
          WHEN 'R02'.
            rs_response = process_a02_r02( is_request_raw = is_request_raw ).
          WHEN OTHERS.
            rs_response-status = cs_message_status-error.
            APPEND VALUE ty_message( type = 'E' text = |Refercence { iv_reference } with Action { iv_action } not allow| ) TO rs_response-message.
        ENDCASE.
      WHEN 'A03'.
        CASE iv_reference.
*          WHEN 'R02'.
          WHEN OTHERS.
            rs_response-status = cs_message_status-error.
            APPEND VALUE ty_message( type = 'E' text = |Refercence { iv_reference } with Action { iv_action } not allow| ) TO rs_response-message.
        ENDCASE.
      WHEN 'A07'.
        CASE iv_reference.
          WHEN 'R05'.
            rs_response = process_a07_r05( is_request_raw = is_request_raw ).
          WHEN 'R08'.
            rs_response = process_a07_r08( is_request_raw = is_request_raw ).
          WHEN 'R09'.
            rs_response = process_r09( is_request_raw = is_request_raw iv_action = iv_action ).
          WHEN 'R10'.
            rs_response = process_r10( is_request_raw = is_request_raw iv_action = iv_action ).
          WHEN OTHERS.
            rs_response-status = cs_message_status-error.
            APPEND VALUE ty_message( type = 'E' text = |Refercence { iv_reference } with Action { iv_action } not allow| ) TO rs_response-message.
        ENDCASE.
      WHEN 'A08'.
        CASE iv_reference.
          WHEN 'R01'.
            rs_response = process_a08_r01( is_request_raw = is_request_raw ).
          WHEN 'R09'.
            rs_response = process_r09( is_request_raw = is_request_raw iv_action = iv_action ).
          WHEN 'R10'.
            rs_response = process_r10( is_request_raw = is_request_raw iv_action = iv_action ).
          WHEN OTHERS.
            rs_response-status = cs_message_status-error.
            APPEND VALUE ty_message( type = 'E' text = |Refercence { iv_reference } with Action { iv_action } not allow| ) TO rs_response-message.
        ENDCASE.
      WHEN 'A10'.
        CASE iv_reference.
          WHEN 'R02'.
            rs_response = process_a10_r02( is_request_raw = is_request_raw ).
          WHEN OTHERS.
            rs_response-status = cs_message_status-error.
            APPEND VALUE ty_message( type = 'E' text = |Refercence { iv_reference } with Action { iv_action } not allow| ) TO rs_response-message.
        ENDCASE.
      WHEN 'A11'.
        CASE iv_reference.
          WHEN 'R01'.
            rs_response = process_a11_r01( is_request_raw = is_request_raw ).
          WHEN OTHERS.
            rs_response-status = cs_message_status-error.
            APPEND VALUE ty_message( type = 'E' text = |Refercence { iv_reference } with Action { iv_action } not allow| ) TO rs_response-message.
        ENDCASE.
      WHEN OTHERS.
        rs_response-status = cs_message_status-error.
        APPEND VALUE ty_message( type = 'E' text = |Action { iv_action } not allow| ) TO rs_response-message.
    ENDCASE.
  ENDMETHOD.


  METHOD get_etag_return_dlv."
    DATA:
      ls_entity_key    TYPE zsc_api_customer_returns_dlv=>tys_a_returns_delivery_heade_2,
      ls_business_data TYPE zsc_api_customer_returns_dlv=>tys_a_returns_delivery_heade_2,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_CUSTOMER_RETURNS_DLV'
                                                 proxy_model_version = '0001' )
             io_http_client           = lo_http_client
             iv_relative_service_root = '/sap/opu/odata/sap/API_CUSTOMER_RETURNS_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document = iv_customerreturndelivery
        ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_RETURNS_DELIVERY_HEADER' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        rv_etag = ls_business_data-etag.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.

  ENDMETHOD.


  METHOD post_goods_receipt_return_dlv."
    TYPES ty_return TYPE STANDARD TABLE OF zsc_api_customer_returns_dlv=>tys_putaway_report.

    DATA:
      ls_parameter         TYPE zsc_api_customer_returns_dlv=>tys_parameters_5,
      la_business_data     TYPE ty_return,
      lo_http_client       TYPE REF TO if_web_http_client,
      lo_client_proxy      TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_function_request  TYPE REF TO /iwbep/if_cp_request_function,
      lo_function          TYPE REF TO /iwbep/if_cp_resource_function,
      lo_function_response TYPE REF TO /iwbep/if_cp_response_function,
      lv_message           TYPE string.

    CHECK es_response-status NE cs_message_status-error.
    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_CUSTOMER_RETURNS_DLV'
                                                 proxy_model_version = '0001' )
             io_http_client           = lo_http_client
             iv_relative_service_root = '/sap/opu/odata/sap/API_CUSTOMER_RETURNS_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Prepare parameter
        ls_parameter = VALUE #(
          delivery_document           = iv_vbeln
          actual_goods_movement_date  = iv_gm_datetime
        ).

        " Navigate to the resource and create a request for the create operation
        lo_function = lo_client_proxy->create_resource_for_function( 'POST_GOODS_RECEIPT' ).
        lo_function->set_parameter(  is_parameter = ls_parameter ).
        lo_function_request = lo_function->create_request( ).

        lo_function_request->set_if_match( iv_etag ).
        lo_function_request->set_http_method( iv_http_method = /iwbep/if_cp_request_function=>gcs_http_method-post ).

        " Execute the request
        lo_function_response = lo_function_request->execute( ).

        " Get the after image
        lo_function_response->get_business_data( IMPORTING ea_response_data = la_business_data ).

        LOOP AT la_business_data TRANSPORTING NO FIELDS
          WHERE system_message_type EQ 'E' OR
                system_message_type EQ 'A'.
          EXIT.
        ENDLOOP.
        IF sy-subrc IS NOT INITIAL.
          es_response-status = cs_message_status-success.
          lv_message = |Post Goods Receipt OD { iv_vbeln ALPHA = OUT } successful!|.
          APPEND VALUE #( type = 'S' text = lv_message ) TO es_response-message.
        ELSE.
          es_response-status = cs_message_status-error.
          LOOP AT la_business_data INTO DATA(ls_business_data).
            MESSAGE ID ls_business_data-system_message_identificat TYPE ls_business_data-system_message_type NUMBER ls_business_data-system_message_number
              WITH ls_business_data-system_message_variable_1
                   ls_business_data-system_message_variable_2
                   ls_business_data-system_message_variable_3
                   ls_business_data-system_message_variable_4
                   INTO lv_message.
            APPEND VALUE #( type = ls_business_data-system_message_type
                            text = lv_message ) TO es_response-message.
          ENDLOOP.
        ENDIF.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.

  ENDMETHOD.


  METHOD update_outbound."
    DATA: lt_delivery_item_update TYPE TABLE FOR UPDATE i_outbounddeliveryitemtp.
    DATA: lv_is_return_dlv TYPE abap_boolean.

    CHECK es_response-status NE cs_message_status-error.

    CHECK it_data IS NOT INITIAL.

    DATA(lt_data) = it_data.

    SORT lt_data BY outbounddelivery outbounddeliveryitem.

    READ TABLE lt_data INTO DATA(ls_data) INDEX 1.

    SELECT SINGLE deliverydocumenttype
      FROM i_outbounddelivery
      WHERE outbounddelivery = @ls_data-outbounddelivery
      INTO @DATA(lv_deliverydocumenttype).

    CHECK sy-subrc EQ 0.

    MODIFY ENTITIES OF i_outbounddeliverytp
      ENTITY outbounddelivery
        UPDATE
        FIELDS ( actualgoodsmovementdate )
        WITH VALUE #( ( outbounddelivery        = ls_data-outbounddelivery
                        actualgoodsmovementdate = iv_pstng_date
                    ) )
      FAILED   DATA(ls_failed_update)
      REPORTED DATA(ls_reported_update).
    IF ls_failed_update IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported_update-outbounddeliveryitem INTO DATA(ls_reported_out_item).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_out_item-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.

*    IF iv_is_wm EQ 'X'.
*      DATA: lt_postd TYPE TABLE OF ztb_wm_dlv_pstdt.
*
*      SELECT COUNT(*)
*        FROM ztb_wm_dlv_pstdt
*        WHERE vbeln = @ls_data-outbounddelivery.
*      IF sy-subrc EQ 0.
*        UPDATE ztb_wm_dlv_pstdt SET budat = @iv_pstng_date
*         WHERE vbeln = @ls_data-outbounddelivery.
*      ELSE.
*        INSERT VALUE #( vbeln = ls_data-outbounddelivery
*                        budat = iv_pstng_date ) INTO lt_postd.
*        MODIFY ztb_wm_dlv_pstdt FROM TABLE @lt_postd.
*      ENDIF.
*
*      COMMIT WORK AND WAIT.
*    ENDIF.

    IF lv_deliverydocumenttype EQ 'RL' OR
       lv_deliverydocumenttype EQ 'RLL'.
      lv_is_return_dlv = 'X'.
    ENDIF.

    IF lv_is_return_dlv IS INITIAL.
      " delete all batch split
      LOOP AT lt_data INTO ls_data.
        IF ls_data-higherlvlitmofbatspltitm IS NOT INITIAL.
          DATA(lv_etag) = get_etag_outbound_item(
            iv_outbounddelivery     = ls_data-outbounddelivery
            iv_outbounddeliveryitem = ls_data-outbounddeliveryitem
          ).

          delete_outbound_item(
            EXPORTING
              iv_etag                   = lv_etag
              iv_outbounddelivery       = ls_data-outbounddelivery
              iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
            CHANGING
              es_response               = es_response
          ).
        ELSE.
          SELECT COUNT(*)
            FROM i_outbounddeliveryitem
            WHERE outbounddelivery     = @ls_data-outbounddelivery
              AND outbounddeliveryitem = @ls_data-outbounddeliveryitem
              AND batch                IS NOT INITIAL.
          IF sy-subrc EQ 0.
            lv_etag = get_etag_outbound_item(
              iv_outbounddelivery       = ls_data-outbounddelivery
              iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
            ).

            clear_batch_sloc_outbound_item(
              EXPORTING
                iv_etag                  = lv_etag
                iv_outbounddelivery      = ls_data-outbounddelivery
                iv_outbounddeliveryitem  = ls_data-outbounddeliveryitem
              CHANGING
                es_response              = es_response
            ).
          ENDIF.
        ENDIF.
      ENDLOOP.
    ENDIF.

    LOOP AT lt_data INTO ls_data.
      " continue code here
      IF ls_data-higherlvlitmofbatspltitm IS NOT INITIAL.
        ls_data-outbounddeliveryitem = ls_data-higherlvlitmofbatspltitm.
      ENDIF.

      READ TABLE lt_delivery_item_update ASSIGNING FIELD-SYMBOL(<lfs_delivery_item_update>)
        WITH KEY outbounddelivery     = ls_data-outbounddelivery
                 outbounddeliveryitem = ls_data-outbounddeliveryitem BINARY SEARCH.
      IF sy-subrc NE 0.
        APPEND VALUE #(
          outbounddelivery     = ls_data-outbounddelivery
          outbounddeliveryitem = ls_data-outbounddeliveryitem
        ) TO lt_delivery_item_update ASSIGNING <lfs_delivery_item_update>.
        SORT lt_delivery_item_update BY outbounddelivery outbounddeliveryitem.
      ENDIF.
      <lfs_delivery_item_update>-actualdeliveredqtyinorderunit          += ls_data-actualdeliveryquantity.
      <lfs_delivery_item_update>-%control-actualdeliveredqtyinorderunit = cl_abap_behv=>flag_changed.
    ENDLOOP.

    SORT lt_delivery_item_update BY outbounddelivery outbounddeliveryitem.
    DELETE ADJACENT DUPLICATES FROM lt_delivery_item_update COMPARING outbounddelivery outbounddeliveryitem.

    CHECK es_response-status NE cs_message_status-error.

    DELETE lt_delivery_item_update WHERE %control IS INITIAL.

    MODIFY ENTITIES OF i_outbounddeliverytp
      ENTITY outbounddeliveryitem
        UPDATE SET FIELDS
        WITH lt_delivery_item_update
      FAILED   DATA(lt_failed_update)
      REPORTED DATA(lt_reported_update).

    IF lt_failed_update IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT lt_reported_update-outbounddelivery INTO DATA(ls_reported_delivery).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_delivery-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT lt_reported_update-outbounddeliveryitem INTO DATA(ls_reported_delivery_item).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_delivery_item-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
    ENDIF.

    CHECK es_response-status NE cs_message_status-error.

    " create batch split
    LOOP AT lt_data INTO ls_data.
      IF lv_is_return_dlv IS INITIAL.
        IF ls_data-higherlvlitmofbatspltitm IS NOT INITIAL.
          ls_data-outbounddeliveryitem = ls_data-higherlvlitmofbatspltitm.
        ENDIF.

        lv_etag = get_etag_outbound_item(
          iv_outbounddelivery       = ls_data-outbounddelivery
          iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
        ).

        clear_batch_sloc_outbound_item(
          EXPORTING
            iv_etag                  = lv_etag
            iv_outbounddelivery      = ls_data-outbounddelivery
            iv_outbounddeliveryitem  = ls_data-outbounddeliveryitem
          CHANGING
            es_response              = es_response
        ).

        lv_etag = get_etag_outbound_item(
          iv_outbounddelivery       = ls_data-outbounddelivery
          iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
        ).

        SELECT COUNT(*)
          FROM i_outbounddeliveryitem
          INNER JOIN i_product
          ON i_outbounddeliveryitem~material = i_product~product
          WHERE i_outbounddeliveryitem~outbounddelivery     = @ls_data-outbounddelivery
            AND i_outbounddeliveryitem~outbounddeliveryitem = @ls_data-outbounddeliveryitem
            AND i_product~isbatchmanagementrequired         = 'X'.
        IF sy-subrc EQ 0.
          DATA(lv_posnr_new) = create_batch_split_outbound(
            EXPORTING
              iv_is_wm                  = iv_is_wm
              iv_etag                   = lv_etag
              iv_outbounddelivery       = ls_data-outbounddelivery
              iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
              iv_batch                  = ls_data-batch
              iv_deliveryquantityunit   = ls_data-deliveryquantityunit
              iv_actualdeliveryquantity = ls_data-actualdeliveryquantity
            CHANGING
              es_response               = es_response
          ).
        ELSE.
          lv_posnr_new = ls_data-outbounddeliveryitem.

          pick_outbound_item(
            EXPORTING
              iv_etag                   = lv_etag
              iv_outbounddelivery       = ls_data-outbounddelivery
              iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
*              iv_deliveryquantityunit   = ls_data-deliveryquantityunit
*              iv_actualdeliveryquantity = ls_data-actualdeliveryquantity
            CHANGING
              es_response               = es_response
          ).
        ENDIF.
      ELSE.
        lv_posnr_new = ls_data-outbounddeliveryitem.

        SELECT COUNT(*)
          FROM i_outbounddeliveryitem
          INNER JOIN i_ewm_plantstorlocmaptowhse
          ON  i_ewm_plantstorlocmaptowhse~plant           = i_outbounddeliveryitem~plant
          AND i_ewm_plantstorlocmaptowhse~storagelocation = i_outbounddeliveryitem~storagelocation
          WHERE outbounddelivery     = @ls_data-outbounddelivery
            AND outbounddeliveryitem = @ls_data-outbounddeliveryitem.
        IF sy-subrc IS INITIAL.
          DATA(lv_is_changed_sloc) = 'X'.

          update_custom_field_out_item(
            EXPORTING
              iv_outbounddelivery       = ls_data-outbounddelivery
              iv_outbounddeliveryitem   = lv_posnr_new
              iv_createby               = sy-uname
            CHANGING
              es_response               = es_response
          ).

          lv_etag = get_etag_outbound_item(
            iv_outbounddelivery       = ls_data-outbounddelivery
            iv_outbounddeliveryitem   = lv_posnr_new
          ).

          update_outbound_item(
            EXPORTING
              iv_etag                  = lv_etag
              iv_outbounddelivery      = ls_data-outbounddelivery
              iv_outbounddeliveryitem  = lv_posnr_new
              iv_storagelocation       = ls_data-storagelocation
            CHANGING
              es_response              = es_response
          ).
        ENDIF.
        lv_etag = get_etag_outbound_item(
          iv_outbounddelivery       = ls_data-outbounddelivery
          iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
        ).

        pick_outbound_item(
          EXPORTING
            iv_etag                   = lv_etag
            iv_outbounddelivery       = ls_data-outbounddelivery
            iv_outbounddeliveryitem   = ls_data-outbounddeliveryitem
*            iv_deliveryquantityunit   = ls_data-deliveryquantityunit
*            iv_actualdeliveryquantity = ls_data-actualdeliveryquantity
          CHANGING
            es_response               = es_response
        ).
      ENDIF.

      IF lv_is_changed_sloc IS INITIAL.
        update_custom_field_out_item(
          EXPORTING
            iv_outbounddelivery       = ls_data-outbounddelivery
            iv_outbounddeliveryitem   = lv_posnr_new
            iv_createby               = sy-uname
          CHANGING
            es_response               = es_response
        ).

        lv_etag = get_etag_outbound_item(
          iv_outbounddelivery       = ls_data-outbounddelivery
          iv_outbounddeliveryitem   = lv_posnr_new
        ).

        update_outbound_item(
          EXPORTING
            iv_etag                  = lv_etag
            iv_outbounddelivery      = ls_data-outbounddelivery
            iv_outbounddeliveryitem  = lv_posnr_new
            iv_storagelocation       = ls_data-storagelocation
          CHANGING
            es_response              = es_response
        ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD post_a01_r08. "
    DATA ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code.
    DATA ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01.
    DATA ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print.
    DATA ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm.
    DATA lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr.
    DATA lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex.
    DATA ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex.
    DATA ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create.
    DATA lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create.
    DATA lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create.
    DATA lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber.
    DATA lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat.
    DATA lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA lv_matnr18                 TYPE n LENGTH 18.

    DATA lv_line_id                 TYPE zsc_bapi_goodsmvt_create=>mb_line_id.
    DATA ls_matdoc_incl_eew_ps_id   TYPE ty_matdoc_incl_eew_ps_id.
    DATA lv_vbeln                   TYPE vbeln_va.

    CHECK es_response-status <> cs_message_status-error.

    ls_goodsmvt_header-pstng_date = is_request-posting_date.
    ls_goodsmvt_header-doc_date   = is_request-document_date.
    ls_goodsmvt_header-header_txt = is_request-document_header_text.
    ls_goodsmvt_code-gm_code      = '02'.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      IF ls_request_item-batch IS INITIAL.
        create_batch( EXPORTING iv_material                 = ls_request_item-material
                                iv_expiration_date          = ls_request_item-expiration_date
                                iv_production_date          = ls_request_item-production_date
                                iv_profit_center            = ls_request_item-profit_center
                                iv_manufacturer             = ls_request_item-manufacturer
                                iv_lot_num                  = ls_request_item-lot_num
                                iv_batch_supplier           = ls_request_item-batch_supplier
                                iv_batch_note               = ls_request_item-batch_note
                                iv_qc_note                  = ls_request_item-qc_note
                                iv_production_date_internal = ls_request_item-production_date_internal
                                iv_expiration_date_internal = ls_request_item-expiration_date_internal
                                iv_access_code              = ls_request_item-access_code
                                iv_packaging_spec           = ls_request_item-packaging_spec
                                iv_origin                   = ls_request_item-origin
                                iv_gross_weight             = ls_request_item-gross_weight
                                iv_quantity_btp             = ls_request_item-quantity_btp
                                iv_quantity_tp              = ls_request_item-quantity_tp
                                iv_plan_dept_note           = ls_request_item-plan_dept_note
                      CHANGING  ev_batch                    = ls_request_item-batch
                                es_response                 = es_response ).
      ELSE.
        update_batch( EXPORTING iv_material                 = ls_request_item-material
                                iv_batch                    = ls_request_item-batch
                                iv_expiration_date          = ls_request_item-expiration_date
                                iv_production_date          = ls_request_item-production_date
                                iv_profit_center            = ls_request_item-profit_center
                                iv_manufacturer             = ls_request_item-manufacturer
                                iv_lot_num                  = ls_request_item-lot_num
                                iv_batch_supplier           = ls_request_item-batch_supplier
                                iv_batch_note               = ls_request_item-batch_note
                                iv_qc_note                  = ls_request_item-qc_note
                                iv_production_date_internal = ls_request_item-production_date_internal
                                iv_expiration_date_internal = ls_request_item-expiration_date_internal
                                iv_access_code              = ls_request_item-access_code
                                iv_packaging_spec           = ls_request_item-packaging_spec
                                iv_origin                   = ls_request_item-origin
                                iv_gross_weight             = ls_request_item-gross_weight
                                iv_quantity_btp             = ls_request_item-quantity_btp
                                iv_quantity_tp              = ls_request_item-quantity_tp
                                iv_plan_dept_note           = ls_request_item-plan_dept_note
                      CHANGING  es_response                 = es_response ).
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id   = lv_line_id.

      ls_goodsmvt_item-material  = ls_request_item-material.
      ls_goodsmvt_item-plant     = ls_request_item-plant.
      ls_goodsmvt_item-batch     = ls_request_item-batch.
      ls_goodsmvt_item-stge_loc  = ls_request_item-storage_location.
      ls_goodsmvt_item-entry_qnt = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
      ls_goodsmvt_item-move_type  = '101'.
      ls_goodsmvt_item-orderid    = |{ ls_request_item-ref_doc ALPHA = IN }|.
      ls_goodsmvt_item-mvt_ind    = 'F'.

      ls_goodsmvt_item-no_more_gr = 'X'.

      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id          = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi = sy-uname.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c( EXPORTING im_value     = ls_matdoc_incl_eew_ps_id
                        IMPORTING ex_container = DATA(lv_container) ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin,
             ls_matdoc_incl_eew_ps_id.

      IF ls_request_item-material+8(3) = '511'.
        lv_vbeln = |{ ls_request_item-sales_ord ALPHA = IN }|.
        SELECT COUNT(*) FROM i_salesdocument
          WHERE salesdocument = @lv_vbeln
            AND (    sddocumentreason = 'Z16'
                  OR sddocumentreason = 'Z17' ).
        IF sy-subrc = 0.
          APPEND ls_request_item TO cs_request-items.
        ENDIF.
      ENDIF.
      CLEAR ls_request_item.
    ENDLOOP.

    cs_request-document_date        = is_request-document_date.
    cs_request-posting_date         = is_request-posting_date.
    cs_request-document_header_text = is_request-document_header_text.

    call_bapi_goodsmvt_create( EXPORTING is_goodsmvt_code           = ls_goodsmvt_code
                                         is_goodsmvt_header         = ls_goodsmvt_header
                                         is_goodsmvt_print_ctrl     = ls_goodsmvt_print_ctrl
                                         is_goodsmvt_ref_ewm        = ls_goodsmvt_ref_ewm
                                         iv_testrun                 = lv_testrun
                               IMPORTING es_goodsmvt_headret        = ls_goodsmvt_headret
                                         ev_matdocumentyear         = lv_matdocumentyear
                                         ev_materialdocument        = lv_materialdocument
                               CHANGING  ct_extensionin             = lt_extensionin
                                         ct_goodsmvt_item           = lt_goodsmvt_item
                                         ct_goodsmvt_item_cwm       = lt_goodsmvt_item_cwm
                                         ct_goodsmvt_serialnumber   = lt_goodsmvt_serialnumber
                                         ct_goodsmvt_serv_part_data = lt_goodsmvt_serv_part_data
                                         ct_return                  = lt_return
                                         cs_response                = es_response ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD update_custom_field_out_item."
    MODIFY ENTITIES OF i_outbounddeliverytp
      ENTITY outbounddeliveryitem
        UPDATE
        FIELDS ( yy1_nguoitao_dli )
        WITH VALUE #( ( %key-outbounddelivery        = iv_outbounddelivery
                        %key-outbounddeliveryitem    = iv_outbounddeliveryitem
                        yy1_nguoitao_dli             = iv_createby ) )
      FAILED   DATA(ls_failed_update)
      REPORTED DATA(ls_reported_update).
    IF ls_failed_update IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported_update-outbounddeliveryitem INTO DATA(ls_reported_out_item).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_out_item-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD get_etag_outbound_item."

    DATA:
      ls_entity_key    TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      ls_business_data TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_outbounddelivery
          delivery_document_item  = iv_outbounddeliveryitem
        ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_OUTB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        rv_etag = ls_business_data-etag.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.
  ENDMETHOD.


  METHOD check_data_a07_r08."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD check_data_a01_r08."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD process_a07_r08."
    DATA(ls_request) = check_data_a07_r08(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a07_r08(
      EXPORTING
        is_request  = ls_request
      CHANGING
        es_response = rs_response
    ).
  ENDMETHOD.


  METHOD read_batch.
    CHECK es_response-status NE cs_message_status-error.

    SELECT COUNT(*)
      FROM i_product
      WHERE product                   = @iv_material
        AND isbatchmanagementrequired = 'X'.

    CHECK sy-subrc EQ 0.

    READ ENTITIES OF i_batchtp_2
      ENTITY batch
        ALL FIELDS
        WITH VALUE #( ( material                          = iv_material
                        batch                             = iv_batch
                    ) )
        RESULT   DATA(lt_batch_read)
        FAILED   DATA(ls_failed)
        REPORTED DATA(ls_reported).
    IF ls_failed IS INITIAL.
*      ev_production_date = lt_batch_read[ 1 ]-manufacturedate.
      ev_expiration_date = lt_batch_read[ 1 ]-shelflifeexpirationdate.
      ev_batch_supplier  = lt_batch_read[ 1 ]-supplier.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported-batch INTO DATA(ls_reported_batch).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.

    SELECT
      i_clfnobjectclass~classinternalid,
      i_clfncharacteristic~characteristic,
      i_clfncharacteristic~charcinternalid
      FROM i_clfnobjectclass
      INNER JOIN i_clfnclasscharacteristicdex
      ON  i_clfnclasscharacteristicdex~classinternalid = i_clfnobjectclass~classinternalid
      AND i_clfnclasscharacteristicdex~validityenddate >= @sy-datum
      INNER JOIN i_clfncharacteristic
      ON  i_clfncharacteristic~charcinternalid = i_clfnclasscharacteristicdex~charcinternalid
      WHERE i_clfnobjectclass~clfnobjectid    = @iv_material
        AND i_clfnobjectclass~clfnobjecttable = 'MARA'
        AND i_clfncharacteristic~characteristic IN ( 'Z_PC', 'Z_NHASX', 'Z_LOT', 'Z_GHICHU',
                                                     'Z_NSXNB', 'Z_HSDNB', 'Z_MTX', 'Z_QCBG',
                                                     'Z_NG', 'Z_GW', 'Z_NSX', 'Z_GCQC',
                                                     'Z_SLBTPKT', 'Z_SLTPKT', 'Z_GHICHU_PKH'
                                                   )
      INTO TABLE @DATA(lt_atinn).
    CHECK sy-subrc EQ 0.

    SORT lt_atinn BY charcinternalid.

    SELECT
      product AS material,
      batch,
      charcinternalid,
      clfncharcvaluepositionnumber
      FROM zcore_i_batch_characteristic
      FOR ALL ENTRIES IN @lt_atinn
      WHERE product           = @iv_material
        AND batch             = @iv_batch
        AND charcinternalid   = @lt_atinn-charcinternalid
      INTO TABLE @DATA(lt_batch_character).

    READ ENTITIES OF i_batchtp_2
      ENTITY batchcharacteristicvalue
        ALL FIELDS
        WITH VALUE #( FOR ls_batch_character IN lt_batch_character (
          material                     = ls_batch_character-material
          batch                        = ls_batch_character-batch
          charcinternalid              = ls_batch_character-charcinternalid
          clfncharcvaluepositionnumber = ls_batch_character-clfncharcvaluepositionnumber
        ) )
        RESULT   DATA(lt_characteristic_read)
        FAILED   ls_failed
        REPORTED ls_reported.
    IF ls_failed IS NOT INITIAL.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported-batch INTO ls_reported_batch.
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-batchcharacteristic INTO DATA(ls_reported_batchcharc).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharc-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-batchcharacteristicvalue INTO DATA(ls_reported_batchcharcvalue).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharcvalue-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.

    LOOP AT lt_characteristic_read INTO DATA(ls_characteristic_read).
      READ TABLE lt_atinn INTO DATA(ls_atinn)
        WITH KEY charcinternalid = ls_characteristic_read-charcinternalid BINARY SEARCH.
      IF sy-subrc EQ 0.
        CASE ls_atinn-characteristic.
          WHEN 'Z_PC'.
            ev_profit_center            = ls_characteristic_read-charcvalue.
          WHEN 'Z_NHASX'.
            ev_manufacturer             = ls_characteristic_read-charcvalue.
          WHEN 'Z_LOT'.
            ev_lot_num                  = ls_characteristic_read-charcvalue.
          WHEN 'Z_GHICHU'.
            ev_batch_note               = ls_characteristic_read-charcvalue.
          WHEN 'Z_GCQC'.
            ev_qc_note                  = ls_characteristic_read-charcvalue.
          WHEN 'Z_NSXNB'.
            ev_production_date_internal = ls_characteristic_read-charcfromdate.
          WHEN 'Z_HSDNB'.
            ev_expiration_date_internal = ls_characteristic_read-charcfromdate.
          WHEN 'Z_MTX'.
            ev_access_code              = ls_characteristic_read-charcvalue.
          WHEN 'Z_QCBG'.
            ev_packaging_spec           = ls_characteristic_read-charcvalue.
          WHEN 'Z_NG'.
            ev_origin                   = ls_characteristic_read-charcvalue.
          WHEN 'Z_GW'.
            ev_gross_weight             = ls_characteristic_read-charcfromdecimalvalue.
          WHEN 'Z_NSX'.
            ev_production_date          = ls_characteristic_read-charcfromdate.
          WHEN 'Z_SLBTPKT'.
            ev_quantity_btp             = ls_characteristic_read-charcfromdecimalvalue.
          WHEN 'Z_SLTPKT'.
            ev_quantity_tp              = ls_characteristic_read-charcfromdecimalvalue.
          WHEN 'Z_GHICHU_PKH'.
            ev_plan_dept_note           = ls_characteristic_read-charcvalue.
        ENDCASE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD delete_outbound_item."
    DATA:
      ls_entity_key    TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      ls_business_data TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_delete,
      lv_message       TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        "Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_outbounddelivery
          delivery_document_item  = iv_outbounddeliveryitem
        ).

        "Navigate to the resource and create a request for the delete operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_OUTB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_delete( ).

        " ETag is needed
        " You need to retrieve it and then set it here
        lo_request->set_if_match( iv_etag ).

        " Execute the request
        lo_request->execute( ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD update_custom_field_redlv_item."
    MODIFY ENTITIES OF i_customerreturnsdeliverytp
      ENTITY customerreturnsdeliveryitem
        UPDATE
        FIELDS ( yy1_nguoitao_dli )
        WITH VALUE #( ( %key-customerreturndelivery     = iv_customerreturndelivery
                        %key-customerreturndeliveryitem = iv_customerreturndeliveryitem
                        yy1_nguoitao_dli                = iv_createby ) )
      FAILED   DATA(ls_failed_update)
      REPORTED DATA(ls_reported_update).
    IF ls_failed_update IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported_update-customerreturnsdeliveryitem INTO DATA(ls_reported_redlv_item).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_redlv_item-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD clear_batch_sloc_outbound_item."
    DATA:
      ls_business_data TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      ls_entity_key    TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lv_message       TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_outbounddelivery
          delivery_document_item  = iv_outbounddeliveryitem
        ).

        " Prepare the business data
        ls_business_data = VALUE #(
          delivery_document       = iv_outbounddelivery
          delivery_document_item  = iv_outbounddeliveryitem
        ).

        " Navigate to the resource and create a request for the update operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_OUTB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-patch ).

        " ETag is needed
        " You need to retrieve it and then set it here
        lo_request->set_if_match( iv_etag ).

        SELECT COUNT(*)
          FROM i_outbounddeliveryitem
          INNER JOIN i_product
          ON  i_outbounddeliveryitem~material = i_product~product
          WHERE i_outbounddeliveryitem~outbounddelivery     = @iv_outbounddelivery
            AND i_outbounddeliveryitem~outbounddeliveryitem = @iv_outbounddeliveryitem
            AND i_product~isbatchmanagementrequired         = 'X'.
        IF sy-subrc EQ 0.
          lo_request->set_business_data(
            is_business_data = ls_business_data
            it_provided_property = VALUE #(
              ( |DELIVERY_DOCUMENT| )
              ( |DELIVERY_DOCUMENT_ITEM| )
              ( |STORAGE_LOCATION| )
              ( |BATCH| )
            )
          ).
        ELSE.
          lo_request->set_business_data(
            is_business_data = ls_business_data
            it_provided_property = VALUE #(
              ( |DELIVERY_DOCUMENT| )
              ( |DELIVERY_DOCUMENT_ITEM| )
              ( |STORAGE_LOCATION| )
            )
          ).
        ENDIF.

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).

        " Get updated entity
        " CLEAR ls_business_data.
        " lo_response->get_business_data( importing es_business_data = ls_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD putaway_return_dlv."
    TYPES ty_return TYPE STANDARD TABLE OF zsc_api_customer_returns_dlv=>tys_putaway_report.

    DATA:
      ls_parameter         TYPE zsc_api_customer_returns_dlv=>tys_parameters_1,
      la_business_data     TYPE ty_return,
      lo_http_client       TYPE REF TO if_web_http_client,
      lo_client_proxy      TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_function_request  TYPE REF TO /iwbep/if_cp_request_function,
      lo_function          TYPE REF TO /iwbep/if_cp_resource_function,
      lo_function_response TYPE REF TO /iwbep/if_cp_response_function,
      lv_message           TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_CUSTOMER_RETURNS_DLV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_CUSTOMER_RETURNS_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Prepare parameter
        ls_parameter = VALUE #(
          delivery_document = iv_vbeln
        ).

        " Navigate to the resource and create a request for the create operation
        lo_function = lo_client_proxy->create_resource_for_function( 'CONFIRM_PUTAWAY_ALL_ITEMS' ).
        lo_function->set_parameter(  is_parameter = ls_parameter ).
        lo_function_request = lo_function->create_request( ).

        lo_function_request->set_if_match( iv_etag ).
        lo_function_request->set_http_method( iv_http_method = /iwbep/if_cp_request_function=>gcs_http_method-post ).

        " Execute the request
        lo_function_response = lo_function_request->execute( ).

        " Get the after image
        lo_function_response->get_business_data( IMPORTING ea_response_data = la_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD get_etag_return_dlv_item."
    DATA:
      ls_entity_key    TYPE zsc_api_customer_returns_dlv=>tys_a_returns_delivery_item_ty,
      ls_business_data TYPE zsc_api_customer_returns_dlv=>tys_a_returns_delivery_item_ty,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_CUSTOMER_RETURNS_DLV'
                                                 proxy_model_version = '0001' )
             io_http_client           = lo_http_client
             iv_relative_service_root = '/sap/opu/odata/sap/API_CUSTOMER_RETURNS_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_customerreturndelivery
          delivery_document_item  = iv_customerreturndeliveryitem
        ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_RETURNS_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        rv_etag = ls_business_data-etag.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.

  ENDMETHOD.


  METHOD check_data_r10."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD update_return_dlv_item."
    DATA:
      ls_business_data TYPE zsc_api_customer_returns_dlv=>tys_a_returns_delivery_item_ty,
      ls_entity_key    TYPE zsc_api_customer_returns_dlv=>tys_a_returns_delivery_item_ty,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lv_message       TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_CUSTOMER_RETURNS_DLV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_CUSTOMER_RETURNS_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_customerreturndelivery
          delivery_document_item  = iv_customerreturndeliveryitem
        ).

        " Prepare the business data
        ls_business_data = VALUE #(
          delivery_document       = iv_customerreturndelivery
          delivery_document_item  = iv_customerreturndeliveryitem
          storage_location        = iv_storagelocation
        ).

        " Navigate to the resource and create a request for the update operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_RETURNS_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-patch ).

        " ETag is needed
        " You need to retrieve it and then set it here
        lo_request->set_if_match( iv_etag ).

        lo_request->set_business_data(
          is_business_data = ls_business_data
          it_provided_property = VALUE #(
            ( |DELIVERY_DOCUMENT| )
            ( |DELIVERY_DOCUMENT_ITEM| )
            ( |STORAGE_LOCATION| )
          )
        ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).

        " Get updated entity
        " CLEAR ls_business_data.
        " lo_response->get_business_data( importing es_business_data = ls_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.

    ENDTRY.

  ENDMETHOD.


  METHOD convert_entry_quantity."
    DATA: lv_entry_quantity TYPE string.

    lv_entry_quantity = iv_entry_quantity.
*    REPLACE ALL OCCURRENCES OF '.' IN lv_entry_quantity WITH ''.
*    REPLACE ALL OCCURRENCES OF ',' IN lv_entry_quantity WITH '.'.

    rv_entry_quantity = lv_entry_quantity.
  ENDMETHOD.


  METHOD update_outbound_item."
    DATA:
      ls_business_data TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      ls_entity_key    TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_item_type,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_request       TYPE REF TO /iwbep/if_cp_request_update,
      lo_response      TYPE REF TO /iwbep/if_cp_response_update,
      lv_message       TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document       = iv_outbounddelivery
          delivery_document_item  = iv_outbounddeliveryitem
        ).

        " Prepare the business data
        ls_business_data = VALUE #(
          delivery_document       = iv_outbounddelivery
          delivery_document_item  = iv_outbounddeliveryitem
          storage_location        = iv_storagelocation
        ).

        " Navigate to the resource and create a request for the update operation
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_OUTB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).
        lo_request = lo_resource->create_request_for_update( /iwbep/if_cp_request_update=>gcs_update_semantic-patch ).

        " ETag is needed
        " You need to retrieve it and then set it here
        lo_request->set_if_match( iv_etag ).

        lo_request->set_business_data(
          is_business_data = ls_business_data
          it_provided_property = VALUE #(
            ( |DELIVERY_DOCUMENT| )
            ( |DELIVERY_DOCUMENT_ITEM| )
            ( |STORAGE_LOCATION| )
          )
        ).

        " Execute the request and retrieve the business data
        lo_response = lo_request->execute( ).

        " Get updated entity
        " CLEAR ls_business_data.
        " lo_response->get_business_data( importing es_business_data = ls_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD pick_outbound_item."

    TYPES ty_return TYPE STANDARD TABLE OF zsc_api_outbound_delivery_srv=>tys_picking_report.

    DATA:
      ls_parameter         TYPE zsc_api_outbound_delivery_srv=>tys_parameters_3,
      la_business_data     TYPE ty_return,
      lo_http_client       TYPE REF TO if_web_http_client,
      lo_client_proxy      TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_function_request  TYPE REF TO /iwbep/if_cp_request_function,
      lo_function          TYPE REF TO /iwbep/if_cp_resource_function,
      lo_function_response TYPE REF TO /iwbep/if_cp_response_function,
      lv_message           TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Prepare parameter
        ls_parameter = VALUE #(
          delivery_document       = iv_outbounddelivery
          delivery_document_item  = iv_outbounddeliveryitem
        ).

        " Navigate to the resource and create a request for the create operation
        lo_function = lo_client_proxy->create_resource_for_function( 'PICK_ONE_ITEM' ).
        lo_function->set_parameter(  is_parameter = ls_parameter ).
        lo_function_request = lo_function->create_request( ).

        lo_function_request->set_if_match( iv_etag ).
        lo_function_request->set_http_method( iv_http_method = /iwbep/if_cp_request_function=>gcs_http_method-post ).

        " Execute the request
        lo_function_response = lo_function_request->execute( ).

        " Get the after image
        lo_function_response->get_business_data( IMPORTING ea_response_data = la_business_data ).

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD check_data_a02_r02."
    rs_result = CORRESPONDING #( is_request_raw EXCEPT items ).
    MOVE-CORRESPONDING is_request_raw-items TO rs_result-items.

    SELECT
      plant,
      storagelocation
      FROM zi_wm_zmigo_sloc_auth
      FOR ALL ENTRIES IN @rs_result-items
      WHERE ( ( plant           = @rs_result-items-plant
            AND storagelocation = @rs_result-items-storage_location )
           OR ( plant           = @rs_result-items-move_plant
            AND storagelocation = @rs_result-items-move_storage_location ) )
        AND userid          = @sy-uname
      INTO TABLE @DATA(lt_auth).
    IF sy-subrc EQ 0.
      SORT lt_auth BY plant storagelocation.
    ENDIF.

    LOOP AT rs_result-items INTO DATA(ls_result_item).
      IF ls_result_item-goods_move_type = '311' OR
         ls_result_item-goods_move_type = 'Z01'.
        IF NOT ( ls_result_item-plant IS INITIAL AND
         ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            IF NOT ( ls_result_item-move_plant IS INITIAL AND
                     ls_result_item-move_storage_location IS INITIAL ).
              READ TABLE lt_auth TRANSPORTING NO FIELDS
                WITH KEY plant           = ls_result_item-move_plant
                         storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
              IF sy-subrc NE 0.
                es_response-status = cs_message_status-error.
                APPEND VALUE #(
                  type = 'E'
                  text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
                ) TO es_response-message.
                RETURN.
              ENDIF.
            ELSE.
              es_response-status = cs_message_status-error.
              APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
              ) TO es_response-message.
              RETURN.
            ENDIF.
          ENDIF.
        ENDIF.
      ELSE.
        IF NOT ( ls_result_item-plant IS INITIAL AND
           ls_result_item-storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-plant
                     storagelocation = ls_result_item-storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-plant } { ls_result_item-storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.

        IF NOT ( ls_result_item-move_plant IS INITIAL AND
           ls_result_item-move_storage_location IS INITIAL ).
          READ TABLE lt_auth TRANSPORTING NO FIELDS
            WITH KEY plant           = ls_result_item-move_plant
                     storagelocation = ls_result_item-move_storage_location BINARY SEARCH.
          IF sy-subrc NE 0.
            es_response-status = cs_message_status-error.
            APPEND VALUE #(
              type = 'E'
              text = |You not have authorized access with storage location { ls_result_item-move_plant } { ls_result_item-move_storage_location }|
            ) TO es_response-message.
            RETURN.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD create_batch. "
    DATA lt_characteristic_create TYPE TABLE FOR CREATE i_batchcharacteristictp_2\_batchcharacteristicvaluetp.
    DATA lv_production_date       TYPE d.
    DATA lv_production_date_flag  TYPE abp_behv_flag.
    DATA lv_atflv                 TYPE atflv.

    CHECK es_response-status <> cs_message_status-error.

    SELECT COUNT(*) FROM i_product
      WHERE product                   = @iv_material
        AND isbatchmanagementrequired = 'X'.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    SELECT SINGLE i_clfnclassdex~class
      FROM i_clfnobjectclass
           INNER JOIN i_clfnclassdex ON  i_clfnclassdex~classinternalid  = i_clfnobjectclass~classinternalid
                                     AND i_clfnclassdex~validityenddate >= @sy-datum
      WHERE i_clfnobjectclass~clfnobjectid    = @iv_material
        AND i_clfnobjectclass~clfnobjecttable = 'MARA'
      INTO @DATA(lv_class).
    IF sy-subrc = 0.
      CASE lv_class.
        WHEN 'Z_TP'.
          lv_production_date = iv_production_date_internal.
          lv_production_date_flag = cl_abap_behv=>flag_changed.
        WHEN 'Z_NVL'.
          lv_production_date = iv_production_date.
          lv_production_date_flag = cl_abap_behv=>flag_changed.
        WHEN OTHERS.
          CLEAR lv_production_date.
          lv_production_date_flag = cl_abap_behv=>flag_null.
      ENDCASE.
    ENDIF.

    MODIFY ENTITIES OF i_batchtp_2
           ENTITY batch
           CREATE
           AUTO FILL CID
           WITH VALUE #( ( material                         = iv_material
                           manufacturedate                  = lv_production_date
                           shelflifeexpirationdate          = iv_expiration_date
                           supplier                         = |{ iv_batch_supplier ALPHA = IN }|
                           %control-material                = cl_abap_behv=>flag_changed
                           %control-manufacturedate         = lv_production_date_flag
                           %control-shelflifeexpirationdate = cl_abap_behv=>flag_changed
                           %control-supplier                = cl_abap_behv=>flag_changed ) )
           MAPPED   DATA(ls_mapped)
           FAILED   DATA(ls_failed)
           REPORTED DATA(ls_reported).
    IF ls_failed IS INITIAL.
      COMMIT ENTITIES BEGIN RESPONSE OF i_batchtp_2
             FAILED DATA(ls_failed_commit)
             REPORTED DATA(ls_reported_commit).
      IF ls_failed_commit IS INITIAL.
        LOOP AT ls_mapped-batch ASSIGNING FIELD-SYMBOL(<lfs_mapped_batch>).
          ev_batch = <lfs_mapped_batch>-batch.
          APPEND VALUE #( type = 'S'
                          text = |Batch { ev_batch } created!| )
                 TO es_response-message.
        ENDLOOP.
      ELSE.
        es_response-status = cs_message_status-error.
        LOOP AT ls_reported_commit-batch INTO DATA(ls_commit_report_batch).
          APPEND VALUE #( type = 'E'
                          text = ls_commit_report_batch-%msg->if_message~get_text( ) )
                 TO es_response-message.
        ENDLOOP.
        ROLLBACK WORK.
        RETURN.
      ENDIF.
      COMMIT ENTITIES END.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported-batch INTO DATA(ls_reported_batch).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.

    SELECT i_clfnobjectclass~classinternalid,
           i_clfncharacteristic~characteristic,
           i_clfncharacteristic~charcinternalid
      FROM i_clfnobjectclass
           INNER JOIN i_clfnclasscharacteristicdex ON  i_clfnclasscharacteristicdex~classinternalid  = i_clfnobjectclass~classinternalid
                                                   AND i_clfnclasscharacteristicdex~validityenddate >= @sy-datum
           INNER JOIN i_clfncharacteristic         ON i_clfncharacteristic~charcinternalid = i_clfnclasscharacteristicdex~charcinternalid
      WHERE i_clfnobjectclass~clfnobjectid       = @iv_material
        AND i_clfnobjectclass~clfnobjecttable    = 'MARA'
        AND i_clfncharacteristic~characteristic IN ( 'Z_PC', 'Z_NHASX', 'Z_LOT', 'Z_GHICHU',
                                                     'Z_NSXNB', 'Z_HSDNB', 'Z_MTX', 'Z_QCBG',
                                                     'Z_NG', 'Z_GW', 'Z_NSX', 'Z_GCQC',
                                                     'Z_SLBTPKT', 'Z_SLTPKT', 'Z_GHICHU_PKH' )
      INTO TABLE @DATA(lt_atinn).

    CHECK lt_atinn IS NOT INITIAL.

    LOOP AT lt_atinn INTO DATA(ls_atinn).
      CASE ls_atinn-characteristic.
        WHEN 'Z_PC'.
          IF iv_profit_center IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NHASX'.
          IF iv_manufacturer IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_LOT'.
          IF iv_lot_num IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GHICHU'.
          IF iv_batch_note IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GCQC'.
          IF iv_qc_note IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NSXNB'.
          IF iv_production_date_internal IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_HSDNB'.
          IF iv_expiration_date_internal IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_MTX'.
          IF iv_access_code IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_QCBG'.
          IF iv_packaging_spec IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NG'.
          IF iv_origin IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GW'.
          IF iv_gross_weight IS INITIAL.
            CONTINUE.
          ENDIF.
          lv_atflv = iv_gross_weight.
          IF lv_atflv IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NSX'.
          IF iv_production_date IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_SLBTPKT'.
          IF iv_quantity_btp IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_SLTPKT'.
          IF iv_quantity_tp IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GHICHU_PKH'.
          IF iv_plan_dept_note IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN OTHERS.
          CONTINUE.
      ENDCASE.
      APPEND VALUE #( material        = iv_material
                      batch           = ev_batch
                      charcinternalid = ls_atinn-charcinternalid
                      %target         = VALUE #( ( material                 = iv_material
                                                   batch                    = ev_batch
                                                   charcinternalid          = ls_atinn-charcinternalid
                                                   %control-material        = cl_abap_behv=>flag_changed
                                                   %control-batch           = cl_abap_behv=>flag_changed
                                                   %control-charcinternalid = cl_abap_behv=>flag_changed ) ) )
             TO lt_characteristic_create ASSIGNING FIELD-SYMBOL(<lfs_characteristic_create>).
      CASE ls_atinn-characteristic.
        WHEN 'Z_PC'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_profit_center.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_NHASX'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_manufacturer.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_LOT'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_lot_num.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_GHICHU'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_batch_note.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_GCQC'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_qc_note.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_NSXNB'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalueintervaltype          = 1.
          <lfs_characteristic_create>-%target[ 1 ]-charcfromnumericvalue           = iv_production_date_internal.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        WHEN 'Z_HSDNB'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalueintervaltype          = 1.
          <lfs_characteristic_create>-%target[ 1 ]-charcfromnumericvalue           = iv_expiration_date_internal.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        WHEN 'Z_MTX'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_access_code.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_QCBG'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_packaging_spec.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_NG'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_origin.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
        WHEN 'Z_GW'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalueintervaltype          = 1.
          <lfs_characteristic_create>-%target[ 1 ]-charcfromnumericvalue           = iv_gross_weight.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        WHEN 'Z_NSX'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalueintervaltype          = 1.
          <lfs_characteristic_create>-%target[ 1 ]-charcfromnumericvalue           = iv_production_date.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        WHEN 'Z_SLBTPKT'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalueintervaltype          = 1.
          <lfs_characteristic_create>-%target[ 1 ]-charcfromnumericvalue           = iv_quantity_btp.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        WHEN 'Z_SLTPKT'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalueintervaltype          = 1.
          <lfs_characteristic_create>-%target[ 1 ]-charcfromnumericvalue           = iv_quantity_tp.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalueintervaltype = cl_abap_behv=>flag_changed.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcfromnumericvalue  = cl_abap_behv=>flag_changed.
        WHEN 'Z_GHICHU_PKH'.
          <lfs_characteristic_create>-%target[ 1 ]-charcvalue                      = iv_plan_dept_note.
          <lfs_characteristic_create>-%target[ 1 ]-%control-charcvalue             = cl_abap_behv=>flag_changed.
      ENDCASE.
    ENDLOOP.

    MODIFY ENTITIES OF i_batchtp_2
           ENTITY batchcharacteristic
           CREATE BY \_batchcharacteristicvaluetp
           AUTO FILL CID
           WITH lt_characteristic_create
           MAPPED   ls_mapped
           FAILED   ls_failed
           REPORTED ls_reported.
    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported-batch INTO ls_reported_batch.
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-batchcharacteristic INTO DATA(ls_reported_batchcharc).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharc-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-batchcharacteristicvalue INTO DATA(ls_reported_batchcharcvalue).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharcvalue-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD create_batch_split_outbound."
    DATA:
      ls_parameter         TYPE zsc_api_outbound_delivery_srv=>tys_parameters_12,
      la_business_data     TYPE zsc_api_outbound_delivery_srv=>tys_created_delivery_item,
      lo_http_client       TYPE REF TO if_web_http_client,
      lo_client_proxy      TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_function_request  TYPE REF TO /iwbep/if_cp_request_function,
      lo_function          TYPE REF TO /iwbep/if_cp_resource_function,
      lo_function_response TYPE REF TO /iwbep/if_cp_response_function,
      lv_message           TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    SELECT COUNT(*)
      FROM i_outbounddeliveryitem
      INNER JOIN i_product
      ON i_outbounddeliveryitem~material = i_product~product
      WHERE i_outbounddeliveryitem~outbounddelivery     = @iv_outbounddelivery
        AND i_outbounddeliveryitem~outbounddeliveryitem = @iv_outbounddeliveryitem
        AND i_product~isbatchmanagementrequired         = 'X'.
    IF sy-subrc NE 0.
      rv_posnr = iv_outbounddeliveryitem.
      RETURN.
    ENDIF.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.

        " Prepare parameter
        ls_parameter = VALUE #(
          delivery_document           = iv_outbounddelivery
          delivery_document_item      = iv_outbounddeliveryitem
          batch                       = iv_batch
          delivery_quantity_unit      = iv_deliveryquantityunit
          actual_delivery_quantity    = iv_actualdeliveryquantity
          pick_quantity_in_sales_uom  = COND #( WHEN iv_is_wm IS INITIAL THEN iv_actualdeliveryquantity ELSE 0 )
        ).

        " Navigate to the resource and create a request for the create operation
        lo_function = lo_client_proxy->create_resource_for_function( 'CREATE_BATCH_SPLIT_ITEM' ).
        lo_function->set_parameter(  is_parameter = ls_parameter ).
        lo_function_request = lo_function->create_request( ).

        lo_function_request->set_if_match( iv_etag ).
        lo_function_request->set_http_method( iv_http_method = /iwbep/if_cp_request_function=>gcs_http_method-post ).

        " Execute the request
        lo_function_response = lo_function_request->execute( ).

        " Get the after image
        lo_function_response->get_business_data( IMPORTING ea_response_data = la_business_data ).

        rv_posnr = la_business_data-delivery_document_item.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD get_etag_inbound_item."

    DATA:
      ls_entity_key    TYPE zsc_api_inbound_delivery_srv=>tys_a_inb_delivery_item_type,
      ls_business_data TYPE zsc_api_inbound_delivery_srv=>tys_a_inb_delivery_item_type,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_INBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_INBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Set entity key
        ls_entity_key = VALUE #(
                  delivery_document       = iv_inbounddelivery
                  delivery_document_item  = iv_inbounddeliveryitem ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_INB_DELIVERY_ITEM' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        rv_etag = ls_business_data-etag.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.
    ENDTRY.
  ENDMETHOD.


  METHOD get_etag_outbound."

    DATA:
      ls_entity_key    TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_header_typ,
      ls_business_data TYPE zsc_api_outbound_delivery_srv=>tys_a_outb_delivery_header_typ,
      lo_http_client   TYPE REF TO if_web_http_client,
      lo_resource      TYPE REF TO /iwbep/if_cp_resource_entity,
      lo_client_proxy  TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_request       TYPE REF TO /iwbep/if_cp_request_read,
      lo_response      TYPE REF TO /iwbep/if_cp_response_read.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Set entity key
        ls_entity_key = VALUE #(
          delivery_document = iv_outbounddelivery
        ).

        " Navigate to the resource
        lo_resource = lo_client_proxy->create_resource_for_entity_set( 'A_OUTB_DELIVERY_HEADER' )->navigate_with_key( ls_entity_key ).

        " Execute the request and retrieve the business data
        lo_response = lo_resource->create_request_for_read( )->execute( ).
        lo_response->get_business_data( IMPORTING es_business_data = ls_business_data ).

        rv_etag = ls_business_data-etag.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        RAISE SHORTDUMP lx_web_http_client_error.


    ENDTRY.
  ENDMETHOD.


  METHOD post_a07_r05."
    TYPES:
      BEGIN OF lty_outbound_input,
        ref_doc              TYPE string,
        ref_item             TYPE string,
        outbounddelivery     TYPE vbeln_vl,
        outbounddeliveryitem TYPE posnr_vl,
        plant                TYPE werks_d,
        storage_location     TYPE lgort_d,
      END OF lty_outbound_input.

    DATA: lt_outbound_input  TYPE TABLE OF lty_outbound_input,
          lt_outbound_change TYPE tty_outbound_change,
          lv_is_wm           TYPE abap_boolean,
          lv_message         TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    DATA(lt_request_item) = is_request-items.

    MOVE-CORRESPONDING lt_request_item TO lt_outbound_input.

    LOOP AT lt_outbound_input ASSIGNING FIELD-SYMBOL(<lfs_outbound_input>).
      <lfs_outbound_input>-outbounddelivery     = |{ <lfs_outbound_input>-ref_doc ALPHA = IN }|.
      <lfs_outbound_input>-outbounddeliveryitem = |{ <lfs_outbound_input>-ref_item ALPHA = IN }|.
      <lfs_outbound_input>-plant                = <lfs_outbound_input>-plant.
      <lfs_outbound_input>-storage_location      = <lfs_outbound_input>-storage_location.
    ENDLOOP.

    SELECT DISTINCT
      ewmwarehouse
      FROM i_ewm_plantstorlocmaptowhse
      FOR ALL ENTRIES IN @lt_outbound_input
      WHERE plant           = @lt_outbound_input-plant
        AND storagelocation = @lt_outbound_input-storage_location
      INTO TABLE @DATA(lt_t320).
    IF sy-subrc EQ 0.
      lv_is_wm = 'X'.
    ENDIF.

    SORT lt_outbound_input BY ref_doc ref_item.

    SELECT
      outbounddelivery,
      outbounddeliveryitem,
      storagelocation,
      batch,
      deliveryquantityunit,
      actualdeliveryquantity,
      higherlvlitmofbatspltitm
      FROM i_outbounddeliveryitem
      FOR ALL ENTRIES IN @lt_outbound_input
      WHERE outbounddelivery     = @lt_outbound_input-outbounddelivery
        AND outbounddeliveryitem = @lt_outbound_input-outbounddeliveryitem
      INTO TABLE @DATA(lt_outbound).
    IF sy-subrc EQ 0.
      SORT lt_outbound BY outbounddelivery outbounddeliveryitem.
    ENDIF.

    LOOP AT lt_request_item ASSIGNING FIELD-SYMBOL(<lfs_request_item>).
      READ TABLE lt_outbound_input INTO DATA(ls_outbound_input)
        WITH KEY ref_doc  = <lfs_request_item>-ref_doc
                 ref_item = <lfs_request_item>-ref_item BINARY SEARCH.
      IF sy-subrc EQ 0.
        READ TABLE lt_outbound INTO DATA(ls_outbound)
          WITH KEY outbounddelivery     = ls_outbound_input-outbounddelivery
                   outbounddeliveryitem = ls_outbound_input-outbounddeliveryitem BINARY SEARCH.
        IF sy-subrc EQ 0.
          APPEND VALUE #(
            outbounddelivery         = ls_outbound_input-outbounddelivery
            outbounddeliveryitem     = ls_outbound_input-outbounddeliveryitem
            storagelocation          = <lfs_request_item>-storage_location
            batch                    = <lfs_request_item>-batch
            deliveryquantityunit     = <lfs_request_item>-entry_uom
            actualdeliveryquantity   = <lfs_request_item>-entry_quantity
            higherlvlitmofbatspltitm = ls_outbound-higherlvlitmofbatspltitm
          ) TO lt_outbound_change ASSIGNING FIELD-SYMBOL(<lfs_outbound_change>).
        ELSE.
          es_response-status = cs_message_status-error.

          APPEND VALUE ty_message(
            type = 'E'
            text = |Delivery Item { ls_outbound_input-outbounddelivery } { ls_outbound_input-outbounddeliveryitem } not found|
          ) TO es_response-message.
        ENDIF.
      ENDIF.
    ENDLOOP.

    CHECK es_response-status NE cs_message_status-error.

    DATA(lt_data_outbound_new) = update_outbound(
      EXPORTING
        iv_is_wm      = lv_is_wm
        it_data       = lt_outbound_change
        iv_pstng_date = COND #( WHEN is_request-posting_date IS NOT INITIAL THEN is_request-posting_date
                                ELSE '00000000' )
      CHANGING
        es_response   = es_response
    ).

    DATA: lt_postd TYPE TABLE OF ztb_wm_dlv_pstdt.

    DATA(lv_vbeln) = lt_outbound_change[ 1 ]-outbounddelivery.

    SELECT COUNT(*)
      FROM ztb_wm_dlv_pstdt
      WHERE vbeln = @lv_vbeln.
    IF sy-subrc EQ 0.
      UPDATE ztb_wm_dlv_pstdt SET budat = @is_request-document_date,
                                  bktxt = @is_request-document_header_text
       WHERE vbeln = @lv_vbeln.
    ELSE.
      APPEND VALUE #( vbeln = lv_vbeln
                      budat = is_request-document_date
                      bktxt = is_request-document_header_text ) TO lt_postd.
      MODIFY ztb_wm_dlv_pstdt FROM TABLE @lt_postd.
    ENDIF.

    COMMIT WORK AND WAIT.

    CHECK es_response-status NE cs_message_status-error.

    IF lv_is_wm EQ 'X'.
      es_response-status = cs_message_status-success.
      lv_message = |OD { ls_outbound_input-outbounddelivery ALPHA = OUT } has been synchronized to warehouse { lt_t320[ 1 ]-ewmwarehouse }!|.
      APPEND VALUE #( type = 'S' text = lv_message ) TO es_response-message.
      RETURN.
    ENDIF.

    DATA(lv_etag) = get_etag_outbound(
      iv_outbounddelivery = ls_outbound_input-outbounddelivery
    ).

    post_goods_issue_oubound(
      EXPORTING
        iv_etag     = lv_etag
        iv_vbeln    = ls_outbound_input-outbounddelivery
      CHANGING
        es_response = es_response
    ).

*    CHECK es_response-status NE cs_message_status-error.
*
*    SELECT SINGLE
*      i_materialdocumentheader_2~materialdocument,
*      i_materialdocumentheader_2~materialdocumentyear
*      FROM i_materialdocumentheader_2
*      INNER JOIN zcore_i_matdoc_remove_rev
*      ON  i_materialdocumentheader_2~materialdocument     = zcore_i_matdoc_remove_rev~materialdocument
*      AND i_materialdocumentheader_2~materialdocumentyear = zcore_i_matdoc_remove_rev~materialdocumentyear
*      WHERE i_materialdocumentheader_2~deliverydocument = @ls_outbound_input-outbounddelivery
*      INTO @DATA(ls_matdoc).
*    IF sy-subrc EQ 0.
*      MODIFY ENTITIES OF i_materialdocumenttp
*        ENTITY materialdocument
*          UPDATE
*          FIELDS ( materialdocumentheadertext )
*          WITH VALUE #( ( materialdocument            = ls_matdoc-materialdocument
*                          materialdocumentyear        = ls_matdoc-materialdocumentyear
*                          materialdocumentheadertext  = is_request-document_header_text ) )
*          REPORTED DATA(ls_reported_matdoc)
*          FAILED   DATA(ls_failed_matdoc).
*      IF ls_failed_matdoc IS INITIAL.
*        COMMIT ENTITIES.
*      ELSE.
*        es_response-status = cs_message_status-error.
*        LOOP AT ls_reported_matdoc-materialdocument INTO DATA(ls_reported_matdoc_header).
*          APPEND VALUE #( type = 'E'
*                          text = ls_reported_matdoc_header-%msg->if_message~get_text( ) ) TO es_response-message.
*        ENDLOOP.
*        ROLLBACK ENTITIES.
*        RETURN.
*      ENDIF.
*    ENDIF.
  ENDMETHOD.


  METHOD post_a07_r08. "
    DATA ls_goodsmvt_code           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_code.
    DATA ls_goodsmvt_header         TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_01.
    DATA ls_goodsmvt_print_ctrl     TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_print.
    DATA ls_goodsmvt_ref_ewm        TYPE zsc_bapi_goodsmvt_create=>/spe/bapi2017_gm_ref_ewm.
    DATA lv_testrun                 TYPE zsc_bapi_goodsmvt_create=>testrun.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA ls_goodsmvt_headret        TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_head_ret.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_matdocumentyear         TYPE zsc_bapi_goodsmvt_create=>mjahr.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_materialdocument        TYPE zsc_bapi_goodsmvt_create=>mblnr.
    DATA lt_extensionin             TYPE zsc_bapi_goodsmvt_create=>_bapiparex.
    DATA ls_extensionin             TYPE zsc_bapi_goodsmvt_create=>bapiparex.
    DATA ls_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>bapi2017_gm_item_create.
    DATA lt_goodsmvt_item           TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_item_create.
    DATA lt_goodsmvt_item_cwm       TYPE zsc_bapi_goodsmvt_create=>_/cwm/bapi2017_gm_item_create.
    DATA lt_goodsmvt_serialnumber   TYPE zsc_bapi_goodsmvt_create=>_bapi2017_gm_serialnumber.
    DATA lt_goodsmvt_serv_part_data TYPE zsc_bapi_goodsmvt_create=>_/spe/bapi2017_servicepart_dat.
    DATA lt_return                  TYPE zsc_bapi_goodsmvt_create=>_bapiret2.

    DATA lv_matnr18                 TYPE n LENGTH 18.

    DATA lv_line_id                 TYPE zsc_bapi_goodsmvt_create=>mb_line_id.
    DATA ls_matdoc_incl_eew_ps_id   TYPE ty_matdoc_incl_eew_ps_id.

    CHECK es_response-status <> cs_message_status-error.

    ls_goodsmvt_header-pstng_date = is_request-posting_date.
    ls_goodsmvt_header-doc_date   = is_request-document_date.
    ls_goodsmvt_header-header_txt = is_request-document_header_text.
    ls_goodsmvt_code-gm_code      = '03'.

    LOOP AT is_request-items INTO DATA(ls_request_item).
      IF ls_request_item-material IS INITIAL.
*
*      ELSEIF ls_request_item-material CO '0123456789'.
      ELSE.
        lv_matnr18 = |{ ls_request_item-material ALPHA = IN }|.
        ls_request_item-material = lv_matnr18.
      ENDIF.

      IF ls_request_item-goods_move_type <> '261'.
        IF ls_request_item-batch IS INITIAL.
          create_batch( EXPORTING iv_material                 = ls_request_item-material
                                  iv_expiration_date          = ls_request_item-expiration_date
                                  iv_production_date          = ls_request_item-production_date
                                  iv_profit_center            = ls_request_item-profit_center
                                  iv_manufacturer             = ls_request_item-manufacturer
                                  iv_lot_num                  = ls_request_item-lot_num
                                  iv_batch_supplier           = ls_request_item-batch_supplier
                                  iv_batch_note               = ls_request_item-batch_note
                                  iv_qc_note                  = ls_request_item-qc_note
                                  iv_production_date_internal = ls_request_item-production_date_internal
                                  iv_expiration_date_internal = ls_request_item-expiration_date_internal
                                  iv_access_code              = ls_request_item-access_code
                                  iv_packaging_spec           = ls_request_item-packaging_spec
                                  iv_origin                   = ls_request_item-origin
                                  iv_gross_weight             = ls_request_item-gross_weight
                                  iv_quantity_btp             = ls_request_item-quantity_btp
                                  iv_quantity_tp              = ls_request_item-quantity_tp
                                  iv_plan_dept_note           = ls_request_item-plan_dept_note
                        CHANGING  ev_batch                    = ls_request_item-batch
                                  es_response                 = es_response ).
        ELSE.
          update_batch( EXPORTING iv_material                 = ls_request_item-material
                                  iv_batch                    = ls_request_item-batch
                                  iv_expiration_date          = ls_request_item-expiration_date
                                  iv_production_date          = ls_request_item-production_date
                                  iv_profit_center            = ls_request_item-profit_center
                                  iv_manufacturer             = ls_request_item-manufacturer
                                  iv_lot_num                  = ls_request_item-lot_num
                                  iv_batch_supplier           = ls_request_item-batch_supplier
                                  iv_batch_note               = ls_request_item-batch_note
                                  iv_qc_note                  = ls_request_item-qc_note
                                  iv_production_date_internal = ls_request_item-production_date_internal
                                  iv_expiration_date_internal = ls_request_item-expiration_date_internal
                                  iv_access_code              = ls_request_item-access_code
                                  iv_packaging_spec           = ls_request_item-packaging_spec
                                  iv_origin                   = ls_request_item-origin
                                  iv_gross_weight             = ls_request_item-gross_weight
                                  iv_quantity_btp             = ls_request_item-quantity_btp
                                  iv_quantity_tp              = ls_request_item-quantity_tp
                                  iv_plan_dept_note           = ls_request_item-plan_dept_note
                        CHANGING  es_response                 = es_response ).
        ENDIF.
      ENDIF.

      lv_line_id += 1.
      ls_goodsmvt_item-line_id   = lv_line_id.

      ls_goodsmvt_item-material  = ls_request_item-material.
      ls_goodsmvt_item-batch     = ls_request_item-batch.
      ls_goodsmvt_item-plant     = ls_request_item-plant.
      ls_goodsmvt_item-stge_loc  = ls_request_item-storage_location.
      ls_goodsmvt_item-entry_qnt = convert_entry_quantity( ls_request_item-entry_quantity ).
*      ls_goodsmvt_item-entry_qnt      = ls_request_item-entry_quantity.
      SELECT SINGLE unitofmeasure FROM i_unitofmeasure
        WHERE unitofmeasure_e = @ls_request_item-entry_uom
        INTO @ls_goodsmvt_item-entry_uom.
*      ls_goodsmvt_item-entry_uom      = ls_request_item-entry_uom.
      ls_goodsmvt_item-move_type = ls_request_item-goods_move_type.

      ls_goodsmvt_item-orderid   = |{ ls_request_item-ref_doc ALPHA = IN }|.
      ls_goodsmvt_item-res_item  = |{ ls_request_item-ref_item ALPHA = IN }|.

      SELECT SINGLE i_reservationdocumentitem~reservation,
                    i_reservationdocumentitem~recordtype
        FROM i_manufacturingorderitem WITH PRIVILEGED ACCESS
        INNER JOIN i_reservationdocumentitem WITH
        PRIVILEGED ACCESS
        ON i_manufacturingorderitem~reservation = i_reservationdocumentitem~reservation
        WHERE i_manufacturingorderitem~manufacturingorder = @ls_goodsmvt_item-orderid
          AND i_reservationdocumentitem~reservationitem   = @ls_goodsmvt_item-res_item
        INTO ( @ls_goodsmvt_item-reserv_no,
               @ls_goodsmvt_item-res_type ).

      ls_goodsmvt_item-mvt_ind = ''.
      APPEND ls_goodsmvt_item TO lt_goodsmvt_item.
      CLEAR ls_goodsmvt_item.

      ls_matdoc_incl_eew_ps_id-line_id          = lv_line_id.
      ls_matdoc_incl_eew_ps_id-yy1_nguoitao_mmi = sy-uname.

      ls_extensionin-structure = 'MATDOC_INCL_EEW_PS_ID'.
*      ls_extensionin-valuepart1 = ls_matdoc_incl_eew_ps_id.

      fill_container_c( EXPORTING im_value     = ls_matdoc_incl_eew_ps_id
                        IMPORTING ex_container = DATA(lv_container) ).
      ls_extensionin+30 = lv_container.
      APPEND ls_extensionin TO lt_extensionin.
      CLEAR: ls_extensionin,
             ls_matdoc_incl_eew_ps_id.
    ENDLOOP.

    call_bapi_goodsmvt_create( EXPORTING is_goodsmvt_code           = ls_goodsmvt_code
                                         is_goodsmvt_header         = ls_goodsmvt_header
                                         is_goodsmvt_print_ctrl     = ls_goodsmvt_print_ctrl
                                         is_goodsmvt_ref_ewm        = ls_goodsmvt_ref_ewm
                                         iv_testrun                 = lv_testrun
                               IMPORTING es_goodsmvt_headret        = ls_goodsmvt_headret
                                         ev_matdocumentyear         = lv_matdocumentyear
                                         ev_materialdocument        = lv_materialdocument
                               CHANGING  ct_extensionin             = lt_extensionin
                                         ct_goodsmvt_item           = lt_goodsmvt_item
                                         ct_goodsmvt_item_cwm       = lt_goodsmvt_item_cwm
                                         ct_goodsmvt_serialnumber   = lt_goodsmvt_serialnumber
                                         ct_goodsmvt_serv_part_data = lt_goodsmvt_serv_part_data
                                         ct_return                  = lt_return
                                         cs_response                = es_response ).
    LOOP AT lt_return INTO DATA(ls_return).
      APPEND VALUE ty_message( type = ls_return-type
                               text = ls_return-message ) TO es_response-message.
    ENDLOOP.
  ENDMETHOD.


  METHOD post_goods_issue_oubound."

    TYPES ty_return TYPE STANDARD TABLE OF zsc_api_outbound_delivery_srv=>tys_picking_report.

    DATA:
      ls_parameter         TYPE zsc_api_outbound_delivery_srv=>tys_parameters_6,
      la_business_data     TYPE ty_return,
      lo_http_client       TYPE REF TO if_web_http_client,
      lo_client_proxy      TYPE REF TO /iwbep/if_cp_client_proxy,
      lo_function_request  TYPE REF TO /iwbep/if_cp_request_function,
      lo_function          TYPE REF TO /iwbep/if_cp_resource_function,
      lo_function_response TYPE REF TO /iwbep/if_cp_response_function,
      lv_message           TYPE string.

    CHECK es_response-status NE cs_message_status-error.

    TRY.
        " Create http client
        TRY.
            DATA(lo_destination) = cl_http_destination_provider=>create_by_comm_arrangement(
                                                         comm_scenario  = 'ZCORE_CS_SAP'
                                                         service_id     = 'Z_API_SAP_REST' ).
          CATCH cx_http_dest_provider_error.
            "handle exception
        ENDTRY.
        lo_http_client = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).
        lo_client_proxy = /iwbep/cl_cp_factory_remote=>create_v2_remote_proxy(
          EXPORTING
             is_proxy_model_key       = VALUE #( repository_id       = 'DEFAULT'
                                                 proxy_model_id      = 'ZSC_API_OUTBOUND_DELIVERY_SRV'
                                                 proxy_model_version = '0001' )
            io_http_client             = lo_http_client
            iv_relative_service_root   = '/sap/opu/odata/sap/API_OUTBOUND_DELIVERY_SRV;v=0002' ).

        ASSERT lo_http_client IS BOUND.


        " Prepare parameter
        ls_parameter = VALUE #(
          delivery_document  = iv_vbeln
        ).

        " Navigate to the resource and create a request for the create operation
        lo_function = lo_client_proxy->create_resource_for_function( 'POST_GOODS_ISSUE' ).
        lo_function->set_parameter(  is_parameter = ls_parameter ).
        lo_function_request = lo_function->create_request( ).

        lo_function_request->set_if_match( iv_etag ).
        lo_function_request->set_http_method( iv_http_method = /iwbep/if_cp_request_function=>gcs_http_method-post ).

        " Execute the request
        lo_function_response = lo_function_request->execute( ).

        " Get the after image
        lo_function_response->get_business_data( IMPORTING ea_response_data = la_business_data ).

        LOOP AT la_business_data TRANSPORTING NO FIELDS
          WHERE system_message_type EQ 'E' OR
                system_message_type EQ 'A'.
          EXIT.
        ENDLOOP.
        IF sy-subrc IS NOT INITIAL.
          es_response-status = cs_message_status-success.
          lv_message = |Post Goods Issue OD { iv_vbeln ALPHA = OUT } successful!|.
          APPEND VALUE #( type = 'S' text = lv_message ) TO es_response-message.
        ELSE.
          es_response-status = cs_message_status-error.
          LOOP AT la_business_data INTO DATA(ls_business_data).
            MESSAGE ID ls_business_data-system_message_identificat TYPE ls_business_data-system_message_type NUMBER ls_business_data-system_message_number
              WITH ls_business_data-system_message_variable_1
                   ls_business_data-system_message_variable_2
                   ls_business_data-system_message_variable_3
                   ls_business_data-system_message_variable_4
                   INTO lv_message.
            APPEND VALUE #( type = ls_business_data-system_message_type
                            text = lv_message ) TO es_response-message.
          ENDLOOP.
        ENDIF.
      CATCH /iwbep/cx_cp_remote INTO DATA(lx_remote).
        " Handle remote Exception
        " It contains details about the problems of your http(s) connection
        es_response-status = cs_message_status-error.
        lv_message = lx_remote->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_gateway->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        " Handle Exception
        es_response-status = cs_message_status-error.
        lv_message = lx_web_http_client_error->get_longtext( ).
        APPEND VALUE #( type = 'E' text = lv_message ) TO es_response-message.
    ENDTRY.
  ENDMETHOD.


  METHOD process_a01_r08."
    DATA: ls_request_return TYPE zcl_api_wm_zmigo=>ty_request .

    DATA(ls_request) = check_data_a01_r08(
      EXPORTING
        is_request_raw  = is_request_raw
      CHANGING
        es_response     = rs_response
    ).

    DATA(lv_material_document) = post_a01_r08(
      EXPORTING
        is_request  = ls_request
      CHANGING
        cs_request  = ls_request_return
        es_response = rs_response
    ).

    CHECK rs_response-status NE cs_message_status-error.
    CHECK ls_request_return-items IS NOT INITIAL.

    LOOP AT ls_request_return-items ASSIGNING FIELD-SYMBOL(<lfs_item>).
      <lfs_item>-goods_move_type        = '411'.
      <lfs_item>-move_plant             = <lfs_item>-plant.
      <lfs_item>-move_material          = <lfs_item>-material.
      <lfs_item>-move_storage_location  = <lfs_item>-storage_location.
      <lfs_item>-move_batch             = <lfs_item>-batch.
      <lfs_item>-move_sales_ord         = <lfs_item>-sales_ord.
      <lfs_item>-move_sales_ord_item    = <lfs_item>-sales_ord_item.
    ENDLOOP.

    lv_material_document = post_r10(
      EXPORTING
        iv_action       = 'A08'
        is_request      = ls_request_return
        iv_no_upd_batch = 'X'
      CHANGING
        es_response     = rs_response
    ).
  ENDMETHOD.


  METHOD update_batch. "
    DATA lt_characteristic_create TYPE TABLE FOR CREATE i_batchcharacteristictp_2\_batchcharacteristicvaluetp.
    DATA lt_characteristic_update TYPE TABLE FOR UPDATE I_BatchCharacteristicValueTP_2.
    DATA lv_production_date       TYPE d.
    DATA lv_production_date_flag  TYPE abp_behv_flag.
    DATA lv_atflv                 TYPE atflv.

    CHECK es_response-status <> cs_message_status-error.

    SELECT COUNT(*) FROM i_product
      WHERE Product                   = @iv_material
        AND IsBatchManagementRequired = 'X'.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    SELECT SINGLE i_clfnclassdex~Class
      FROM I_ClfnObjectClass
           INNER JOIN I_ClfnClassDEX ON  i_clfnclassdex~ClassInternalID  = i_clfnobjectclass~ClassInternalID
                                     AND i_clfnclassdex~ValidityEndDate >= @sy-datum
      WHERE i_clfnobjectclass~ClfnObjectID    = @iv_material
        AND i_clfnobjectclass~ClfnObjectTable = 'MARA'
      INTO @DATA(lv_class).
    IF sy-subrc = 0.
      CASE lv_class.
        WHEN 'Z_TP'.
          lv_production_date      = iv_production_date_internal.
          lv_production_date_flag = cl_abap_behv=>flag_changed.
        WHEN 'Z_NVL'.
          lv_production_date      = iv_production_date.
          lv_production_date_flag = cl_abap_behv=>flag_changed.
        WHEN OTHERS.
          CLEAR lv_production_date.
          lv_production_date_flag = cl_abap_behv=>flag_null.
      ENDCASE.
    ENDIF.

    MODIFY ENTITIES OF i_batchtp_2
           ENTITY batch
           UPDATE
           FROM VALUE #( ( Material                         = iv_material
                           Batch                            = iv_batch
                           ManufactureDate                  = lv_production_date
                           ShelfLifeExpirationDate          = iv_expiration_date
                           Supplier                         = |{ iv_batch_supplier ALPHA = IN }|
                           %control-ManufactureDate         = lv_production_date_flag
                           %control-ShelfLifeExpirationDate = cl_abap_behv=>flag_changed
                           %control-Supplier                = cl_abap_behv=>flag_changed ) )
           " TODO: variable is assigned but never used (ABAP cleaner)
           MAPPED   DATA(ls_mapped)
           FAILED   DATA(ls_failed)
           REPORTED DATA(ls_reported).
    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported-Batch INTO DATA(ls_reported_batch).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.

    SELECT i_clfnobjectclass~ClassInternalID,
           i_clfncharacteristic~Characteristic,
           i_clfncharacteristic~CharcInternalID
      FROM I_ClfnObjectClass
           INNER JOIN I_ClfnClassCharacteristicDEX ON  i_clfnclasscharacteristicdex~ClassInternalID  = i_clfnobjectclass~ClassInternalID
                                                   AND i_clfnclasscharacteristicdex~ValidityEndDate >= @sy-datum
           INNER JOIN I_ClfnCharacteristic         ON i_clfncharacteristic~CharcInternalID = i_clfnclasscharacteristicdex~CharcInternalID
      WHERE i_clfnobjectclass~ClfnObjectID       = @iv_material
        AND i_clfnobjectclass~ClfnObjectTable    = 'MARA'
        AND i_clfncharacteristic~Characteristic IN ( 'Z_PC', 'Z_NHASX', 'Z_LOT', 'Z_GHICHU',
                                                     'Z_NSXNB', 'Z_HSDNB', 'Z_MTX', 'Z_QCBG',
                                                     'Z_NG', 'Z_GW', 'Z_NSX', 'Z_GCQC',
                                                     'Z_SLBTPKT', 'Z_SLTPKT', 'Z_GHICHU_PKH' )
      INTO TABLE @DATA(lt_atinn).

    IF lt_atinn IS INITIAL.
      RETURN.
    ENDIF.

    SELECT Product                      AS material,
           Batch,
           CharcInternalID,
           ClfnCharcValuePositionNumber
      FROM zcore_i_batch_characteristic
      FOR ALL ENTRIES IN @lt_atinn
      WHERE Product         = @iv_material
        AND Batch           = @iv_batch
        AND CharcInternalID = @lt_atinn-CharcInternalID
      INTO TABLE @DATA(lt_batch_character).

    READ ENTITIES OF i_batchtp_2
         ENTITY batchcharacteristicvalue
         ALL FIELDS
         WITH VALUE #( FOR ls_batch_character IN lt_batch_character
                       ( Material                     = ls_batch_character-Material
                         Batch                        = ls_batch_character-Batch
                         CharcInternalID              = ls_batch_character-CharcInternalID
                         ClfnCharcValuePositionNumber = ls_batch_character-ClfnCharcValuePositionNumber ) )
         RESULT   DATA(lt_characteristic_read)
         FAILED   ls_failed
         REPORTED ls_reported.

    SORT lt_characteristic_read BY CharcInternalID.

    LOOP AT lt_atinn INTO DATA(ls_atinn).
      CASE ls_atinn-Characteristic.
        WHEN 'Z_PC'.
          IF iv_profit_center IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NHASX'.
          IF iv_manufacturer IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_LOT'.
          IF iv_lot_num IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GHICHU'.
          IF iv_batch_note IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GCQC'.
          IF iv_qc_note IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NSXNB'.
          IF iv_production_date_internal IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_HSDNB'.
          IF iv_expiration_date_internal IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_MTX'.
          IF iv_access_code IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_QCBG'.
          IF iv_packaging_spec IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NG'.
          IF iv_origin IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GW'.
          IF iv_gross_weight IS INITIAL.
            CONTINUE.
          ENDIF.
          lv_atflv = iv_gross_weight.
          IF lv_atflv IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_NSX'.
          IF iv_production_date IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_SLBTPKT'.
          IF iv_quantity_btp IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_SLTPKT'.
          IF iv_quantity_tp IS INITIAL.
            CONTINUE.
          ENDIF.
        WHEN 'Z_GHICHU_PKH'.
          IF iv_plan_dept_note IS INITIAL.
            CONTINUE.
          ENDIF.
      ENDCASE.

      READ TABLE lt_characteristic_read INTO DATA(ls_characteristic_read)
           WITH KEY Material        = iv_material
                    Batch           = iv_batch
                    CharcInternalID = ls_atinn-CharcInternalID BINARY SEARCH.
      IF sy-subrc = 0.
        APPEND VALUE #( Material                     = ls_characteristic_read-Material
                        Batch                        = ls_characteristic_read-Batch
                        CharcInternalID              = ls_characteristic_read-CharcInternalID
                        ClfnCharcValuePositionNumber = ls_characteristic_read-ClfnCharcValuePositionNumber )
               TO lt_characteristic_update ASSIGNING FIELD-SYMBOL(<lfs_characteristic_update>).
        CASE ls_atinn-Characteristic.
          WHEN 'Z_PC'.
            <lfs_characteristic_update>-CharcValue          = iv_profit_center.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_NHASX'.
            <lfs_characteristic_update>-CharcValue          = iv_manufacturer.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_LOT'.
            <lfs_characteristic_update>-CharcValue          = iv_lot_num.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_GHICHU'.
            <lfs_characteristic_update>-CharcValue          = iv_batch_note.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_GCQC'.
            <lfs_characteristic_update>-CharcValue          = iv_qc_note.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_NSXNB'.
            <lfs_characteristic_update>-CharcValueIntervalType = 1.
            <lfs_characteristic_update>-CharcFromNumericValue  = iv_production_date_internal.
            <lfs_characteristic_update>-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_update>-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.

            " fix bug: update multiple dates not working
            DELETE lt_characteristic_update INDEX lines( lt_characteristic_update ).
            MODIFY ENTITIES OF i_batchtp_2
                   ENTITY batchcharacteristicvalue
                   UPDATE
                   FIELDS ( charcvalueintervaltype
                            charcfromnumericvalue )
                   WITH VALUE #( ( Material                     = ls_characteristic_read-Material
                                   Batch                        = ls_characteristic_read-Batch
                                   CharcInternalID              = ls_characteristic_read-CharcInternalID
                                   ClfnCharcValuePositionNumber = ls_characteristic_read-ClfnCharcValuePositionNumber
                                   CharcValueIntervalType       = 1
                                   CharcFromNumericValue        = iv_production_date_internal ) )
                   MAPPED   ls_mapped
                   FAILED   ls_failed
                   REPORTED ls_reported.
            IF ls_failed IS INITIAL.
              COMMIT ENTITIES.
            ENDIF.
          WHEN 'Z_HSDNB'.
            <lfs_characteristic_update>-CharcValueIntervalType = 1.
            <lfs_characteristic_update>-CharcFromNumericValue  = iv_expiration_date_internal.
            <lfs_characteristic_update>-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_update>-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.

            " fix bug: update multiple dates not working
            DELETE lt_characteristic_update INDEX lines( lt_characteristic_update ).
            MODIFY ENTITIES OF i_batchtp_2
                   ENTITY batchcharacteristicvalue
                   UPDATE
                   FIELDS ( charcvalueintervaltype
                            charcfromnumericvalue )
                   WITH VALUE #( ( Material                     = ls_characteristic_read-Material
                                   Batch                        = ls_characteristic_read-Batch
                                   CharcInternalID              = ls_characteristic_read-CharcInternalID
                                   ClfnCharcValuePositionNumber = ls_characteristic_read-ClfnCharcValuePositionNumber
                                   CharcValueIntervalType       = 1
                                   CharcFromNumericValue        = iv_expiration_date_internal ) )
                   MAPPED   ls_mapped
                   FAILED   ls_failed
                   REPORTED ls_reported.
            IF ls_failed IS INITIAL.
              COMMIT ENTITIES.
            ENDIF.
          WHEN 'Z_MTX'.
            <lfs_characteristic_update>-CharcValue          = iv_access_code.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_QCBG'.
            <lfs_characteristic_update>-CharcValue          = iv_packaging_spec.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_NG'.
            <lfs_characteristic_update>-CharcValue          = iv_origin.
            <lfs_characteristic_update>-%control-CharcValue = cl_abap_behv=>flag_changed.
          WHEN 'Z_GW'.
            <lfs_characteristic_update>-CharcValueIntervalType = 1.
            <lfs_characteristic_update>-CharcFromNumericValue  = iv_gross_weight.
            <lfs_characteristic_update>-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_update>-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.

            " fix bug: update multiple numeric not working
            DELETE lt_characteristic_update INDEX lines( lt_characteristic_update ).
            MODIFY ENTITIES OF i_batchtp_2
                   ENTITY batchcharacteristicvalue
                   UPDATE
                   FIELDS ( charcvalueintervaltype
                            charcfromnumericvalue )
                   WITH VALUE #( ( Material                     = ls_characteristic_read-Material
                                   Batch                        = ls_characteristic_read-Batch
                                   CharcInternalID              = ls_characteristic_read-CharcInternalID
                                   ClfnCharcValuePositionNumber = ls_characteristic_read-ClfnCharcValuePositionNumber
                                   CharcValueIntervalType       = 1
                                   CharcFromNumericValue        = iv_gross_weight ) )
                   MAPPED   ls_mapped
                   FAILED   ls_failed
                   REPORTED ls_reported.
            IF ls_failed IS INITIAL.
              COMMIT ENTITIES.
            ENDIF.
          WHEN 'Z_NSX'.
            <lfs_characteristic_update>-CharcValueIntervalType = 1.
            <lfs_characteristic_update>-CharcFromNumericValue  = iv_production_date.
            <lfs_characteristic_update>-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_update>-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.

            " fix bug: update multiple dates not working
            DELETE lt_characteristic_update INDEX lines( lt_characteristic_update ).
            MODIFY ENTITIES OF i_batchtp_2
                   ENTITY batchcharacteristicvalue
                   UPDATE
                   FIELDS ( charcvalueintervaltype
                            charcfromnumericvalue )
                   WITH VALUE #( ( Material                     = ls_characteristic_read-Material
                                   Batch                        = ls_characteristic_read-Batch
                                   CharcInternalID              = ls_characteristic_read-CharcInternalID
                                   ClfnCharcValuePositionNumber = ls_characteristic_read-ClfnCharcValuePositionNumber
                                   CharcValueIntervalType       = 1
                                   CharcFromNumericValue        = iv_production_date ) )
                   MAPPED   ls_mapped
                   FAILED   ls_failed
                   REPORTED ls_reported.
            IF ls_failed IS INITIAL.
              COMMIT ENTITIES.
            ENDIF.
          WHEN 'Z_SLBTPKT'.
            <lfs_characteristic_update>-CharcValueIntervalType = 1.
            <lfs_characteristic_update>-CharcFromNumericValue  = iv_quantity_btp.
            <lfs_characteristic_update>-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_update>-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.

            " fix bug: update multiple numeric not working
            DELETE lt_characteristic_update INDEX lines( lt_characteristic_update ).
            MODIFY ENTITIES OF i_batchtp_2
                   ENTITY batchcharacteristicvalue
                   UPDATE
                   FIELDS ( charcvalueintervaltype
                            charcfromnumericvalue )
                   WITH VALUE #( ( Material                     = ls_characteristic_read-Material
                                   Batch                        = ls_characteristic_read-Batch
                                   CharcInternalID              = ls_characteristic_read-CharcInternalID
                                   ClfnCharcValuePositionNumber = ls_characteristic_read-ClfnCharcValuePositionNumber
                                   CharcValueIntervalType       = 1
                                   CharcFromNumericValue        = iv_quantity_btp ) )
                   MAPPED   ls_mapped
                   FAILED   ls_failed
                   REPORTED ls_reported.
            IF ls_failed IS INITIAL.
              COMMIT ENTITIES.
            ENDIF.
          WHEN 'Z_SLTPKT'.
            <lfs_characteristic_update>-CharcValueIntervalType = 1.
            <lfs_characteristic_update>-CharcFromNumericValue  = iv_quantity_tp.
            <lfs_characteristic_update>-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_update>-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.

            " fix bug: update multiple numeric not working
            DELETE lt_characteristic_update INDEX lines( lt_characteristic_update ).
            MODIFY ENTITIES OF i_batchtp_2
                   ENTITY batchcharacteristicvalue
                   UPDATE
                   FIELDS ( charcvalueintervaltype
                            charcfromnumericvalue )
                   WITH VALUE #( ( Material                     = ls_characteristic_read-Material
                                   Batch                        = ls_characteristic_read-Batch
                                   CharcInternalID              = ls_characteristic_read-CharcInternalID
                                   ClfnCharcValuePositionNumber = ls_characteristic_read-ClfnCharcValuePositionNumber
                                   CharcValueIntervalType       = 1
                                   CharcFromNumericValue        = iv_quantity_tp ) )
                   MAPPED   ls_mapped
                   FAILED   ls_failed
                   REPORTED ls_reported.
            IF ls_failed IS INITIAL.
              COMMIT ENTITIES.
            ENDIF.
          WHEN 'Z_GHICHU_PKH'.
            <lfs_characteristic_update>-CharcValue                      = iv_plan_dept_note.
            <lfs_characteristic_update>-%control-CharcValue             = cl_abap_behv=>flag_changed.
        ENDCASE.
      ELSE.
        APPEND VALUE #( Material        = iv_material
                        Batch           = iv_batch
                        CharcInternalID = ls_atinn-CharcInternalID
                        %target         = VALUE #( ( Material                 = iv_material
                                                     Batch                    = iv_batch
                                                     CharcInternalID          = ls_atinn-CharcInternalID
                                                     %control-Material        = cl_abap_behv=>flag_changed
                                                     %control-Batch           = cl_abap_behv=>flag_changed
                                                     %control-CharcInternalID = cl_abap_behv=>flag_changed ) ) )
               TO lt_characteristic_create ASSIGNING FIELD-SYMBOL(<lfs_characteristic_create>).
        CASE ls_atinn-Characteristic.
          WHEN 'Z_PC'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_profit_center.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_NHASX'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_manufacturer.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_LOT'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_lot_num.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_GHICHU'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_batch_note.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_GCQC'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_qc_note.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_NSXNB'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValueIntervalType          = 1.
            <lfs_characteristic_create>-%target[ 1 ]-CharcFromNumericValue           = iv_production_date_internal.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.
          WHEN 'Z_HSDNB'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValueIntervalType          = 1.
            <lfs_characteristic_create>-%target[ 1 ]-CharcFromNumericValue           = iv_expiration_date_internal.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.
          WHEN 'Z_MTX'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_access_code.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_QCBG'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_packaging_spec.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_NG'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_origin.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
          WHEN 'Z_GW'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValueIntervalType          = 1.
            <lfs_characteristic_create>-%target[ 1 ]-CharcFromNumericValue           = iv_gross_weight.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.
          WHEN 'Z_NSX'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValueIntervalType          = 1.
            <lfs_characteristic_create>-%target[ 1 ]-CharcFromNumericValue           = iv_production_date.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.
          WHEN 'Z_SLBTPKT'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValueIntervalType          = 1.
            <lfs_characteristic_create>-%target[ 1 ]-CharcFromNumericValue           = iv_quantity_btp.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.
          WHEN 'Z_SLTPKT'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValueIntervalType          = 1.
            <lfs_characteristic_create>-%target[ 1 ]-CharcFromNumericValue           = iv_quantity_tp.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValueIntervalType = cl_abap_behv=>flag_changed.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcFromNumericValue  = cl_abap_behv=>flag_changed.
          WHEN 'Z_GHICHU_PKH'.
            <lfs_characteristic_create>-%target[ 1 ]-CharcValue                      = iv_plan_dept_note.
            <lfs_characteristic_create>-%target[ 1 ]-%control-CharcValue             = cl_abap_behv=>flag_changed.
        ENDCASE.
      ENDIF.
    ENDLOOP.

    MODIFY ENTITIES OF i_batchtp_2
           ENTITY batchcharacteristic
           CREATE BY \_batchcharacteristicvaluetp
           AUTO FILL CID
           WITH lt_characteristic_create
           ENTITY batchcharacteristicvalue
           UPDATE
           FROM lt_characteristic_update
           MAPPED   ls_mapped
           FAILED   ls_failed
           REPORTED ls_reported.
    IF ls_failed IS INITIAL.
      COMMIT ENTITIES.
    ELSE.
      es_response-status = cs_message_status-error.
      LOOP AT ls_reported-Batch INTO ls_reported_batch.
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batch-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-BatchCharacteristic INTO DATA(ls_reported_batchcharc).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharc-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      LOOP AT ls_reported-BatchCharacteristicValue INTO DATA(ls_reported_batchcharcvalue).
        APPEND VALUE #( type = 'E'
                        text = ls_reported_batchcharcvalue-%msg->if_message~get_text( ) ) TO es_response-message.
      ENDLOOP.
      ROLLBACK ENTITIES.
      RETURN.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

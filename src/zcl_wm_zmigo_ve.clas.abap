CLASS zcl_wm_zmigo_ve DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_sadl_exit_calc_element_read.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA: mv_entity TYPE string.
ENDCLASS.



CLASS ZCL_WM_ZMIGO_VE IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    CHECK NOT it_original_data IS INITIAL.
    CASE mv_entity.
      WHEN 'ZI_WM_ZMIGO_R01'.
        DATA : lt_calculated_data_r01 TYPE STANDARD TABLE OF zi_wm_zmigo_r01 WITH DEFAULT KEY.

        MOVE-CORRESPONDING it_original_data TO lt_calculated_data_r01.

        SELECT
          purchaseorder,
          textobjecttype,
          plainlongtext
          FROM i_purchaseordernotetp_2
          FOR ALL ENTRIES IN @lt_calculated_data_r01
          WHERE purchaseorder   = @lt_calculated_data_r01-purchaseorder
            AND textobjecttype  IN ( 'F01' )
            AND language        EQ @sy-langu
          INTO TABLE @DATA(lt_po_text).
        IF sy-subrc EQ 0.
          SORT lt_po_text BY purchaseorder textobjecttype.
        ENDIF.

        "Product Basic Text
        DATA(lt_mat) = CORRESPONDING zcore_cl_get_long_text=>ty_product( lt_calculated_data_r01 DISCARDING DUPLICATES MAPPING product = material ).
        DATA(lt_mat_text) = zcore_cl_get_long_text=>get_multi_product_text( it_material = lt_mat
                                                                            what_get    = 'purchase' ).

        SELECT
          purchaseorder,
          purchaseorderitem,
          textobjecttype,
          plainlongtext
          FROM i_purchaseorderitemnotetp_2
          FOR ALL ENTRIES IN @lt_calculated_data_r01
          WHERE purchaseorder     = @lt_calculated_data_r01-purchaseorder
            AND purchaseorderitem = @lt_calculated_data_r01-purchaseorderitem
            AND textobjecttype    IN ( 'F01', 'F03' )
            AND language          EQ @sy-langu
          INTO TABLE @DATA(lt_poitem_text).
        IF sy-subrc EQ 0.
          SORT lt_poitem_text BY purchaseorder purchaseorderitem textobjecttype.
        ENDIF.

        SELECT
          purchaseorder,
          purchaseorderitem,
          purchaseorderitemtext
          FROM i_purchaseorderitemapi01
          FOR ALL ENTRIES IN @lt_calculated_data_r01
          WHERE purchaseorder     = @lt_calculated_data_r01-purchaseorder
            AND purchaseorderitem = @lt_calculated_data_r01-purchaseorderitem
          INTO TABLE @DATA(lt_poitem).
        IF sy-subrc EQ 0.
          SORT lt_poitem BY purchaseorder purchaseorderitem.
        ENDIF.

        SELECT
          mseg~purchaseorder,
          mseg~purchaseorderitem,
          mseg~batch
          FROM  i_materialdocumentitem_2 AS mseg
          LEFT OUTER JOIN       i_materialdocumentitem_2 AS mseg_rev
          ON  mseg~materialdocument     = mseg_rev~reversedmaterialdocument
          AND mseg~materialdocumentitem = mseg_rev~reversedmaterialdocument
          AND mseg~materialdocumentyear = mseg_rev~reversedmaterialdocument
          INNER JOIN @lt_calculated_data_r01 AS data
          ON  mseg~purchaseorder     = data~purchaseorder
          AND mseg~purchaseorderitem = data~purchaseorderitem
          WHERE mseg~goodsmovementrefdoctype        = 'B'
            AND mseg~reversedmaterialdocument       IS INITIAL
            AND mseg_rev~materialdocument           IS NULL
          ORDER BY
          mseg~purchaseorder,
          mseg~purchaseorderitem,
          mseg~batch
          INTO TABLE @DATA(lt_batch).

        LOOP AT lt_calculated_data_r01 ASSIGNING FIELD-SYMBOL(<lfs_data_r01>).
          " Ưu tiên 1: Material PO Text - Tên dài mua hàng
          " Ưu tiên 1.1 :
          " Tham chiếu Số đơn hàng (PO) + Item PO
          " --> [APP] Display Purchase Order --> Item Detail
          " --> Tab Texts --> Lấy diễn giải Material PO Text
          READ TABLE lt_poitem_text INTO DATA(ls_poitem_text)
            WITH KEY purchaseorder     = <lfs_data_r01>-purchaseorder
                     purchaseorderitem = <lfs_data_r01>-purchaseorderitem
                     textobjecttype    = 'F03' BINARY SEARCH.
          IF sy-subrc EQ 0.
            <lfs_data_r01>-materialdescription = ls_poitem_text-plainlongtext.
          ENDIF.

          " Ưu tiên 1.2 :
          " Tham chiếu Số đơn hàng (PO) + Item PO
          " --> CDs View I_PurchaseOrderItemAPI01 --> Lấy [Field] Material
          " --> [APP] MM03 --> Tab Purchase order text --> Lấy diễn giải EN
          IF <lfs_data_r01>-materialdescription IS INITIAL.
            READ TABLE lt_mat_text INTO DATA(ls_mat_text)
              WITH KEY product                      = <lfs_data_r01>-material
                       product_sales_org            = ''
                       product_distribution_chnl    = ''
                       language                     = 'EN' BINARY SEARCH.
            IF sy-subrc EQ 0.
              <lfs_data_r01>-materialdescription = ls_mat_text-long_text.
            ENDIF.
          ENDIF.

          " Ưu tiên 2: Item text - Tên dài sản phẩm0
          " Tham chiếu Số đơn hàng (PO) + Item PO
          " --> [APP] Display Purchase Order --> Item Detail
          " --> Tab Texts --> Lấy diễn giải Item Text
          IF <lfs_data_r01>-materialdescription IS INITIAL.
            READ TABLE lt_poitem_text INTO ls_poitem_text
              WITH KEY purchaseorder     = <lfs_data_r01>-purchaseorder
                       purchaseorderitem = <lfs_data_r01>-purchaseorderitem
                       textobjecttype    = 'F01' BINARY SEARCH.
            IF sy-subrc EQ 0.
              <lfs_data_r01>-materialdescription = ls_poitem_text-plainlongtext.
            ENDIF.
          ENDIF.

          " Ưu tiên 3: PO Short Text - Tên ngắn trên PO
          " Tham chiếu Số đơn hàng (PO) + Item PO
          " --> CDs View I_PurchaseOrderItemAPI01 Lấy [Field] Short Text
          IF <lfs_data_r01>-materialdescription IS INITIAL.
            READ TABLE lt_poitem INTO DATA(ls_poitem)
              WITH KEY purchaseorder     = <lfs_data_r01>-purchaseorder
                       purchaseorderitem = <lfs_data_r01>-purchaseorderitem BINARY SEARCH.
            IF sy-subrc EQ 0.
              <lfs_data_r01>-materialdescription = ls_poitem-purchaseorderitemtext.
            ENDIF.
          ENDIF.

          READ TABLE lt_po_text INTO DATA(ls_po_text)
            WITH KEY purchaseorder  = <lfs_data_r01>-purchaseorder
                     textobjecttype = 'F01' BINARY SEARCH.
          IF sy-subrc EQ 0.
            <lfs_data_r01>-headertext = ls_po_text-plainlongtext.
          ENDIF.

          READ TABLE lt_batch INTO DATA(ls_batch)
            WITH KEY purchaseorder     = <lfs_data_r01>-purchaseorder
                     purchaseorderitem = <lfs_data_r01>-purchaseorderitem BINARY SEARCH.
          IF sy-subrc EQ 0.
            <lfs_data_r01>-batch = ls_batch-batch.
          ENDIF.
        ENDLOOP.

        MOVE-CORRESPONDING lt_calculated_data_r01 TO ct_calculated_data.
      WHEN 'ZI_WM_ZMIGO_R04'.
        TYPES: BEGIN OF lty_purchaseorderitem,
                 purchaseorder     TYPE ebeln,
                 purchaseorderitem TYPE ebelp,
               END OF lty_purchaseorderitem,
               BEGIN OF lty_product,
                 product TYPE matnr,
               END OF lty_product.
        DATA: lt_purchaseorderitem   TYPE TABLE OF lty_purchaseorderitem,
              lt_product             TYPE TABLE OF lty_product,
              lt_calculated_data_r04 TYPE STANDARD TABLE OF zi_wm_zmigo_r04 WITH DEFAULT KEY.

        MOVE-CORRESPONDING it_original_data TO lt_calculated_data_r04.

        lt_purchaseorderitem = CORRESPONDING #( lt_calculated_data_r04
                                                MAPPING purchaseorder     = referencesddocument
                                                        purchaseorderitem = referencesddocumentitem ).
        SORT lt_purchaseorderitem BY purchaseorder purchaseorderitem.
        DELETE ADJACENT DUPLICATES FROM lt_purchaseorderitem COMPARING ALL FIELDS.

        SELECT
          purchaseorder,
          purchaseorderitem,
          textobjecttype,
          plainlongtext
          FROM i_purchaseorderitemnotetp_2
          FOR ALL ENTRIES IN @lt_purchaseorderitem
          WHERE purchaseorder     = @lt_purchaseorderitem-purchaseorder
            AND purchaseorderitem = @lt_purchaseorderitem-purchaseorderitem
            AND textobjecttype    IN ( 'F03' )
            AND language          EQ @sy-langu
          INTO TABLE @lt_poitem_text.
        IF sy-subrc EQ 0.
          SORT lt_poitem_text BY purchaseorder purchaseorderitem textobjecttype.
        ENDIF.

        lt_product = CORRESPONDING #( lt_calculated_data_r04 MAPPING product = material ).
        SORT lt_product BY product.
        DELETE ADJACENT DUPLICATES FROM lt_product COMPARING ALL FIELDS.

        SELECT
          product,
          productname
          FROM i_producttext
          FOR ALL ENTRIES IN @lt_product
          WHERE product  = @lt_product-product
            AND language EQ @sy-langu
          INTO TABLE @DATA(lt_product_text).
        IF sy-subrc EQ 0.
          SORT lt_product_text BY product.
        ENDIF.

        LOOP AT lt_calculated_data_r04 ASSIGNING FIELD-SYMBOL(<lfs_data_r04>).
          " Ưu tiên 1: Material PO Text - Tên dài mua hàng
          " Tham chiếu Số đơn hàng (PO) + Item PO
          " --> [APP] Display Purchase Order --> Item Detail
          " --> Tab Texts --> Lấy diễn giải Material PO Text
          READ TABLE lt_poitem_text INTO ls_poitem_text
            WITH KEY purchaseorder     = <lfs_data_r04>-referencesddocument
                     purchaseorderitem = <lfs_data_r04>-referencesddocumentitem
                     textobjecttype    = 'F03' BINARY SEARCH.
          IF sy-subrc EQ 0.
            <lfs_data_r04>-materialdescription = ls_poitem_text-plainlongtext.
          ELSE.
            READ TABLE lt_product_text INTO DATA(ls_product_text)
              WITH KEY product = <lfs_data_r04>-material BINARY SEARCH.
            IF sy-subrc EQ 0.
              <lfs_data_r04>-materialdescription = ls_product_text-productname.
            ENDIF.
          ENDIF.
        ENDLOOP.

        MOVE-CORRESPONDING lt_calculated_data_r04 TO ct_calculated_data.
      WHEN 'ZI_WM_ZMIGO_R08'.
        DATA : lt_calculated_data_r08 TYPE STANDARD TABLE OF zi_wm_zmigo_r08 WITH DEFAULT KEY.

        MOVE-CORRESPONDING it_original_data TO lt_calculated_data_r08.

        SELECT
          manufacturingorder,
          manufacturingorderlongtext
          FROM i_manufacturingorderlongtext
          FOR ALL ENTRIES IN @lt_calculated_data_r08
          WHERE manufacturingorder = @lt_calculated_data_r08-manufacturingorder
            AND longtextlanguage   = @sy-langu
          INTO TABLE @DATA(lt_longtext).
        IF sy-subrc EQ 0.
          SORT lt_longtext BY manufacturingorder.
        ENDIF.

        LOOP AT lt_calculated_data_r08 ASSIGNING FIELD-SYMBOL(<lfs_calculated_data_r08>).
          READ TABLE lt_longtext INTO DATA(ls_longtext)
            WITH KEY manufacturingorder = <lfs_calculated_data_r08>-manufacturingorder BINARY SEARCH.
          IF sy-subrc EQ 0.
            <lfs_calculated_data_r08>-longtext = ls_longtext-manufacturingorderlongtext.
          ENDIF.
        ENDLOOP.

        MOVE-CORRESPONDING lt_calculated_data_r08 TO ct_calculated_data.
      WHEN 'ZI_WM_ZMIGO_R09'.
        DATA : lt_calculated_data_r09 TYPE STANDARD TABLE OF zi_wm_zmigo_r09 WITH DEFAULT KEY.
*        DATA: lt_wbs_int TYPE zcore_cl_ewm_odata=>tt_wbs_element_int_id.

        MOVE-CORRESPONDING it_original_data TO lt_calculated_data_r09.

*        LOOP AT lt_calculated_data_r09 REFERENCE INTO DATA(lr_calculated_data_r09).
*          IF lr_calculated_data_r09->wbselementinternalid IS NOT INITIAL.
*            APPEND lr_calculated_data_r09->wbselementinternalid TO lt_wbs_int.
*          ENDIF.
*        ENDLOOP.
*
*        IF lt_wbs_int IS NOT INITIAL.
*          SORT lt_wbs_int.
*          DELETE ADJACENT DUPLICATES FROM lt_wbs_int COMPARING ALL FIELDS.
*
*          DATA(lt_wbs_ext) = zcore_cl_ewm_odata=>get_multi_wbs_with_key( lt_wbs_int ).
*          SORT lt_wbs_ext BY wbselement_internal_id.
*        ENDIF.

        SELECT
          physstock~ewmwarehouse,
          physstock~product,
          physstock~batch,
          physstock~stockdocumentcategoryconv,
          physstock~salesorder,
          physstock~salesorderitem,
          physstock~parenthandlingunituuid,
          physstock~stockitemuuid,
          availstock~ewmstoragebin,
          availstock~handlingunitnumber
          FROM zi_ewm_physstockprod AS physstock
          INNER JOIN i_ewm_availablestock AS availstock
          ON  physstock~stockitemuuid          = availstock~stockitemuuid
          AND physstock~parenthandlingunituuid = availstock~parenthandlingunituuid
          FOR ALL ENTRIES IN @lt_calculated_data_r09
          WHERE physstock~ewmwarehouse              = @lt_calculated_data_r09-warehousenumber
            AND physstock~product                   = @lt_calculated_data_r09-material
            AND physstock~batch                     = @lt_calculated_data_r09-batch
            AND physstock~stockdocumentcategoryconv = @lt_calculated_data_r09-inventoryspecialstocktype
            AND physstock~salesorder                = @lt_calculated_data_r09-salesorder
            AND physstock~salesorderitem            = @lt_calculated_data_r09-salesorderitem
          INTO TABLE @DATA(lt_stock).
        IF sy-subrc EQ 0.
          SORT lt_stock BY ewmwarehouse product batch stockdocumentcategoryconv salesorder salesorderitem ewmstoragebin handlingunitnumber.
        ENDIF.

        LOOP AT lt_calculated_data_r09 ASSIGNING FIELD-SYMBOL(<lfs_calculated_data_r09>).
*          READ TABLE lt_wbs_ext INTO DATA(ls_wbs_ext)
*            WITH KEY wbselement_internal_id = <lfs_calculated_data_r09>-wbselementinternalid BINARY SEARCH.
*          IF sy-subrc EQ 0.
*            <lfs_calculated_data_r09>-wbselementexternalid = ls_wbs_ext-wbselement_external_id.
*          ENDIF.

          READ TABLE lt_stock INTO DATA(ls_stock)
            WITH KEY ewmwarehouse              = <lfs_calculated_data_r09>-warehousenumber
                     product                   = <lfs_calculated_data_r09>-material
                     batch                     = <lfs_calculated_data_r09>-batch
                     stockdocumentcategoryconv = <lfs_calculated_data_r09>-inventoryspecialstocktype
                     salesorder                = <lfs_calculated_data_r09>-salesorder
                     salesorderitem            = <lfs_calculated_data_r09>-salesorderitem BINARY SEARCH.
          IF sy-subrc EQ 0.
            <lfs_calculated_data_r09>-storagebin             = ls_stock-ewmstoragebin.
            <lfs_calculated_data_r09>-handlingunitnumber     = |{ ls_stock-handlingunitnumber ALPHA = OUT }|.
            <lfs_calculated_data_r09>-parenthandlingunituuid = ls_stock-parenthandlingunituuid.
            <lfs_calculated_data_r09>-stockitemuuid          = ls_stock-stockitemuuid.
          ENDIF.
        ENDLOOP.

        MOVE-CORRESPONDING lt_calculated_data_r09 TO ct_calculated_data.
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    mv_entity = iv_entity.
  ENDMETHOD.
ENDCLASS.

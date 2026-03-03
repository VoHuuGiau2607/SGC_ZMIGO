CLASS zcl_wm_zmigo_exec DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WM_ZMIGO_EXEC IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    SELECT SINGLE
*      i_materialdocumentheader_2~materialdocument,
*      i_materialdocumentheader_2~materialdocumentyear
*      FROM i_materialdocumentheader_2
*      INNER JOIN zcore_i_matdoc_remove_rev
*      ON  i_materialdocumentheader_2~materialdocument     = zcore_i_matdoc_remove_rev~materialdocument
*      AND i_materialdocumentheader_2~materialdocumentyear = zcore_i_matdoc_remove_rev~materialdocumentyear
*      WHERE i_materialdocumentheader_2~deliverydocument = '0080000638'
*      INTO @DATA(ls_matdoc).
*    IF sy-subrc EQ 0.
*      READ ENTITIES OF i_materialdocumenttp
*        ENTITY materialdocument
*        ALL FIELDS
*        WITH VALUE #( ( materialdocument     = ls_matdoc-materialdocument
*                        materialdocumentyear = ls_matdoc-materialdocumentyear ) )
*        RESULT DATA(lt_matdoc_entity).
*
*      MODIFY ENTITIES OF i_materialdocumenttp
*        ENTITY materialdocument
*          UPDATE
*          FIELDS ( materialdocumentheadertext )
*          WITH VALUE #( FOR ls_matdoc_entity IN lt_matdoc_entity (
*                          %tky                        = ls_matdoc_entity-%tky
*                          materialdocumentheadertext  = '123333' ) )
*          REPORTED DATA(ls_reported_matdoc)
*          FAILED   DATA(ls_failed_matdoc).
*      IF ls_failed_matdoc IS INITIAL.
*        COMMIT ENTITIES.
*      ELSE.
*        ROLLBACK ENTITIES.
*        RETURN.
*      ENDIF.
*    ENDIF.
  ENDMETHOD.
ENDCLASS.

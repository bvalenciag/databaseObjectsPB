prompt
prompt PACKAGE: TBL_QEMPRESAS_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qempresas_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tempresas
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/10/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE TY_EMPR IS RECORD (
    empr_empr        tbl_tempresas.empr_empr%TYPE
  , empr_externo     tbl_tempresas.empr_externo%TYPE
  , empr_descripcion tbl_tempresas.empr_descripcion%TYPE
  , empr_fond        tbl_tempresas.empr_fond%TYPE
  , empr_esta        tbl_tempresas.empr_esta%TYPE
  , empr_fuente      tbl_tempresas.empr_fuente%TYPE
  , empr_sincroniza  tbl_tempresas.empr_sincroniza%TYPE
  , empr_fecins      tbl_tempresas.empr_fecins%TYPE
  , empr_usuains     tbl_tempresas.empr_usuains%TYPE
  , empr_fecupd      tbl_tempresas.empr_fecupd%TYPE
  , empr_usuaupd     tbl_tempresas.empr_usuaupd%TYPE
  , empr_nit         tbl_tempresas.empr_nit%TYPE   --27/02/2024
  , empr_digito      tbl_tempresas.empr_digito%TYPE--27/02/2024
  , empr_mandato     tbl_tempresas.empr_mandato%TYPE--29/04/2024
  );
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tempresas
 *
 * Author: Cramirezs
 * Created: 25/10/2023
 *
 * Param: p_ty_empr Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tempresas(p_ty_empr       tbl_qempresas_crud.ty_empr,
                                 p_empr_empr OUT tbl_tempresas.empr_empr%TYPE,
                                 p_ty_msg    OUT gen_qgeneral.ty_msg);
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tempresas
 *
 * Author: Cramirezs
 * Created: 25/10/2023
 *
 * Param: p_ty_empr Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tempresas(p_ty_empr     tbl_qempresas_crud.ty_empr,
                                   p_ty_msg  OUT gen_qgeneral.ty_msg);
-------------------------------------------------------------------------------------------------
/**
 * Description: Eliminar en la tabla tbl_tempresas
 *
 * Author: Cramirezs
 * Created: 2023/10/2023
 *
 * Param: p_ty_empr Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE eliminar_tbl_tempresas(p_ty_empr     tbl_qempresas_crud.ty_empr,
                                 p_ty_msg  OUT gen_qgeneral.ty_msg);
-------------------------------------------------------------------------------------------------
--
PROCEDURE update_check_grandfather(list_checks XMLTYPE);
-------------------------------------------------------------------------------------------------
--
END TBL_QEMPRESAS_CRUD;
/
prompt
prompt PACKAGE BODY: tbl_qempresas_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qempresas_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE INSERTAR_TBL_TEMPRESAS(P_TY_EMPR       TBL_QEMPRESAS_CRUD.TY_EMPR,
                                 P_EMPR_EMPR OUT TBL_TEMPRESAS.EMPR_EMPR % TYPE,
                                 P_TY_MSG    OUT GEN_QGENERAL.TY_MSG)
  IS
    --
    E_ERROR     EXCEPTION;
    v_empr_empr TBL_TEMPRESAS.EMPR_EMPR % TYPE;
  --
  BEGIN
    --
    P_TY_MSG.COD_MSG := 'OK';
    --
    v_empr_empr := GEN_QGENERAL.P_SECU('tbl_sempresas', P_TY_MSG.MSG_MSG);
    --
    IF P_TY_MSG.MSG_MSG IS NOT NULL
    THEN
      RAISE E_ERROR;
    END IF;
    --
    INSERT INTO TBL_TEMPRESAS (
        empr_empr
      , empr_externo
      , empr_descripcion
      , empr_fond
      , empr_esta
      , empr_fuente
      , empr_sincroniza
      , empr_fecins
      , empr_usuains
      , empr_nit
      , empr_digito
      , empr_mandato
    )VALUES (
         v_empr_empr
       , p_ty_empr.empr_externo
       , p_ty_empr.empr_descripcion
       , p_ty_empr.empr_fond
       , p_ty_empr.empr_esta
       , p_ty_empr.empr_fuente
       , p_ty_empr.empr_sincroniza
       , p_ty_empr.empr_fecins
       , p_ty_empr.empr_usuains
       , p_ty_empr.empr_nit
       , p_ty_empr.empr_digito
       , p_ty_empr.empr_mandato
       );
    --
    P_EMPR_EMPR := v_empr_empr;
    P_TY_MSG.MSG_MSG := 'Transaccion Exitosa';
  --
  EXCEPTION
    WHEN E_ERROR THEN P_TY_MSG.COD_MSG := 'ERR_SEC';
    WHEN OTHERS THEN P_TY_MSG.COD_MSG := 'ORA' || LTRIM(TO_CHAR(SQLCODE, '000000'));
        P_TY_MSG.MSG_MSG := 'tbl_qempresas_crud.insertar_tbl_tempresas. ' || TO_CHAR(SYSDATE, 'dd/mm/yyyy hh24miss') || '. Error: ' || SQLERRM;
  END INSERTAR_TBL_TEMPRESAS;
--------------------------------------------------------------------------------------------------
PROCEDURE ACTUALIZAR_TBL_TEMPRESAS(P_TY_EMPR     TBL_QEMPRESAS_CRUD.TY_EMPR,
                                   P_TY_MSG  OUT GEN_QGENERAL.TY_MSG)
  IS
  --
  BEGIN
    --
    P_TY_MSG.COD_MSG := 'OK';
    --
    UPDATE TBL_TEMPRESAS
      SET EMPR_EXTERNO     = NVL(p_ty_empr.empr_externo, empr_externo)
        , EMPR_DESCRIPCION = NVL(p_ty_empr.empr_descripcion, empr_descripcion)
        , EMPR_FOND        = NVL(p_ty_empr.empr_fond, empr_fond)
        , EMPR_ESTA        = NVL(p_ty_empr.empr_esta, empr_esta)
        , EMPR_FUENTE      = NVL(p_ty_empr.empr_fuente, empr_fuente)
        , EMPR_SINCRONIZA  = NVL(p_ty_empr.empr_sincroniza, empr_sincroniza)
        , empr_nit         = NVL(p_ty_empr.empr_nit, empr_nit)
        , empr_digito      = NVL(p_ty_empr.empr_digito, empr_digito)  
        , empr_mandato     = NVL(p_ty_empr.empr_mandato, empr_mandato)    
        , empr_fecupd      = NVL(p_ty_empr.empr_fecupd, sysdate)
        , empr_usuaupd     = NVL(p_ty_empr.empr_usuaupd, user)
      WHERE empr_empr      = p_ty_empr.empr_empr
    ;
    --
    P_TY_MSG.MSG_MSG := 'Transaccion Exitosa';
  --
  EXCEPTION
    WHEN OTHERS THEN P_TY_MSG.COD_MSG := 'ORA' || LTRIM(TO_CHAR(SQLCODE, '000000'));
        P_TY_MSG.MSG_MSG := 'tbl_qempresas_crud.actualizar_tbl_tempresas. ' || TO_CHAR(SYSDATE, 'dd/mm/yyyy hh24miss') || '. Error: ' || SQLERRM;
  END ACTUALIZAR_TBL_TEMPRESAS;
--------------------------------------------------------------------------------------------------
PROCEDURE ELIMINAR_TBL_TEMPRESAS(P_TY_EMPR     TBL_QEMPRESAS_CRUD.TY_EMPR,
                                 P_TY_MSG  OUT GEN_QGENERAL.TY_MSG)
  IS
  --
  BEGIN
    --
    P_TY_MSG.COD_MSG := 'OK';
    --
    DELETE FROM TBL_TEMPRESAS
      WHERE EMPR_EMPR = P_TY_EMPR.EMPR_EMPR
    ;
    --
    P_TY_MSG.MSG_MSG := 'Transaccion Exitosa';
  --
  EXCEPTION
    WHEN OTHERS THEN P_TY_MSG.COD_MSG := 'ORA' || LTRIM(TO_CHAR(SQLCODE, '000000'));
        P_TY_MSG.MSG_MSG := 'tbl_qempresas_crud.eliminar_tbl_tempresas ' || TO_CHAR(SYSDATE, 'dd/mm/yyyy hh24miss') || '. Error: ' || SQLERRM;
END ELIMINAR_TBL_TEMPRESAS;
--------------------------------------------------------------------------------------------------
PROCEDURE UPDATE_CHECK_GRANDFATHER(LIST_CHECKS XMLTYPE) IS
    l_grandFather_array APEX_APPLICATION_GLOBAL.VC_ARR2;
    DATA_CLOB           CLOB;
  BEGIN
    SELECT RTRIM(XMLAGG (LIST_CHECKS).GETCLOBVAL(), ',')
      INTO DATA_CLOB
      FROM DUAL;
    l_grandFather_array := APEX_UTIL.STRING_TO_TABLE(DATA_CLOB, ',');
    FOR N IN 1 .. l_grandFather_array.count
    LOOP
      UPDATE TBL_TEMPRESAS
        SET EMPR_SINCRONIZA = 'S'
        WHERE EMPR_EMPR = l_grandFather_array(N);
      COMMIT;
    END LOOP;
    --Actualizar a N lo que no este en el arreglo
    UPDATE TBL_TEMPRESAS
      SET EMPR_SINCRONIZA = 'N'
      WHERE EMPR_EMPR NOT IN (SELECT *
          FROM TABLE (GEN_QGENERAL.FN_GET_STRING_TO_TABLE(DATA_CLOB, ',')));
    COMMIT;
END;
--------------------------------------------------------------------------------------------------
END TBL_QEMPRESAS_CRUD;
/

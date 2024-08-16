prompt
prompt PACKAGE: TBL_QTRASEBRA_CRUD
prompt
create or replace PACKAGE tbl_qtrasebra_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_ttrasebra
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       22/01/2024 Jmartinez    000002       * Ajuste de columnas.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_tras IS RECORD(
     tras_tras      tbl_ttrasebra.tras_tras     %TYPE
   , tras_empr      tbl_ttrasebra.tras_empr     %TYPE
   , tras_banc      tbl_ttrasebra.tras_banc     %TYPE
   , tras_cuen      tbl_ttrasebra.tras_cuen     %TYPE
   , tras_cuen_cud  tbl_ttrasebra.tras_cuen_cud %TYPE
   , tras_tipo_oper tbl_ttrasebra.tras_tipo_oper%TYPE
   , tras_esta      tbl_ttrasebra.tras_esta     %TYPE
   , tras_valor     tbl_ttrasebra.tras_valor    %TYPE
   , tras_impreso   tbl_ttrasebra.tras_impreso  %TYPE
   , tras_fecha     tbl_ttrasebra.tras_fecha    %TYPE --1001       22/01/2024 Jmartinez
   , tras_fecins    tbl_ttrasebra.tras_fecins   %TYPE
   , tras_usuains   tbl_ttrasebra.tras_usuains  %TYPE
   , tras_fecupd    tbl_ttrasebra.tras_fecupd   %TYPE
   , tras_usuaupd   tbl_ttrasebra.tras_usuaupd  %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_ttrasebra
 *
 * Author: Cramirezs
 * Created: 10/01/2024
 *
 * Param: p_ty_tras Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_ttrasebra(
                                  p_ty_tras        tbl_qtrasebra_crud.ty_tras
                                , p_tras_tras  OUT  tbl_ttrasebra.tras_tras%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_ttrasebra
 *
 * Author: Cramirezs
 * Created: 10/01/2024
 *
 * Param: p_ty_tras Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_ttrasebra(
                                  p_ty_tras         tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Eliminar en la tabla tbl_ttrasebra
 *
 * Author: Cramirezs
 * Created: 2024/01/2024
 *
 * Param: p_ty_tras Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE eliminar_tbl_ttrasebra(
                                  p_ty_tras         tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qtrasebra_crud;
/
prompt
prompt PACKAGE BODY: tbl_qtrasebra_crud
prompt
--
create or replace PACKAGE BODY tbl_qtrasebra_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_ttrasebra(
                                  p_ty_tras        tbl_qtrasebra_crud.ty_tras
                                , p_tras_tras  OUT  tbl_ttrasebra.tras_tras%TYPE  
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_tras_tras  tbl_ttrasebra.tras_tras%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_tras_tras := gen_qgeneral.p_secu('tbl_strasebra', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_ttrasebra
        (
              tras_tras
            , tras_empr
            , tras_banc
            , tras_cuen
            , tras_cuen_cud
            , tras_tipo_oper
            , tras_esta
            , tras_valor
            , tras_impreso
            , tras_fecha --1001       22/01/2024 Jmartinez
            , tras_fecins
            , tras_usuains
        )VALUES
        (
              v_tras_tras
            , p_ty_tras.tras_empr
            , p_ty_tras.tras_banc
            , p_ty_tras.tras_cuen
            , p_ty_tras.tras_cuen_cud
            , p_ty_tras.tras_tipo_oper
            , p_ty_tras.tras_esta
            , p_ty_tras.tras_valor
            , p_ty_tras.tras_impreso
            , p_ty_tras.tras_fecha --1001       22/01/2024 Jmartinez
            , p_ty_tras.tras_fecins
            , p_ty_tras.tras_usuains
        );
    --
    p_tras_tras         := v_tras_tras;
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qtrasebra_crud.insertar_tbl_ttrasebra. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_ttrasebra;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_ttrasebra(
                                  p_ty_tras         tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_ttrasebra SET
          tras_empr      = NVL(p_ty_tras.tras_empr     , tras_empr     )
        , tras_banc      = NVL(p_ty_tras.tras_banc     , tras_banc     )
        , tras_cuen      = NVL(p_ty_tras.tras_cuen     , tras_cuen     )
        , tras_cuen_cud  = NVL(p_ty_tras.tras_cuen_cud , tras_cuen_cud )
        , tras_tipo_oper = NVL(p_ty_tras.tras_tipo_oper, tras_tipo_oper)
        , tras_esta      = NVL(p_ty_tras.tras_esta     , tras_esta     )
        , tras_valor     = NVL(p_ty_tras.tras_valor    , tras_valor    )
        , tras_impreso   = NVL(p_ty_tras.tras_impreso  , tras_impreso  )
        , tras_fecupd    = NVL(p_ty_tras.tras_fecupd, SYSDATE)
        , tras_usuaupd   = NVL(p_ty_tras.tras_usuaupd, USER)
    WHERE tras_tras = p_ty_tras.tras_tras
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qtrasebra_crud.actualizar_tbl_ttrasebra. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_ttrasebra;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_ttrasebra(
                                  p_ty_tras         tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_ttrasebra
        WHERE tras_tras = p_ty_tras.tras_tras
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qtrasebra_crud.eliminar_tbl_ttrasebra '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_ttrasebra;
--------------------------------------------------------------------------------------------------
END tbl_qtrasebra_crud;
/
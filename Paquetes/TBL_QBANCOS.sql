prompt
prompt PACKAGE: TBL_QBANCOS
prompt
CREATE OR REPLACE PACKAGE tbl_qbancos IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de bancos
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       19/03/2024 Jmartinezm    000001       * Se crea paquete.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Types
-------------------------------------------------------------------------------------------------
--
--
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
--
PROCEDURE actualizar_tbl_tbancos_tasa_agrp(
                                  p_ty_banc         tbl_qbancos_crud.ty_banc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
END tbl_qbancos;
/
prompt
prompt PACKAGE BODY: tbl_qbancos
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qbancos IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tbancos_tasa_agrp(
                                  p_ty_banc      tbl_qbancos_crud.ty_banc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    e_error     EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
BEGIN
    --
    IF p_ty_banc.banc_tasa_agru < 0 THEN
        p_ty_msg.cod_msg := 'ER_VLOR_NP'; --Valor no permitido. Por favor verifique.
        raise e_error;
        RETURN;
    END IF;
    --
    tbl_qbancos_crud.actualizar_tbl_tbancos(p_ty_banc, p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error_e;
    --
    ELSE
    --
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
    END IF;
    --
    UPDATE tbl_tcuentasban SET
        cuen_tasa_ea        = NVL(p_ty_banc.banc_tasa_agru  , cuen_tasa_ea  )
    WHERE cuen_banc = p_ty_banc.banc_banc
    AND   cuen_tasa_ea > 0
    ;
    --
EXCEPTION
    WHEN e_error_e THEN
       return;
    WHEN e_error THEN
       v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg,v_tipo);
       p_ty_msg.msg_msg := v_desc_msg;
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qbancos_crud.actualizar_tbl_tbancos. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tbancos_tasa_agrp;
---------------------------------------------------------------------------------------------------
--
END tbl_qbancos;
/
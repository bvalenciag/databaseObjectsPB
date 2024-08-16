prompt
prompt PACKAGE: TBL_QTRASEBRA
prompt
CREATE OR REPLACE PACKAGE tbl_qtrasebra IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de la tabla tbl_ttrasebra
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/01/2024 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       12/04/2024 Jmartinezm    00002       * Ajuste paquete.
--                       Kilonova      MVP2
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
PROCEDURE insertar_tbl_ttrasebra_valida(
                                  p_ty_tras        tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_ttrasebra_valida(
                                  p_ty_tras         tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );                                
--
-------------------------------------------------------------------------------------------------
--
END tbl_qtrasebra;
/
prompt
prompt PACKAGE BODY: tbl_qtrasebra
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qtrasebra IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_ttrasebra_valida(
                                  p_ty_tras        tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    v_tras_tras tbl_ttrasebra.tras_tras%TYPE;

    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';    
    --
   -- IF p_ty_tras.tras_valor < 0 OR p_ty_tras.tras_cuen is null OR p_ty_tras.tras_cuen_cud is null THEN Antes 1001       12/04/2024 Jmartinezm
    IF p_ty_tras.tras_valor < 0 OR p_ty_tras.tras_cuen is null  THEN -- 1001       12/04/2024 Jmartinezm
        p_ty_msg.cod_msg := 'ER_VLOR_NP'; --Valor no permitido. Por favor verifique.
        raise e_error;
    END IF;
    --
    tbl_qtrasebra_crud.insertar_tbl_ttrasebra(p_ty_tras,v_tras_tras,p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        raise e_error_e;
    ELSE
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    END IF;
    --
EXCEPTION
     WHEN e_error_e THEN
         return;
     WHEN e_error THEN
         v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg,v_tipo);
         p_ty_msg.msg_msg := v_desc_msg;
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qtrasebra.insertar_tbl_ttrasebra_valida. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_ttrasebra_valida;
---------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_ttrasebra_valida(
                                  p_ty_tras         tbl_qtrasebra_crud.ty_tras
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --    
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    IF p_ty_tras.tras_valor <0  THEN
        p_ty_msg.cod_msg := 'ER_VLOR_NP'; --Valor no permitido. Por favor verifique.
        raise e_error;         
    END IF;
    --
    tbl_qtrasebra_crud.actualizar_tbl_ttrasebra(p_ty_tras,p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        raise e_error_e;
    ELSE
        p_ty_msg.msg_msg := 'Proceso Exitoso';    
    END IF;
    --
EXCEPTION
     WHEN e_error_e THEN
         return;
     WHEN e_error THEN
         v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg,v_tipo);
         p_ty_msg.msg_msg := v_desc_msg;
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qtrasebra.actualizar_tbl_ttrasebra_valida. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_ttrasebra_valida;

---------------------------------------------------------------------------------------------------
--
END tbl_qtrasebra;
/
prompt
prompt PACKAGE: TBL_QCUENTASBAN
prompt
CREATE OR REPLACE PACKAGE tbl_qcuentasban IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de actualizar cuentasban para las homologaciones de traslados de cuentas bancarias
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       30/11/2023 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       26/01/2024 Jmartinezm    00002       * Ajuste de funciones.
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
PROCEDURE actualizar_tbl_tcuentasban_traslados( 
                                            p_ty_cuen       tbl_qcuentasban_crud.ty_cuen
                                            , p_ty_msg     OUT gen_qgeneral.ty_msg
                                            );
--
-------------------------------------------------------------------------------------------------
--
PROCEDURE actualizar_tbl_tcuentasban_tasaea(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
-- ini  1001       26/01/2024 Jmartinezm 
PROCEDURE actualizar_tbl_tcuentasban_sldmin(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--fin 1001       26/01/2024 Jmartinezm 
-------------------------------------------------------------------------------------------------
--  
END tbl_qcuentasban;
/
prompt
prompt PACKAGE BODY: tbl_qcuentasban
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qcuentasban IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tcuentasban_traslados( 
                                            p_ty_cuen       tbl_qcuentasban_crud.ty_cuen
                                            , p_ty_msg     OUT gen_qgeneral.ty_msg
                                            )IS
    --
    e_error EXCEPTION;
    e_error_e EXCEPTION;
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_cuent IS
        SELECT 'S'
          FROM tbl_tcuentasban
         WHERE cuen_empr = p_ty_cuen.cuen_empr
         and   cuen_banc = p_ty_cuen.cuen_banc
         and   cuen_tipo_oper = p_ty_cuen.cuen_tipo_oper
        ;
    --
    r_cuent    c_cuent%ROWTYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    OPEN  c_cuent ;
     FETCH c_cuent INTO r_cuent;
     IF c_cuent%FOUND THEN
        CLOSE c_cuent;
        p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
        raise e_error;
     END IF;
    CLOSE c_cuent;
    --
    --
    tbl_qcuentasban_crud.actualizar_tbl_tcuentasban(p_ty_cuen,p_ty_msg);
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
EXCEPTION
     WHEN e_error_e THEN
        return;
     WHEN e_error THEN
        v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg,v_tipo);
        p_ty_msg.msg_msg := v_desc_msg;
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcuentasban.actualizar_tbl_tcuentasban_traslados. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcuentasban_traslados;
---------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tcuentasban_tasaea(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    e_error     EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_cuent IS
     SELECT 'S'
       FROM TBL_TCUENTASBAN
      WHERE  CUEN_TASA_EA IS NOT NULL
      and cuen_empr = p_ty_cuen.cuen_empr
      and cuen_banc = p_ty_cuen.cuen_banc
    ;
    --
    r_cuent    c_cuent%ROWTYPE;
    --
BEGIN
    --
    -- Validación: No permitir un valor negativo en la tasa
    IF p_ty_cuen.cuen_tasa_ea < 0 OR p_ty_cuen.cuen_sldmincor < 0  THEN
        p_ty_msg.cod_msg := 'ER_VLOR_NP'; --Valor no permitido. Por favor verifique.
        raise e_error;
        RETURN;
    END IF;
    --
    OPEN  c_cuent ;
     FETCH c_cuent INTO r_cuent;
     IF c_cuent%FOUND THEN
     CLOSE c_cuent;
     p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
     raise e_error;
     END IF;
    CLOSE c_cuent;
    --
    --
    tbl_qcuentasban_crud.actualizar_tbl_tcuentasban(p_ty_cuen,p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error_e;
    --
    ELSE
    --
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
    END IF;
EXCEPTION
     WHEN e_error_e THEN
        return;
     WHEN e_error THEN
        v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg,v_tipo);
        p_ty_msg.msg_msg := v_desc_msg;
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcuentasban.actualizar_tbl_tcuentasban_tasaea. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcuentasban_tasaea;
--------------------------------------------------------------------------------------------------
-- ini 1001       26/01/2024 Jmartinezm 
PROCEDURE actualizar_tbl_tcuentasban_sldmin(
                                  p_ty_cuen         tbl_qcuentasban_crud.ty_cuen
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    e_error     EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_cuent IS
     SELECT 'S'
       FROM TBL_TCUENTASBAN
      WHERE  CUEN_SLDMINCOR IS NOT NULL
      and cuen_empr = p_ty_cuen.cuen_empr
      and cuen_banc = p_ty_cuen.cuen_banc
    ;
    --
    r_cuent    c_cuent%ROWTYPE;
    --
BEGIN
    --
    -- Validación: No permitir un valor negativo en la tasa
    IF  p_ty_cuen.cuen_sldmincor < 0  THEN
        p_ty_msg.cod_msg := 'ER_VLOR_NP'; --Valor no permitido. Por favor verifique.
        raise e_error;
        RETURN;
    END IF;
    --
    OPEN  c_cuent ;
     FETCH c_cuent INTO r_cuent;
     IF c_cuent%FOUND THEN
     CLOSE c_cuent;
     p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
     raise e_error;
     END IF;
    CLOSE c_cuent;
    --
    --
    tbl_qcuentasban_crud.actualizar_tbl_tcuentasban(p_ty_cuen,p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error_e;
    --
    ELSE
    --
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
    END IF;
EXCEPTION
     WHEN e_error_e THEN
        return;
     WHEN e_error THEN
        v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg,v_tipo);
        p_ty_msg.msg_msg := v_desc_msg;
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcuentasban.actualizar_tbl_tcuentasban_tasaea. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcuentasban_sldmin;
--fin 1001       26/01/2024 Jmartinezm 
--------------------------------------------------------------------------------------------------
--
END tbl_qcuentasban;
/
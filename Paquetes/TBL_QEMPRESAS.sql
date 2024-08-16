prompt
prompt PACKAGE: TBL_QEMPRESAS
prompt
CREATE OR REPLACE PACKAGE tbl_qempresas IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de la tabla tbl_tempresas
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       30/04/2024 Jmartinezm    000001       * Se crea paquete.
--                       Kilonova
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
PROCEDURE actualizar_tbl_tempresas_mandato(
                                  p_ty_empr     tbl_qempresas_crud.ty_empr
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
END tbl_qempresas;
/
prompt
prompt PACKAGE BODY: tbl_qempresas
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qempresas IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tempresas_mandato(
                                  p_ty_empr     tbl_qempresas_crud.ty_empr
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                )IS
    e_error     EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_empr IS
        SELECT 'S'
          FROM tbl_tempresas
         WHERE empr_empr = p_ty_empr.empr_empr
         AND empr_mandato is not null
        ;
    --
    r_empr    c_empr%ROWTYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    OPEN  c_empr ;
     FETCH c_empr INTO r_empr;
     IF c_empr%FOUND THEN
        CLOSE c_empr;
        p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
        raise e_error;
     END IF;
    CLOSE c_empr;
    --
    tbl_qempresas_crud.ACTUALIZAR_TBL_TEMPRESAS(p_ty_empr, p_ty_msg);
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
        p_ty_msg.msg_msg := 'tbl_qempresas.actualizar_tbl_tempresas_mandato. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tempresas_mandato;
---------------------------------------------------------------------------------------------------
--
END tbl_qempresas;
/
prompt
prompt PACKAGE: TBL_QENTIDADES
prompt
CREATE OR REPLACE PACKAGE tbl_qentidades IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de tbl_tentidades
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/01/2024 Jmartinezm    000001       * Se crea paquete.
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
PROCEDURE insertar_tbl_tentidades_variables(
                                  p_ty_enti        tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
END tbl_qentidades;
/
prompt
prompt PACKAGE BODY: tbl_qentidades
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qentidades IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tentidades_variables(
                                  p_ty_enti        tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    e_error_e    EXCEPTION;
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_enti IS
        SELECT 'S'
          FROM tbl_tentidades
         WHERE enti_vari = p_ty_enti.enti_vari
        ;
    --
    r_enti    c_enti%ROWTYPE;
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    OPEN  c_enti;
    FETCH c_enti INTO r_enti;
    IF c_enti%FOUND THEN
        CLOSE c_enti;
        p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
        raise e_error;
    END IF;
    CLOSE c_enti;
    --
    tbl_qentidades_crud.insertar_tbl_tentidades(p_ty_enti,p_ty_msg);
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
        p_ty_msg.msg_msg := 'tbl_qentidades.insertar_tbl_tentidades_variables. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tentidades_variables;
---------------------------------------------------------------------------------------------------
--
END tbl_qentidades;
/
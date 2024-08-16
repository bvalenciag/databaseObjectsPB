prompt
prompt PACKAGE: TBL_QINFBANCOS
prompt
CREATE OR REPLACE PACKAGE tbl_qinfbancos IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de la tabla tbl_tinfbancos
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
PROCEDURE insertar_tbl_tinfbancos_banc(
                                  p_ty_infb        tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
--
-------------------------------------------------------------------------------------------------
--
END tbl_qinfbancos;
/
prompt
prompt PACKAGE BODY: tbl_qinfbancos
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qinfbancos IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tinfbancos_banc(
                                  p_ty_infb        tbl_qinfbancos_crud.ty_infb
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    e_error_e    EXCEPTION;
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_infb IS
        SELECT 'S'
          FROM tbl_tinfbancos
         WHERE infb_banc = p_ty_infb.infb_banc
        ;
    --
    r_infb    c_infb%ROWTYPE;
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    OPEN  c_infb ;
    FETCH c_infb INTO r_infb;
    IF c_infb%FOUND THEN
        CLOSE c_infb;
        p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
        raise e_error;
    END IF;
    CLOSE c_infb;
    --
    tbl_qinfbancos_crud.insertar_tbl_tinfbancos(p_ty_infb,p_ty_msg);
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
         p_ty_msg.msg_msg := 'tbl_qinfbancos.insertar_tbl_tinfbancos_banc. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tinfbancos_banc;
---------------------------------------------------------------------------------------------------
--
END tbl_qinfbancos;
/
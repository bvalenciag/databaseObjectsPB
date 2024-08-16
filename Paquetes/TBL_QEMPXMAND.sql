prompt
prompt PACKAGE: TBL_QEMPXMAND
prompt
CREATE OR REPLACE PACKAGE tbl_qempxmand IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de la tabla tbl_tempxmand
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/06/2024 Jmartinezm    000001       * Se crea paquete.
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
PROCEDURE insertar_tbl_tempxmand(
                                  p_ty_empx     tbl_qempxmand_crud.ty_empx
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                );
--
PROCEDURE actualizar_tbl_tempxmand(
                                  p_ty_empx     tbl_qempxmand_crud.ty_empx,
                                  p_ty_msg      OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qempxmand;
/
prompt
prompt PACKAGE BODY: tbl_qempxmand
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qempxmand IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tempxmand(
                                  p_ty_empx     tbl_qempxmand_crud.ty_empx,
                                  p_ty_msg      OUT gen_qgeneral.ty_msg
                                )IS
    e_error     EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_empx IS
        SELECT 'S'
          FROM tbl_tempxmand
         WHERE empx_empr = p_ty_empx.empx_empr
           AND empx_encargo = p_ty_empx.empx_encargo;
    --
    r_empx    c_empx%ROWTYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    OPEN  c_empx ;
    FETCH c_empx INTO r_empx;
    IF c_empx%FOUND THEN
        CLOSE c_empx;
        p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
        RAISE e_error;
    END IF;
    CLOSE c_empx;
    --
    tbl_qempxmand_crud.insertar_tbl_tempxmand(p_ty_empx, p_ty_msg);
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error_e;
    ELSE
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    END IF;
    --
EXCEPTION
    WHEN e_error_e THEN
       RETURN;
    WHEN e_error THEN
       v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg, v_tipo);
       p_ty_msg.msg_msg := v_desc_msg;
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||LTRIM(TO_CHAR(SQLCODE, '000000'));
        p_ty_msg.msg_msg := 'tbl_qempxmand.insertar_tbl_tempxmand. '|| TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24MISS')||'. Error: '||SQLERRM;
END insertar_tbl_tempxmand;
--
---------------------------------------------------------------------------------------------------
--
PROCEDURE actualizar_tbl_tempxmand(
                                  p_ty_empx     tbl_qempxmand_crud.ty_empx,
                                  p_ty_msg      OUT gen_qgeneral.ty_msg
                                )IS
    e_error     EXCEPTION;
    e_error_e   EXCEPTION;
    --
    v_tipo      gen_tmensajes.mens_tipo%TYPE;
    v_desc_msg  gen_tmensajes.mens_descripcion%TYPE;
    --
    CURSOR c_empx IS
        SELECT 'S'
          FROM tbl_tempxmand
         WHERE empx_empr = p_ty_empx.empx_empr
           AND empx_encargo = p_ty_empx.empx_encargo
           AND empx_empx <> p_ty_empx.empx_empx;
    --
    r_empx    c_empx%ROWTYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    OPEN  c_empx ;
    FETCH c_empx INTO r_empx;
    IF c_empx%FOUND THEN
        CLOSE c_empx;
        p_ty_msg.cod_msg := 'ER_RGID_EX'; --Ya existe un registro con esta identificación. Por favor verifique.
        RAISE e_error;
    END IF;
    CLOSE c_empx;
    --
    tbl_qempxmand_crud.actualizar_tbl_tempxmand(p_ty_empx, p_ty_msg);  
    --
    IF p_ty_msg.cod_msg <> 'OK' THEN
        RAISE e_error_e;
    ELSE
        p_ty_msg.msg_msg := 'Proceso Exitoso';
    END IF;
    --
EXCEPTION
    WHEN e_error_e THEN
       RETURN;
    WHEN e_error THEN
       v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg, v_tipo);
       p_ty_msg.msg_msg := v_desc_msg;
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||LTRIM(TO_CHAR(SQLCODE, '000000'));
        p_ty_msg.msg_msg := 'tbl_qempxmand.actualizar_tbl_tempxmand. '|| TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24MISS')||'. Error: '||SQLERRM;
END actualizar_tbl_tempxmand;
---------------------------------------------------------------------------------------------------
--
END tbl_qempxmand;
/
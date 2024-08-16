prompt
prompt PACKAGE: TBL_QEMPXMAND_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qempxmand_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla TBL_TEMPXMAND
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
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_empx IS RECORD(
     empx_empx     tbl_tempxmand.empx_empx    %TYPE
   , empx_empr     tbl_tempxmand.empx_empr    %TYPE
   , empx_encargo  tbl_tempxmand.empx_encargo %TYPE
   , empx_mandato  tbl_tempxmand.empx_mandato %TYPE
   , empx_fecins   tbl_tempxmand.empx_fecins  %TYPE
   , empx_usuains  tbl_tempxmand.empx_usuains %TYPE
   , empx_fecupd   tbl_tempxmand.empx_fecupd  %TYPE
   , empx_usuaupd  tbl_tempxmand.empx_usuaupd %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tempxmand
 *
 * Author: Jmartinezm
 * Created: 25/06/2024
 *
 * Param: p_ty_empx Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tempxmand(
                                  p_ty_empx        tbl_qempxmand_crud.ty_empx
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tempxmand
 *
 * Author: Jmartinezm
 * Created: 25/06/2024
 *
 * Param: p_ty_empx Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tempxmand(
                                  p_ty_empx         tbl_qempxmand_crud.ty_empx
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tempxmand
 *
 * Author: Jmartinezm
 * Created: 2024/06/2024
 *
 * Param: p_ty_empx Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tempxmand(
                                  p_ty_empx         tbl_qempxmand_crud.ty_empx
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qempxmand_crud;
/
prompt
prompt PACKAGE BODY: tbl_qempxmand_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qempxmand_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tempxmand(
                                  p_ty_empx        tbl_qempxmand_crud.ty_empx
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_empx_empx  tbl_tempxmand.empx_empx%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_empx_empx := gen_qgeneral.p_secu('tbl_sempxmand', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tempxmand
        (
              empx_empx
            , empx_empr
            , empx_encargo
            , empx_mandato
            , empx_fecins
            , empx_usuains
        )VALUES
        (
              v_empx_empx
            , p_ty_empx.empx_empr
            , p_ty_empx.empx_encargo
            , p_ty_empx.empx_mandato
            , p_ty_empx.empx_fecins
            , p_ty_empx.empx_usuains
        );
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qempxmand_crud.insertar_tbl_tempxmand. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tempxmand;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tempxmand(
                                  p_ty_empx         tbl_qempxmand_crud.ty_empx
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tempxmand SET
          empx_empr     = NVL(p_ty_empx.empx_empr, empx_empr)            
        , empx_encargo = NVL(p_ty_empx.empx_encargo, empx_encargo)
        , empx_mandato = NVL(p_ty_empx.empx_mandato, empx_mandato)
        , empx_fecupd  = NVL(p_ty_empx.empx_fecupd, SYSDATE)
        , empx_usuaupd = NVL(p_ty_empx.empx_usuaupd, USER)
    WHERE empx_empx = p_ty_empx.empx_empx
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qempxmand_crud.actualizar_tbl_tempxmand. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tempxmand;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tempxmand(
                                  p_ty_empx         tbl_qempxmand_crud.ty_empx
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tempxmand 
        WHERE empx_empx = p_ty_empx.empx_empx
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qempxmand_crud.eliminar_tbl_tempxmand '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tempxmand;
--------------------------------------------------------------------------------------------------
END tbl_qempxmand_crud;
/
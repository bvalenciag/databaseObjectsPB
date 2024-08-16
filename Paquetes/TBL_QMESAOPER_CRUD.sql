prompt
prompt PACKAGE: TBL_QMESAOPER_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qmesaoper_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tmesaoper
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       27/12/2023 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       22/02/2024 Jmartinezm    00002       * Se agrega columna.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       24/04/2024 Jmartinezm    00003       * Se agrega columna.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_mesa IS RECORD(
     mesa_mesa           tbl_tmesaoper.mesa_mesa        %TYPE
   , mesa_fecha          tbl_tmesaoper.mesa_fecha       %TYPE
   , mesa_empr           tbl_tmesaoper.mesa_empr        %TYPE
   , mesa_banc           tbl_tmesaoper.mesa_banc        %TYPE
   , mesa_oper           tbl_tmesaoper.mesa_oper        %TYPE
   , mesa_descripcion    tbl_tmesaoper.mesa_descripcion %TYPE
   , mesa_ticket         tbl_tmesaoper.mesa_ticket      %TYPE
   , mesa_valor          tbl_tmesaoper.mesa_valor       %TYPE
   , mesa_esta           tbl_tmesaoper.mesa_esta        %TYPE -- 1001       22/02/2024 Jmartinezm
   , mesa_mandato        tbl_tmesaoper.mesa_mandato     %TYPE -- 1002       24/04/2024 Jmartinezm 
   , mesa_fecins         tbl_tmesaoper.mesa_fecins      %TYPE
   , mesa_usuains        tbl_tmesaoper.mesa_usuains     %TYPE
   , mesa_fecupd         tbl_tmesaoper.mesa_fecupd      %TYPE
   , mesa_usuaupd        tbl_tmesaoper.mesa_usuaupd     %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tmesaoper
 *
 * Author: Jmartinezm
 * Created: 27/12/2023
 *
 * Param: p_ty_mesa Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tmesaoper(
                                  p_ty_mesa        tbl_qmesaoper_crud.ty_mesa
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tmesaoper
 *
 * Author: Jmartinezm
 * Created: 27/12/2023
 *
 * Param: p_ty_mesa Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tmesaoper(
                                  p_ty_mesa         tbl_qmesaoper_crud.ty_mesa
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tmesaoper
 *
 * Author: Jmartinezm
 * Created: 2023/12/2023
 *
 * Param: p_ty_mesa Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tmesaoper(
                                  p_ty_mesa         tbl_qmesaoper_crud.ty_mesa
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qmesaoper_crud;
/
prompt
prompt PACKAGE BODY: tbl_qmesaoper_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qmesaoper_crud IS
--
-- #VERSION: 1001
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tmesaoper(
                                  p_ty_mesa        tbl_qmesaoper_crud.ty_mesa
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_mesa_mesa  tbl_tmesaoper.mesa_mesa%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_mesa_mesa := gen_qgeneral.p_secu('tbl_smesaoper', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tmesaoper
        (
              mesa_mesa
            , mesa_fecha
            , mesa_empr
            , mesa_banc
            , mesa_oper
            , mesa_descripcion
            , mesa_ticket
            , mesa_valor
            , mesa_esta     -- 1001       22/02/2024 Jmartinezm 
            , mesa_mandato  -- 1002       24/04/2024 Jmartinezm 
            , mesa_fecins
            , mesa_usuains
        )VALUES
        (
              v_mesa_mesa
            , p_ty_mesa.mesa_fecha
            , p_ty_mesa.mesa_empr
            , p_ty_mesa.mesa_banc
            , p_ty_mesa.mesa_oper
            , p_ty_mesa.mesa_descripcion
            , p_ty_mesa.mesa_ticket
            , p_ty_mesa.mesa_valor  
            , p_ty_mesa.mesa_esta    -- 1001       22/02/2024 Jmartinezm  
            , p_ty_mesa.mesa_mandato -- 1002       24/04/2024 Jmartinezm 
            , p_ty_mesa.mesa_fecins
            , p_ty_mesa.mesa_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qmesaoper_crud.insertar_tbl_tmesaoper. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tmesaoper;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tmesaoper(
                                  p_ty_mesa         tbl_qmesaoper_crud.ty_mesa
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tmesaoper SET
          mesa_fecha        = NVL(p_ty_mesa.mesa_fecha, mesa_fecha)        
        , mesa_empr         = NVL(p_ty_mesa.mesa_empr, mesa_empr)            
        , mesa_banc         = NVL(p_ty_mesa.mesa_banc, mesa_banc)    
        , mesa_oper         = NVL(p_ty_mesa.mesa_oper, mesa_oper)    
        , mesa_descripcion  = NVL(p_ty_mesa.mesa_descripcion, mesa_descripcion)
        , mesa_ticket       = NVL(p_ty_mesa.mesa_ticket, mesa_ticket)
        , mesa_valor        = NVL(p_ty_mesa.mesa_valor, mesa_valor)
        , mesa_esta         = NVL(p_ty_mesa.mesa_esta, mesa_esta)      -- 1001       22/02/2024 Jmartinezm  
        , mesa_mandato      = p_ty_mesa.mesa_mandato                   -- 1002       24/04/2024 Jmartinezm 
        , mesa_fecupd       = NVL(p_ty_mesa.mesa_fecupd, SYSDATE)
        , mesa_usuaupd      = NVL(p_ty_mesa.mesa_usuaupd, USER)
    WHERE mesa_mesa = p_ty_mesa.mesa_mesa
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmesaoper_crud.actualizar_tbl_tmesaoper. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tmesaoper;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tmesaoper(
                                  p_ty_mesa         tbl_qmesaoper_crud.ty_mesa
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tmesaoper 
        WHERE mesa_mesa = p_ty_mesa.mesa_mesa
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmesaoper_crud.eliminar_tbl_tmesaoper '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tmesaoper;
--------------------------------------------------------------------------------------------------
END tbl_qmesaoper_crud;
/
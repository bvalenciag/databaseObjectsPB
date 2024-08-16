prompt
prompt PACKAGE: TBL_QMESAOPER
prompt
CREATE OR REPLACE PACKAGE tbl_qmesaoper IS
--
-- Reúne funciones y procedimientos directamente relacionados con el procedimiento de la tabla de tbl_tmesaoper
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       27/12/2023 Jmartinezm    00001       * Se crea paquete.
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
/**
 * Description: Valida la data de la tabla tbl_tmesaoper para posterior Insertar en la tabla tbl_tmesaoper
 *
 * Author: Jmartinezm
 * Created: 27/12/2023
 *
 * Param: p_ty_mesa Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE valida_data(p_ty_mesa        tbl_qmesaoper_crud.ty_mesa
                      , p_ty_msg     OUT gen_qgeneral.ty_msg
                      );
--
-------------------------------------------------------------------------------------------------
--
END tbl_qmesaoper;
/
prompt
prompt PACKAGE BODY: tbl_qmesaoper
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qmesaoper IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE valida_data(p_ty_mesa        tbl_qmesaoper_crud.ty_mesa
                     , p_ty_msg     OUT gen_qgeneral.ty_msg
                     )IS
    --
    CURSOR c_mesa IS
        SELECT mesa_mesa
          FROM tbl_tmesaoper
         WHERE mesa_ticket = p_ty_mesa.mesa_ticket
        ;
    --
    v_mesa                  tbl_tmesaoper.mesa_mesa%TYPE;
    v_desc_msg              gen_tmensajes.mens_descripcion%TYPE;
    v_tipo                  gen_tmensajes.mens_tipo%TYPE;
    e_error                 EXCEPTION;
    e_error_e               EXCEPTION;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    IF  NVL(p_ty_mesa.mesa_valor, 0) <= 0 THEN
        --
        p_ty_msg.cod_msg := 'ER_VLOR_NP';--Valor no permitido. Por favor verifique.
        RAISE e_error;  
        --
    END IF;
    --    
    OPEN  c_mesa;
    FETCH c_mesa INTO v_mesa;
    CLOSE c_mesa;
    --
    IF v_mesa IS NOT NULL AND p_ty_mesa.mesa_mesa IS NULL THEN
        --
        p_ty_msg.cod_msg := 'ER_RGID_EX';--Ya existe un registro con esta identificación. Por favor verifique.
        RAISE e_error;
        --
    END IF;
    --
    IF p_ty_mesa.mesa_mesa IS NOT NULL AND v_mesa <> p_ty_mesa.mesa_mesa THEN
        --
        p_ty_msg.cod_msg := 'ER_RGID_EX';--Ya existe un registro con esta identificación. Por favor verifique.
        RAISE e_error;
        --
    END IF;
    --
    IF (p_ty_mesa.mesa_mesa IS NOT NULL AND (v_mesa = p_ty_mesa.mesa_mesa OR v_mesa IS NULL)) THEN
        --
        tbl_qmesaoper_crud.actualizar_tbl_tmesaoper(p_ty_mesa,p_ty_msg);
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            RAISE e_error_e; 
            --
        END IF;
        --
    ELSIF p_ty_mesa.mesa_mesa IS NULL THEN
        --
        tbl_qmesaoper_crud.insertar_tbl_tmesaoper(p_ty_mesa,p_ty_msg);  
        --
        IF p_ty_msg.cod_msg <> 'OK' THEN
            --
            RAISE e_error_e; 
            --
        END IF;        
    END IF;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN e_error THEN
         v_desc_msg := gen_fmensajes(p_ty_msg.cod_msg, v_tipo);
         p_ty_msg.msg_msg := v_desc_msg;
    --        
    WHEN e_error_e THEN
         return;   
    --
    WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qmesaoper.valida_data. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END valida_data;
---------------------------------------------------------------------------------------------------
--
END tbl_qmesaoper;
/
prompt
prompt PACKAGE: GEN_QFESTIVOS_CRUD
prompt
CREATE OR REPLACE PACKAGE gen_qfestivos_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla gen_tfestivos
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       04/01/2024 Cramirezs    000001       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_fest IS RECORD(
     fest_fest     gen_tfestivos.fest_fest    %TYPE
   , fest_fecins   gen_tfestivos.fest_fecins  %TYPE
   , fest_usuains  gen_tfestivos.fest_usuains %TYPE
   , fest_fecupd   gen_tfestivos.fest_fecupd  %TYPE
   , fest_usuaupd  gen_tfestivos.fest_usuaupd %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla gen_tfestivos
 *
 * Author: Cramirezs
 * Created: 04/01/2024
 *
 * Param: p_ty_fest Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_gen_tfestivos(
                                  p_ty_fest        gen_qfestivos_crud.ty_fest
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla gen_tfestivos
 *
 * Author: Cramirezs
 * Created: 04/01/2024
 *
 * Param: p_ty_fest Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_gen_tfestivos(
                                  p_ty_fest         gen_qfestivos_crud.ty_fest
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla gen_tfestivos
 *
 * Author: Cramirezs
 * Created: 2024/01/2024
 *
 * Param: p_ty_fest Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_gen_tfestivos(
                                  p_ty_fest         gen_qfestivos_crud.ty_fest
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END gen_qfestivos_crud;
/
prompt
prompt PACKAGE BODY: gen_qfestivos_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY gen_qfestivos_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_gen_tfestivos(
                                  p_ty_fest        gen_qfestivos_crud.ty_fest
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    INSERT INTO gen_tfestivos
        (
              fest_fest
            , fest_fecins
            , fest_usuains
        )VALUES
        (
              p_ty_fest.fest_fest
            , p_ty_fest.fest_fecins
            , p_ty_fest.fest_usuains
        );
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'gen_qfestivos_crud.insertar_gen_tfestivos. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_gen_tfestivos;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_gen_tfestivos(
                                  p_ty_fest         gen_qfestivos_crud.ty_fest
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE gen_tfestivos SET
          fest_fecupd  = NVL(p_ty_fest.fest_fecupd, SYSDATE)
        , fest_usuaupd = NVL(p_ty_fest.fest_usuaupd, USER)
    WHERE fest_fest = p_ty_fest.fest_fest
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'gen_qfestivos_crud.actualizar_gen_tfestivos. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_gen_tfestivos;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_gen_tfestivos(
                                  p_ty_fest         gen_qfestivos_crud.ty_fest
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM gen_tfestivos 
        WHERE fest_fest = p_ty_fest.fest_fest
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'gen_qfestivos_crud.eliminar_gen_tfestivos '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_gen_tfestivos;
--------------------------------------------------------------------------------------------------
END gen_qfestivos_crud;
/
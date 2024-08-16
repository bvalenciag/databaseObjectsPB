prompt
prompt PACKAGE: TBL_QENTIDADES_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qentidades_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tentidades
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_enti IS RECORD(
     enti_enti          tbl_tentidades.enti_enti            %TYPE
   , enti_vari          tbl_tentidades.enti_vari            %TYPE
   , enti_descripcion   tbl_tentidades.enti_descripcion     %TYPE
   , enti_fecins        tbl_tentidades.enti_fecins          %TYPE
   , enti_usuains       tbl_tentidades.enti_usuains         %TYPE
   , enti_fecupd        tbl_tentidades.enti_fecupd          %TYPE
   , enti_usuaupd       tbl_tentidades.enti_usuaupd         %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tentidades
 *
 * Author: Jmartinezm
 * Created: 23/01/2024
 *
 * Param: p_ty_enti Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tentidades(
                                  p_ty_enti        tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tentidades
 *
 * Author: Jmartinezm
 * Created: 23/01/2024
 *
 * Param: p_ty_enti Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tentidades(
                                  p_ty_enti         tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tentidades
 *
 * Author: Jmartinezm
 * Created: 2024/01/2024
 *
 * Param: p_ty_enti Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tentidades(
                                  p_ty_enti         tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qentidades_crud;
/
prompt
prompt PACKAGE BODY: tbl_qentidades_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qentidades_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tentidades(
                                  p_ty_enti        tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_enti_enti  tbl_tentidades.enti_enti%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_enti_enti := gen_qgeneral.p_secu('tbl_sentidades', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tentidades
        (
              enti_enti
            , enti_vari
            , enti_descripcion
            , enti_fecins
            , enti_usuains
        )VALUES
        (
              v_enti_enti
            , p_ty_enti.enti_vari
            , p_ty_enti.enti_descripcion
            , p_ty_enti.enti_fecins
            , p_ty_enti.enti_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qentidades_crud.insertar_tbl_tentidades. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tentidades;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tentidades(
                                  p_ty_enti         tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tentidades SET
          enti_vari         = NVL(p_ty_enti.enti_vari, enti_vari)
        , enti_descripcion  = NVL(p_ty_enti.enti_descripcion, enti_descripcion)
        , enti_fecupd       = NVL(p_ty_enti.enti_fecupd, SYSDATE)
        , enti_usuaupd      = NVL(p_ty_enti.enti_usuaupd, USER)
    WHERE enti_enti = p_ty_enti.enti_enti
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qentidades_crud.actualizar_tbl_tentidades. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tentidades;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tentidades(
                                  p_ty_enti         tbl_qentidades_crud.ty_enti
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tentidades 
        WHERE enti_enti = p_ty_enti.enti_enti
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qentidades_crud.eliminar_tbl_tentidades '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tentidades;
--------------------------------------------------------------------------------------------------
END tbl_qentidades_crud;
/
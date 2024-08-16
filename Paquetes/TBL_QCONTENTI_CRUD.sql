prompt
prompt PACKAGE: TBL_QCONTENTI_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qcontenti_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tcontenti
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
TYPE ty_cont IS RECORD(
     cont_cont          tbl_tcontenti.cont_cont         %TYPE
   , cont_nombre        tbl_tcontenti.cont_nombre       %TYPE
   , cont_telefono      tbl_tcontenti.cont_telefono     %TYPE
   , cont_extension     tbl_tcontenti.cont_extension    %TYPE    
   , cont_sebra         tbl_tcontenti.cont_sebra        %TYPE
   , cont_fecins        tbl_tcontenti.cont_fecins       %TYPE
   , cont_usuains       tbl_tcontenti.cont_usuains      %TYPE
   , cont_fecupd        tbl_tcontenti.cont_fecupd       %TYPE
   , cont_usuaupd       tbl_tcontenti.cont_usuaupd      %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tcontenti
 *
 * Author: Jmartinezm
 * Created: 23/01/2024
 *
 * Param: p_ty_cont Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tcontenti(
                                  p_ty_cont        tbl_qcontenti_crud.ty_cont
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tcontenti
 *
 * Author: Jmartinezm
 * Created: 23/01/2024
 *
 * Param: p_ty_cont Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tcontenti(
                                  p_ty_cont         tbl_qcontenti_crud.ty_cont
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tcontenti
 *
 * Author: Jmartinezm
 * Created: 2024/01/2024
 *
 * Param: p_ty_cont Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tcontenti(
                                  p_ty_cont         tbl_qcontenti_crud.ty_cont
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qcontenti_crud;
/
prompt
prompt PACKAGE BODY: tbl_qcontenti_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qcontenti_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tcontenti(
                                  p_ty_cont        tbl_qcontenti_crud.ty_cont
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_cont_cont  tbl_tcontenti.cont_cont%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_cont_cont := gen_qgeneral.p_secu('tbl_scontenti', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tcontenti
        (
              cont_cont
            , cont_nombre
            , cont_telefono
            , cont_extension
            , cont_sebra
            , cont_fecins
            , cont_usuains
        )VALUES
        (
              v_cont_cont
            , p_ty_cont.cont_nombre
            , p_ty_cont.cont_telefono
            , p_ty_cont.cont_extension
            , p_ty_cont.cont_sebra
            , p_ty_cont.cont_fecins
            , p_ty_cont.cont_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qcontenti_crud.insertar_tbl_tcontenti. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tcontenti;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tcontenti(
                                  p_ty_cont         tbl_qcontenti_crud.ty_cont
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tcontenti SET
    --
          cont_nombre       = NVL(p_ty_cont.cont_nombre,cont_nombre)
        , cont_telefono     = NVL(p_ty_cont.cont_telefono,cont_telefono)
        , cont_extension    = NVL(p_ty_cont.cont_extension,cont_extension)
        , cont_sebra        = NVL(p_ty_cont.cont_sebra,cont_sebra)
        , cont_fecupd       = NVL(p_ty_cont.cont_fecupd, SYSDATE)
        , cont_usuaupd      = NVL(p_ty_cont.cont_usuaupd, USER)
    WHERE cont_cont = p_ty_cont.cont_cont
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcontenti_crud.actualizar_tbl_tcontenti. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcontenti;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tcontenti(
                                  p_ty_cont         tbl_qcontenti_crud.ty_cont
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tcontenti 
        WHERE cont_cont = p_ty_cont.cont_cont
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcontenti_crud.eliminar_tbl_tcontenti '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tcontenti;
--------------------------------------------------------------------------------------------------
END tbl_qcontenti_crud;
/
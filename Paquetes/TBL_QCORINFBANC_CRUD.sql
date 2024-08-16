prompt
prompt PACKAGE: TBL_QCORINFBANC_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qcorinfbanc_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tcorinfbanc
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
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_cori IS RECORD(
     cori_cori     tbl_tcorinfbanc.cori_cori    %TYPE
   , cori_infb     tbl_tcorinfbanc.cori_infb    %TYPE
   , cori_email    tbl_tcorinfbanc.cori_email   %TYPE
   , cori_fecins   tbl_tcorinfbanc.cori_fecins  %TYPE
   , cori_usuains  tbl_tcorinfbanc.cori_usuains %TYPE
   , cori_fecupd   tbl_tcorinfbanc.cori_fecupd  %TYPE
   , cori_usuaupd  tbl_tcorinfbanc.cori_usuaupd %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tcorinfbanc
 *
 * Author: Jmartinezm
 * Created: 25/01/2024
 *
 * Param: p_ty_cori Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tcorinfbanc(
                                  p_ty_cori        tbl_qcorinfbanc_crud.ty_cori
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tcorinfbanc
 *
 * Author: Jmartinezm
 * Created: 25/01/2024
 *
 * Param: p_ty_cori Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tcorinfbanc(
                                  p_ty_cori         tbl_qcorinfbanc_crud.ty_cori
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tcorinfbanc
 *
 * Author: Jmartinezm
 * Created: 2024/01/2024
 *
 * Param: p_ty_cori Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tcorinfbanc(
                                  p_ty_cori         tbl_qcorinfbanc_crud.ty_cori
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qcorinfbanc_crud;
/
prompt
prompt PACKAGE BODY: tbl_qcorinfbanc_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qcorinfbanc_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tcorinfbanc(
                                  p_ty_cori        tbl_qcorinfbanc_crud.ty_cori
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_cori_cori  tbl_tcorinfbanc.cori_cori%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_cori_cori := gen_qgeneral.p_secu('tbl_scorinfbanc', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tcorinfbanc
        (
              cori_cori
            , cori_infb
            , cori_email
            , cori_fecins
            , cori_usuains
        )VALUES
        (
              v_cori_cori
            , p_ty_cori.cori_infb
            , p_ty_cori.cori_email
            , p_ty_cori.cori_fecins
            , p_ty_cori.cori_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qcorinfbanc_crud.insertar_tbl_tcorinfbanc. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tcorinfbanc;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tcorinfbanc(
                                  p_ty_cori         tbl_qcorinfbanc_crud.ty_cori
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tcorinfbanc SET
          cori_infb    = NVL(p_ty_cori.cori_infb, cori_infb) 
        , cori_email   = NVL(p_ty_cori.cori_email, cori_email) 
        , cori_fecupd  = NVL(p_ty_cori.cori_fecupd, SYSDATE)
        , cori_usuaupd = NVL(p_ty_cori.cori_usuaupd, USER)
    WHERE cori_cori = p_ty_cori.cori_cori
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcorinfbanc_crud.actualizar_tbl_tcorinfbanc. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcorinfbanc;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tcorinfbanc(
                                  p_ty_cori         tbl_qcorinfbanc_crud.ty_cori
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tcorinfbanc 
        WHERE cori_cori = p_ty_cori.cori_cori
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcorinfbanc_crud.eliminar_tbl_tcorinfbanc '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tcorinfbanc;
--------------------------------------------------------------------------------------------------
END tbl_qcorinfbanc_crud;
/
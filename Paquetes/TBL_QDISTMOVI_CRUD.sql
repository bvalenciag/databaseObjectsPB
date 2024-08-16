prompt
prompt PACKAGE: TBL_QDISTMOVI_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qdistmovi_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tdistmovi
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       15/12/2023 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_dist IS RECORD(
     dist_dist     tbl_tdistmovi.dist_dist    %TYPE
   , dist_motp     tbl_tdistmovi.dist_motp    %TYPE
   , dist_motm     tbl_tdistmovi.dist_motm    %TYPE
   , dist_banc     tbl_tdistmovi.dist_banc    %TYPE
   , dist_val      tbl_tdistmovi.dist_val     %TYPE
   , dist_fecins   tbl_tdistmovi.dist_fecins  %TYPE
   , dist_usuains  tbl_tdistmovi.dist_usuains %TYPE
   , dist_fecupd   tbl_tdistmovi.dist_fecupd  %TYPE
   , dist_usuaupd  tbl_tdistmovi.dist_usuaupd %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tdistmovi
 *
 * Author: Jmartinezm
 * Created: 15/12/2023
 *
 * Param: p_ty_dist Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tdistmovi(
                                  p_ty_dist        tbl_qdistmovi_crud.ty_dist
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tdistmovi
 *
 * Author: Jmartinezm
 * Created: 15/12/2023
 *
 * Param: p_ty_dist Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tdistmovi(
                                  p_ty_dist         tbl_qdistmovi_crud.ty_dist
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tdistmovi
 *
 * Author: Jmartinezm
 * Created: 2023/12/2023
 *
 * Param: p_ty_dist Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tdistmovi(
                                  p_ty_dist         tbl_qdistmovi_crud.ty_dist
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qdistmovi_crud;
/
prompt
prompt PACKAGE BODY: tbl_qdistmovi_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qdistmovi_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tdistmovi(
                                  p_ty_dist        tbl_qdistmovi_crud.ty_dist
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_dist_dist  tbl_tdistmovi.dist_dist%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_dist_dist := gen_qgeneral.p_secu('tbl_sdistmovi', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tdistmovi
        (
              dist_dist
            , dist_motp
            , dist_motm
            , dist_banc
            , dist_val
            , dist_fecins
            , dist_usuains
        )VALUES
        (
              v_dist_dist
            , p_ty_dist.dist_motp
            , p_ty_dist.dist_motm
            , p_ty_dist.dist_banc
            , p_ty_dist.dist_val
            , p_ty_dist.dist_fecins
            , p_ty_dist.dist_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qdistmovi_crud.insertar_tbl_tdistmovi. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tdistmovi;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tdistmovi(
                                  p_ty_dist         tbl_qdistmovi_crud.ty_dist
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tdistmovi SET

          dist_motp    = NVL(p_ty_dist.dist_motp, dist_motp)
        , dist_motm    = NVL(p_ty_dist.dist_motm, dist_motm)
        , dist_banc    = NVL(p_ty_dist.dist_banc, dist_banc)
        , dist_val     = NVL(p_ty_dist.dist_val,  dist_val)
        , dist_fecupd  = NVL(p_ty_dist.dist_fecupd, SYSDATE)
        , dist_usuaupd = NVL(p_ty_dist.dist_usuaupd, USER)
    WHERE dist_dist = p_ty_dist.dist_dist
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qdistmovi_crud.actualizar_tbl_tdistmovi. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tdistmovi;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tdistmovi(
                                  p_ty_dist         tbl_qdistmovi_crud.ty_dist
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tdistmovi 
        WHERE dist_dist = p_ty_dist.dist_dist
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qdistmovi_crud.eliminar_tbl_tdistmovi '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tdistmovi;
--------------------------------------------------------------------------------------------------
END tbl_qdistmovi_crud;
/
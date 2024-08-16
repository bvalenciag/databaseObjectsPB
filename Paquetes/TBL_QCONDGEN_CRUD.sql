prompt
prompt PACKAGE: TBL_QCONDGEN_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qcondgen_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tcondgen
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/12/2023 Jmartinezm    00001       * Se crea paquete.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       24/07/2024 Jmartinezm    00001       * Se agraga columna.
--                       Kilonova      MVP3
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_cond IS RECORD(
     cond_cond       tbl_tcondgen.cond_cond       %TYPE
   , cond_banc_inter tbl_tcondgen.cond_banc_inter %TYPE
   , cond_banc_cance tbl_tcondgen.cond_banc_cance %TYPE
   , cond_dv1        tbl_tcondgen.cond_dv1        %TYPE
   , cond_repre      tbl_tcondgen.cond_repre      %TYPE --1001
   , cond_fecins     tbl_tcondgen.cond_fecins     %TYPE
   , cond_usuains    tbl_tcondgen.cond_usuains    %TYPE
   , cond_fecupd     tbl_tcondgen.cond_fecupd     %TYPE
   , cond_usuaupd    tbl_tcondgen.cond_usuaupd    %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tcondgen
 *
 * Author: Jmartinezm
 * Created: 18/12/2923
 *
 * Param: p_ty_cond Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tcondgen(
                                  p_ty_cond        tbl_qcondgen_crud.ty_cond
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tcondgen
 *
 * Author: Jmartinezm
 * Created: 18/12/2923
 *
 * Param: p_ty_cond Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tcondgen(
                                  p_ty_cond         tbl_qcondgen_crud.ty_cond
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tcondgen
 *
 * Author: Jmartinezm
 * Created: 2923/12/2923
 *
 * Param: p_ty_cond Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tcondgen(
                                  p_ty_cond         tbl_qcondgen_crud.ty_cond
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qcondgen_crud;
/
prompt
prompt PACKAGE BODY: tbl_qcondgen_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qcondgen_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tcondgen(
                                  p_ty_cond        tbl_qcondgen_crud.ty_cond
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    INSERT INTO tbl_tcondgen
        (
              cond_cond
            , cond_banc_inter
            , cond_banc_cance
            , cond_dv1  --1001
            , cond_repre
            , cond_fecins
            , cond_usuains
        )VALUES
        (
              p_ty_cond.cond_cond
            , p_ty_cond.cond_banc_inter
            , p_ty_cond.cond_banc_cance
            , p_ty_cond.cond_dv1
            , p_ty_cond.cond_repre
            , p_ty_cond.cond_fecins
            , p_ty_cond.cond_usuains
        );
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qcondgen_crud.insertar_tbl_tcondgen. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tcondgen;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tcondgen(
                                  p_ty_cond         tbl_qcondgen_crud.ty_cond
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error EXCEPTION;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    if p_ty_cond.cond_dv1 < 0 then
      raise e_error;
    end if;
    --
    UPDATE tbl_tcondgen SET
          cond_banc_inter  = NVL(p_ty_cond.cond_banc_inter, cond_banc_inter)
        , cond_banc_cance  = NVL(p_ty_cond.cond_banc_cance, cond_banc_cance)  
        , cond_dv1         = p_ty_cond.cond_dv1    
        , cond_repre       = NVL(p_ty_cond.cond_repre, cond_repre) --1001
        , cond_fecupd      = NVL(p_ty_cond.cond_fecupd, SYSDATE)
        , cond_usuaupd     = NVL(p_ty_cond.cond_usuaupd, USER)
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.msg_msg := 'Valor no permitido. Por favor verifique.';
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcondgen_crud.actualizar_tbl_tcondgen. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcondgen;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tcondgen(
                                  p_ty_cond         tbl_qcondgen_crud.ty_cond
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tcondgen 
        WHERE cond_cond = p_ty_cond.cond_cond
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcondgen_crud.eliminar_tbl_tcondgen '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tcondgen;
--------------------------------------------------------------------------------------------------
END tbl_qcondgen_crud;
/
prompt
prompt PACKAGE: TBL_QCANCELACIO_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qcancelacio_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tcancelacio
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_canc IS RECORD(
     canc_canc      tbl_tcancelacio.canc_canc     %TYPE
   , canc_canc_ex   tbl_tcancelacio.canc_canc_ex  %TYPE
   , canc_fond_ex   tbl_tcancelacio.canc_fond_ex  %TYPE
   , canc_empr_ex   tbl_tcancelacio.canc_empr_ex  %TYPE
   , canc_empr      tbl_tcancelacio.canc_empr     %TYPE
   , canc_banc_ex   tbl_tcancelacio.canc_banc_ex  %TYPE
   , canc_banc      tbl_tcancelacio.canc_banc     %TYPE
   , canc_fecha     tbl_tcancelacio.canc_fecha    %TYPE
   , canc_plan      tbl_tcancelacio.canc_plan     %TYPE
   , canc_desc_plan tbl_tcancelacio.canc_desc_plan%TYPE
   , canc_vlr_canc  tbl_tcancelacio.canc_vlr_canc %TYPE
   , canc_vlr_ajus  tbl_tcancelacio.canc_vlr_ajus %TYPE
   , canc_vlr_gmf   tbl_tcancelacio.canc_vlr_gmf  %TYPE
   , canc_vlr_giro  tbl_tcancelacio.canc_vlr_giro %TYPE
   , canc_val_act   tbl_tcancelacio.canc_val_act  %TYPE
   , canc_fuente    tbl_tcancelacio.canc_fuente   %TYPE
   , canc_fecins    tbl_tcancelacio.canc_fecins   %TYPE
   , canc_usuains   tbl_tcancelacio.canc_usuains  %TYPE
   , canc_fecupd    tbl_tcancelacio.canc_fecupd   %TYPE
   , canc_usuaupd   tbl_tcancelacio.canc_usuaupd  %TYPE
   , canc_stat_ex   tbl_tcancelacio.canc_stat_ex  %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tcancelacio
 *
 * Author: Cramirezs
 * Created: 14/12/2023
 *
 * Param: p_ty_canc Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tcancelacio(
                                  p_ty_canc        tbl_qcancelacio_crud.ty_canc
                                , p_canc_canc  OUT  tbl_tcancelacio.canc_canc%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tcancelacio
 *
 * Author: Cramirezs
 * Created: 14/12/2023
 *
 * Param: p_ty_canc Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tcancelacio(
                                  p_ty_canc         tbl_qcancelacio_crud.ty_canc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tcancelacio
 *
 * Author: Cramirezs
 * Created: 2023/12/2023
 *
 * Param: p_ty_canc Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tcancelacio(
                                  p_ty_canc         tbl_qcancelacio_crud.ty_canc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qcancelacio_crud;
/
prompt
prompt PACKAGE BODY: tbl_qcancelacio_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qcancelacio_crud IS
--
-- #VERSION: 1000
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tcancelacio(
                                  p_ty_canc        tbl_qcancelacio_crud.ty_canc
                                , p_canc_canc  OUT  tbl_tcancelacio.canc_canc%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_canc_canc  tbl_tcancelacio.canc_canc%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_canc_canc := gen_qgeneral.p_secu('tbl_scancelacio', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tcancelacio
        (
              canc_canc
            , canc_canc_ex  
            , canc_fond_ex  
            , canc_empr_ex  
            , canc_empr     
            , canc_banc_ex  
            , canc_banc     
            , canc_fecha    
            , canc_plan     
            , canc_desc_plan
            , canc_vlr_canc 
            , canc_vlr_ajus 
            , canc_vlr_gmf  
            , canc_vlr_giro 
            , canc_val_act
            , canc_fuente   
            , canc_fecins
            , canc_usuains
            , canc_stat_ex
        )VALUES
        (
              v_canc_canc
            , p_ty_canc.canc_canc_ex  
            , p_ty_canc.canc_fond_ex  
            , p_ty_canc.canc_empr_ex  
            , p_ty_canc.canc_empr     
            , p_ty_canc.canc_banc_ex  
            , p_ty_canc.canc_banc     
            , p_ty_canc.canc_fecha    
            , p_ty_canc.canc_plan     
            , p_ty_canc.canc_desc_plan
            , p_ty_canc.canc_vlr_canc 
            , p_ty_canc.canc_vlr_ajus 
            , p_ty_canc.canc_vlr_gmf  
            , p_ty_canc.canc_vlr_giro 
            , p_ty_canc.canc_val_act
            , p_ty_canc.canc_fuente   
            , p_ty_canc.canc_fecins
            , p_ty_canc.canc_usuains
            , p_ty_canc.canc_stat_ex
        );
    --
    p_canc_canc         := v_canc_canc;
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qcancelacio_crud.insertar_tbl_tcancelacio. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tcancelacio;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tcancelacio(
                                  p_ty_canc         tbl_qcancelacio_crud.ty_canc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tcancelacio SET
          canc_canc_ex   = NVL(p_ty_canc.canc_canc_ex  , canc_canc_ex  )
        , canc_fond_ex   = NVL(p_ty_canc.canc_fond_ex  , canc_fond_ex  )
        , canc_empr_ex   = NVL(p_ty_canc.canc_empr_ex  , canc_empr_ex  )
        , canc_empr      = NVL(p_ty_canc.canc_empr     , canc_empr     )
        , canc_banc_ex   = NVL(p_ty_canc.canc_banc_ex  , canc_banc_ex  )
        , canc_banc      = NVL(p_ty_canc.canc_banc     , canc_banc     )
        , canc_fecha     = NVL(p_ty_canc.canc_fecha    , canc_fecha    )
        , canc_plan      = NVL(p_ty_canc.canc_plan     , canc_plan     )
        , canc_desc_plan = NVL(p_ty_canc.canc_desc_plan, canc_desc_plan)
        , canc_vlr_canc  = NVL(p_ty_canc.canc_vlr_canc , canc_vlr_canc )
        , canc_vlr_ajus  = NVL(p_ty_canc.canc_vlr_ajus , canc_vlr_ajus )
        , canc_vlr_gmf   = NVL(p_ty_canc.canc_vlr_gmf  , canc_vlr_gmf  )
        , canc_vlr_giro  = NVL(p_ty_canc.canc_vlr_giro , canc_vlr_giro )
        , canc_val_act   = NVL(p_ty_canc.canc_val_act  , canc_val_act  )
        , canc_fuente    = NVL(p_ty_canc.canc_fuente   , canc_fuente   )
        , canc_fecupd    = NVL(p_ty_canc.canc_fecupd   , SYSDATE       )
        , canc_usuaupd   = NVL(p_ty_canc.canc_usuaupd  , USER          )
        , canc_stat_ex   = NVL(p_ty_canc.canc_stat_ex  , canc_stat_ex  )
    WHERE canc_canc = p_ty_canc.canc_canc
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcancelacio_crud.actualizar_tbl_tcancelacio. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tcancelacio;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tcancelacio(
                                  p_ty_canc         tbl_qcancelacio_crud.ty_canc
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tcancelacio 
        WHERE canc_canc = p_ty_canc.canc_canc
    ;
    --
    p_ty_msg.msg_msg := 'Proceso Exitoso';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qcancelacio_crud.eliminar_tbl_tcancelacio '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tcancelacio;
--------------------------------------------------------------------------------------------------
END tbl_qcancelacio_crud;
/
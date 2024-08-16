prompt
prompt PACKAGE: TBL_QMOTMITRA_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qmotmitra_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tmotmitra
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       11/12/2023 Cramirezs    000001       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       24/04/2024 Jmartinezm   000002       * Se crea paquete.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
-------------------------------------------------------------------------------------------------
--Type
-------------------------------------------------------------------------------------------------
TYPE ty_motm IS RECORD(
     motm_motm          tbl_tmotmitra.motm_motm       %TYPE
   , motm_folio         tbl_tmotmitra.motm_folio      %TYPE
   , motm_operacion     tbl_tmotmitra.motm_operacion  %TYPE
   , motm_cod_contra    tbl_tmotmitra.motm_cod_contra %TYPE
   , motm_desc_contra   tbl_tmotmitra.motm_desc_contra%TYPE
   , motm_monto         tbl_tmotmitra.motm_monto      %TYPE
   , motm_act           tbl_tmotmitra.motm_act        %TYPE
   , motm_fech_cump     tbl_tmotmitra.motm_fech_cump  %TYPE
   , motm_cod_trader    tbl_tmotmitra.motm_cod_trader %TYPE
   , motm_desc_trader   tbl_tmotmitra.motm_desc_trader%TYPE
   , motm_destino       tbl_tmotmitra.motm_destino    %TYPE
   , motm_estado        tbl_tmotmitra.motm_estado     %TYPE
   , motm_fuente        tbl_tmotmitra.motm_fuente     %TYPE
   , motm_empr          tbl_tmotmitra.motm_empr       %TYPE
   , motm_mandato       tbl_tmotmitra.motm_mandato    %TYPE -- 1001   24/04/2024 Jmartinezm 
   , motm_fecins        tbl_tmotmitra.motm_fecins     %TYPE
   , motm_usuains       tbl_tmotmitra.motm_usuains    %TYPE
   , motm_fecupd        tbl_tmotmitra.motm_fecupd     %TYPE
   , motm_usuaupd       tbl_tmotmitra.motm_usuaupd    %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tmotmitra
 *
 * Author: Cramirezs
 * Created: 11/12/2023
 *
 * Param: p_ty_motmitra Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tmotmitra(
                                  p_ty_motm         tbl_qmotmitra_crud.ty_motm
                                , p_motm_motm   OUT tbl_tmotmitra.motm_motm%TYPE
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tmotmitra
 *
 * Author: Cramirezs
 * Created: 11/12/2023
 *
 * Param: p_ty_motmitra Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tmotmitra(
                                  p_ty_motm         tbl_qmotmitra_crud.ty_motm
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tmotmitra
 *
 * Author: Cramirezs
 * Created: 2023/12/2023
 *
 * Param: p_ty_motmitra Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tmotmitra(
                                  p_ty_motm         tbl_qmotmitra_crud.ty_motm
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qmotmitra_crud;
/
prompt
prompt PACKAGE BODY: tbl_qmotmitra_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qmotmitra_crud IS
--
-- #VERSION: 1001
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tmotmitra(
                                  p_ty_motm         tbl_qmotmitra_crud.ty_motm
                                , p_motm_motm   OUT tbl_tmotmitra.motm_motm%TYPE
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_motm_motm  tbl_tmotmitra.motm_motm%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_motm_motm := gen_qgeneral.p_secu('tbl_smotmitra', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tmotmitra
        (
              motm_motm       
            , motm_folio      
            , motm_operacion  
            , motm_cod_contra 
            , motm_desc_contra
            , motm_monto 
            , motm_act     
            , motm_fech_cump  
            , motm_cod_trader 
            , motm_desc_trader
            , motm_destino    
            , motm_estado     
            , motm_fuente     
            , motm_empr   
            , motm_mandato -- 1001   24/04/2024 Jmartinezm     
            , motm_fecins
            , motm_usuains
        )VALUES
        (
              v_motm_motm
            , p_ty_motm.motm_folio      
            , p_ty_motm.motm_operacion  
            , p_ty_motm.motm_cod_contra 
            , p_ty_motm.motm_desc_contra
            , p_ty_motm.motm_monto   
            , p_ty_motm.motm_act   
            , p_ty_motm.motm_fech_cump  
            , p_ty_motm.motm_cod_trader 
            , p_ty_motm.motm_desc_trader
            , p_ty_motm.motm_destino    
            , p_ty_motm.motm_estado     
            , p_ty_motm.motm_fuente     
            , p_ty_motm.motm_empr  
            , p_ty_motm.motm_mandato  -- 1001   24/04/2024 Jmartinezm      
            , p_ty_motm.motm_fecins
            , p_ty_motm.motm_usuains
        );
    --
    p_motm_motm         := v_motm_motm;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qmotmitra_crud.insertar_tbl_tmotmitra. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tmotmitra;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tmotmitra(
                                  p_ty_motm         tbl_qmotmitra_crud.ty_motm
                                , p_ty_msg      OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tmotmitra SET
          motm_folio       = NVL(p_ty_motm.motm_folio      , motm_folio      )
        , motm_operacion   = NVL(p_ty_motm.motm_operacion  , motm_operacion  )
        , motm_cod_contra  = NVL(p_ty_motm.motm_cod_contra , motm_cod_contra )
        , motm_desc_contra = NVL(p_ty_motm.motm_desc_contra, motm_desc_contra)
        , motm_monto       = NVL(p_ty_motm.motm_monto      , motm_monto      )
        , motm_act         = NVL(p_ty_motm.motm_act         , motm_act        ) 
        , motm_fech_cump   = NVL(p_ty_motm.motm_fech_cump  , motm_fech_cump  )
        , motm_cod_trader  = NVL(p_ty_motm.motm_cod_trader , motm_cod_trader )
        , motm_desc_trader = NVL(p_ty_motm.motm_desc_trader, motm_desc_trader)
        , motm_destino     = NVL(p_ty_motm.motm_destino    , motm_destino    )
        , motm_estado      = NVL(p_ty_motm.motm_estado     , motm_estado     )
        , motm_fuente      = NVL(p_ty_motm.motm_fuente     , motm_fuente     )
        , motm_empr        = NVL(p_ty_motm.motm_empr       , motm_empr       )
        , motm_mandato     = NVL(p_ty_motm.motm_mandato    , motm_mandato    ) -- 1001   24/04/2024 Jmartinezm 
        , motm_fecupd      = NVL(p_ty_motm.motm_fecupd     , SYSDATE         )
        , motm_usuaupd     = NVL(p_ty_motm.motm_usuaupd    , USER            )
    WHERE motm_motm = p_ty_motm.motm_motm
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmotmitra_crud.actualizar_tbl_tmotmitra. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tmotmitra;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tmotmitra(
                                  p_ty_motm         tbl_qmotmitra_crud.ty_motm
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tmotmitra 
        WHERE motm_motm = p_ty_motm.motm_motm
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmotmitra_crud.eliminar_tbl_tmotmitra '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tmotmitra;
--------------------------------------------------------------------------------------------------
END tbl_qmotmitra_crud;
/
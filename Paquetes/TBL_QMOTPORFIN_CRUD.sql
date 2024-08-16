prompt
prompt PACKAGE: TBL_QMOTPORFIN_CRUD
prompt
CREATE OR REPLACE PACKAGE tbl_qmotporfin_crud IS
--
-- Reúne funciones y procedimientos directamente relacionados con la tabla tbl_tmotporfin
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
TYPE ty_motp IS RECORD(
     motp_motp        tbl_tmotporfin.motp_motp       %TYPE
   , motp_ope_fecha   tbl_tmotporfin.motp_ope_fecha  %TYPE
   , motp_det         tbl_tmotporfin.motp_det        %TYPE
   , motp_transac     tbl_tmotporfin.motp_transac    %TYPE
   , motp_especie     tbl_tmotporfin.motp_especie    %TYPE
   , motp_consec      tbl_tmotporfin.motp_consec     %TYPE
   , motp_valor_nom   tbl_tmotporfin.motp_valor_nom  %TYPE
   , motp_emision     tbl_tmotporfin.motp_emision    %TYPE
   , motp_vcto        tbl_tmotporfin.motp_vcto       %TYPE
   , motp_vr_reci     tbl_tmotporfin.motp_vr_reci    %TYPE
   , motp_vr_act      tbl_tmotporfin.motp_vr_act     %TYPE
   , motp_nit         tbl_tmotporfin.motp_nit        %TYPE
   , motp_contraparte tbl_tmotporfin.motp_contraparte%TYPE
   , motp_por         tbl_tmotporfin.motp_por        %TYPE
   , motp_empr        tbl_tmotporfin.motp_empr       %TYPE
   , motp_fuente      tbl_tmotporfin.motp_fuente     %TYPE
   , motp_mandato     tbl_tmotporfin.motp_mandato    %TYPE -- 1001  24/04/2024 Jmartinezm
   , motp_fecins      tbl_tmotporfin.motp_fecins     %TYPE
   , motp_usuains     tbl_tmotporfin.motp_usuains    %TYPE
   , motp_fecupd      tbl_tmotporfin.motp_fecupd     %TYPE
   , motp_usuaupd     tbl_tmotporfin.motp_usuaupd    %TYPE
);
-------------------------------------------------------------------------------------------------
--Procedure - Function
-------------------------------------------------------------------------------------------------
/**
 * Description: Insertar en la tabla tbl_tmotporfin
 *
 * Author: Cramirezs
 * Created: 11/12/2023
 *
 * Param: p_ty_motporfin Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE insertar_tbl_tmotporfin(
                                  p_ty_motp         tbl_qmotporfin_crud.ty_motp
                                , p_motp_motp  OUT  tbl_tmotporfin.motp_motp%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
/**
 * Description: Actualizar en la tabla tbl_tmotporfin
 *
 * Author: Cramirezs
 * Created: 11/12/2023
 *
 * Param: p_ty_motporfin Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */
PROCEDURE actualizar_tbl_tmotporfin(
                                  p_ty_motp         tbl_qmotporfin_crud.ty_motp
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------    
/**
 * Description: Eliminar en la tabla tbl_tmotporfin
 *
 * Author: Cramirezs
 * Created: 2023/12/2023
 *
 * Param: p_ty_motporfin Description: Type de la tabla
 * Param: p_ty_msg Description: Type de errores
 */                      
PROCEDURE eliminar_tbl_tmotporfin(
                                  p_ty_motp         tbl_qmotporfin_crud.ty_motp
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                );
-------------------------------------------------------------------------------------------------
--
END tbl_qmotporfin_crud;
/
prompt
prompt PACKAGE BODY: tbl_qmotporfin_crud
prompt
--
CREATE OR REPLACE PACKAGE BODY tbl_qmotporfin_crud IS
--
-- #VERSION: 1001
--
---------------------------------------------------------------------------------------------------
PROCEDURE insertar_tbl_tmotporfin(
                                  p_ty_motp        tbl_qmotporfin_crud.ty_motp
                                , p_motp_motp  OUT tbl_tmotporfin.motp_motp%TYPE
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
    e_error      EXCEPTION;
    v_motp_motp  tbl_tmotporfin.motp_motp%TYPE;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    v_motp_motp := gen_qgeneral.p_secu('tbl_smotporfin', p_ty_msg.msg_msg);
    --
    IF p_ty_msg.msg_msg IS NOT NULL THEN
        raise e_error;
    END IF;
    --
    INSERT INTO tbl_tmotporfin
        (
              motp_motp 
            , motp_ope_fecha      
            , motp_det        
            , motp_transac    
            , motp_especie    
            , motp_consec     
            , motp_valor_nom  
            , motp_emision    
            , motp_vcto       
            , motp_vr_reci  
            , motp_vr_act  
            , motp_nit        
            , motp_contraparte
            , motp_por        
            , motp_empr       
            , motp_fuente    
            , motp_mandato                  -- 1001  24/04/2024 Jmartinezm
            , motp_fecins
            , motp_usuains
        )VALUES
        (
              v_motp_motp
            , p_ty_motp.motp_ope_fecha
            , p_ty_motp.motp_det        
            , p_ty_motp.motp_transac    
            , p_ty_motp.motp_especie    
            , p_ty_motp.motp_consec     
            , p_ty_motp.motp_valor_nom  
            , p_ty_motp.motp_emision    
            , p_ty_motp.motp_vcto       
            , p_ty_motp.motp_vr_reci  
            , p_ty_motp.motp_vr_act  
            , p_ty_motp.motp_nit        
            , p_ty_motp.motp_contraparte
            , p_ty_motp.motp_por        
            , p_ty_motp.motp_empr       
            , p_ty_motp.motp_fuente    
            , p_ty_motp.motp_mandato        -- 1001  24/04/2024 Jmartinezm
            , p_ty_motp.motp_fecins
            , p_ty_motp.motp_usuains
        );
    --
    p_motp_motp         := v_motp_motp;
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
     WHEN e_error THEN
         p_ty_msg.cod_msg := 'ERR_SEC';
     WHEN OTHERS THEN
         p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
         p_ty_msg.msg_msg := 'tbl_qmotporfin_crud.insertar_tbl_tmotporfin. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END insertar_tbl_tmotporfin;
--------------------------------------------------------------------------------------------------
PROCEDURE actualizar_tbl_tmotporfin(
                                  p_ty_motp         tbl_qmotporfin_crud.ty_motp
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    UPDATE tbl_tmotporfin SET
          motp_ope_fecha   = NVL(p_ty_motp.motp_ope_fecha  , motp_ope_fecha  )
        , motp_det         = NVL(p_ty_motp.motp_det        , motp_det        )
        , motp_transac     = NVL(p_ty_motp.motp_transac    , motp_transac    )
        , motp_especie     = NVL(p_ty_motp.motp_especie    , motp_especie    )
        , motp_consec      = NVL(p_ty_motp.motp_consec     , motp_consec     )
        , motp_valor_nom   = NVL(p_ty_motp.motp_valor_nom  , motp_valor_nom  )
        , motp_emision     = NVL(p_ty_motp.motp_emision    , motp_emision    )
        , motp_vcto        = NVL(p_ty_motp.motp_vcto       , motp_vcto       )
        , motp_vr_reci     = NVL(p_ty_motp.motp_vr_reci    , motp_vr_reci    )
        , motp_vr_act      = NVL(p_ty_motp.motp_vr_act     , motp_vr_act     )
        , motp_nit         = NVL(p_ty_motp.motp_nit        , motp_nit        )
        , motp_contraparte = NVL(p_ty_motp.motp_contraparte, motp_contraparte)
        , motp_por         = NVL(p_ty_motp.motp_por        , motp_por        )
        , motp_empr        = NVL(p_ty_motp.motp_empr       , motp_empr       )
        , motp_fuente      = NVL(p_ty_motp.motp_fuente     , motp_fuente     )
        , motp_mandato     = NVL(p_ty_motp.motp_mandato    , motp_mandato    )  -- 1001  24/04/2024 Jmartinezm
        , motp_fecupd      = NVL(p_ty_motp.motp_fecupd     , SYSDATE         )
        , motp_usuaupd     = NVL(p_ty_motp.motp_usuaupd    , USER            )
    WHERE motp_motp = p_ty_motp.motp_motp
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmotporfin_crud.actualizar_tbl_tmotporfin. '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END actualizar_tbl_tmotporfin;
--------------------------------------------------------------------------------------------------
PROCEDURE eliminar_tbl_tmotporfin(
                                  p_ty_motp         tbl_qmotporfin_crud.ty_motp
                                , p_ty_msg     OUT gen_qgeneral.ty_msg
                                )IS
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --
    DELETE FROM tbl_tmotporfin 
        WHERE motp_motp = p_ty_motp.motp_motp
    ;
    --
    p_ty_msg.msg_msg := 'Transaccion Exitosa';
    --
EXCEPTION
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ORA'||ltrim(to_char(sqlcode, '000000'));
        p_ty_msg.msg_msg := 'tbl_qmotporfin_crud.eliminar_tbl_tmotporfin '|| to_char(sysdate,'dd/mm/yyyy hh24miss')||'. Error: '||SQLERRM;
END eliminar_tbl_tmotporfin;
--------------------------------------------------------------------------------------------------
END tbl_qmotporfin_crud;
/
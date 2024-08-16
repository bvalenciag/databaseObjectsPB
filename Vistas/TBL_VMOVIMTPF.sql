prompt
prompt VIEW: TBL_VMOVIMTPF
prompt
CREATE OR REPLACE FORCE VIEW tbl_vmovimtpf
    (
      movi_fuente 
    , row_id
    , movi_empr
    , movi_empr_descri
    , movi_tipo_oper
    , movi_operacion
    , movi_especie
    , movi_fecha
    , movi_consec 
    , movi_nit
    , movi_desc_nit
    , movi_cod_trader
    , movi_desc_trader
    , movi_valor_nomi
    , movi_emision
    , movi_vcto
    , movi_valor
    , movi_estado 
    , movi_vlr_act
    , movi_mandato
    )
AS
SELECT
--
-- #VERSION: 1002
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       27/12/2023 Cramirezs    000001       * Se crea vista.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       11/04/2024 Jmartinezm   000002       * Se ajusta vista.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       24/04/2024 Jmartinezm   000003       * Se ajusta vista.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
--Registros de PORFIN
     'PF'                                                     movi_fuente
     ,TP.MOTP_MOTP                                            ROW_ID
    , empr_externo                                            movi_empr
    , empr_descripcion                                        movi_empr_descri -- 1002       24/04/2024 Jmartinezm 
    --, decode(motp_det, 'ENT', 'INGRESO', 'EGRESO')	        movi_tipo_oper  antes 1001    11/04/2024 Jmartinezm 
    , decode(UPPER(motp_det), 'ENT', 'INGRESO', 'EGRESO')	    movi_tipo_oper  -- 1001       11/04/2024 Jmartinezm 
    , motp_transac	                                          movi_operacion
    , motp_especie                                            movi_especie
    , MOTP_OPE_FECHA                                          movi_fecha
    , TO_CHAR(motp_consec)                                    movi_consec
    , motp_nit                                                movi_nit
    , motp_contraparte                                        movi_desc_nit
    , NULL                                                    movi_cod_trader
    , NULL                                                    movi_desc_trader
    , motp_valor_nom                                          movi_valor_nomi
    , motp_emision                                            movi_emision
    , motp_vcto                                               movi_vcto
    , motp_vr_reci                                            movi_valor
    , NULL                                                    movi_estado
    , motp_vr_act                                             movi_vlr_act
    , (select empr_descripcion
        from tbl_tempresas em
        where em.empr_empr = motp_mandato)                    movi_mandato  -- 1002       24/04/2024 Jmartinezm  
 FROM tbl_tmotporfin tp
   INNER JOIN TBL_TEMPRESAS tt ON TP.MOTP_EMPR = TT.EMPR_EMPR
--    , tbl_tempresas
--WHERE motp_empr = empr_empr
UNION ALL
--Registros de MITRA
SELECT 'MT'                                                         movi_fuente
, TM.MOTM_MOTM                                                      ROW_ID
    , empr_externo/*OPE_PORTAFOLIO*/                                movi_empr
    , empr_descripcion                                        movi_empr_descri -- 1002       24/04/2024 Jmartinezm 
    --, decode(motm_operacion, 'COMPRA', 'EGRESO', 'INGRESO')       movi_tipo_oper antes 1001    11/04/2024 Jmartinezm  
    , decode(UPPER(motm_operacion), 'COMPRA', 'EGRESO', 'INGRESO')  movi_tipo_oper -- 1001       11/04/2024 Jmartinezm 
    , motm_operacion                                                movi_operacion
    , NULL                                                          movi_especie
    , motm_fech_cump                                                movi_fecha
    , motm_folio                                                    movi_consec
    , motm_cod_contra                                               movi_nit
    , motm_desc_contra                                              movi_desc_nit
    , motm_cod_trader                                               movi_cod_trader
    , motm_desc_trader                                              movi_desc_trader
    , NULL                                                          movi_valor_nomi
    , NULL                                                          movi_emision
    , NULL                                                          movi_vcto
    , motm_monto                                                    movi_valor
    , motm_estado                                                   movi_estado
    , motm_act                                                      movi_vlr_act
    , (select empr_descripcion
        from tbl_tempresas em
        where em.empr_empr = motm_mandato)                         movi_mandato  -- 1002       24/04/2024 Jmartinezm  
 FROM tbl_tmotmitra tm
  INNER JOIN TBL_TEMPRESAS tt ON TM.MOTM_EMPR = TT.EMPR_EMPR
--    , tbl_tempresas
--WHERE motm_empr = empr_empr
/
--
COMMENT ON TABLE  tbl_vmovimtpf                     IS 'Muestra operaciones provenientes de MITRA y PORFIN.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_fuente         IS 'Fuente.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_empr           IS 'Empresa.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_tipo_oper      IS 'Tipo de operación.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_operacion      IS 'Descripción operación.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_especie        IS 'Especie.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_fecha          IS 'Fecha de operación.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_consec         IS 'Consecutivo de la operación.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_nit            IS 'Nit.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_desc_nit       IS 'Descripción nit.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_cod_trader     IS 'Código trader.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_desc_trader    IS 'Descripción trader.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_valor_nomi     IS 'Valor nominal.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_emision        IS 'Fecha emisión.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_vcto           IS 'Fecha vencimiento.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_valor          IS 'Valor operación.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_estado         IS 'Estado.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_vlr_act        IS 'Valor Actualizado.';
COMMENT ON COLUMN tbl_vmovimtpf.movi_mandato        IS 'Mandato.';

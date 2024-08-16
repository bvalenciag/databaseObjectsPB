prompt
prompt VIEW: TBL_VSALDOS_GENLIQUIDEZ
prompt
CREATE OR REPLACE FORCE VIEW tbl_vsaldos_genliquidez
    (
    empr_empr
    , empr_externo
    , empr_descripcion
    , cuen_banc
    , banc_externo
    , banc_descripcion
    , sald_fecha
    , cuen_tasa_ea
    , sald_vlr
    , canc_vlr
    , regi_vlr
    , motp_mesa
    , sald_fin
    )
AS
SELECT
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       21/12/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
     empr_empr
    ,empr_externo
    ,empr_descripcion
    ,cuen_banc
    ,banc_externo
    ,banc_descripcion
    ,sald_fecha
    ,TO_CHAR(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0), '9999.99') || '%' CUEN_TASA_EA
    ,tbl_qgeneral.fn_sald_ini(empr_empr,cuen_banc,null,sald_fecha)     sald_vlr
    ,tbl_qgeneral.fn_val_canc(empr_empr,cuen_banc,null,sald_fecha)     canc_vlr
    ,tbl_qgeneral.fn_val_regi(empr_empr,cuen_banc,null,sald_fecha)    regi_vlr
    ,tbl_qgeneral.fn_val_mesa(empr_empr,cuen_banc,null,sald_fecha)    motp_mesa
    ,tbl_qgeneral.fn_sald_fin(empr_empr,cuen_banc, sald_fecha)        sald_fin
FROM
      TBL_TSALDOS_CTA
    , TBL_TCUENTASBAN
    , TBL_TEMPRESAS
    , tbl_tbancos
    , tbl_tbanxempres
where sald_cuen = cuen_cuen
and cuen_empr = empr_empr
and cuen_banc = banc_banc
and banx_empr = empr_empr
and banx_banc = banc_banc
and banx_sincroniza = 'S'
and empr_sincroniza = 'S'
and cuen_sincroniza = 'S'
group by empr_externo,empr_empr, empr_descripcion,banc_externo,cuen_banc,banc_descripcion,sald_fecha
/
--
COMMENT ON TABLE  tbl_vsaldos_genliquidez                     IS 'Vista general tablero de liquidez';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.empr_empr           IS 'Código empresa sistema EDGE';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.empr_externo        IS 'Código empresa sistema externo';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.empr_descripcion    IS 'Descripción empresa externo';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.cuen_banc           IS 'Código del banco sistema EDGE';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.banc_externo        IS 'Código banco sistema externo';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.banc_descripcion    IS 'Descripción banco externo';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.sald_fecha          IS 'Fecha';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.cuen_tasa_ea        IS 'Valor Tasa EA';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.sald_vlr            IS 'Valor calculado de saldos cuenta';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.canc_vlr            IS 'Valor calculado de vista de cancelacio';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.regi_vlr            IS 'Valor calculado de vista de regionales';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.motp_mesa           IS 'Valor calculado de la vista motporfin';
COMMENT ON COLUMN tbl_vsaldos_genliquidez.sald_fin            IS 'Valor calculado de las operaciónes de las columnas de valor calculado';
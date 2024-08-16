prompt
prompt VIEW: TBL_VCUENTASBANRENT
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcuentasbanrent
    (
     empr_empr
    ,empr_descripcion
    ,cuen_banc
    ,banc_descripcion
    ,sald_fecha
    ,sald
    ,sld_min
    ,total_banc
    ,cuen_tasa_ea
    ,sald_dia
    ,rent_ajus
    ,variacion
    ,interes_np
    ,dv1
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
-- 1000       04/01/2024 Jmartinezm    00001       * Se crea vista.
--                       Kilonova       MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
     empr_empr
    ,empr_descripcion
    ,cuen_banc
    ,banc_descripcion
    ,sald_fecha
    ,tbl_qgeneral.fn_sald_fin(empr_empr,cuen_banc, sald_fecha)        sald
    ,NVL(sum(cuen_sldmincor),0) sld_min
    ,tbl_qgeneral.fn_sald_fin_rent(empr_empr,cuen_banc, sald_fecha) total_banc
    ,TO_CHAR(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0), '9999.99') || '%' CUEN_TASA_EA
    ,tbl_qgeneral.fn_sald_fin(empr_empr,cuen_banc, sald_fecha)        sald_dia
    , TO_CHAR(ROUND (
      (NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0) * tbl_qgeneral.fn_sald_fin_rent(empr_empr,cuen_banc, sald_fecha))/
      NULLIF(tbl_qgeneral.fn_sald_fin(empr_empr,cuen_banc, sald_fecha),0),2),'9999.99') || '%' rent_ajus
    , TO_CHAR(ROUND(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0) -
      (NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0) * tbl_qgeneral.fn_sald_fin_rent(empr_empr,cuen_banc, sald_fecha))/
      NULLIF(tbl_qgeneral.fn_sald_fin(empr_empr,cuen_banc, sald_fecha),0),2),'9999.99')||'%' variacion
    , ROUND(
    (TBL_QGENERAL.fn_tasa_365(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0))/365) * NVL(sum(cuen_sldmincor),0),2) interes_np
    , ROUND(((NVL(sum(cuen_sldmincor),0)*(TBL_QGENERAL.fn_tasa_365(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0))/365)) *  tbl_qgeneral.fn_codi_cond('DV1')  ) / 1000000,2) dv1
FROM
      TBL_TSALDOS_CTA
    , TBL_TCUENTASBAN
    , TBL_TEMPRESAS
    , tbl_tbancos
where sald_cuen = cuen_cuen
AND cuen_empr = empr_empr
and cuen_banc = banc_banc
and empr_sincroniza = 'S'
group by empr_empr
    ,empr_descripcion
    ,cuen_banc
    ,banc_descripcion
    ,sald_fecha
/
--
COMMENT ON TABLE  tbl_vcuentasbanrent                         IS 'Vista para mostrar el resumen de las rentabilidades';
COMMENT ON COLUMN tbl_vcuentasbanrent.empr_empr               IS 'Código de la empresa EDGE';
COMMENT ON COLUMN tbl_vcuentasbanrent.empr_descripcion        IS 'Descripción de la empresa';
COMMENT ON COLUMN tbl_vcuentasbanrent.cuen_banc               IS 'Código del banco EDGE';
COMMENT ON COLUMN tbl_vcuentasbanrent.banc_descripcion        IS 'Descripción del banco';
COMMENT ON COLUMN tbl_vcuentasbanrent.sald_fecha              IS 'Fecha';
COMMENT ON COLUMN tbl_vcuentasbanrent.sald                    IS 'Saldo Final';
COMMENT ON COLUMN tbl_vcuentasbanrent.sld_min                 IS 'Saldo minimo cuenta corriente';
COMMENT ON COLUMN tbl_vcuentasbanrent.total_banc              IS 'Saldo final rentabilidad';
COMMENT ON COLUMN tbl_vcuentasbanrent.cuen_tasa_ea            IS 'Tasa EA';
COMMENT ON COLUMN tbl_vcuentasbanrent.sald_dia                IS 'Saldo día';
COMMENT ON COLUMN tbl_vcuentasbanrent.rent_ajus               IS 'Rentabilidad Ajustada';
COMMENT ON COLUMN tbl_vcuentasbanrent.variacion               IS 'Variación';
COMMENT ON COLUMN tbl_vcuentasbanrent.interes_np              IS 'Interes no percibido';
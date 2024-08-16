prompt
prompt VIEW: TBL_VCUENTASBAN_DETALLE
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcuentasban_detalle
    (
      empr_empr
    , detalle  
    , empr_externo
    , empr_descripcion
    , empr_fond
    , banc_banc
    , banc_externo
    , banc_descripcion
    , sald_fecha
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
-- 1000       16/04/2024 Jmartinezm    000001       * Se crea vista.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       12/07/2024 Jmartinezm    000001       * Se agrega condicional.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
  empr.empr_empr
    , empr.empr_empr AS detalle
    , empr.empr_externo
    , empr.empr_descripcion
    , DECODE(empr.empr_fond, null, 'OTROS NEGOCIOS', 'FONDOS DE INVERSION') empr_fond
    , banc.banc_banc
    , banc.banc_externo
    , banc.banc_descripcion
    , sald.sald_fecha
  FROM tbl_tempresas empr
    , tbl_tcuentasban cuen
    , tbl_tbancos banc
    , TBL_TSALDOS_CTA sald
    , tbl_tbanxempres banx
     WHERE cuen.cuen_empr = empr.empr_empr
       AND cuen.cuen_banc = banc.banc_banc
       AND cuen.cuen_cuen = sald.sald_cuen(+)
       AND banx.banx_empr = empr.empr_empr
       AND banx.banx_banc = banc_banc
       AND banx.banx_sincroniza = 'S'
       AND cuen.cuen_sincroniza = 'S'
       AND empr.empr_sincroniza = 'S' 
       AND (
       (empr.empr_fond is null and empr.empr_externo = 1)
       OR (empr.empr_fond is not null)
       ) -- 1001       12/07/2024 Jmartinezm 
GROUP BY empr.EMPR_EMPR
       , empr.EMPR_EXTERNO
       , empr.EMPR_DESCRIPCION
       , empr.empr_fond
       , banc.BANC_BANC
       , banc.BANC_EXTERNO
       , banc.BANC_DESCRIPCION
       , sald.sald_fecha
/
--
COMMENT ON TABLE  tbl_vcuentasban_detalle                           IS 'Vista que visualiza el detalle de cuentas bancaria por empresa';
COMMENT ON COLUMN tbl_vcuentasban_detalle.empr_empr                 IS 'Código Empresa Edge';
COMMENT ON COLUMN tbl_vcuentasban_detalle.detalle                   IS 'Código Empresa Edge';
COMMENT ON COLUMN tbl_vcuentasban_detalle.empr_externo              IS 'Código Empresa Externo';
COMMENT ON COLUMN tbl_vcuentasban_detalle.empr_descripcion          IS 'Descripción de empresa';
COMMENT ON COLUMN tbl_vcuentasban_detalle.empr_fond                 IS 'Fondo asociado a la empresa';
COMMENT ON COLUMN tbl_vcuentasban_detalle.banc_banc                 IS 'Código Banco Edge';
COMMENT ON COLUMN tbl_vcuentasban_detalle.banc_externo              IS 'Código Banco Externo';
COMMENT ON COLUMN tbl_vcuentasban_detalle.banc_descripcion          IS 'Descripción Banco';
COMMENT ON COLUMN tbl_vcuentasban_detalle.sald_fecha                IS 'Fecha del saldo';
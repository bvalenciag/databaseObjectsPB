prompt
prompt VIEW: TBL_VCUENTASBANEMPR
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcuentasbanempr
    (
      empr_empr
    , detalle  
    , empr_externo
    , empr_descripcion
    , empr_fond
    , banc_banc
    , banc_externo
    , banc_descripcion
    , tasa_ea    
    , movi_sald
    , sald_fecha
    )
AS
SELECT
--
-- #VERSION: 1003
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       21/11/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       03/01/2024 Jmartinezm    00001       * Ajustes de funciones.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       20/02/2024 Jmartinezm    00002       * Agregar columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1003       09/04/2024 Jmartinezm   00003       * Ajuste a vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
  /*
  Antes 1003 Jmartinezm 09/04/2024
  EMPR_EMPR,
  EMPR_EMPR AS DETALLE,
  EMPR_EXTERNO,
  EMPR_DESCRIPCION,
  DECODE(empr_fond, null, 'OTROS NEGOCIOS', 'FONDOS DE INVERSION') empr_fond, --1002       20/02/2024 Jmartinezm
  BANC_BANC,
  BANC_EXTERNO,
  BANC_DESCRIPCION,
  TO_CHAR(NVL(tbl_qgeneral.fn_banc_rentabilidad(EMPR_EMPR, BANC_BANC, sald_fecha),0.0), '9999.99') || '%' AS TASA_EA,
  --(SUM(NVL(SALD_VALOR_ACT, SALD_VALOR))) + NVL(tbl_qgeneral.fn_movi_dia(banc_banc, EMPR_EMPR, null, sald_fecha),0) MOVI_SALD --Antes 1001 03/01/2024 jmartinezm
  tbl_qgeneral.fn_sald_fin(empr_empr,banc_banc,sald_fecha) MOVI_SALD,--1001 03/01/2024 jmartinezm
  sald_fecha
FROM
  tbl_tempresas,
  tbl_tcuentasban,
  tbl_tbancos,
  TBL_TSALDOS_CTA,
  tbl_tbanxempres--1001 03/01/2024 jmartinezm
WHERE
  cuen_empr = empr_empr
  AND cuen_banc = banc_banc
  AND cuen_cuen = sald_cuen(+)
  AND banx_empr = empr_empr--1001 03/01/2024 jmartinezm
  AND banx_banc = banc_banc--1001 03/01/2024 jmartinezm
  AND banx_sincroniza = 'S'--1001 03/01/2024 jmartinezm
  AND cuen_sincroniza = 'S'
  AND empr_sincroniza = 'S'
GROUP BY
  EMPR_EMPR,
  EMPR_EXTERNO,
  EMPR_DESCRIPCION,
  empr_fond,
  BANC_BANC,
  BANC_EXTERNO,
  BANC_DESCRIPCION,
  tbl_qgeneral.fn_banc_rentabilidad(EMPR_EMPR, BANC_BANC, SALD_FECHA),
  sald_fecha
ORDER BY
  EMPR_EXTERNO, BANC_EXTERNO
  Antes 1003 Jmartinezm 09/04/2024
  */
  --Ini 1003 Jmartinezm 09/04/2024
      EMPR_EMPR
    , DETALLE
    , EMPR_EXTERNO
    , EMPR_DESCRIPCION
    , empr_fond
    , BANC_BANC
    , BANC_EXTERNO
    , BANC_DESCRIPCION
    , TO_CHAR(NVL(tbl_qgeneral.fn_banc_rentabilidad(EMPR_EMPR, BANC_BANC, sald_fecha),0), '9999.99') || '%' AS TASA_EA
    , tbl_qgeneral.fn_sald_fin(empr_empr,banc_banc,sald_fecha) MOVI_SALD
    , sald_fecha
FROM tbl_vcuentasban_detalle
ORDER BY
  EMPR_EXTERNO, BANC_EXTERNO
--Fin 1003 Jmartinezm 09/04/2024
/
--
COMMENT ON TABLE  tbl_vcuentasbanempr                     IS 'Vista que permite visualizar los saldos generales de las empresa';
COMMENT ON COLUMN tbl_vcuentasbanempr.empr_empr           IS 'Identificador interno de la empresa';
COMMENT ON COLUMN tbl_vcuentasbanempr.empr_externo        IS 'Identificador externo de la empresa';
COMMENT ON COLUMN tbl_vcuentasbanempr.empr_descripcion    IS 'Nombre de la empresa';
COMMENT ON COLUMN tbl_vcuentasbanempr.empr_fond           IS 'Fondo Empresa';
COMMENT ON COLUMN tbl_vcuentasbanempr.banc_banc           IS 'Identificador interno del banco';
COMMENT ON COLUMN tbl_vcuentasbanempr.banc_externo        IS 'Identificador externo del banco';
COMMENT ON COLUMN tbl_vcuentasbanempr.banc_descripcion    IS 'Nombre del Banco';
COMMENT ON COLUMN tbl_vcuentasbanempr.movi_sald           IS 'Saldo de la cuenta ';
COMMENT ON COLUMN tbl_vcuentasbanempr.tasa_ea             IS 'Funcion que calcula la Rentabilidad';
prompt
prompt VIEW: TBL_VCUENTASBAN
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcuentasban
    (
      CUEN_NROCTA
    , CUEN_DESCRIPCION
    , CUEN_TIPO
    , CUEN_TASA_EA
    , MOVI_SALD
    , CUEN_BANC
    , SALD_FECHA
    , EMPR_DESCRIPCION
    , BANC_DESCRIPCION
    , EMPR_EMPR
    , CUEN_CUEN
    )
AS
SELECT
--
-- #VERSION: 1001
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/11/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       30/12/2023 Jmartinezm    00001       * Ajustes de columnas.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
  CUEN_NROCTA
, CUEN_DESCRIPCION
, DECODE(CUEN_TIPO, 'CH', 'Ahorro'
                  , 'CC', 'Corriente'
                  , CUEN_TIPO
                    )CUEN_TIPO
, TO_CHAR(NVL(tbl_qgeneral.fn_banc_rentabilidad(CUEN_EMPR, cuen_banc, sald_fecha) ,0.0), '9999.99') || '%' CUEN_TASA_EA
, tbl_qgeneral.fn_sald_ini(CUEN_EMPR,cuen_banc,cuen_cuen,sald_fecha)    movi_sald
, CUEN_BANC
, SALD_FECHA
, EMPR_DESCRIPCION
, BANC_DESCRIPCION
, CUEN_EMPR
, CUEN_CUEN
from TBL_TSALDOS_CTA
, TBL_TCUENTASBAN
, TBL_TBANCOS
, TBL_TEMPRESAS
, tbl_tbanxempres--1001       30/12/2023 Jmartinezm 
where SALD_CUEN = cuen_cuen
AND CUEN_SINCRONIZA = 'S'
AND EMPR_SINCRONIZA = 'S'
AND banx_sincroniza = 'S'--1001       30/12/2023 Jmartinezm 
AND banx_empr = empr_empr--1001       30/12/2023 Jmartinezm 
AND banx_banc = banc_banc--1001       30/12/2023 Jmartinezm 
AND CUEN_BANC = BANC_BANC
AND CUEN_EMPR = EMPR_EMPR
/* antes 1001       30/12/2023 Jmartinezm 
order by CUEN_CUEN
, EMPR_EXTERNO
, BANC_EXTERNO
, CUEN_NROCTA
*/
--ini 1001       30/12/2023 Jmartinezm 
UNION ALL
select 
  '99999999' cuen_nrocta
, 'CUENTA COMODIN' cuen_descripcion
, 'Ahorro' cuen_tipo
, TO_CHAR(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0), '9999.99') || '%' CUEN_TASA_EA
, motp_mesa + regi_vlr movi_sald
, cuen_banc
, sald_fecha
, EMPR_DESCRIPCION
, banc_descripcion
, empr_empr
, 0
from tbl_vsaldos_genliquidez
, TBL_TBANXEMPRES
WHERE BANX_banc = cuen_banc
AND banx_empr = empr_empr
--fin 1001       30/12/2023 Jmartinezm 
/
--
COMMENT ON TABLE  tbl_vcuentasban                         IS 'Vista que muestra las cuentas y movimientos de acuerdo a el banco y empresa';
COMMENT ON COLUMN tbl_vcuentasban.cuen_nrocta             IS 'Numero de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasban.cuen_descripcion        IS 'Descripción de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasban.cuen_tipo               IS 'Tipo de cuenta de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasban.cuen_tasa_ea            IS 'Porcentaje de rentabilidad de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasban.movi_sald               IS 'Saldo del movimiento bancario';
COMMENT ON COLUMN tbl_vcuentasban.cuen_banc               IS 'Id del banco que se relaciona con la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasban.sald_fecha              IS 'Fecha del saldo';
COMMENT ON COLUMN tbl_vcuentasban.empr_descripcion        IS 'Descripción de la empresa';
COMMENT ON COLUMN tbl_vcuentasban.banc_descripcion        IS 'Descripción del banco';
COMMENT ON COLUMN tbl_vcuentasban.empr_empr               IS 'Id de la empresa EDGE';
COMMENT ON COLUMN tbl_vcuentasban.cuen_cuen               IS 'Id de la cuenta EDGE';

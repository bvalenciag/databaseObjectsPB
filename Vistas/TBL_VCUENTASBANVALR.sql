prompt
prompt VIEW: TBL_VCUENTASBANVALR
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcuentasbanvalr
    (
    empr_empr
    , banc_banc
    , cuen_banc
    , banc_descripcion
    , cuen_nrocta
    , cuen_descripcion
    , empr_descripcion
    , infb_nit
    , cuen_tasa_ea
    , sald_act
    , sald_fecha
    , cuen_tasa_365
    , rendimiento 
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
-- 1000       03/01/2024 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       15/02/2024 Jmartinezm    00002       * Agrega columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       20/02/2024 Jmartinezm    00003       * Ajuste de vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- ini 1002       20/02/2024 Jmartinezm 
    empr_empr
    , banc_banc
    , cuen_banc --fin 1002       20/02/2024 Jmartinezm
    , banc_descripcion
    , cuen_nrocta
    , cuen_descripcion
    , empr_descripcion
    , (select infb_nit from tbl_tinfbancos where infb_banc = banc_banc) infb_nit --1001       15/02/2024 Jmartinezm
    , TO_CHAR(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0), '9999.99') || '%' CUEN_TASA_EA
    , sum(tbl_qgeneral.fn_sald_fin_rent(empr_empr, banc_banc, sald_fecha)) sald_act
    , sald_fecha
    , TO_CHAR(NVL(tbl_qgeneral.fn_tasa_365(NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0)), 0.0),'9999.99') || '%' cuen_tasa_365
    , ROUND(sum(tbl_qgeneral.fn_val_rendi(tbl_qgeneral.fn_sald_fin_rent(empr_empr, banc_banc, sald_fecha),
        (NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha), 0.0)))/100),0) rendimiento -- 1002       20/02/2024 Jmartinezm  
    /*, sum(tbl_qgeneral.fn_val_rendi(tbl_qgeneral.fn_sald_fin_rent(empr_empr, banc_banc, sald_fecha),
        (NVL(tbl_qgeneral.fn_banc_rentabilidad(empr_empr, cuen_banc, sald_fecha) ,0.0)/100))/36500) rendimiento  antes  1002       20/02/2024 Jmartinezm */
from  TBL_TSALDOS_CTA
    , TBL_TCUENTASBAN
    , TBL_TEMPRESAS
    , tbl_tbancos
    , tbl_tbanxempres --1002       20/02/2024 Jmartinezm
where sald_cuen = cuen_cuen
AND cuen_empr = empr_empr
and cuen_banc = banc_banc
and empr_sincroniza = 'S'
and cuen_sincroniza = 'S' 
and banx_sincroniza = 'S' -- ini 1002       20/02/2024 Jmartinezm
and banx_empr = empr_empr
and banx_banc = banc_banc
and cuen_tasa_ea is not null  
group by
empr_empr
,banc_banc
,cuen_banc
,banc_descripcion
,cuen_nrocta
,cuen_descripcion
,empr_descripcion
,sald_fecha --fin 1002       20/02/2024 Jmartinezm
/
--
COMMENT ON TABLE  tbl_vcuentasbanvalr                           IS 'Vista que ayuda a visualizar la Valorización de cuentas bancarias';
COMMENT ON COLUMN tbl_vcuentasbanvalr.empr_empr                 IS 'Código EDGE de empresa';
COMMENT ON COLUMN tbl_vcuentasbanvalr.banc_banc                 IS 'Código EDGE de banco';
COMMENT ON COLUMN tbl_vcuentasbanvalr.banc_descripcion          IS 'Descripción del banco';
COMMENT ON COLUMN tbl_vcuentasbanvalr.cuen_nrocta               IS 'Numero de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasbanvalr.infb_nit                  IS 'NIT';
COMMENT ON COLUMN tbl_vcuentasbanvalr.cuen_tasa_ea              IS 'Tasa EA';
COMMENT ON COLUMN tbl_vcuentasbanvalr.sald_act                  IS 'Calculo de Saldo Inicial +/- regionales +/- operaciones mesa - saldo en cuentas corrientes';
COMMENT ON COLUMN tbl_vcuentasbanvalr.sald_fecha                IS 'Fecha';
COMMENT ON COLUMN tbl_vcuentasbanvalr.cuen_tasa_365             IS 'Calculo realizado con el valor de Tasa EA';
COMMENT ON COLUMN tbl_vcuentasbanvalr.rendimiento               IS 'Calculo realizado entre Sald_act y tasa_365';
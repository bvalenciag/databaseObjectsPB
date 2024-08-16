prompt
prompt VIEW: TBL_VCANCELACIO
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcancelacio
    (
      canc_canc
    , canc_canc_ex
    , canc_fond_ex
    , canc_empr_ex
    , canc_empr
    , empr_descripcion
    , canc_banc_ex
    , banc_banc
    , banc_descripcion
    , canc_banc
    , canc_fecha
    , canc_plan
    , canc_desc_plan
    , canc_vlr_canc
    , canc_vlr_ajus
    , canc_vlr_gmf
    , canc_vlr_giro
    , canc_fuente
    , canc_stat_ex
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
-- 1000       18/12/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       11/04/2024 Jmartinezm    00002       * Se agrega columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
      canc_canc
    , canc_canc_ex
    , canc_fond_ex
    , canc_empr_ex
    , canc_empr
    , empr_descripcion
    , canc_banc_ex
    , tbl_qgeneral.fn_codi_cond('CANCE')  canc_banc
    , banc_descripcion
    , canc_banc
    , canc_fecha
    , canc_plan
    , canc_desc_plan
    , canc_vlr_canc
    , canc_vlr_ajus
    , NVL(canc_vlr_gmf,0)                      canc_vlr_gmf
    , (canc_vlr_canc - NVL(canc_vlr_gmf,0))    canc_vlr_giro
    , canc_fuente
    , decode(canc_stat_ex, 'P', 'Procesado','Insertado') canc_stat_ex -- 1001       11/04/2024 Jmartinezm
from tbl_tcancelacio
 , tbl_tbancos
 , tbl_tempresas
 where canc_empr = empr_empr
 and tbl_qgeneral.fn_codi_cond('CANCE') = banc_banc
/
--
COMMENT ON TABLE  tbl_vcancelacio                         IS 'Vista que permite visualizar las cancelasciones progarmadas';
COMMENT ON COLUMN tbl_vcancelacio.canc_canc               IS 'Secuencial y llave primaria de la tabla';
COMMENT ON COLUMN tbl_vcancelacio.canc_canc_ex            IS 'Código cancelación externo';
COMMENT ON COLUMN tbl_vcancelacio.canc_fond_ex            IS 'Código fondo externo';
COMMENT ON COLUMN tbl_vcancelacio.canc_empr_ex            IS 'Código empresa externo';
COMMENT ON COLUMN tbl_vcancelacio.canc_empr               IS 'Código empresa interno';
COMMENT ON COLUMN tbl_vcancelacio.empr_descripcion        IS 'Descripción de la empresa';
COMMENT ON COLUMN tbl_vcancelacio.canc_banc_ex            IS 'Código banco externo';
COMMENT ON COLUMN tbl_vcancelacio.banc_banc               IS 'Código del banco seleccionado de la tabla TBL_TDISTMOVI';
COMMENT ON COLUMN tbl_vcancelacio.banc_descripcion        IS 'Descripción del banco';
COMMENT ON COLUMN tbl_vcancelacio.canc_banc               IS 'Código banco interno';
COMMENT ON COLUMN tbl_vcancelacio.canc_fecha              IS 'Fecha';
COMMENT ON COLUMN tbl_vcancelacio.canc_plan               IS 'Código encargo/plan';
COMMENT ON COLUMN tbl_vcancelacio.canc_desc_plan          IS 'Descripción encargo/plan';
COMMENT ON COLUMN tbl_vcancelacio.canc_vlr_canc           IS 'Valor cancelación';
COMMENT ON COLUMN tbl_vcancelacio.canc_vlr_ajus           IS 'Valor ajustado';
COMMENT ON COLUMN tbl_vcancelacio.canc_vlr_gmf            IS 'Valor Gmf';
COMMENT ON COLUMN tbl_vcancelacio.canc_vlr_giro           IS 'Valor calculado de la resta del Valor cancelación y Valor Gmf';
COMMENT ON COLUMN tbl_vcancelacio.canc_fuente             IS 'Fuente información';
COMMENT ON COLUMN tbl_vcancelacio.canc_stat_ex            IS 'Estado';
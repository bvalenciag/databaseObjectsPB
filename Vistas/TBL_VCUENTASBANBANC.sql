prompt
prompt VIEW: TBL_VCUENTASBANBANC
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcuentasbanbanc
    (
      empr_fond
    , banc_descripcion
    , tasa_ea
    , movi_sald
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
-- 1000       22/02/2024 Jmartinezm    000001       * Se crea vista.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
      empr_fond
    , banc_descripcion
    , max(tasa_ea) tasa_ea 
    , sum(movi_sald) movi_sald
    , sald_fecha
from tbl_vcuentasbanempr v
group by empr_fond,
banc_descripcion
, banc_banc
, sald_fecha
/
--
COMMENT ON TABLE  tbl_vcuentasbanbanc                           IS 'Vista que permite visualizar los saldos generales de los bancos ';
COMMENT ON COLUMN tbl_vcuentasbanbanc.empr_fond                 IS 'Fondos';
COMMENT ON COLUMN tbl_vcuentasbanbanc.banc_descripcion          IS 'Descripción del banco';
COMMENT ON COLUMN tbl_vcuentasbanbanc.tasa_ea                   IS 'Tasa EA';
COMMENT ON COLUMN tbl_vcuentasbanbanc.movi_sald                 IS 'Saldo';
COMMENT ON COLUMN tbl_vcuentasbanbanc.sald_fecha                IS 'Fecha';
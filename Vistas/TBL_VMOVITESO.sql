prompt
prompt VIEW: TBL_VMOVITESO
prompt
CREATE OR REPLACE FORCE VIEW tbl_vmoviteso
    (
      MOVI_CUEN
    , empr_empr
    , empr_externo
    , empr_descripcion
    , banc_banc
    , banc_externo
    , banc_descripcion
    , cuen_nrocta
    , cuen_descripcion
    , movi_encargo
    , movi_fuente
    , movi_tipo_oper
    , movi_valor
    , MOVI_FECHA
    , CUEN_CUEN
    , cuen_sebra
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
-- 1000       15/11/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       02/01/2024 Jmartinezm    00001       * Se ajusta la vista.
--                       Kilonova      MVP2 
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       30/04/2024 Jmartinezm    00002       * Se ajusta la vista.
--                       Kilonova      MVP2 
-- ========== ========== ============ ============ ============================================================================================================
--
  MOVI_CUEN
, empr_empr
, empr_externo
, empr_descripcion
, banc_banc
, banc_externo
, banc_descripcion
, cuen_nrocta
, cuen_descripcion-- 1001 Jmartinezm 02/01/2024
, movi_encargo
, gen_qgeneral.id_lista_desc(movi_fuente) movi_fuente
, movi_tipo_oper
, movi_valor
, MOVI_FECHA
, CUEN_CUEN
, cuen_sebra -- 1002 30/04/2024 Jmartinezm 
from tbl_tmoviteso
, tbl_tcuentasban
, tbl_tempresas
, tbl_tbancos
where cuen_cuen = movi_cuen
and cuen_empr = empr_empr
and cuen_banc = banc_banc
and cuen_sincroniza = 'S'
and empr_sincroniza = 'S'
/
--
COMMENT ON TABLE  tbl_vmoviteso                        IS 'Vista que permite mostrar los movimientos';
COMMENT ON COLUMN tbl_vmoviteso.MOVI_CUEN              IS 'Cuenta del movimiento';
COMMENT ON COLUMN tbl_vmoviteso.empr_empr              IS 'Id de la empresa que tiene este movimiento';
COMMENT ON COLUMN tbl_vmoviteso.empr_externo           IS 'Id de la empresa externa que tiene este movimiento';
COMMENT ON COLUMN tbl_vmoviteso.empr_descripcion       IS 'Nombre de la empresa que tiene este movimiento';
COMMENT ON COLUMN tbl_vmoviteso.banc_banc              IS 'Id del banco que tiene el movimiento';
COMMENT ON COLUMN tbl_vmoviteso.banc_externo           IS 'Id del banco externo que tiene el movimiento';
COMMENT ON COLUMN tbl_vmoviteso.banc_descripcion       IS 'descripción del banco que tiene el movimiento';
COMMENT ON COLUMN tbl_vmoviteso.cuen_nrocta            IS 'Numero de cuenta bancaria que tiene el movimiento';
COMMENT ON COLUMN tbl_vmoviteso.cuen_descripcion       IS 'Descripción de cuenta bancaria que tiene el movimiento';
COMMENT ON COLUMN tbl_vmoviteso.movi_encargo           IS 'Encargo del movimiento';
COMMENT ON COLUMN tbl_vmoviteso.movi_fuente            IS 'Fuente de donde se realizo el movimiento';
COMMENT ON COLUMN tbl_vmoviteso.movi_tipo_oper         IS 'Tipo de operación del movimiento';
COMMENT ON COLUMN tbl_vmoviteso.movi_valor             IS 'Valor del movimiento';
COMMENT ON COLUMN tbl_vmoviteso.MOVI_FECHA             IS 'Fecha en que se reliazo el movimiento';
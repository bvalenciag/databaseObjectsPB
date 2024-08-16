prompt
prompt VIEW: TBL_VTRASEBRA
prompt
CREATE OR REPLACE FORCE VIEW tbl_vtrasebra
    (
      tras_tras
    , tras_empr
    , empr_descripcion
    , tras_banc
    , banc_descripcion
    , tras_cuen
    , cuen_nrocta
    , cuen_cta_cud
    , cuen_tipo_oper
    , tras_esta
    , tras_valor
    , tras_fecha
    , tras_impreso
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
-- 1000       16/01/2024 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       22/01/2024 Jmartinezm    00002       * Ajuste de columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       21/02/2024 Jmartinezm    00003       * Ajuste de columna.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1003       12/04/2024 Jmartinezm    00004       * Ajuste de vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
      tras_tras
    , tras_empr
    , empr_descripcion
    , tras_banc
    , banc_descripcion
    , tras_cuen
    , cb.cuen_nrocta
    --, (select cuen_nrocta from tbl_tcuentasban where cuen_cuen = cb.cuen_cta_cud)cuen_cta_cud antes 1003       12/04/2024 Jmartinezm
    , infb_cuen_cud_cod cuen_cta_cud -- 1003       12/04/2024 Jmartinezm
    , list_descri cuen_tipo_oper
    , esta_descri tras_esta
    , tras_valor
    --, tras_fecins 1000       16/01/2024 Jmartinezm 
    , tras_fecha -- 1001       22/01/2024 Jmartinezm   
    , (select esta_descri from gen_testados where esta_esta = tras_impreso)tras_impreso -- 1002       21/02/2024 Jmartinezm 
from tbl_ttrasebra
    ,tbl_tempresas
    ,tbl_tbancos
    ,tbl_tcuentasban cb
    ,gen_tlistas
    ,gen_testados
    ,tbl_tinfbancos -- 1003       12/04/2024 Jmartinezm
where tras_empr = empr_empr
and   tras_banc = banc_banc
and   tras_cuen = cb.cuen_cuen
and   list_list = tras_tipo_oper
and   esta_esta = tras_esta
and   infb_banc = banc_banc -- 1003       12/04/2024 Jmartinezm
/
--
COMMENT ON TABLE  tbl_vtrasebra                     IS 'Vista que ayuda a visualizar los traslados de sebre';
COMMENT ON COLUMN tbl_vtrasebra.tras_tras           IS 'Secuencial y llave primaria de la tabla';
COMMENT ON COLUMN tbl_vtrasebra.tras_empr           IS 'Código empresa';
COMMENT ON COLUMN tbl_vtrasebra.tras_banc           IS 'Código banco';
COMMENT ON COLUMN tbl_vtrasebra.tras_cuen           IS 'Codigo cuenta';
COMMENT ON COLUMN tbl_vtrasebra.cuen_nrocta         IS 'Número de cuenta bancaria';
COMMENT ON COLUMN tbl_vtrasebra.cuen_cta_cud        IS 'Cuenta CUD';
COMMENT ON COLUMN tbl_vtrasebra.cuen_tipo_oper      IS 'Tipo de operación';
COMMENT ON COLUMN tbl_vtrasebra.tras_esta           IS 'Estado del traslado';
COMMENT ON COLUMN tbl_vtrasebra.tras_valor          IS 'Valor traslado';
COMMENT ON COLUMN tbl_vtrasebra.tras_fecha          IS 'Fecha';
COMMENT ON COLUMN tbl_vtrasebra.tras_impreso        IS 'Impreso';
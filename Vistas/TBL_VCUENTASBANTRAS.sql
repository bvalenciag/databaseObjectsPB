prompt
prompt VIEW: TBL_VCUENTASBANTRAS
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcuentasbantras
    (
      empr_empr
    , empr_descripcion
    , banc_banc
    , banc_descripcion
    , cuen_cuen
    , cuen_nrocta
    , cuen_descripcion
    , cuen_tipo_oper
    , cuen_cta_cud
    , cuen_cta_cud_descri
    , list_descri
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
-- 1000       10/01/2024 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1001       22/01/2024 Jmartinezm    00002       * Agrega nuevas columnas
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
-- 1002       12/04/2024 Jmartinezm    00003       * Ajuste vistas
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
      empr_empr
    , empr_descripcion
    , banc_banc
    , banc_descripcion
    , cb.cuen_cuen
    , cb.cuen_nrocta
    , cb.cuen_descripcion --1001       22/01/2024 Jmartinezm 
    , cb.cuen_tipo_oper
    --, (select cuen_nrocta from tbl_tcuentasban where cuen_cuen = cb.cuen_cta_cud)cuen_cta_cud   antes 1002       12/04/2024 Jmartinezm 
    --, (select cuen_descripcion from tbl_tcuentasban where cuen_cuen = cb.cuen_cta_cud)cuen_cta_cud_descri antes  1002       12/04/2024 Jmartinezm 
    , infb_cuen_cud_cod  cuen_cta_cud         -- 1002       12/04/2024 Jmartinezm 
    , infb_cuen_cud_desc  cuen_cta_cud_descri -- 1002       12/04/2024 Jmartinezm 
    , list_descri
from tbl_tcuentasban cb
    ,tbl_tempresas
    ,tbl_tbancos
    ,gen_tlistas
    ,tbl_tinfbancos                           -- 1002       12/04/2024 Jmartinezm 
where cb.cuen_banc = banc_banc
 and cb.cuen_empr = empr_empr
 and list_list = cb.cuen_tipo_oper
 and infb_banc = banc_banc                   -- 1002       12/04/2024 Jmartinezm 
/
--
COMMENT ON TABLE  tbl_vcuentasbantras                     IS 'Vista que permite visualizar las cuentas bancarias para traslados';
COMMENT ON COLUMN tbl_vcuentasbantras.empr_empr           IS 'Código de empresa EDGE';
COMMENT ON COLUMN tbl_vcuentasbantras.empr_descripcion    IS 'Descripción de la empresa';
COMMENT ON COLUMN tbl_vcuentasbantras.banc_banc           IS 'Código de banco EDGE';
COMMENT ON COLUMN tbl_vcuentasbantras.banc_descripcion    IS 'Descripción del banco ';
COMMENT ON COLUMN tbl_vcuentasbantras.cuen_cuen           IS 'Código de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasbantras.cuen_nrocta         IS 'Numero de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasbantras.cuen_descripcion    IS 'Descripción de cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasbantras.cuen_tipo_oper      IS 'Tipo de operación de la cuenta bancaria';
COMMENT ON COLUMN tbl_vcuentasbantras.cuen_cta_cud        IS 'Cuenta CUD';
COMMENT ON COLUMN tbl_vcuentasbantras.cuen_cta_cud_descri IS 'Descripción de cuenta CUD';
COMMENT ON COLUMN tbl_vcuentasbantras.list_descri         IS 'Descripción de la operación';
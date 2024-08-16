prompt
prompt VIEW: TBL_VMOTBBIZA
prompt
CREATE OR REPLACE FORCE VIEW tbl_vmotbbiza
    (
      motb_motb
    , motb_caso
    , motb_empresa
    , motb_empr
    , motb_banco
    , motb_banc
    , motb_nrocta
    , motb_cuen
    , motb_fecha
    , motb_descripcion
    , motb_valor
    , motb_esta
    , motb_tipo_oper
    , motb_gmf
    , motb_fuente
    , motb_fecins
    , motb_usuains
    , motb_fecupd
    , motb_usuaupd
    , empr_descripcion
    , banc_descripcion
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
-- 1000       28/12/2023 Jmartinezm    00001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
      motb_motb
    , motb_caso
    , motb_empresa
    , motb_empr
    , motb_banco
    , motb_banc
    , motb_nrocta
    , motb_cuen
    , motb_fecha
    , motb_descripcion
    , motb_valor
    , motb_esta
    , motb_tipo_oper
    , motb_gmf
    , motb_fuente
    , motb_fecins
    , motb_usuains
    , motb_fecupd
    , motb_usuaupd
    , empr_descripcion
    , banc_descripcion
from  tbl_tmotbbiza
    , tbl_tempresas
    , tbl_tbancos
where motb_empr = empr_empr
and   motb_banc = banc_banc 
/
--
COMMENT ON TABLE  tbl_vmotbbiza                         IS 'Vista que ayuda a visualizar la operación del BIZAGI';
COMMENT ON COLUMN tbl_vmotbbiza.motb_motb               IS 'Secuencial y llave primaria de la tabla';
COMMENT ON COLUMN tbl_vmotbbiza.motb_caso               IS 'Número de caso en el aplicativo bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_empresa            IS 'Código de empresa enviado desde bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_empr               IS 'Código de empresa interno de EDGE';
COMMENT ON COLUMN tbl_vmotbbiza.motb_banco              IS 'Código de banco enviado desde bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_banc               IS 'Código de banco interno de EDGE';
COMMENT ON COLUMN tbl_vmotbbiza.motb_nrocta             IS 'Número de cuenta enviado desde bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_cuen               IS 'Código de cuenta, relación con la tabla tbl_tcuentasban';
COMMENT ON COLUMN tbl_vmotbbiza.motb_fecha              IS 'Fecha del movimiento enviado desde Bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_descripcion        IS 'Descripción enviada desde Bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_valor              IS 'Valor de movimiento enviado desde Bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_esta               IS 'Estado de movimiento enviado desde Bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_tipo_oper          IS 'Tipo de operación';
COMMENT ON COLUMN tbl_vmotbbiza.motb_gmf                IS 'Valor del GMF enviado desde Bizagi';
COMMENT ON COLUMN tbl_vmotbbiza.motb_fuente             IS 'Código de fuente, relación con la tabla gen_tlistas LIST_MODULO = TBL, LIST_LISTA = FUEN_INFO, LIST_SIGLA = B';
COMMENT ON COLUMN tbl_vmotbbiza.motb_fecins             IS 'Fecha en la que se realiza la inserción del registro';
COMMENT ON COLUMN tbl_vmotbbiza.motb_usuains            IS 'Usuario que realizo la inserción del registro';
COMMENT ON COLUMN tbl_vmotbbiza.motb_fecupd             IS 'Ultima fecha de actualización del registro';
COMMENT ON COLUMN tbl_vmotbbiza.motb_usuaupd            IS 'Ultimo usuario que actualizo el registro';
COMMENT ON COLUMN tbl_vmotbbiza.empr_descripcion        IS 'Descripción de la empresa';
COMMENT ON COLUMN tbl_vmotbbiza.banc_descripcion        IS 'Descripción del banco';

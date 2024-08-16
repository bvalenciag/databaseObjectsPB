--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/11/2023 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TMOTBBIZA
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tmotbbiza                                 IS 'Almacena los movimientos que llegan desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_motb                       IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_caso                       IS 'N�mero de caso en el aplicativo bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_empresa                    IS 'C�digo de empresa enviado desde bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_empr                       IS 'C�digo de empresa interno de EDGE.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_banco                      IS 'C�digo de banco enviado desde bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_banc                       IS 'C�digo de banco interno de EDGE.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_nrocta                     IS 'N�mero de cuenta enviado desde bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_cuen                       IS 'C�digo de cuenta, relaci�n con la tabla tbl_tcuentasban.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fecha                      IS 'Fecha del movimiento enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_descripcion                IS 'Descripci�n enviada desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_valor                      IS 'Valor de movimiento enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_esta                       IS 'Estado de movimiento enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_tipo_oper                  IS 'Tipo de operaci�n.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_gmf                        IS 'Valor del GMF enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fuente                     IS 'C�digo de fuente, relaci�n con la tabla gen_tlistas LIST_MODULO = TBL, LIST_LISTA = FUEN_INFO, LIST_SIGLA = BZ';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fecins                     IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_usuains                    IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fecupd                     IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_usuaupd                    IS 'Ultimo usuario que actualizo el registro.';
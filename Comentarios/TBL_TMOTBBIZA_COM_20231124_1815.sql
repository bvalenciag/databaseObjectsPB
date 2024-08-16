--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
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
COMMENT ON COLUMN tbl_tmotbbiza.motb_caso                       IS 'Número de caso en el aplicativo bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_empresa                    IS 'Código de empresa enviado desde bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_empr                       IS 'Código de empresa interno de EDGE.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_banco                      IS 'Código de banco enviado desde bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_banc                       IS 'Código de banco interno de EDGE.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_nrocta                     IS 'Número de cuenta enviado desde bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_cuen                       IS 'Código de cuenta, relación con la tabla tbl_tcuentasban.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fecha                      IS 'Fecha del movimiento enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_descripcion                IS 'Descripción enviada desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_valor                      IS 'Valor de movimiento enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_esta                       IS 'Estado de movimiento enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_tipo_oper                  IS 'Tipo de operación.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_gmf                        IS 'Valor del GMF enviado desde Bizagi.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fuente                     IS 'Código de fuente, relación con la tabla gen_tlistas LIST_MODULO = TBL, LIST_LISTA = FUEN_INFO, LIST_SIGLA = BZ';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fecins                     IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_usuains                    IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_fecupd                     IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tmotbbiza.motb_usuaupd                    IS 'Ultimo usuario que actualizo el registro.';
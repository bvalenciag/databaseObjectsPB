--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crean comentarios.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TINFBANCOS
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tinfbancos                                  IS 'Tabla que contiene la informaci�n de traslados bancarios';
COMMENT ON COLUMN tbl_tinfbancos.infb_infb                        IS 'Secuencial y llave primaria.';
COMMENT ON COLUMN tbl_tinfbancos.infb_banc                        IS 'C�digo de banco.';
COMMENT ON COLUMN tbl_tinfbancos.infb_nit                         IS 'NIT.';
COMMENT ON COLUMN tbl_tinfbancos.infb_desti                       IS 'destinatario.';
COMMENT ON COLUMN tbl_tinfbancos.infb_cargo                       IS 'Cargo.';
COMMENT ON COLUMN tbl_tinfbancos.infb_dv                          IS 'Digito de verificaci�n.';
COMMENT ON COLUMN tbl_tinfbancos.infb_dir                         IS 'Direcci�n.';
COMMENT ON COLUMN tbl_tinfbancos.infb_ciudad                      IS 'Ciudad.';
COMMENT ON COLUMN tbl_tinfbancos.infb_fax                         IS 'Fax.';
COMMENT ON COLUMN tbl_tinfbancos.infb_telefono                    IS 'Telefono.';
COMMENT ON COLUMN tbl_tinfbancos.infb_ref                         IS 'Referencia.';
COMMENT ON COLUMN tbl_tinfbancos.infb_concep                      IS 'Concepto.';
COMMENT ON COLUMN tbl_tinfbancos.infb_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tinfbancos.infb_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tinfbancos.infb_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tinfbancos.infb_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
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
Prompt Generando Comentarios de la tabla TBL_TCONTENTI
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tcontenti                                  IS 'Tabla que almacena la informaci�n de contacto de las entidades';
COMMENT ON COLUMN tbl_tcontenti.cont_cont                        IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tcontenti.cont_nombre                      IS 'Nombre';
COMMENT ON COLUMN tbl_tcontenti.cont_telefono                    IS 'Telefono';
COMMENT ON COLUMN tbl_tcontenti.cont_extension                   IS 'Extensi�n de telefono';
COMMENT ON COLUMN tbl_tcontenti.cont_sebra                       IS 'Estado de SEBRA: (Modulo TBL, Lista CONT_ENTI)';
COMMENT ON COLUMN tbl_tcontenti.cont_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcontenti.cont_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tcontenti.cont_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tcontenti.cont_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
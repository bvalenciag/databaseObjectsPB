--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
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
COMMENT ON TABLE  tbl_tcontenti                                  IS 'Tabla que almacena la información de contacto de las entidades';
COMMENT ON COLUMN tbl_tcontenti.cont_cont                        IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_tcontenti.cont_nombre                      IS 'Nombre';
COMMENT ON COLUMN tbl_tcontenti.cont_telefono                    IS 'Telefono';
COMMENT ON COLUMN tbl_tcontenti.cont_extension                   IS 'Extensión de telefono';
COMMENT ON COLUMN tbl_tcontenti.cont_sebra                       IS 'Estado de SEBRA: (Modulo TBL, Lista CONT_ENTI)';
COMMENT ON COLUMN tbl_tcontenti.cont_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tcontenti.cont_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tcontenti.cont_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tcontenti.cont_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
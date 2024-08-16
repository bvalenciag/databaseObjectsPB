--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       04/01/2024 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla GEN_TFESTIVOS
Prompt
/**********************************************************************************/
COMMENT ON TABLE  gen_tfestivos                                  IS 'Almacena los festivos sincronizados desde SIFI.';
COMMENT ON COLUMN gen_tfestivos.fest_fest                        IS 'D�a Festivo y llave primaria de la tabla.';
COMMENT ON COLUMN gen_tfestivos.fest_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN gen_tfestivos.fest_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN gen_tfestivos.fest_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN gen_tfestivos.fest_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
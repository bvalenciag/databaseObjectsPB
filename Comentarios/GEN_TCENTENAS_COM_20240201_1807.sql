--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       01/02/2024 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla GEN_TCENTENAS
Prompt
/**********************************************************************************/
COMMENT ON TABLE  gen_tcentenas                                  IS 'Cantidad de centenas convertidas a letras.';
COMMENT ON COLUMN gen_tcentenas.cent_cent                        IS 'N�mero de centenas.';
COMMENT ON COLUMN gen_tcentenas.cent_letras                      IS 'Centenas en lestras.';
COMMENT ON COLUMN gen_tcentenas.cent_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN gen_tcentenas.cent_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN gen_tcentenas.cent_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN gen_tcentenas.cent_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
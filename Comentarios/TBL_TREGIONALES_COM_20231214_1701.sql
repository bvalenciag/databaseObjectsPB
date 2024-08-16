--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TREGIONALES
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tregionales                                  IS 'Almacena información referente a los datos de regionales estraidos de SIFI.';
COMMENT ON COLUMN tbl_tregionales.regi_empr                        IS 'Código empresa interno.';
COMMENT ON COLUMN tbl_tregionales.regi_empr_ex                     IS 'Código empresa externo.';
COMMENT ON COLUMN tbl_tregionales.regi_banc                        IS 'Código banco interno.';
COMMENT ON COLUMN tbl_tregionales.regi_banc_ex                     IS 'Código banco externo.';
COMMENT ON COLUMN tbl_tregionales.regi_fecha                       IS 'Fecha.';
COMMENT ON COLUMN tbl_tregionales.regi_adic_reales                 IS 'Adiciones reales.';
COMMENT ON COLUMN tbl_tregionales.regi_reti_reales                 IS 'Retiros reales.';
COMMENT ON COLUMN tbl_tregionales.regi_fuente                      IS 'Fuente de información.';
COMMENT ON COLUMN tbl_tregionales.regi_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tregionales.regi_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tregionales.regi_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tregionales.regi_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
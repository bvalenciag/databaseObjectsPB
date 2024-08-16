--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
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
COMMENT ON TABLE  tbl_tregionales                                  IS 'Almacena informaci�n referente a los datos de regionales estraidos de SIFI.';
COMMENT ON COLUMN tbl_tregionales.regi_empr                        IS 'C�digo empresa interno.';
COMMENT ON COLUMN tbl_tregionales.regi_empr_ex                     IS 'C�digo empresa externo.';
COMMENT ON COLUMN tbl_tregionales.regi_banc                        IS 'C�digo banco interno.';
COMMENT ON COLUMN tbl_tregionales.regi_banc_ex                     IS 'C�digo banco externo.';
COMMENT ON COLUMN tbl_tregionales.regi_fecha                       IS 'Fecha.';
COMMENT ON COLUMN tbl_tregionales.regi_adic_reales                 IS 'Adiciones reales.';
COMMENT ON COLUMN tbl_tregionales.regi_reti_reales                 IS 'Retiros reales.';
COMMENT ON COLUMN tbl_tregionales.regi_fuente                      IS 'Fuente de informaci�n.';
COMMENT ON COLUMN tbl_tregionales.regi_fecins                      IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_tregionales.regi_usuains                     IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_tregionales.regi_fecupd                      IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_tregionales.regi_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
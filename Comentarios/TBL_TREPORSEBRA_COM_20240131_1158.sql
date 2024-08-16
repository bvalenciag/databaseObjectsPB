--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       31/01/2024 Cramirezs    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TREPORSEBRA
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_treporsebra                            IS 'Par�metrizaci�n reportes por banco.';
COMMENT ON COLUMN tbl_treporsebra.repo_repo                  IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_treporsebra.repo_banc	                 IS 'C�digo de banco ge_tbancos.';
COMMENT ON COLUMN tbl_treporsebra.repo_tipo                  IS 'Tipo de reporte, I-Ingreso, E-Egreso, A-Ambos.';
COMMENT ON COLUMN tbl_treporsebra.repo_reporte               IS 'Ruta donde se enecuntra el reporte .jasper en el servidor weblogic que contiene el JRI';
COMMENT ON COLUMN tbl_treporsebra.repo_fecins                IS 'Fecha en la que se realiza la inserci�n del registro.';
COMMENT ON COLUMN tbl_treporsebra.repo_usuains               IS 'Usuario que realizo la inserci�n del registro.';
COMMENT ON COLUMN tbl_treporsebra.repo_fecupd                IS 'Ultima fecha de actualizaci�n del registro.';
COMMENT ON COLUMN tbl_treporsebra.repo_usuaupd               IS 'Ultimo usuario que actualizo el registro.';
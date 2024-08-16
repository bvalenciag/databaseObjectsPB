--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       08/08/2024 Jmartinezm    000001       * Se crean comentarios.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Generando Comentarios de la tabla TBL_TPROVISIONES
Prompt
/**********************************************************************************/
COMMENT ON TABLE  tbl_tprovisiones                                  IS 'Tabla donde se almacenan las provisiones';
COMMENT ON COLUMN tbl_tprovisiones.prov_prov                        IS 'Identificador principal, secuencial';
COMMENT ON COLUMN tbl_tprovisiones.prov_empr_externo                IS 'Identificador de empresa SIFI';
COMMENT ON COLUMN tbl_tprovisiones.prov_empr                        IS 'Identificador de empresa interno EDGE';
COMMENT ON COLUMN tbl_tprovisiones.prov_banc_externo                IS 'Identificador de banco SIFI';
COMMENT ON COLUMN tbl_tprovisiones.prov_banc                        IS 'Identificador de banco interno EDGE';
COMMENT ON COLUMN tbl_tprovisiones.prov_valor                       IS 'Valor';
COMMENT ON COLUMN tbl_tprovisiones.prov_log                         IS 'Log de cargue';
COMMENT ON COLUMN tbl_tprovisiones.prov_fecins                      IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_tprovisiones.prov_usuains                     IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_tprovisiones.prov_fecupd                      IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_tprovisiones.prov_usuaupd                     IS 'Ultimo usuario que actualizo el registro.';
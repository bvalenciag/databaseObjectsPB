prompt
prompt VIEW: ADM_VPERFILESAPEX
prompt
CREATE OR REPLACE FORCE VIEW adm_vperfilesapex
    (
      perf_nombre
    , perf_descri
    , mepe_inserta
    , mepe_actualiza
    , mepe_elimina
    , mepe_perf
    , mepe_app
    , application_name
    , entry_text
    )
AS
SELECT DISTINCT
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       30/01/2024 Jmartinezm    000001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
      perf_nombre
    , perf_descri
    , CASE WHEN mepe_inserta = 'S' THEN 'X' END AS mepe_inserta
    , CASE WHEN mepe_actualiza = 'S' THEN 'X' END AS mepe_actualiza
    , CASE WHEN mepe_elimina = 'S' THEN 'X' END AS mepe_elimina
    , CASE WHEN mepe_inserta = 'N' AND mepe_actualiza = 'N' AND mepe_elimina = 'N' THEN 'X' END AS mepe_perf
    , mepe_app
    , application_name
    , entry_text
FROM 
    adm_tusuarios,
    adm_tperfiles,
    adm_tmeperfiles,
    apex_application_list_entries
WHERE 
    perf_perf = usua_perf
    AND perf_perf = mepe_perf
    AND mepe_menu = list_entry_id
    AND application_id = mepe_app
/
--
COMMENT ON TABLE  adm_vperfilesapex                     IS 'Vista que permite visualizar las opciones por perfil';
COMMENT ON COLUMN adm_vperfilesapex.perf_nombre         IS 'Nombre del perfil';
COMMENT ON COLUMN adm_vperfilesapex.perf_descri         IS 'Descripción del perfil';
COMMENT ON COLUMN adm_vperfilesapex.mepe_inserta        IS 'Acceso a insertar';
COMMENT ON COLUMN adm_vperfilesapex.mepe_actualiza      IS 'Acceso a actualizar';
COMMENT ON COLUMN adm_vperfilesapex.mepe_elimina        IS 'Acceso a eliminar';
COMMENT ON COLUMN adm_vperfilesapex.mepe_perf           IS 'Sin acceso';
COMMENT ON COLUMN adm_vperfilesapex.mepe_app            IS 'Código de la aplicación';
COMMENT ON COLUMN adm_vperfilesapex.application_name    IS 'Nombre de la aplicación';
COMMENT ON COLUMN adm_vperfilesapex.entry_text          IS 'Nombre de los menu de la aplicación';
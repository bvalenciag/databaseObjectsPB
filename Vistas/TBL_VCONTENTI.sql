prompt
prompt VIEW: TBL_VCONTENTI
prompt
CREATE OR REPLACE FORCE VIEW tbl_vcontenti
    (
      cont_cont
    , cont_nombre
    , cont_telefono
    , cont_extension
    , cont_sebra
    , cont_fecins
    , cont_usuains
    , cont_fecupd
    , cont_usuaupd
    , list_descri
    )
AS
SELECT
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/01/2024 Jmartinezm    000001       * Se crea vista.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
      cont_cont
    , cont_nombre
    , cont_telefono
    , cont_extension
    , cont_sebra
    , cont_fecins
    , cont_usuains
    , cont_fecupd
    , cont_usuaupd
    , list_descri
 FROM tbl_tcontenti 
    , gen_tlistas
where cont_sebra = list_list
/
--
COMMENT ON TABLE  tbl_vcontenti                     IS 'Vista que permite visualizar los contactos de la definición de cartas traslados';
COMMENT ON COLUMN tbl_vcontenti.cont_cont           IS 'Secuencial y llave primaria de la tabla.';
COMMENT ON COLUMN tbl_vcontenti.cont_nombre         IS 'Nombre';
COMMENT ON COLUMN tbl_vcontenti.cont_telefono       IS 'Telefono';
COMMENT ON COLUMN tbl_vcontenti.cont_extension      IS 'Extensión de telefono';
COMMENT ON COLUMN tbl_vcontenti.cont_sebra          IS 'Estado de SEBRA: (Modulo TBL, Lista CONT_ENTI)';
COMMENT ON COLUMN tbl_vcontenti.cont_fecins         IS 'Fecha en la que se realiza la inserción del registro.';
COMMENT ON COLUMN tbl_vcontenti.cont_usuains        IS 'Usuario que realizo la inserción del registro.';
COMMENT ON COLUMN tbl_vcontenti.cont_fecupd         IS 'Ultima fecha de actualización del registro.';
COMMENT ON COLUMN tbl_vcontenti.cont_usuaupd        IS 'Ultimo usuario que actualizo el registro.';
COMMENT ON COLUMN tbl_vcontenti.list_descri         IS 'Descripción de estado sebra';
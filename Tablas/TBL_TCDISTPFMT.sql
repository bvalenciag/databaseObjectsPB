--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/01/2024 mzabala      000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TCDISTPFMT
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tcdistpfmt(
      id_cdist          NUMBER(9)  DEFAULT TBL_SCDISTPFMT.NEXTVAL     CONSTRAINT nn_tbl_tcdis_cdis NOT NULL
    , cod_rdist         NUMBER(9)
    , name_dist         VARCHAR2(1000)
    , is_check          VARCHAR2(5)
    , type_dist         VARCHAR2(20)
)
;
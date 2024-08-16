--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/05/2024 Jmartinezm    000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TDOCS
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tdocs(
      docs_docs         NUMBER(9) DEFAULT TBL_SDOCS.NEXTVAL CONSTRAINT nn_tbl_tdocs_docs NOT NULL
    , docs_name         VARCHAR2(100)
    , docs_file         BLOB
    , docs_mime         VARCHAR2(50)
)
;
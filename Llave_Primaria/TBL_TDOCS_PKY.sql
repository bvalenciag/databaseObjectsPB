--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/05/2024 Jmartinezm    000001       * Se crea llave primaria.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla TBL_TDOCS
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tdocs
    ADD CONSTRAINT pk_tbl_tdocs PRIMARY KEY ( docs_docs )
        ;
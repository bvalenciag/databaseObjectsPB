--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       31/01/2024 Cramirezs    000001       * Se crean check constraints.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando check constraints para la tabla TBL_TREPORSEBRA campo REPO_TIPO
Prompt
ALTER TABLE tbl_treporsebra
    ADD CONSTRAINT ch_tbl_treporsebra_tipo
        CHECK ( repo_tipo IN ( 'I', 'E', 'A' ) ) ;
--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/11/2023 Cramirezs    00001       * Se crea llave primaria.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla TBL_TMOTBBIZA
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tmotbbiza
    ADD CONSTRAINT pk_tbl_tmotbbiza PRIMARY KEY ( motb_motb );
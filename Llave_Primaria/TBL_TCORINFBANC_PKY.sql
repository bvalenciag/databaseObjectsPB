--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/01/2024 Jmartinezm    000001       * Se crea llave primaria.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla tbl_tcorinfbanc
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tcorinfbanc
    ADD CONSTRAINT pk_tbl_tcorinfbanc PRIMARY KEY ( cori_cori )
        ;
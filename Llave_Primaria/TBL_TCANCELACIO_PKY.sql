--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crea llave primaria.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla TBL_TCANCELACIO
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tcancelacio
    ADD CONSTRAINT pk_tbl_tcancelacio PRIMARY KEY ( canc_canc );
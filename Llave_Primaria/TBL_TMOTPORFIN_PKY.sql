--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       11/12/2023 Cramirezs    000001       * Se crea llave primaria.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla TBL_TMOTPORFIN
Prompt
/**********************************************************************************/
ALTER TABLE tbl_tmotporfin
    ADD CONSTRAINT pk_tbl_tmotporfin PRIMARY KEY ( motp_motp );
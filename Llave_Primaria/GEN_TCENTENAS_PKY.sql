--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       01/02/2024 Cramirezs    000001       * Se crea llave primaria.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla GEN_TCENTENAS
Prompt
/**********************************************************************************/
ALTER TABLE gen_tcentenas
    ADD CONSTRAINT pk_gen_tcentenas PRIMARY KEY ( cent_cent )
    ;
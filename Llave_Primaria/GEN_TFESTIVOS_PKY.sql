--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       04/01/2024 Cramirezs    000001       * Se crea llave primaria.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla GEN_TFESTIVOS
Prompt
/**********************************************************************************/
ALTER TABLE gen_tfestivos
    ADD CONSTRAINT pk_gen_tfestivos PRIMARY KEY ( fest_fest );
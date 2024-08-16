--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       03/01/2023 Cramirezs    000001       * Se crean check constraints.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando check constraints para la tabla GEN_TCONTROLPRO campo CONT_ESTADO
Prompt
ALTER TABLE gen_tcontrolpro
    ADD CONSTRAINT ch_gen_tcontrolpro_estado
        CHECK ( cont_estado IN ( 'P', 'F' ) ) ;
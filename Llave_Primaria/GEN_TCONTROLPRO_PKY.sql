--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       03/01/2023 Cramirezs    000001       * Se crea llave primaria.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando llave primaria de la tabla GEN_TCONTROLPRO
Prompt
/**********************************************************************************/
ALTER TABLE gen_tcontrolpro
    ADD CONSTRAINT pk_gen_tcontrolpro PRIMARY KEY ( cont_proceso, cont_llave, cont_sesion );
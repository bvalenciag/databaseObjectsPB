--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       22/02/2024 Jmartinezm    000001       * Se crean llaves foraneas.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tmesaoper con gen_testados
Prompt
ALTER TABLE tbl_tmesaoper ADD CONSTRAINT fk_tbl_tmesaoper_gen_testados
    FOREIGN KEY ( mesa_esta ) 
        REFERENCES gen_testados ( esta_esta ) ;
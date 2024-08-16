--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       30/04/2024 Jmartinezm    000001       * Se crean llaves foraneas.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TCUENTASBAN con gen_testados
Prompt
ALTER TABLE tbl_tcuentasban ADD CONSTRAINT fk_tbl_tcuentasban_gen_testados_sebra
    FOREIGN KEY ( cuen_sebra ) 
        REFERENCES gen_testados ( esta_esta ) ;
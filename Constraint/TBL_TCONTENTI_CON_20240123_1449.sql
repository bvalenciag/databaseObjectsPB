--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crean llaves foraneas.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TCONTENTI con gen_tlistas
Prompt
ALTER TABLE tbl_tcontenti ADD CONSTRAINT fk_tbl_tcontenti_gen_tlistas
    FOREIGN KEY ( cont_sebra ) 
        REFERENCES gen_tlistas ( list_list ) ;
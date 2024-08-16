--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crean llaves foraneas.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TCUENTASBAN con GEN_TLISTAS
Prompt
ALTER TABLE tbl_tcuentasban ADD CONSTRAINT fk_tbl_tcuentasban_gen_tlistas
    FOREIGN KEY ( cuen_tipo_oper ) 
        REFERENCES gen_tlistas ( list_list ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TCUENTASBAN con TBL_TCUENTASBAN
Prompt
ALTER TABLE tbl_tcuentasban ADD CONSTRAINT fk_tbl_tcuentasban_tbl_tcuentasban
    FOREIGN KEY ( cuen_cta_cud ) 
        REFERENCES tbl_tcuentasban ( cuen_cuen ) ;
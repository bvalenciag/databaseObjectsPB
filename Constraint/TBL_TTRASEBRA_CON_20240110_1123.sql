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
Prompt Creando llave foranea para la tabla TBL_TTRASEBRA con TBL_TEMPRESAS
Prompt
ALTER TABLE tbl_ttrasebra ADD CONSTRAINT fk_tbl_ttrasebra_tbl_tempresas
    FOREIGN KEY ( tras_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TTRASEBRA con TBL_TBANCOS
Prompt
ALTER TABLE tbl_ttrasebra ADD CONSTRAINT fk_tbl_ttrasebra_tbl_tbancos
    FOREIGN KEY ( tras_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TTRASEBRA con TBL_TCUENTASBAN
Prompt
ALTER TABLE tbl_ttrasebra ADD CONSTRAINT fk_tbl_ttrasebra_tbl_tcuentasban
    FOREIGN KEY ( tras_cuen ) 
        REFERENCES tbl_tcuentasban ( cuen_cuen ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TTRASEBRA con TBL_TCUENTASBAN
Prompt
ALTER TABLE tbl_ttrasebra ADD CONSTRAINT fk_tbl_ttrasebra_tbl_tcuentasban_cud
    FOREIGN KEY ( tras_cuen_cud ) 
        REFERENCES tbl_tcuentasban ( cuen_cuen ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TTRASEBRA con GEN_TLISTAS
Prompt
ALTER TABLE tbl_ttrasebra ADD CONSTRAINT fk_tbl_ttrasebra_gen_tlistas
    FOREIGN KEY ( tras_tipo_oper ) 
        REFERENCES gen_tlistas ( list_list ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TTRASEBRA con GEN_TESTADOS
Prompt
ALTER TABLE tbl_ttrasebra ADD CONSTRAINT fk_tbl_ttrasebra_gen_testados
    FOREIGN KEY ( tras_esta ) 
        REFERENCES gen_testados ( esta_esta ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TTRASEBRA con GEN_TESTADOS
Prompt
ALTER TABLE tbl_ttrasebra ADD CONSTRAINT fk_tbl_ttrasebra_gen_testados_impr
    FOREIGN KEY ( tras_impreso ) 
        REFERENCES gen_testados ( esta_esta ) ;
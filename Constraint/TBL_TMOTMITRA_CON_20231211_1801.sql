--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       11/12/2023 Cramirezs    000001       * Se crean llaves foraneas.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTMITRA con GEN_TLISTAS
Prompt
ALTER TABLE tbl_tmotmitra ADD CONSTRAINT fk_tbl_tmotmitra_gen_tlistas
    FOREIGN KEY ( motm_fuente ) 
        REFERENCES gen_tlistas ( list_list ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTMITRA con TBL_TEMPRESAS
Prompt
ALTER TABLE tbl_tmotmitra ADD CONSTRAINT fk_tbl_tmotmitra_tbl_tempresas
    FOREIGN KEY ( motm_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
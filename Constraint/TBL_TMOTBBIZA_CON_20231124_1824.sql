--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/11/2023 Cramirezs    000001       * Se crean llaves foraneas.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTBBIZA con GEN_TLISTAS
Prompt
ALTER TABLE tbl_tmotbbiza ADD CONSTRAINT fk_tbl_tmotbbiza_gen_tlistas
    FOREIGN KEY ( motb_fuente ) 
        REFERENCES gen_tlistas ( list_list ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTBBIZA con TBL_TCUENTASBAN
Prompt
ALTER TABLE tbl_tmotbbiza ADD CONSTRAINT fk_tbl_tmotbbiza_tbl_tcuentasban
    FOREIGN KEY ( motb_cuen ) 
        REFERENCES tbl_tcuentasban ( cuen_cuen ) ;
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTBBIZA con TBL_TBANCOS
Prompt
ALTER TABLE tbl_tmotbbiza ADD CONSTRAINT fk_tbl_tmotbbiza_tbl_tbancos
    FOREIGN KEY ( motb_banc )
        REFERENCES tbl_tbancos ( banc_banc );
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTBBIZA con TBL_TEMPRESAS
Prompt
ALTER TABLE tbl_tmotbbiza ADD CONSTRAINT fk_tbl_tmotbbiza_tbl_tempresas
    FOREIGN KEY ( motb_empr )
        REFERENCES tbl_tempresas ( empr_empr );
--
Prompt
Prompt Creando restricciones de unique de la tabla TBL_TMOTBBIZA
Prompt
ALTER TABLE tbl_tmotbbiza
    ADD CONSTRAINT uq_tbl_tmotbbiza_bizagi
        UNIQUE (motb_caso, motb_empresa, motb_banco, motb_nrocta, motb_fecha); 
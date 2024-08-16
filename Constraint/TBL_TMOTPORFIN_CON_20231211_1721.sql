--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       11/12/2023 Cramirezs    000001       * Se crean constraints.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
--
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTPORFIN con TBL_TEMPRESAS
Prompt
ALTER TABLE tbl_tmotporfin ADD CONSTRAINT fk_tbl_tmotporfin_tbl_tempresas
    FOREIGN KEY ( motp_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
--
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMOTPORFIN con GEN_TLISTAS
Prompt
ALTER TABLE tbl_tmotporfin ADD CONSTRAINT fk_tbl_tmotporfin_gen_tlistas
    FOREIGN KEY ( motp_fuente ) 
        REFERENCES gen_tlistas ( list_list ) ;
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       13/12/2023 Jmartinezm    00001       * Se crean check constraints.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tdistmovi con tbl_tmotmitra
Prompt
ALTER TABLE tbl_tdistmovi ADD CONSTRAINT fk_tbl_tdistmovi_tbl_tmotmitra
    FOREIGN KEY ( dist_motm ) 
        REFERENCES tbl_tmotmitra ( motm_motm ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tdistmovi con tbl_tmotporfin
Prompt
ALTER TABLE tbl_tdistmovi ADD CONSTRAINT fk_tbl_tdistmovi_tbl_tmotporfin
    FOREIGN KEY ( dist_motp ) 
        REFERENCES tbl_tmotporfin ( motp_motp ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tdistmovi con tbl_tbancos
Prompt
ALTER TABLE tbl_tdistmovi ADD CONSTRAINT fk_tbl_tdistmovi_tbl_tbancos
    FOREIGN KEY ( dist_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;
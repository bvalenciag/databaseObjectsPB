--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       27/12/2023 Jmartinezm    00001       * Se crean llaves foraneas.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla TBL_TMESAOPER con tbl_tbancos
Prompt
ALTER TABLE tbl_tmesaoper ADD CONSTRAINT fk_tbl_tmesaoper_tbl_tbancos
    FOREIGN KEY ( mesa_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;

--
Prompt
Prompt Creando llave foranea para la tabla tbl_tmesaoper con tbl_tempresas
Prompt
ALTER TABLE tbl_tmesaoper ADD CONSTRAINT fk_tbl_tmesaoper_tbl_tempresas
    FOREIGN KEY ( mesa_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tmesaoper con gen_tlistas
Prompt
ALTER TABLE tbl_tmesaoper ADD CONSTRAINT fk_tbl_tmesaoper_gen_tlistas
    FOREIGN KEY ( mesa_oper ) 
        REFERENCES gen_tlistas ( list_list ) ;
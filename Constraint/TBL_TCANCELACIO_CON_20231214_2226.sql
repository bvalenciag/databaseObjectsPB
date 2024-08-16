--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crean constraint.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tcancelacio con tbl_tempresas
Prompt
ALTER TABLE tbl_tcancelacio ADD CONSTRAINT fk_tbl_tcancelacio_tbl_tempresas
    FOREIGN KEY ( canc_empr ) 
        REFERENCES tbl_tempresas ( empr_empr ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tcancelacio con tbl_tbancos
Prompt
ALTER TABLE tbl_tcancelacio ADD CONSTRAINT fk_tbl_tcancelacio_tbl_tbancos
    FOREIGN KEY ( canc_banc ) 
        REFERENCES tbl_tbancos ( banc_banc ) ;
--
Prompt
Prompt Creando llave foranea para la tabla tbl_tcancelacio con gen_tlistas
Prompt
ALTER TABLE tbl_tcancelacio ADD CONSTRAINT fk_tbl_tcancelacio_gen_tlistas
    FOREIGN KEY ( canc_fuente ) 
        REFERENCES gen_tlistas ( list_list ) ;
--
Prompt
Prompt Creando restriccion de unique de la tabla tbl_tcancelacio
Prompt
ALTER TABLE tbl_tcancelacio
    ADD CONSTRAINT uq_tbl_tcancelacio_canc_ex_fond_ex
        UNIQUE (canc_canc_ex, canc_fond_ex); 
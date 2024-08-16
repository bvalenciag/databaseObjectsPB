--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/01/2024 mzabala      000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TCONDGENPFMT
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tcondgenpfmt(
      id_cond           NUMBER(9)  DEFAULT TBL_SCONDGENPFMT.NEXTVAL CONSTRAINT nn_tbl_tcond_cond_pfmt NOT NULL
    , cod_banc_banc     NUMBER(9)
    , banc_description  VARCHAR2(1000)
    , cond_fecins       DATE DEFAULT SYSDATE                        CONSTRAINT nn_tbl_tcond_fecinspfmt NOT NULL
    , cond_usuains      VARCHAR2(20) DEFAULT USER                   CONSTRAINT nn_tbl_tcond_userpfmt NOT NULL
    , cond_fecupd       DATE
    , cod_usuapd        VARCHAR2(20)
)
;
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       18/12/2023 Jmartinezm    00001       * Se crea tabla.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TCONDGEN
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tcondgen(
      cond_cond         NUMBER(9)                           CONSTRAINT nn_tbl_tcond_cond NOT NULL
    , cond_banc_inter   NUMBER(9)                           CONSTRAINT nn_tbl_tcond_banc_inter NOT NULL
    , cond_banc_cance   NUMBER(9)                           CONSTRAINT nn_tbl_tcond_banc_cance NOT NULL
    , cond_dv1          NUMBER(20,2)      
    , cond_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tcond_fecins NOT NULL
    , cond_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tcond_user NOT NULL
    , cond_fecupd       DATE
    , cond_usuaupd      VARCHAR2(20)
)
;
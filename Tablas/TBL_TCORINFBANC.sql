--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/01/2024 Jmartinezm    000001       * Se crea tabla.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TCORINFBANC
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tcorinfbanc(
      cori_cori         NUMBER(9)                           CONSTRAINT nn_tbl_tcori_cori NOT NULL
    , cori_infb         NUMBER(9)                           CONSTRAINT nn_tbl_tcori_infb NOT NULL
    , cori_email        VARCHAR2(200)
    , cori_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tcori_fecins NOT NULL
    , cori_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tcori_user NOT NULL
    , cori_fecupd       DATE
    , cori_usuaupd      VARCHAR2(20)
)
;
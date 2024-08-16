--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/06/2024 Jmartinezm    000001       * Se crea tabla.
--                       Kilonova      MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TEMPXMAND
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tempxmand(
      empx_empx         NUMBER(9)                           CONSTRAINT nn_tbl_tempx_empx NOT NULL
    , empx_empr         NUMBER(9)
    , empx_encargo      NUMBER(20)
    , empx_mandato      NUMBER(9)
    , empx_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tempx_fecins NOT NULL
    , empx_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tempx_user NOT NULL
    , empx_fecupd       DATE
    , empx_usuaupd      VARCHAR2(20)
)
;
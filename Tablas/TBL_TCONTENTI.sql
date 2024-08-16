--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       23/01/2024 Jmartinezm    00001       * Se crea tabla.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TCONTENTI
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tcontenti(
      cont_cont         NUMBER(9)                           CONSTRAINT nn_tbl_tcont_cont NOT NULL
    , cont_nombre       VARCHAR2(200)                       CONSTRAINT nn_tbl_tcont_nombre NOT NULL
    , cont_telefono     VARCHAR2(20)                        CONSTRAINT nn_tbl_tcont_telefono NOT NULL                          
    , cont_extension    VARCHAR2(20)                        CONSTRAINT nn_tbl_tcont_extension NOT NULL
    , cont_sebra        NUMBER(9)                           CONSTRAINT nn_tbl_tcont_sebra NOT NULL
    , cont_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tcont_fecins NOT NULL
    , cont_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tcont_user NOT NULL
    , cont_fecupd       DATE
    , cont_usuaupd      VARCHAR2(20)
)
;
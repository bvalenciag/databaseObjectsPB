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
Prompt Creando tabla TBL_TINFBANCOS
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tinfbancos(
      infb_infb         NUMBER(9)                           CONSTRAINT nn_tbl_tinfb_infb NOT NULL
    , infb_banc         NUMBER(9)                           CONSTRAINT nn_tbl_tinfb_banc NOT NULL
    , infb_nit          VARCHAR2(200)                       CONSTRAINT nn_tbl_tinfb_nit NOT NULL
    , infb_desti        VARCHAR2(200)
    , infb_cargo        VARCHAR2(200)
    , infb_dv           NUMBER(9)
    , infb_dir          VARCHAR2(200)
    , infb_ciudad       VARCHAR2(200)
    , infb_fax          VARCHAR2(200)
    , infb_telefono     VARCHAR2(200)
    , infb_ref          VARCHAR2(200)
    , infb_concep       VARCHAR2(200)
    , infb_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tinfb_fecins NOT NULL
    , infb_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tinfb_user NOT NULL
    , infb_fecupd       DATE
    , infb_usuaupd      VARCHAR2(20)
)
;
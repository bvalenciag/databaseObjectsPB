--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       31/01/2024 Cramirezs    000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TREPORSEBRA
Prompt
/**********************************************************************************/
CREATE TABLE tbl_treporsebra(
      repo_repo         NUMBER(9)   DEFAULT TBL_SREPORSEBRA.NEXTVAL CONSTRAINT nn_tbl_trepo_repo   NOT NULL
    , repo_banc	        NUMBER(9)                                   CONSTRAINT nn_tbl_trepo_banc   NOT NULL
    , repo_tipo         VARCHAR2(1)                                 CONSTRAINT nn_tbl_trepo_tipo   NOT NULL
    , repo_jrd_id       NUMBER                                      CONSTRAINT nn_tbl_trepo_jrd_id NOT NULL
    , repo_fecins       DATE DEFAULT SYSDATE                        CONSTRAINT nn_tbl_trepo_fecins NOT NULL
    , repo_usuains      VARCHAR2(20) DEFAULT USER                   CONSTRAINT nn_tbl_trepo_user   NOT NULL
    , repo_fecupd       DATE
    , repo_usuaupd      VARCHAR2(20)
)
;
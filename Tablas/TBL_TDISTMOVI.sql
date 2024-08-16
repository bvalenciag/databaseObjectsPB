--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       13/12/2023 Jmartinezm    00001       * Se crea tabla.
--                       Kilonova      MVP2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TDISTMOVI
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tdistmovi(
      dist_dist         NUMBER(9)                           CONSTRAINT nn_tbl_tdist_dist NOT NULL
    , dist_motp         NUMBER(9)
    , dist_motm         NUMBER(9)
    , dist_banc         NUMBER(9)                           CONSTRAINT nn_tbl_tdist_banc NOT NULL
    , dist_val          NUMBER(20,2)                        CONSTRAINT nn_tbl_tdist_val NOT NULL
    , dist_motmd        NUMBER(20,2)
    , dist_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tdist_fecins NOT NULL
    , dist_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tdist_user NOT NULL
    , dist_fecupd       DATE
    , dist_usuaupd      VARCHAR2(20)
)
;




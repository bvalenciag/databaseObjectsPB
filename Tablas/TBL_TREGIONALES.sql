--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       14/12/2023 Cramirezs    000001       * Se crea tabla.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TREGIONALES
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tregionales(
      regi_regi                 NUMBER(9)                           CONSTRAINT nn_tbl_tregi_regi           NOT NULL
    , regi_empr                 NUMBER(9)                           CONSTRAINT nn_tbl_tregi_empr           NOT NULL
    , regi_empr_ex              VARCHAR2(50)                        CONSTRAINT nn_tbl_tregi_empr_ex        NOT NULL
    , regi_banc                 NUMBER(9)                           CONSTRAINT nn_tbl_tregi_banc           NOT NULL
    , regi_banc_ex              VARCHAR2(50)                        CONSTRAINT nn_tbl_tregi_banc_ex        NOT NULL
    , regi_fecha                DATE                                CONSTRAINT nn_tbl_tregi_fecha          NOT NULL
    , regi_adic_reales          NUMBER(22,2)                        CONSTRAINT nn_tbl_tregi_adic_reales    NOT NULL
    , regi_reti_reales          NUMBER(22,2)                        CONSTRAINT nn_tbl_tregi_reti_reales    NOT NULL
    , regi_fuente               NUMBER(9)                           CONSTRAINT nn_tbl_tregi_fuente         NOT NULL
    , regi_fecins               DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tregi_fecins         NOT NULL
    , regi_usuains              VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tregi_user           NOT NULL
    , regi_fecupd               DATE
    , regi_usuaupd              VARCHAR2(20)
)
;
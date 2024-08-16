--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       10/01/2024 Cramirezs    000001       * Se crea tabla.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TTRASEBRA
Prompt
/**********************************************************************************/
CREATE TABLE tbl_ttrasebra(
      tras_tras         NUMBER(9)                           CONSTRAINT nn_tbl_ttras_tras      NOT NULL
    , tras_empr         NUMBER(9)                           CONSTRAINT nn_tbl_ttras_empr      NOT NULL
    , tras_banc         NUMBER(9)                           CONSTRAINT nn_tbl_ttras_banc      NOT NULL
    , tras_cuen         NUMBER(9)                           CONSTRAINT nn_tbl_ttras_cuen      NOT NULL
    , tras_cuen_cud     NUMBER(9)                           CONSTRAINT nn_tbl_ttras_cuen_cud  NOT NULL
    , tras_tipo_oper    NUMBER(9)                           CONSTRAINT nn_tbl_ttras_tipo_oper NOT NULL
    , tras_esta         NUMBER(9)                           CONSTRAINT nn_tbl_ttras_esta      NOT NULL
    , tras_valor        NUMBER(20,2)                        CONSTRAINT nn_tbl_ttras_valor     NOT NULL 
    , tras_impreso      NUMBER(9)
    , tras_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_ttras_fecins NOT NULL
    , tras_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_ttras_user NOT NULL
    , tras_fecupd       DATE
    , tras_usuaupd      VARCHAR2(20)
)
;
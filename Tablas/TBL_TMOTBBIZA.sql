--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       24/11/2023 Cramirezs    000001       * Se crea tabla.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TMOTBBIZA
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tmotbbiza(
      motb_motb         NUMBER(9)                           CONSTRAINT nn_tbl_tmotb_motb        NOT NULL
    , motb_caso         NUMBER(9)                           CONSTRAINT nn_tbl_tmotb_caso        NOT NULL
    , motb_empresa      VARCHAR2(50)                        CONSTRAINT nn_tbl_tmotb_empresa     NOT NULL
    , motb_empr         NUMBER(9)                           CONSTRAINT nn_tbl_tmotb_empr        NOT NULL
    , motb_banco        VARCHAR2(50)                        CONSTRAINT nn_tbl_tmotb_banco       NOT NULL
    , motb_banc         NUMBER(9)                           CONSTRAINT nn_tbl_tmotb_banc        NOT NULL
    , motb_nrocta       VARCHAR2(50)                        
    , motb_cuen         NUMBER(9)                           
    , motb_fecha        DATE                                CONSTRAINT nn_tbl_tmotb_fecha       NOT NULL
    , motb_descripcion  VARCHAR2(200)                       CONSTRAINT nn_tbl_tmotb_descripcion NOT NULL
    , motb_valor        NUMBER(22,2)                        CONSTRAINT nn_tbl_tmotb_valor       NOT NULL
    , motb_esta         VARCHAR2(30)                        CONSTRAINT nn_tbl_tmotb_esta        NOT NULL
    , motb_tipo_oper    VARCHAR2(50)                        CONSTRAINT nn_tbl_tmotb_tipo_oper   NOT NULL
    , motb_gmf          VARCHAR2(1)                         CONSTRAINT nn_tbl_tmotb_GMF         NOT NULL
    , motb_fuente       NUMBER(9)                           CONSTRAINT nn_tbl_tmotb_fuente      NOT NULL
    , motb_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tmotb_fecins      NOT NULL
    , motb_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tmotb_user        NOT NULL
    , motb_fecupd       DATE
    , motb_usuaupd      VARCHAR2(20)
)
;
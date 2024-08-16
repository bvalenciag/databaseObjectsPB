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
Prompt Creando tabla TBL_TCANCELACIO
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tcancelacio(
      canc_canc         NUMBER(9)                           CONSTRAINT nn_tbl_tcanc_canc      NOT NULL
    , canc_canc_ex      VARCHAR2(50)                        CONSTRAINT nn_tbl_tcanc_canc_ex   NOT NULL
    , canc_fond_ex      VARCHAR2(50)                        CONSTRAINT nn_tbl_tcanc_fond_ex   NOT NULL
    , canc_empr_ex      VARCHAR2(50)                        CONSTRAINT nn_tbl_tcanc_empr_ex   NOT NULL
    , canc_empr         NUMBER(9)                           CONSTRAINT nn_tbl_tcanc_empr      NOT NULL
    , canc_banc_ex      VARCHAR2(50)                        
    , canc_banc         NUMBER(9)                           
    , canc_fecha        DATE                                CONSTRAINT nn_tbl_tcanc_fecha     NOT NULL
    , canc_plan         NUMBER(20)                          CONSTRAINT nn_tbl_tcanc_plan      NOT NULL
    , canc_desc_plan    VARCHAR2(250)                       CONSTRAINT nn_tbl_tcanc_desc_plan NOT NULL
    , canc_vlr_canc     NUMBER(22,2)                        CONSTRAINT nn_tbl_tcanc_vlr_canc  NOT NULL
    , canc_vlr_ajus     NUMBER(22,2)                        CONSTRAINT nn_tbl_tcanc_vlr_ajus  NOT NULL
    , canc_vlr_gmf      NUMBER(22,2)                        
    , canc_vlr_giro     NUMBER(22,2)                        CONSTRAINT nn_tbl_tcanc_vlr_giro  NOT NULL
    , canc_fuente       NUMBER(9)                           CONSTRAINT nn_tbl_tcanc_fuente    NOT NULL
    , canc_val_act      NUMBER(22,2)                             
    , canc_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tcanc_fecins    NOT NULL
    , canc_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tcanc_user      NOT NULL
    , canc_fecupd       DATE
    , canc_usuaupd      VARCHAR2(20)
)
;
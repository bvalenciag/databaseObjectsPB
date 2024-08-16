--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       11/12/2023 Cramirezs    000001       * Se crea tabla.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TMOTMITRA
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tmotmitra(
      motm_motm         NUMBER(9)                           CONSTRAINT nn_tbl_tmotm_motm NOT NULL
    , motm_folio        VARCHAR2(25)                        
    , motm_operacion    VARCHAR2(6)                         
    , motm_cod_contra   VARCHAR2(20)                        
    , motm_desc_contra  VARCHAR2(250)                       
    , motm_monto        NUMBER(22,4)                       
    , motm_act          NUMBER(22,4)                       
    , motm_fech_cump    DATE                                
    , motm_cod_trader   VARCHAR2(20)                        
    , motm_desc_trader  VARCHAR2(250)                       
    , motm_destino      VARCHAR2(10)                        
    , motm_estado       VARCHAR2(20)                        
    , motm_fuente       NUMBER(9)                           CONSTRAINT nn_tbl_tmotm_fuente NOT NULL
    , motm_empr         NUMBER(9)                           
    , motm_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tmotm_fecins NOT NULL
    , motm_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tmotm_user NOT NULL
    , motm_fecupd       DATE
    , motm_usuaupd      VARCHAR2(20)
)
;
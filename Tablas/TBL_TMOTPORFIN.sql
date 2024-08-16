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
Prompt Creando tabla TBL_TMOTPORFIN
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tmotporfin(
      motp_motp         NUMBER(9)                           CONSTRAINT nn_tbl_tmotp_motp NOT NULL
    , motp_ope_fecha    DATE                                CONSTRAINT nn_tbl_tmotp_fecha NOT NULL
    , motp_det          VARCHAR2(3)                         
    , motp_transac      VARCHAR2(50)                        
    , motp_especie      VARCHAR2(30)                        
    , motp_consec       NUMBER(8)                           
    , motp_valor_nom    NUMBER(22,4)                       
    , motp_emision      DATE                                
    , motp_vcto         DATE                                
    , motp_vr_reci      NUMBER(22,4)                       
    , motp_vr_act       NUMBER(22,2)                       
    , motp_nit          VARCHAR2(20)                        
    , motp_contraparte  VARCHAR2(20)                        
    , motp_por          VARCHAR2(5)                         
    , motp_empr         NUMBER(9)
    , motp_fuente       NUMBER(9)                           CONSTRAINT nn_tbl_tmotp_fuente NOT NULL
    , motp_fecins       DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tmotp_fecins NOT NULL
    , motp_usuains      VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tmotp_user NOT NULL
    , motp_fecupd       DATE
    , motp_usuaupd      VARCHAR2(20)
)
;
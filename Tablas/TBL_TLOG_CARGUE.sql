---
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       08/08/2024 Jmartinezm    000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TBL_TLOG_CARGUE
Prompt
/**********************************************************************************/
CREATE TABLE tbl_tlog_cargue(
      log_log               NUMBER(9)                           CONSTRAINT nn_tbl_tlog_log NOT NULL
    , log_tipo_cargue       VARCHAR2(200)
    , log_archivo           BLOB
    , log_tipo_archivo      VARCHAR2(200)
    , log_nombre_archivo    VARCHAR2(200)
    , log_fecins            DATE DEFAULT SYSDATE                CONSTRAINT nn_tbl_tlog_fecins NOT NULL
    , log_usuains           VARCHAR2(20) DEFAULT USER           CONSTRAINT nn_tbl_tlog_user NOT NULL
    , log_fecupd            DATE
    , log_usuaupd           VARCHAR2(20)
)
;
--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       22/07/2024 Jmartinezm    000001       * Se crea tabla.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando tabla TEMP_GRF_MOVI
Prompt
/**********************************************************************************/
CREATE TABLE temp_grf_movi(  
      temp_empr	        VARCHAR2(2000 BYTE)
    , temp_banc	        VARCHAR2(2000 BYTE)
    , temp_fuente	    VARCHAR2(2000 BYTE)
    , temp_tipo_oper    VARCHAR2(2000 BYTE)
)
;
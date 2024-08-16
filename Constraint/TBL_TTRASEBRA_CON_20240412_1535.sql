--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       12/04/2024 Jmartinezm    000001       * Se crea columna.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
/**********************************************************************************/
Prompt
Prompt Creando campos de la tabla TBL_TTRASEBRA
Prompt
/**********************************************************************************/
ALTER TABLE TBL_TTRASEBRA 
    DROP CONSTRAINT NN_TBL_TTRAS_CUEN_CUD;
ALTER TABLE TBL_TTRASEBRA 
    DROP CONSTRAINT FK_TBL_TTRASEBRA_TBL_TCUENTASBAN_CUD;
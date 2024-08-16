PROMPT
PROMPT Se elimina TYPE table si existe
PROMPT
DROP TYPE tbl_ybanc_comi_cout;
--
PROMPT
PROMPT Creando TYPE TBL_YBANC_COMI_OOUT
PROMPT
CREATE OR REPLACE TYPE tbl_ybanc_comi_oout IS OBJECT
    ( 
        ---------------------------------------------------------------------------------------------------------------------
        -- (OUT) Parametros de salida cartas bancolombia 
        --------------------------------------------------------------------------------------------------------------------- 
          tipo_cuen             VARCHAR2(3)         --Tipo de cuenta, CR-Corriente, CA-Ahorros
        , num_cuen              VARCHAR2(11)        --Número de cuenta    
    );
--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       02/01/2023 Cramirezs    000001       * Se crea type OBJECT para los datos de salida de las cartas de bancolombia.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
/  
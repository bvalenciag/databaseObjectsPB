PROMPT
PROMPT Se elimina TYPE table si existe
PROMPT
DROP TYPE tbl_ybanc_envi_cout;
--
PROMPT
PROMPT Creando TYPE TBL_YBANC_ENVI_OOUT
PROMPT
CREATE OR REPLACE TYPE tbl_ybanc_envi_oout IS OBJECT
    ( 
        ---------------------------------------------------------------------------------------------------------------------
        -- (OUT) Parametros de salida cartas bancolombia 
        --------------------------------------------------------------------------------------------------------------------- 
          tipo_cuen             VARCHAR2(3)         --Tipo de cuenta, CR-Corriente, CA-Ahorros
        , num_cuen              VARCHAR2(11)        --N�mero de cuenta    
        , entidad               VARCHAR2(100)       --Entidad financiera/empresa
        , valor                 NUMBER(22,2)        --Valor
        , cuen_depo             NUMBER(8)           --Cuenta de deposito
        , portafolio            VARCHAR2(3)         --Portafolio N�mero 
    );
--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       02/01/2023 Cramirezs    000001       * Se crea type OBJECT para los datos de salida de las cartas de bancolombia.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
/  
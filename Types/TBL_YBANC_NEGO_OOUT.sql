PROMPT
PROMPT Se elimina TYPE table si existe
PROMPT
DROP TYPE tbl_ybanc_nego_cout;
--
PROMPT
PROMPT Creando TYPE TBL_YBANC_NEGO_OOUT
PROMPT
CREATE OR REPLACE TYPE tbl_ybanc_nego_oout IS OBJECT
    ( 
        ---------------------------------------------------------------------------------------------------------------------
        -- (OUT) Parametros de salida cartas bancolombia 
        --------------------------------------------------------------------------------------------------------------------- 
          ciudad                VARCHAR2(100)       --Descripci�n de la ciudad
        , ano                   NUMBER(4)           --Ano YYYY
        , mes                   NUMBER(2)           --Mes MM
        , dia                   NUMBER(2)           --Dia DD
        , razon                 VARCHAR2(100)       --Nombre o raz�n social
        , tipo_docu             VARCHAR(3)          --Tipo de documento CC, NIT, CE, PB 
        , identif               VARCHAR2(20)        --N�mero de identificaci�n
        , dv                    NUMBER(2)           --Digito de verificaci�n
        , Observ                VARCHAR2(200)       --Observaci�n
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

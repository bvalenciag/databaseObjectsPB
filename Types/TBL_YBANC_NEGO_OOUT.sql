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
          ciudad                VARCHAR2(100)       --Descripción de la ciudad
        , ano                   NUMBER(4)           --Ano YYYY
        , mes                   NUMBER(2)           --Mes MM
        , dia                   NUMBER(2)           --Dia DD
        , razon                 VARCHAR2(100)       --Nombre o razón social
        , tipo_docu             VARCHAR(3)          --Tipo de documento CC, NIT, CE, PB 
        , identif               VARCHAR2(20)        --Número de identificación
        , dv                    NUMBER(2)           --Digito de verificación
        , Observ                VARCHAR2(200)       --Observación
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

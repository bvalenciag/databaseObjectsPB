PROMPT
PROMPT Se elimina TYPE table si existe
PROMPT
DROP TYPE tbl_ybanc_reci_cout;
--
PROMPT
PROMPT Creando TYPE TBL_YBANC_RECI_OOUT
PROMPT
CREATE OR REPLACE TYPE tbl_ybanc_reci_oout IS OBJECT
    ( 
        ---------------------------------------------------------------------------------------------------------------------
        -- (OUT) Parametros de salida cartas bancolombia 
        --------------------------------------------------------------------------------------------------------------------- 
          entidad               VARCHAR2(100)       --Entidad financiera/empresa
        , cuen_depo             NUMBER(8)           --Cuenta de deposito
        , portafolio            VARCHAR2(3)         --Portafolio Número
        , valor                 NUMBER(22,2)        --Valor
        , fecha_ing             VARCHAR2(10)        --Fecha de ingreso de los fondos
        , tipo_cuen             VARCHAR2(3)         --Tipo de cuenta, CR-Corriente, CA-Ahorros
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
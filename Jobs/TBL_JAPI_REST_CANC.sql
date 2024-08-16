--
-- #VERSION: 1000
--
-- History
--
-- Versión    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       09/01/2024 Cramirezs    000001       * Se crea job para ejecución información de cancelaciones cada 12 Horas.
--                       Kilonova     MVP_2
-- ========== ========== ============ ============ ============================================================================================================
--
begin
  begin
    dbms_scheduler.drop_job('TBL_JAPI_REST_CANC');
  exception
    when others then
	  null;
  end;
  dbms_scheduler.create_job
  (
    job_name => 'TBL_JAPI_REST_CANC', 
    job_type => 'STORED_PROCEDURE', 
    job_action => 'gen_qapi_rest.api_rest_canc', 
    start_date => TO_TIMESTAMP_TZ('2024/01/09 08:00:05.000000 America/Bogota','yyyy/mm/dd hh24:mi:ss.ff tzr'),
    repeat_interval => 'freq=hourly;interval=12',    
    --FREQ=DAILY; BYHOUR=16,17,18;
    enabled => true,
    comments => 'Ejecuta el consumo de cancelaciones expuestos desde el APEX de SIFI.'
  );
end;
/
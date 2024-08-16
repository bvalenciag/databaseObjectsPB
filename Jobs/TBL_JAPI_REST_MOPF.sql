--
-- #VERSION: 1000
--
-- History
--
-- Versi�n    Date       User         Request      Description
-- ========== ========== ============ ============ ============================================================================================================
-- 1000       25/10/2023 Cramirezs    000001       * Se crea job para ejecuci�n informaci�n de movimientos PORFIN cada 5 minutos.
--                       Kilonova
-- ========== ========== ============ ============ ============================================================================================================
--
begin
  begin
    dbms_scheduler.drop_job('TBL_JAPI_REST_MOPF');
  exception
    when others then
	  null;
  end;
  dbms_scheduler.create_job
  (
    job_name => 'TBL_JAPI_REST_MOPF', 
    job_type => 'STORED_PROCEDURE', 
    job_action => 'gen_qapi_rest.api_rest_mopf', 
    start_date => TO_TIMESTAMP_TZ('2024/01/09 08:00:15.000000 America/Bogota','yyyy/mm/dd hh24:mi:ss.ff tzr'),
    repeat_interval => 'freq=MINUTELY;interval=5',    
    enabled => true,
    comments => 'Ejecuta el consumo de movimientos expuestos desde el APEX de PORFIN.'
  );
end;
/
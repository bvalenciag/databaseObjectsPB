CREATE OR REPLACE PROCEDURE gen_pcontrolpro(p_proceso        gen_tcontrolpro.cont_proceso%TYPE
                                          , p_llave          gen_tcontrolpro.cont_llave%TYPE
                                          , p_estado         gen_tcontrolpro.cont_sesion%TYPE
                                          , p_ty_msg     OUT gen_qgeneral.ty_msg
                                            ) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
    --
    --
    -- #VERSION: 1000
    --
    -- History
    --
    -- Versión    Date       User         Request      Description
    -- ========== ========== ============ ============ ============================================================================================================
    -- 1000       03/01/2023 Cramirezs    000001       * Se cra procedimiento
    --                       Kilonova
    -- ========== ========== ============ ============ ============================================================================================================
    --
    e_error     EXCEPTION;
    v_sesion    gen_tcontrolpro.cont_sesion%TYPE;
    v_maquina   gen_tcontrolpro.cont_maquina%TYPE;
    --
    CURSOR c_cont IS
        SELECT cont_usuains
             , cont_maquina
          FROM gen_tcontrolpro
         WHERE cont_proceso = p_proceso
           AND cont_llave   = p_llave
           AND cont_sesion  = v_sesion
           AND cont_estado  = 'P'
        ;
    r_cont c_cont%Rowtype;
    --
    CURSOR c_sys IS
        SELECT Sys_Context ('USERENV', 'SESSIONID')
             , Sys_Context ('USERENV', 'HOST')
          FROM Dual 
        ;
    --
BEGIN
    --
    p_ty_msg.cod_msg := 'OK';
    --si la sesion ya fue cerrada, se cambia el estado a F-Finalizado
    UPDATE gen_tcontrolpro
       SET cont_estado   = 'F'
     WHERE cont_proceso  = p_proceso
       AND cont_llave    = p_llave
       AND NOT EXISTS (SELECT 'S' 
                         FROM V$session 
                        WHERE Audsid = cont_sesion)
    ; 
    --
    --Recupera el id de la sesión y el host de la maquina.
    OPEN  c_sys;
    FETCH c_sys INTO v_sesion
                   , v_maquina
                    ;
    CLOSE c_sys;
    --
    IF p_estado = 'P' THEN--Procesando
        --
        OPEN c_cont;
        FETCH c_cont INTO r_cont;
        IF c_cont%found THEN
            --
            p_ty_msg.msg_msg := 'Error de concurrencia. proceso ocupado por el usuario '||r_cont.cont_usuains||' desde la maquina '||r_cont.cont_maquina;
            raise e_error;
        --
        ELSE
            --
            UPDATE gen_tcontrolpro
               SET cont_estado = p_estado
                 , cont_sesion = v_sesion
             WHERE cont_proceso = p_proceso
               AND cont_llave   = p_llave
               AND cont_sesion  = v_sesion
            ;
            IF SQL%ROWCOUNT = 0 THEN
                INSERT INTO gen_tcontrolpro(
                      cont_proceso
                    , cont_llave  
                    , cont_sesion 
                    , cont_maquina
                    , cont_estado 
                    , cont_fecins 
                    , cont_usuains
                )VALUES (
                      p_proceso
                    , p_llave        
                    , v_sesion
                    , v_maquina
                    , p_estado
                    , SYSDATE
                    , USER
                );
            --
            END IF;
            --
        END IF;
        CLOSE c_cont;
        --
    ELSIF p_estado = 'F' THEN--Finalizado
        --
        UPDATE gen_tcontrolpro
           SET cont_estado  = p_estado
         WHERE cont_proceso = p_proceso
           AND cont_llave   = p_llave
           AND cont_sesion  = v_sesion
        ;
    --
    ELSE
        --
        p_ty_msg.msg_msg := 'Error estado del proceso no valido, solo F-Finalizado y P-Procesando';
        raise e_error;
        --
    END IF;
    --
    COMMIT;--Commit Autonomo
    --
EXCEPTION
    WHEN e_error THEN
        p_ty_msg.cod_msg := 'ERROR';
    WHEN OTHERS THEN
        p_ty_msg.cod_msg := 'ERROR';
        p_ty_msg.msg_msg := 'Error no controlado GEN_PCONTROLPRO: '||sqlerrm;
END gen_pcontrolpro;
/
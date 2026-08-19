--Problematica:Cuanto pago cada cliente y en que estado quedo su pago?
--quiere saber:nombre de cliente, monto final pagado y estado de la transaccion
--devolver: nomnbre del cliente, monto final y estado pagado, cada fila con DBMS
--Reglas: usar JOIN + mas por una fila + cursor explicito
SET SERVEROUTPUT ON
DECLARE
    CURSOR c_pagos IS
        SELECT c.nombre, c.apellido, tp.monto_final, tp.estado
        FROM CLIENTE c
        JOIN RESERVA_TEMPORAL rt ON c.CLIENTE_ID = rt.CLIENTE_ID
        JOIN TRANSACCION_PAGO tp ON rt.RESERVA_ID = tp.RESERVA_ID;

    v_nombre_cliente CLIENTE.nombre%TYPE;
    v_apellido_cliente CLIENTE.apellido%TYPE;
    v_monto_final TRANSACCION_PAGO.monto_final%TYPE;
    v_estado_pago TRANSACCION_PAGO.estado%TYPE;

BEGIN
    OPEN c_pagos;
    LOOP
        FETCH c_pagos INTO v_nombre_cliente, v_apellido_cliente, v_monto_final, v_estado_pago;
        EXIT WHEN c_pagos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('=== REPORTE DE PAGOS ===');
        DBMS_OUTPUT.PUT_LINE('||-----------------------------||');
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || v_nombre_cliente || ' ' || v_apellido_cliente);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
        DBMS_OUTPUT.PUT_LINE('Monto Final: ' || v_monto_final);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
        dbms_output.put_line('Estado de Pago: ' || v_estado_pago);
        DBMS_OUTPUT.PUT_LINE('||-----------------------------||');
    END LOOP;
    CLOSE c_pagos;
    
END;
/
DECLARE
    TYPE boleta_cliente IS RECORD (
        nombre_cliente      VARCHAR2(200),
        monto_bruto         TRANSACCION_PAGO.MONTO_BRUTO%TYPE,
        descuento_aplicado  TRANSACCION_PAGO.DESCUENTO%TYPE,
        monto_final_pagado  TRANSACCION_PAGO.MONTO_FINAL%TYPE,
        estado_pago         TRANSACCION_PAGO.ESTADO%TYPE
    );
    v_boleta_cliente boleta_cliente;
BEGIN
    SELECT nombre, monto, descuento, monto_final, estado
    INTO v_boleta_cliente
    FROM (
        SELECT 
            c.NOMBRE || ' ' || c.APELLIDO AS nombre,
            tp.MONTO_BRUTO              AS monto,
            tp.DESCUENTO                AS descuento,
            tp.MONTO_FINAL              AS monto_final,
            tp.ESTADO                   AS estado
        FROM CLIENTE c 
        JOIN RESERVA_TEMPORAL rt ON c.CLIENTE_ID = rt.CLIENTE_ID
        JOIN TRANSACCION_PAGO tp ON rt.RESERVA_ID = tp.RESERVA_ID
        WHERE c.CLIENTE_ID = 1
        ORDER BY tp.FECHA_TRANSACCION DESC
    )
    WHERE ROWNUM = 1;

    DBMS_OUTPUT.PUT_LINE('  â•”â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•—');
    DBMS_OUTPUT.PUT_LINE('  â•‘       BOLETA DE PAGO - PUNTOTICKET   â•‘');
    DBMS_OUTPUT.PUT_LINE('  â• â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•£');
    DBMS_OUTPUT.PUT_LINE('  â•‘                                      â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘  Cliente : ' || RPAD(v_boleta_cliente.nombre_cliente, 26) || 'â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘  â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€  â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘  Monto Bruto     $' || LPAD(TO_CHAR(v_boleta_cliente.monto_bruto, '999G990'), 15) || '    â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘  Descuento      -$' || LPAD(TO_CHAR(v_boleta_cliente.descuento_aplicado, '999G990'), 15) || '    â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘  â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€  â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘  TOTAL PAGADO    $' || LPAD(TO_CHAR(v_boleta_cliente.monto_final_pagado, '999G990'), 15) || '    â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘                                      â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘  Estado : ' || RPAD(v_boleta_cliente.estado_pago, 26) || ' â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•‘                                      â•‘');
    DBMS_OUTPUT.PUT_LINE('  â•šâ•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•');
    DBMS_OUTPUT.PUT_LINE('     Gracias por su compra, vuelva pronto!');
END;
/

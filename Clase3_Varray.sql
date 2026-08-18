DECLARE
    TYPE asientos_cine IS VARRAY(6) OF VARCHAR2(3);

    v_asientos asientos_cine := asientos_cine('A1', 'A2', 'A3', 'B1', 'B2', 'B3');
BEGIN
    DBMS_OUTPUT.PUT_LINE('Se le asigno el asiento N°: ' || v_asientos(3));
    NULL;
END;
/


DECLARE
    TYPE rut_clientes IS VARRAY(5) OF VARCHAR2(12);
    v_rut_clientes rut_clientes := rut_clientes();
BEGIN
    v_rut_clientes.extend;
    v_rut_clientes(1) := '12345678-9';

    v_rut_clientes.extend;
    v_rut_clientes(2) := '98765432-1';

    v_rut_clientes.extend;
    v_rut_clientes(3) := '11111111-1';

    v_rut_clientes.extend;
    v_rut_clientes(4) := '22222222-2';

    v_rut_clientes.extend;
    v_rut_clientes(5) := '33333333-3';

    DBMS_OUTPUT.PUT_LINE('Los RUT de los clientes son:');
    FOR i IN 1 .. v_rut_clientes.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('  ' || v_rut_clientes(i));
    END LOOP;
END;
/
-- ● Paso 1: Creamos la base de datos transacciones y nos conectamos.
create database transacciones2;
\c transacciones2;
-- ● Paso 2: Creamos una tabla llamada cuentas con los campos numero_cuenta y balance.
create table cuentas (numero_cuenta int primary key, 
balance float check(balance >= 0.00)); --check es una constraint, valida que el balance siempre debe ser mayor o igual a 0.

\d cuentas

--● Paso 3: Insertamos dos registros a la tabla.
insert into cuentas (numero_cuenta, balance) values (1, 1000);
insert into cuentas (numero_cuenta, balance) values (2, 1000);

select * from cuentas;

/*● Paso 4: Si quisiéramos hacer una transferencia de $1000 desde nuestra cuenta
1 a la cuenta 2, una forma de asegurarnos que el monto de nuestro balance
disminuya en $1000 y el de la segunda cuenta aumenta en la misma cifra,
podría escribirse de la siguiente manera:*/

begin transaction; -- inicio de la transacción, consiste de dos acciones
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 1; -- con la misma columan balance se resta de una cuenta
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2; -- y a la otra cuenta se le suma el mismo monto

-- ● Paso 5: Verificamos el estado de la tabla.
select * from cuentas; -- se hizo la resta y suma entre las cuentas

--● Paso 6: Confirmamos la transacción con commit.
commit; -- se confirma y guarda la transacción

--probar error
BEGIN TRANSACTION;
UPDATE cuentas SET balance = balance + 1000 WHERE numero_cuenta = 2;
UPDATE cuentas SET balance = balance - 1000 WHERE numero_cuenta = 1;
--ERROR:  el nuevo registro para la relación «cuentas» viola la restricción «check» «cuentas_balance_check»
--DETAIL:  La fila que falla contiene (1, -1000).
select * from cuentas;
-- ERROR:  transacción abortada, las órdenes serán ignoradas hasta el fin de bloque de transacción 
-- en el caso de hacer un COMMIT de una transacción CON ERROR, se hará un ROLLBACK AUTOMATICAMENTE
ROLLBACK;

--● Paso 4: Intentemos registrar una nueva cuenta de número 3 en nuestra tabla “cuentas” con un saldo de $5000 y
-- justo luego guardemos ese punto de la transacción con un SAVEPOINT de nombre “nueva_cuenta”.
BEGIN TRANSACTION;
INSERT INTO cuentas(numero_cuenta, balance) VALUES (
    3, 5000);
    select * from cuentas;
SAVEPOINT nueva_cuenta; -- EL SAVEPOINT PERMITE VOLVER A ESTE PUNTO Y NO AL COMMIT ANTERIOR, CONSERVANDO EL INSERT.

/*● Paso 5: Hasta este punto tenemos la transacción en curso y hemos fijado que
podríamos volver a este estado en cualquier circunstancia. Ahora, intentemos
transferir a esta nueva cuenta $3000 desde la cuenta 2. Para esto continua la
transacción de la siguiente manera.*/
UPDATE cuentas SET balance = balance + 3000 WHERE numero_cuenta = 3;
    select * from cuentas;
UPDATE cuentas SET balance = balance - 3000 WHERE numero_cuenta = 2;
    select * from cuentas;
--ERROR:  el nuevo registro para la relación «cuentas» viola la restricción «check» «cuentas_balance_check»
--DETAIL:  La fila que falla contiene (2, -1000).

ROLLBACK TO nueva_cuenta;
    select * from cuentas;
COMMIT;
    select * from cuentas;

/* A continuación, deberás insertar al menos 10 registros más en la base de datos de
transacciones. Una vez ingresados, genera un reporte con los siguientes datos:
● Reporta aquellas cuentas cuyo balance sea mayor a 2000.
● Reporta cuántas tienen un balance inferior a 1000.
● Reporta el promedio total de las cuentas registradas según su balance.
● Reporta el promedio de cuentas cuyo balance sea mayor o igual a 10000.
*/
-- ● Inserción de registros
INSERT INTO cuentas(numero_cuenta, balance) VALUES 
(4, 7000);
INSERT INTO cuentas(numero_cuenta, balance) VALUES 
(5, 500);
INSERT INTO cuentas(numero_cuenta, balance) VALUES 
(6, 12000);
INSERT INTO cuentas(numero_cuenta, balance) VALUES 
(7, 900);
INSERT INTO cuentas(numero_cuenta, balance) VALUES 
(8, 100);
INSERT INTO cuentas(numero_cuenta, balance) VALUES 
(9, 20000);
INSERT INTO cuentas(numero_cuenta, balance) VALUES 
(10, 50);

select * from cuentas;
--● Reporta aquellas cuentas cuyo balance sea mayor a 2000.
select numero_cuenta from cuentas where balance > 2000;
/*  numero_cuenta
---------------
            3
            4
            6
            9 */

-- ● Reporta cuántas tienen un balance inferior a 1000.
select numero_cuenta from cuentas where balance < 1000;
/*  numero_cuenta
---------------
            1
            5
            7
            8
            10
*/
-- ● Reporta el promedio total de las cuentas registradas según su balance.
select AVG(balance) as promedio_total from cuentas;
/*  promedio_total
----------------
    4755 */

-- ● Reporta el promedio de cuentas cuyo balance sea mayor o igual a 10000.
select avg(balance) as promedio from cuentas where balance >= 10000;
/*   promedio 
    ----------
    16000   */
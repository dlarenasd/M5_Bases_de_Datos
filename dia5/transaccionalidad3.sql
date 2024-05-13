-- ● Paso 1: Creamos la base de datos transacciones y nos conectamos.
create database transacciones;
\c transacciones;
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

-- ● Paso 7: Continuemos con el ejercicio anterior y apliquemos el uso de ROLLBACK. Para ello haremos un nuevo insert a la base de datos.
insert into cuentas (numero_cuenta, balance) values (3, 1000);
select * from cuentas;
-- ● Paso 8: Iniciamos una transacción para transferir 1000 de la cuenta 3 a la 1.
begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 3;
UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;

--● Paso 9: Rollback.
ROLLBACK; --revierte las acciones hasta el último commit y cierra la transacción

commit;

-- SAVE POINT 
begin transaction;
UPDATE cuentas set balance = balance - 1000 where numero_cuenta = 3;

SAVEPOINT descuento3;

UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 1;

ROLLBACK TO descuento3; 

UPDATE cuentas set balance = balance + 1000 where numero_cuenta = 2;

commit;

\echo :AUTOCOMMIT -- es una función que hace commit automáticamente después de cada cambio que hagamos en la base de datos, por defecto está "on"

update cuentas set balance = balance + 1000 where numero_cuenta = 1;

-- BORRADO FÍSICO
delete from cuentas where numero_cuenta = 3;

--para el borrado lógico se usa una columna adicional como pivote, booleana

alter table cuentas add column activa boolean;

update cuentas set activa = true;
--BORRADO LÓGICO
update cuentas set activa = false where numero_cuenta = 3;



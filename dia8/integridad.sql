CREATE DATABASE descripciones;
\c descripciones;

-- ● Paso 1: Creamos la tabla clientes create table clientes;
create table clientes (
    id integer unique not null, 
    name varchar(25) not null, 
    email varchar(50));
-- ● Paso 2: Insertamos al menos 3 registros, todos sin ingresar el campo email.
insert into clientes(id, name) values (1, 'Nombre 1');
insert into clientes(id, name) values (2, 'Nombre 2');
insert into clientes(id, name) values (3, 'Nombre 3');
insert into clientes(id, name, email) values (4, 'Nombre 4', 'd@l.com');
select * from clientes;
/* id |   name   | email
------+----------+-------
    1 | Nombre 1 |
    2 | Nombre 2 |
    3 | Nombre 3 |
*/

-- ● Paso 3: Modificamos el campo email a not null con alter table.
ALTER TABLE clientes 
ALTER COLUMN email 
SET NOT NULL;
-- ERROR:  la columna «email» de la relación «clientes» contiene valores null

/*● Paso 4: Debemos actualizar la tabla con el comando UPDATE, seguidamente 
debemos indicar la columna a modificar y por último con WHERE definir la
condición cuando el campo sea nulo.*/
UPDATE clientes SET email = '' 
WHERE email IS NULL;
-- ● Paso 5: Corremos nuevamente el comando de alteración de la columna
ALTER TABLE clientes 
ALTER COLUMN email 
SET NOT NULL;

-- En la tabla clientes del ejercicio anterior, crearemos un campo fecha. Para esto, modifica la tabla y asigna la restricción.
Alter TABLE clientes add column fecha date not null; 
-- ERROR:  la columna «fecha» de la relación «clientes» contiene valores null. Ya hay registros y no tienen datos en la columna que estamos agregando
Alter TABLE clientes add column fecha date not null default now(); 

-- FUNCIÓN COALESCE  permite seleccionar campos que sean nulos en una tabla y modificarlos con un valor determinado.
UPDATE clientes SET email = COALESCE(email, 'Correo electrónico no ingresado');
select * from clientes;
-- QUITAR UNA RESTRICCIÓN
ALTER TABLE IF EXISTS public.clientes
    ALTER COLUMN email DROP NOT NULL;

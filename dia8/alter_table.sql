-- ● Paso 1: Creamos la base de datos con el nombre Mawashi Phones.
create database mawashi_phones; 
--● Paso 2: Nos conectamos a la base de datos.
\c mawashi_phones

-- Paso 3: Creamos la tabla con los campos que nos solicita inicialmente el cliente.
create table phones (
    id int primary key, 
    modelo varchar(50), 
    mac_address int unique,
    fecha_fabricacion varchar(50));
-- ● Paso 4: Insertamos un registro para probar la tabla.
insert into phones (id, modelo, mac_address, fecha_fabricacion) values (1, 'Iphone 14', '1B:2A:3C:4D:5F:6G', '2022-09-09');
-- ERROR:  la sintaxis de entrada no es válida para tipo integer: «1B:2A:3C:4D:5F:6G»
-- LINE 1: ...dress, fecha_fabricacion) values (1, 'Iphone 14', '1B:2A:3C:...

-- ● Paso 5: Modificamos el tipo de dato definido en el campo mac_address.
alter table phones alter column mac_address type varchar(50);

-- Paso 6: Verificar
\d+ phones

-- ● Paso 7: Insertamos nuevamente el registro.
insert into phones (id, modelo, mac_address, fecha_fabricacion) values (1, 'Iphone 14', '1B:2A:3C:4D:5F:6G', '2022-09-09');

-- ● Paso 8: Con el alter table también podemos agregar nuevas restricciones sin reescribir las ya existentes.
alter table phones alter column mac_address set not null;

insert into phones (id, modelo, mac_address, fecha_fabricacion) values (2, 'Iphone 15', '2022-09-09');
-- ERROR:  INSERT tiene más columnas de destino que expresiones
-- LINE 1: insert into phones (id, modelo, mac_address, fecha_fabricaci...
insert into phones (id, modelo, mac_address, fecha_fabricacion) values (1, 'Iphone 14', NULL, '2022-09-09');
-- ERROR:  el valor nulo en la columna «mac_address» de la relación «phones» viola la restricción de no nulo
-- DETAIL:  La fila que falla contiene (1, Iphone 14, null, 2022-09-09).

--CREAR UN USUARIO 
CREATE USER Diego WITH PASSWORD 'Admin1234'; -- contraseña provisoria

--crear base de datos para el usuario
CREATE DATABASE diego WITH OWNER Diego; 

--asignar permisos
ALTER USER Diego with SUPERUSER CREATEDB CREATEROLE;
select usename from pg_user;

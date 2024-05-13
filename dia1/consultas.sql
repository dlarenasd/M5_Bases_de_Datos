CREATE DATABASE "Diego"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- lo primero a realizar es conectarse a la base de datos desde la terminal-->psql -U postgres (postgres es el usuario)
-- Paso 1: Accedemos al cliente de postgresql via el terminal.
-- Paso 2: Crea una base de datos llamada prueba1.
CREATE DATABASE prueba1; -- sentencia SQL usa ;
-- Paso 3: Lista las bases de datos creadas.
\l --
-- Paso 4: Conéctate a la base de datos.
\c prueba1  -- You are now connected to database "prueba1" as user "postgres".

-- Paso X: Salir de la terminal de postgres.
\q

-- VARCHAR = STR
create table clientes(
    nombre varchar(30),
    apellido varchar(30)
);
-- listar las tablas de una base de datos
\d 
-- detalla una tabla (ingresando el nombre)
\d clientes

\d+ clientes

--insertar valores a una tabla
insert into clientes (nombre, apellido) values ('Diego','Larenas');
insert into clientes (nombre, apellido) values ('Verónica','Bartolotti');
insert into clientes values ('Juan Carlos', 'Maguire'); --> se puede obviar la especificación de las columnas, pero se complica cuando hay campos opcionales
insert into clientes (apellido, nombre) values ('Mardo', 'Javi'); --> se puede establecer el orden en que vamos a ingresar datos
--consultar registros en una tabla
select * from clientes;
select * from clientes order by nombre desc;

-- BORRAR ALGÚN REGISTRO DE LA TABLA
delete from clientes where nombre = 'Javi';

-- ELIMINAR los datos de una tabla (¡RESPALDAR ANTES!)
delete from clientes; --> no usar where para especificar

insert into clientes values ('Ignacio', 'Mc-Manus');
insert into clientes values ('Valentina', 'Reyes');
insert into clientes values ('Diego', 'Ramoneda');
insert into clientes values ('Sofía', 'Gozze');
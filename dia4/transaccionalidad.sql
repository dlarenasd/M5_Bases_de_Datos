-- DQL: Data Query Language/ Lenguaje de Consulta de Datos
-- DDL:
-- DCL:
-- DML: Data Manipulation Language/ Lenguaje de Manipulación de Datos: INSERT; UPDATE, DELETE

-- ● Paso 1: Creamos una base de datos de comidas típicas chilenas.
create database comidas_tipicas;
-- ● Paso 2: Creamos una tabla llamada cocina chilena con los campos id y nombre.
\c comidas_tipicas
create table cocina_chilena(
    id int, 
    nombre varchar(50));
\d cocina_chilena
-- ● Paso 3: Insertamos 2 registros a la tabla con sus respectivos campos.
insert into cocina_chilena (id, nombre) values ('1','Pastel de choclo');
insert into cocina_chilena (id, nombre) values ('2', 'Umitas');

select * from cocina_chilena;

alter table cocina_chilena add primary key(id);

-- ● Paso 4: Para actualizar un registro utilizamos update. ACTUALIZAR UN REGISTRO
UPDATE cocina_chilena 
set nombre='Humitas' 
where id = '2'; --dado que especificamos que el dato es de tipo integer, la tabla hace la conversión
/* Con el código SQL anterior estamos:
1. Utilizamos la sentencia update.
2. Pasamos el nombre de la tabla en la cual se ejecutará el update
3. Utilizamos set, seleccionamos el nombre de la columna y el nuevo valor para el
registro.
4. Evaluamos condicionalmente con where la selección del registro cuyo ID sea 2. */

UPDATE cocina_chilena 
set nombre='Pastel de Choclo' 
where id = '1';

-- "Ingresa 3 registros más a la tabla e intenciona el update en al menos 2 de ellos"
insert into cocina_chilena (id, nombre) values ('3','Porotos con mazmorra');
insert into cocina_chilena (id, nombre) values ('4','Carbonara');
insert into cocina_chilena (id, nombre) values ('5','Curanto');

select * from cocina_chilena;

UPDATE cocina_chilena 
set nombre='Porotos con Mazamorra' 
where id = '3';

UPDATE cocina_chilena 
set nombre='Carbonada' 
where id = '4';

UPDATE cocina_chilena 
set nombre='Curanto' 
where id = '5';

select * from cocina_chilena;

-- DELETE 
/* ● Paso 5: Eliminar un registro lo podremos hacer con la sentencia Delete. Así
como hicimos con la actualización, utilizaremos el id para capturar un registro
puntual.
*/
delete from cocina_chilena 
where id = 2;

--¿Qué sucede si utilizamos delete o update sin la cláusula where?
delete from cocina_chilena ; --se eliminan todos los registros

insert into cocina_chilena (id, nombre) values ('1','Pastel de choclo');
insert into cocina_chilena (id, nombre) values ('2','Humitas');
insert into cocina_chilena (id, nombre) values ('3','Porotos con mazmorra');
insert into cocina_chilena (id, nombre) values ('4','Carbonara');
insert into cocina_chilena (id, nombre) values ('5','Curanto');

select * from cocina_chilena;

UPDATE cocina_chilena 
set nombre='Porotos con Mazamorra' 
where id = '3';

UPDATE cocina_chilena 
set nombre='Carbonada' 
where id = '4';
-- ● Paso 6: Eliminar múltiples registros en la tabla. Para ello añadiremos platos de cocina chilena.
--Eliminamos entonces múltiples registros, supongamos que queremos eliminar aquellos cuyo id vayan del 3 hasta el 5.
delete from cocina_chilena 
where id in (3, 4, 5); -- IN IDENTIFICA LA PRESENCIA DE UN DATO Y ACTÚA SOBRE ÉL

delete from cocina_chilena 
where id = 5
and id = 3; -- DELETE 0, NADA VA A TENER 2 ID, BUSCA UN REGISTRO QUE TENGA AMBOS

delete from cocina_chilena 
where id = 5
OR id = 3; -- DELETE 2, EL IN USADO PREVIAMENTE ES UN GRAN "OR"

delete from cocina_chilena 
where id = 2
and nombre = 'Carbonada'; -- DELETE 0, "AND" no elimina porque nada tiene ambas condiciones

delete from cocina_chilena 
where id = 2
or nombre = 'Carbonada'; -- DELETE 2

/*
Crea una nueva base de datos, en ella deberás almacenar información de perros o
gatos, los campos deberán ser:
1. ID
2. Nombre
3. Raza
4. Edad
Ingresa al menos unos 5 registros e intenciona las acciones de:
● Update.
● Delete.*/

\c postgres
CREATE DATABASE registro_animales;
\c registro_animales
CREATE TABLE registro (
    id int, 
    nombre varchar(30),
    raza varchar (25),
    edad int
);

insert into registro values (1, 'Tofu', 'Gato', 12);
insert into registro values (2, 'Tesla', 'Perro', 6);
insert into registro values (3, 'Totoro', 'Gato', 3);
insert into registro values (4, 'Amapola', 'Gato', 13);
insert into registro values (5, 'Olvier', 'Gato', 13);

update registro
set edad = 15
where id = 1;

update registro
set raza = 'Gato'
where id = 2;

update registro
set edad = 1
where id = 3;

update registro
set raza = 'Perro'
where id = 4;

delete from registro
where id = 5;

alter table registro add primary key(id);

delete from registro
where id = 2; -- editaremos nuevamente un registro

insert into registro values (2, 'Tesla', 'Perro', 6);

update registro
set raza = 'Gato', 
edad = 7
where id = 2
RETURNING *;

UPDATE registro
set raza = raza +' DPC'
RETURNING *; -- HINT:  Ningún operador coincide en el nombre y tipos de argumentos. Puede ser necesario agregar conversión explícita de tipos.

UPDATE registro
set edad = edad + 1
RETURNING *; -- SE PUEDE USAR EL OPERADOR CON DATOS NUMÉRICOS

UPDATE registro
set edad = edad - 1
RETURNING *;

UPDATE registro
set raza = CONCAT (raza, ' DPC')
where id in (1, 2, 3)
RETURNING *; -- PARA CONCATENAR SE USA "CONCAT ( DATO, A AÑADIR)"

UPDATE registro
SET raza = 'Perra' || ' ' || 'quiltra'
where id = 4
RETURNING *; -- también se puede usar este método

select * from registro;
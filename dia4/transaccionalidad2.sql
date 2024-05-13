-- AUTOINCREMENTO DE DATOS
-- ● Paso 1: Creamos la base de datos restricciones_psql. Luego debemosconectarnos a ella.
create database restricciones_psql;
\c restricciones_psql

-- ● Paso 2: Creamos una tabla llamada company con los campos id y nombre.
create table company (
    id serial primary key, 
    nombre varchar not null unique);  -- id de tipo serial, no int. eso hace que se rellene automaticamente con cada registro 
                                        -- not null y unique para delimitar el nombre que no puede ser null y no puede repetirse

select * from company; 
\d company
-- ● Paso 3: Hacemos dos insert a la tabla.
insert into company(nombre) values('Amazon');
insert into company(nombre) values('Apple'); --sin ingresarles un id, se genera de forma automática y en secuencia

-- ● Paso 4: Validar la restricción Unique dentro de la tabla. Para ello intentaremos ingresar un nombre que ya exista.
insert into company(nombre) values('Apple');
-- ERROR:  llave duplicada viola restricción de unicidad «company_nombre_key»
-- DETAIL:  Ya existe la llave (nombre)=(Apple).

insert into company(nombre) values('Microsoft'); -- al hacer el select tiene id 4, porque el 3 se intentó usar en el paso anterior de la secuencia

--NEXTVAL
select nextval('company_id_seq'::regclass); -- 5
select nextval('company_id_seq'); -- 6 las solcitudes lo avanzan
select * from company_id_seq; -- el select no
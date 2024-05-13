-- 1. Comienza a grabar
-- 2. Entra al terminal
-- 3. Ingresa al cliente de postgreSQL desde el terminal
psql -U postgres 
/* 4. Crea una base de datos llamada desafio-tuNombre-tuApellido-3digitos
Ejemplo: desafio-Camila-Fernandez-931 no acepta guíon normal, solo bajo*/ 
CREATE DATABASE desafio_diegolarenas_013;
-- 5. Ingresa a la base de datos creada.
\c desafio_diegolarenas_013
/* 6. Crea una tabla llamada clientes, con una columna llamada email de tipo
varchar(50), una columna llamada nombre de tipo varchar sin limitación, una
columna llamada teléfono de tipo varchar(16), un campo llamado empresa de
tipo varchar(50) y una columna de tipo smallint, para indicar la prioridad del
cliente. Ahí se debe ingresar un valor entre 1 y 10, donde 10 es más prioritario.*/
CREATE TABLE clientes (
    email varchar (50),
    nombre varchar,
    teléfono varchar(16),
    empresa varchar (50),
    prioridad smallint
);
\d clientes 
select * from clientes;

-- 7. Ingresa 5 clientes distintos con distintas prioridades, el resto de los valores los puedes inventar.
insert into clientes (email, nombre, teléfono, empresa, prioridad)values ('plira@gmail.com', 'Pedro Lira', '56912345678', 'ASIDEF', 9);
insert into clientes (nombre, email, teléfono, empresa, prioridad) values ('Gonzalo Frez', 'gfrez@yahoo.es', '56912345671', 'KNS', 7);
insert into clientes values ('farrnav@gmail.com', 'Felipe Arriagada', '56912345675', 'Gym Kulgy', 10);
insert into clientes values ('fperez@ufro.cl', 'Felipe Pérez', '56912345658', 'UFRO', 5);
insert into clientes values ('kthlara@gmail.com', 'Katherine Lara', '56912345547', 'Haki Vet', 3);

select * from clientes;

-- 8. Selecciona los tres clientes de mayor prioridad.
SELECT * FROM clientes ORDER BY prioridad DESC LIMIT 3;
-- 9. Selecciona, de la tabla clientes, una prioridad o una empresa, de forma que el resultado devuelva 2 registros.
select * from clientes where prioridad = 9 or empresa = 'Haki Vet';
-- 10. Sal de postgreSQL.
\q 

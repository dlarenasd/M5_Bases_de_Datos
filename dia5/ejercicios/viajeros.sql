CREATE DATABASE registro_viajeros
\c registro_viajeros

-- Crear la tabla Viajeros
CREATE TABLE Viajeros (
    viajero_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    genero CHAR(5) NOT NULL,
    email VARCHAR(250),
    telefono CHAR(50) NOT NULL,
    rut CHAR(10) NOT NULL UNIQUE
);

-- Crear la tabla Destinos
CREATE TABLE Destinos (
    destino_id SERIAL PRIMARY KEY,
    nombre_destino VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50),
    pais VARCHAR(50)
);

-- Crear la tabla Tickets
CREATE TABLE Tickets (
    ticket_id SERIAL PRIMARY KEY,
    destino_id INT REFERENCES DESTINOS (destino_id),
    viajero_id INT REFERENCES Viajeros(viajero_id),
    numero_boleto VARCHAR(50) NOT NULL UNIQUE,
    fecha_emision DATE,
    fecha_salida DATE,
    fecha_retorno DATE
);

-- Inserts para la tabla Viajeros
INSERT INTO Viajeros (nombre, genero, email, telefono, rut) VALUES
('Juan Perez', 'M', 'juan@email.com', '123456789', '1111111111'),
('Maria Rodriguez', 'F', 'maria@email.com', '987654321', '2222222222'),
('Carlos Gonzalez', 'M', 'carlos@email.com', '111222333', '3333333333'),
('Luisa Martinez', 'F', 'luisa@email.com', '444555666', '4444444444'),
('Pedro Hernandez', 'M', 'pedro@email.com', '777888999', '5555555555'),
('Ana Lopez', 'F', 'ana@email.com', '333444555', '6666666666'),
('Jorge Ramirez', 'M', 'jorge@email.com', '666777888', '7777777777'),
('Sofia Torres', 'F', 'sofia@email.com', '999000111', '8888888888'),
('Daniel Castro', 'M', 'daniel@email.com', '222333444', '9999999999'),
('Laura Garcia', 'F', 'laura@email.com', '555666777', '0000000000'),
('Manuel Silva', 'M', 'manuel@email.com', '888999000', '1231231231'),
('Elena Vargas', 'F', 'elena@email.com', '111222333', '4564564564'),
('Gabriel Morales', 'M', 'gabriel@email.com', '444555666', '7897897897'),
('Isabel Rios', 'F', 'isabel@email.com', '777888999', '0120120120'),
('Hector Mendoza', 'M', 'hector@email.com', '333444555', '9876543210');

-- Inserts para la tabla Destinos
INSERT INTO Destinos (nombre_destino, ciudad, pais) VALUES
('Playa del Carmen', 'Playa del Carmen', 'México'),
('Machu Picchu', 'Cuzco', 'Perú'),
('Torres del Paine', 'Puerto Natales', 'Chile'),
('Gran Barrera de Coral', 'Queensland', 'Australia'),
('Monte Everest', 'Khumbu', 'Nepal'),
('Santorini', 'Santorini', 'Grecia'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Kioto', 'Kioto', 'Japón'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos'),
('Marrakech', 'Marrakech', 'Marruecos');

-- Inserts para la tabla Tickets
INSERT INTO Tickets (viajero_id, destino_id, numero_boleto, fecha_emision, fecha_salida, fecha_retorno) VALUES
(1, 1, 'T111111', '2024-01-04', '2024-01-10', '2024-01-20'),
(2, 2, 'T222222', '2024-01-05', '2024-02-01', '2024-02-15'),
(2, 3, 'T333333', '2024-01-06', '2024-03-05', '2024-03-20'),
(4, 4, 'T444444', '2024-01-07', '2024-04-12', '2024-05-01'),
(5, 5, 'T555555', '2024-01-08', '2024-06-02', '2024-06-20'),
(6, 1, 'T666666', '2024-01-09', '2024-07-15', '2024-08-01'),
(4, 2, 'T777777', '2024-01-10', '2024-09-03', '2024-09-20'),
(8, 3, 'T888888', '2024-01-11', '2024-10-18', '2024-11-01'),
(9, 4, 'T999999', '2024-01-12', '2024-12-05', '2024-12-20'),
(10, 5, 'T101010', '2024-01-13', '2025-01-02', '2025-01-20'),
(15, 1, 'T1111111', '2024-01-14', '2025-02-10', '2025-02-25'),
(12, 2, 'T121212', '2024-01-15', '2025-03-15', '2025-04-01'),
(13, 3, 'T131313', '2024-01-16', '2025-05-02', '2025-05-20'),
(14, 4, 'T141414', '2024-01-17', '2025-06-12', '2025-06-30'),
(15, 5, 'T151515', '2024-01-18', '2025-07-20', '2025-08-05');

select * from Viajeros;
select * from Destinos;
select * from Tickets;

/* 1. Obtener una lista de todos los viajeros y la información de sus boletos, incluyendo
aquellos viajeros que no tengan boletos emitidos. En el caso de los viajeros con
boleto, mostrar su destino.*/

SELECT viajeros.nombre, tickets.numero_boleto, destinos.nombre_destino
FROM viajeros
LEFT JOIN tickets ON viajeros.viajero_id = tickets.viajero_id
LEFT JOIN destinos ON tickets.destino_id = destinos.destino_id;

-- 2. Mostrar la información del boleto T123456 junto con los detalles del viajero y destino correspondiente a ese boleto.
SELECT tickets.numero_boleto, viajeros.nombre, destinos.nombre_destino
from tickets
LEFT JOIN Viajeros on tickets.viajero_id =Viajeros.viajero_id 
LEFT JOIN destinos ON tickets.destino_id = destinos.destino_id
where numero_boleto = 'T123456';


-- 3. Listar todos los viajeros que tienen fecha de salida o de retorno el '2024-01-10'

select viajeros.nombre, Tickets.fecha_salida, Tickets.fecha_retorno
from viajeros
LEFT JOIN Tickets on Viajeros.viajero_id = tickets.viajero_id
where Tickets.fecha_salida = '2024-01-10' or Tickets.fecha_retorno = '2024-01-10';
-- 4. Obtener el número total de boletos por cada género

select genero, count(viajeros.genero)
from viajeros
inner JOIN tickets on Viajeros.viajero_id = tickets.viajero_id
group by genero;

SELECT tickets.numero_boleto, viajeros.nombre, viajeros.genero
from tickets
LEFT JOIN Viajeros on tickets.viajero_id =Viajeros.viajero_id; --verificación

-- 5. Obtener un listado de todos los viajeros que han viajado a Playa del Carmen
select viajeros.nombre, Destinos.nombre_destino
from viajeros
LEFT JOIN tickets ON viajeros.viajero_id = tickets.viajero_id
LEFT JOIN destinos ON tickets.destino_id = destinos.destino_id
where destinos.nombre_destino = 'Playa del Carmen';


-- Además, desea que insertemos algunos datos de prueba y comprobemos las restricciones de los campos.
/*
Ingresa tres nuevos tickets con la siguiente información:
1. Ticket 1
destino_id:3
viajero_id:4
numero_boleto:T171717
fecha_salida:2024-03-28
fecha_retorno:2024-04-01
2. Ticket 2
destino_id:5
viajero_id:10
numero_boleto:T888888
fecha_salida:2024-03-28
fecha_retorno:2024-04-01
3. Ticket 3
destino_id:4
numero_boleto:T202020
fecha_salida:2024-03-28
fecha_retorno:2024-04-01

*/
insert into tickets (destino_id, viajero_id, numero_boleto, fecha_salida, fecha_retorno) VALUES
(3, 4, 'T171717', '2024-03-28', '2024-04-01'); --no lanza error a pesar de no tener fecha_emision, esto es porque no hay restricción NotNull

select * from tickets;

insert into tickets(destino_id, viajero_id, numero_boleto, fecha_salida, fecha_retorno) values
(5, 10, 'T888888', '2024-03-28', '2024-04-01');
-- ERROR:  llave duplicada viola restricción de unicidad «tickets_numero_boleto_key» restricción Unique
-- DETAIL:  Ya existe la llave (numero_boleto)=(T888888). 

insert into tickets (destino_id, numero_boleto, fecha_salida, fecha_retorno) values 
(4,'T202020','2024-03-28', '2024-04-01'); -- no tiene restricción de NotNull en viajero_id ni en fecha_emision

select * from tickets;

-- A continuación borra los siguientes registros:
-- ● Ticket con ID 4
delete from tickets
where ticket_id = 4; --se pudo

-- ● Viajero con ID 2
delete from viajeros
where viajero_id = 2; --viajero_id es una clave de la tabla tickets
-- ERROR:  update o delete en «viajeros» viola la llave foránea «tickets_viajero_id_fkey» en la tabla «tickets»
-- DETAIL:  La llave (viajero_id)=(2) todavía es referida desde la tabla «tickets».


-- ● Destino con ID 5
delete from Destinos
where destino_id = 5; --destino_id es una clave de la tabla tickets
-- ERROR:  update o delete en «destinos» viola la llave foránea «tickets_destino_id_fkey» en la tabla «tickets»
-- DETAIL:  La llave (destino_id)=(5) todavía es referida desde la tabla «tickets».

/*¿Por qué pudiste borrar algunos registros y otros no?
¿Qué solución podrías entregar para borrar todos los registros solicitados?
*/
-- ● Viajero con ID 2
select viajeros.nombre, tickets.viajero_id
from viajeros
inner join Tickets on viajeros.viajero_id = tickets.viajero_id
group by viajeros.nombre , tickets.viajero_id
order by tickets.viajero_id; --chequear qué viajero tiene id 2, es 'Maria Rodriguez'

delete from tickets where viajero_id = 2; --borra los dos tickets
delete from viajeros where nombre = 'Maria Rodriguez'; -- permite borrar a la viajera

-- ● Destino con ID 5
select destinos.nombre_destino, tickets.destino_id
from destinos 
inner join tickets on destinos.destino_id = tickets.destino_id
order by destino_id; -- el destino con id 5 es el Monte Everest 

delete from tickets where destino_id = 5; -- borrar los 3 tickets
delete from destinos where nombre_destino = 'Monte Everest'; -- borrar el destino

/* 
Crea una tabla llamada País que contenga las siguientes columnas:
país_id, nombre_país, ciudad y código_postal. Recuerda indicar sus correspondientes
tipos de datos y restricciones (el nombre del país y el código postal no pueden ser nulos).*/

CREATE TABLE pais (
    pais_id SERIAL,
    nombre_país VARCHAR (50) NOT NULL,
    ciudad VARCHAR (50),
    codigo_postal VARCHAR (25) NOT NULL);

-- Luego, realiza los inserts correspondientes a los países y ciudades que tenías originalmente registrados en la tabla destinos.

INSERT INTO pais (ciudad, nombre_país, codigo_postal) VALUES
('Playa del Carmen', 'México', '01'),
('Cuzco', 'Perú', '02'),
('Puerto Natales', 'Chile', '03'),
('Queensland', 'Australia', '04'),
('Khumbu', 'Nepal', '05'),
('Santorini', 'Grecia', '06'),
('Marrakech', 'Marruecos', '07'),
('Kioto', 'Japón', '08');

alter table pais add primary key(pais_id);

select * from pais;
-- Finalmente, realiza estos tres pasos:
-- ● Modifica la tabla Destinos para agregar el pais_id como FK
alter table Destinos
add column pais_id int REFERENCES pais (pais_id);

-- ● Actualiza la tabla Destinos para que coincidan los pais_id en ambas tablas según el nombre de destino.
update Destinos 
SET pais_id = (
    select pais_id 
    from pais
    where pais.nombre_país = destinos.pais
    limit 1
);

select *
from destinos
inner join pais on destinos.pais_id = pais.pais_id;
-- ● Borra las columnas país y ciudad de la tabla Destinos
alter table destinos drop column pais;
alter table destinos drop column ciudad;

select *
from destinos
inner join pais on destinos.pais_id = pais.pais_id
order by destinos.pais_id;

select * from destinos;


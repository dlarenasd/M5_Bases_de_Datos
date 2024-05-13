CREATE DATABASE libreria;
\c libreria

CREATE TABLE autores (
    id INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE libros (
    id INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor_id INT NOT NULL,
    FOREIGN KEY (autor_id) REFERENCES autores (id)
);

INSERT INTO autores (id, nombre)
VALUES
    (1, 'Juan Pérez'),
    (2, 'María García'),
    (3, 'Pedro Rodríguez');

INSERT INTO libros (id, titulo, autor_id)
VALUES
    (1, 'El Quijote', 1),
    (2, 'La Divina Comedia', 2),
    (3, 'Hamlet', 3);

SELECT libros.titulo, autores.nombre
FROM libros
INNER JOIN autores
ON libros.autor_id = autores.id;
/*
    titulo       |     nombre      
------------------+-----------------
El Quijote        | Juan Pérez
La Divina Comedia | María García
Hamlet            | Pedro Rodríguez*/

-- ● Paso 4: Comprobación de la restricción de clave foránea.
delete from autores;
-- ERROR:  update o delete en «autores» viola la llave foránea «libros_autor_id_fkey» en la tabla «libros»
-- DETAIL:  La llave (id)=(1) todavía es referida desde la tabla «libros».
delete from autores where id = 3;
-- ERROR:  update o delete en «autores» viola la llave foránea «libros_autor_id_fkey» en la tabla «libros»
-- DETAIL:  La llave (id)=(3) todavía es referida desde la tabla «libros».

delete from libros; --esto permitirá borrar autores porque ya no habrá referencia, a pesar de que siguen habiendo restricciones en las tablas

--BORRADO EN CASCADA 
drop table autores cascade;

CREATE TABLE autores (
    id serial PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
);

CREATE TABLE libros (
    id serial PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor_id INT NOT NULL,
    FOREIGN KEY (autor_id) REFERENCES autores (id) ON DELETE CASCADE
); -- AL AGREGAR ESTA INSTRUCCIÓN A LA FOREIGN KEY SE EESTABLECE QUE AL BORRAR UN DATO EN LA TABLA PADRE ESTO SE LLEVARÁ SUS REGISTROS ASOCIADOS

--ELIMINADO EN CASCADA
-- ??????

--TRUNCATE se comporta similar a un delete, borra registros de una tabla, pero no afecta el esquema y reinicia identidades (seriales)
--además Truncate modifica de forma automática toda la info asociada mediante clave foránea al registro que está borrando.

INSERT INTO autores (nombre)
VALUES
    ('Juan Pérez'),
    ('María García'),
    ('Pedro Rodríguez');

INSERT INTO libros (titulo, autor_id)
VALUES
    ('El Quijote', 1),
    ('La Divina Comedia', 2),
    ('Hamlet', 3);

truncate libros;
select * from libros;
select * from autores;
/*
id |      titulo       | autor_id
---+-------------------+----------
4 | El Quijote        |        1
5 | La Divina Comedia |        2
6 | Hamlet            |        3*/

truncate libros restart identity; --para reiniciar los seriales hay que solicitarlo, por defecto continúa con la secuencia
/*
id |      titulo       | autor_id
----+-------------------+----------
1 | El Quijote        |        1
2 | La Divina Comedia |        2
3 | Hamlet            |        3*/

truncate autores restart identity cascade;
--NOTICE:  truncando además la tabla «libros»
select * from libros;
/*
id | titulo | autor_id
----+--------+----------*/
select * from autores;
/*
id | nombre
----+--------*/

--REINICIAR UNA SECUENCIA
Alter Sequence libros_id_seq restart;
/*1. Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las 
claves primarias, foráneas y tipos de datos. (1 punto)*/
DROP DATABASE IF EXISTS prueba_basesdedatos;
CREATE DATABASE prueba_basesdedatos;
\c prueba_basesdedatos

CREATE TABLE peliculas (
    id int PRIMARY KEY,
    nombre varchar(250),
    anno int
);
CREATE TABLE tags(
    id int PRIMARY KEY,
    tag varchar(250)
);
CREATE TABLE peliculas_tags(
    id int PRIMARY KEY,
    pelicula_id int, 
    tag_id int,
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);
\d+ peliculas
\d+ tags
\d+ peliculas_tags

/*2. Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, la
segunda película debe tener dos tags asociados. (1 punto)*/
INSERT INTO peliculas VALUES (1, 'The Others', 2001),
(2, 'Reservoir Dogs', 1992),
(3, 'Ace Ventura: Pet Detective', 1994),
(4, 'Inception', 2010),
(5, 'V for Vendetta', 2005);

select * from peliculas;

INSERT INTO tags VALUES (1, 'Terror'),
(2, 'Suspenso'),
(3, 'Misterio'),
(4, 'Crimen'),
(5, 'Comedia');

select * from tags;

INSERT INTO peliculas_tags VALUES(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 2, 2),
(5, 2, 4);

select * from peliculas_tags;

/*3. Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe
mostrar 0. (1 punto)*/

SELECT peliculas.nombre as título, COUNT(pelicula_id) as cantidad_tags
from peliculas
left join peliculas_tags 
on peliculas_tags.pelicula_id = peliculas.id
group by peliculas.nombre, pelicula_id
order by cantidad_tags DESC;
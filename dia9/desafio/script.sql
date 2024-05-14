SELECT p.id , p.pelicula , p.anio_estreno , p.director 
FROM peliculas p ;

select r.* 
from reparto r ;
-- 3. Obtener el ID de la película “Titanic”. (1 Punto)
select p.id from peliculas p where p.pelicula = 'Titanic';
-- id: 2

-- 4. Listar a todos los actores que aparecen en la película "Titanic". (1 Punto)
select r.actor from reparto r
inner join peliculas p on 
r.id_pelicula = p.id 
where p.pelicula = 'Titanic';
/*
actor            |
-----------------+	
Leonardo DiCaprio|
Kate Winslet     |
Billy Zane       |
Kathy Bates      |
Frances Fisher   |
Bernard Hill     |
Jonathan Hyde    |
Danny Nucci      |
David Warner     |
Bill Paxton      |
Gloria Stuart    |
Victor Garber    |
Suzy Amis        | */

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)
select count(p.pelicula)  as cantidad_peliculas from peliculas p 
inner join reparto r on 
p.id = r.id_pelicula
group by r.actor 
having r.actor = 'Harrison Ford';
/*
cantidad_peliculas|
------------------+
                 8| */

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente. (1 punto)
select p.pelicula from peliculas p 
where p.anio_estreno >= 1990 and p.anio_estreno < 2000
order by p.pelicula asc;

/*
pelicula                                  |
------------------------------------------+
American Beauty                           |
American History X                        |
Braveheart                                |
Cadena perpetua                           |
Eduardo Manostijeras                      |
El club de la pelea                       |
El Padrino. Parte III                     |
El profesional                            |
El sexto sentido                          |
El show de Truman                         |
El silencio de los corderos               |
Entrevista con el vampiro                 |
Forest Gump                               |
Hombres de negro                          |
La lista de Schindler                     |
La milla verde                            |
Matrix                                    |
Mejor... imposible                        |
Parque Jurásico                           |
Pesadilla antes de navidad                |
Pulp Fiction                              |
Salvar al soldado Ryan                    |
Seven                                     |
Star Wars. Episodio I: La amenaza fantasma|
Terminator 2: el juicio final             |
Titanic                                   |
Toy Story                                 |
Toy Story 2                               |
Trainspotting                             |
Uno de los nuestros                       |*/

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”. (1 punto)
select p.pelicula , length(p.pelicula) as longitud_titulo 
from peliculas p 
order by longitud_titulo; 

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas. (2 punto)
select p.pelicula , length(p.pelicula) as longitud_titulo 
from peliculas p 
order by longitud_titulo desc 
limit 1; 
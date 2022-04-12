-- Se crea la database
CREATE DATABASE blog_db;
-- Se accede a la database \c blog_db
-- Se crean las tablas (TODAS LAS RESTRICCIONES DESPUÉS DEL TIPO DE DATO!!!)
CREATE TABLE usuarios(id INT PRIMARY KEY, email VARCHAR(255) UNIQUE NOT NULL);
CREATE TABLE posts(id INT PRIMARY KEY, usuarios_fk INT, titulo VARCHAR (100) NOT NULL, fecha DATE NOT NULL, FOREIGN KEY (usuarios_fk) REFERENCES usuarios(id));
CREATE TABLE comentarios(id INT PRIMARY KEY, posts_fk INT, usuarios_fk INT, texto VARCHAR(200) NOT NULL, fecha DATE, FOREIGN KEY (posts_fk) REFERENCES posts(id), FOREIGN KEY (usuarios_fk) REFERENCES usuarios(id));
/*
Se importan los registros de cada tabla
\copy usuarios FROM 'C:\src\desafio-blog\usuarios.csv' csv header
\copy posts FROM 'C:\src\desafio-blog\posts.csv' csv header
\copy comentarios FROM 'C:\src\desafio-blog\comentarios.csv' csv header
*/
-- Seleccionar el correo, id y título de todos los post publicados por el usuario 5
SELECT u.id, u.email, p.titulo FROM usuarios AS u INNER JOIN posts AS p ON u.id  = p.usuarios_fk WHERE u.id  = 5;
-- Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com
SELECT * FROM usuarios AS u INNER JOIN comentarios AS c ON u.id = c.usuarios_fk WHERE u.email <> 'usuario06@hotmail.com';
-- Listar los usuarios que no han publicado ningún post
SELECT u.email FROM usuarios AS u LEFT JOIN posts AS p ON u.id = p.usuarios_fk WHERE p.id IS NULL;
-- Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios)
SELECT p.titulo, c.texto FROM posts AS p full outer join comentarios AS c ON p.id = c.posts_fk ORDER BY p.id;
-- Listar todos los usuarios que hayan publicado un post en Junio
SELECT u.email, p.fecha FROM usuarios AS u LEFT JOIN posts AS p ON u.id = p.usuarios_fk WHERE p.fecha BETWEEN '2020-06-01' AND '2020-06-30';
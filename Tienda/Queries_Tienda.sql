-- BASE DADES TIENDA. 
USE tienda;

-- 1. Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;

-- 2. Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto;

-- 3, Llista totes les columnes de la taula producto.
SELECT * FROM producto;

-- 4, Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
 SELECT nombre, precio, (precio * 0.99) AS 'PRECIO DOLARES' FROM producto;

-- 5, Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). 
-- Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS 'NOMBRE PRODUCTO' , precio AS 'EUROS', (precio * 0.99) AS 'DOLARES' FROM producto;

-- 6, Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre) AS nombre, precio FROM producto;

-- 7, Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre) AS nombre, precio FROM producto;

-- 8, Llista el nom de tots els fabricants en una columna, i en una altra columna 
-- obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre, UPPER(substring(nombre, 1, 2)) FROM fabricante;

-- 9, Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre, CAST(precio as signed) AS precio FROM producto;

-- 10, Llista els noms i els preus de tots els productes de la taula producto, 
-- truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre, TRUNCATE(precio, 0) AS precio FROM producto;

-- 11, Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT codigo_fabricante FROM producto;

-- 12, Llista el codi dels fabricants que tenen productes en la taula producto, 
-- eliminant els codis que apareixen repetits.
SELECT distinct codigo_fabricante FROM producto;

-- 13, Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre ASC;

-- 14, Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;

-- 15, Llista els noms dels productes ordenats, en primer lloc, 
-- pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre FROM producto ORDER BY nombre ASC;

-- 16, Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante LIMIT 0, 5;

-- 17, Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante.
-- La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante LIMIT 3, 2;

-- 18, Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). 
-- NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

-- 19, Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). 
-- NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- 20, Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;

-- 21 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT producto.nombre, producto.precio, fabricante.nombre 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo;

-- 22 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. 
-- Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT producto.nombre AS nombre_producto, producto.precio AS precio_producto, fabricante.nombre AS nombre_fabricante 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY fabricante.nombre ASC;

-- 23 Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, 
-- de tots els productes de la base de dades.
SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo;

-- 24 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT producto.nombre, producto.precio, fabricante.nombre 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY precio ASC LIMIT 1;

-- 25 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT producto.nombre, producto.precio, fabricante.nombre 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo 
ORDER BY precio DESC LIMIT 1;

-- 26 Retorna una llista de tots els productes del fabricant Lenovo.
SELECT producto.nombre, fabricante.nombre 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre IN ("Lenovo");

-- 27 Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT producto.nombre, fabricante.nombre 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre IN ("Crucial") 
AND producto.precio > 200;

-- 28 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Sense utilitzar l'operador IN.
SELECT producto.nombre, fabricante.nombre
FROM producto JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = 'ASUS' OR fabricante.nombre = 'Hewlett-Packard' OR fabricante.nombre = 'Seagate';

-- 29 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packardy Seagate. Fent servir l'operador IN.
SELECT producto.nombre, fabricante.nombre 
FROM producto JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre IN ("Crucial", "Hewlett-Packard", "Seagate");

-- 30 Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT producto.nombre AS 'NOMBRE PRODUCTO', producto.precio AS 'PRECIO PRODUCTO'
FROM producto LEFT JOIN fabricante 
ON fabricante.codigo = producto.codigo_fabricante
WHERE RIGHT(fabricante.nombre, 1) = 'e';

-- 31 Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT producto.nombre AS 'NOMBRE PRODUCTO', producto.precio AS 'PRECIO PRODUCTO'
FROM producto LEFT JOIN fabricante 
ON fabricante.codigo = producto.codigo_fabricante
WHERE fabricante.nombre like '%w%';










-- BASE DE DADES UNIVERSIDAD
USE universidad;

-- 1, Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT  apellido1 AS 'PRIMER APELLIDO', apellido2 'SEGUNDO APELLIDO', nombre AS 'NOMBRE' FROM persona ORDER BY apellido1 ASC;

-- 2, Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre AS 'NOMBRE', apellido1 AS 'PRIMER APELLIDO', apellido2 AS 'SEGUNDO APELLIDO' FROM persona WHERE telefono IS NULL;

-- 3, Retorna el llistat dels alumnes que van néixer en 1999.
SELECT nombre AS 'NOMBRE', apellido1 AS 'PRIMER APELLIDO', apellido2 AS 'SEGUNDO APELLIDO' FROM persona WHERE YEAR(fecha_nacimiento) = 1999;

-- 4, Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT nombre AS 'NOMBRE', apellido1 AS 'PRIMER APELLIDO', apellido2 AS 'SEGUNDO APELLIDO' FROM persona JOIN profesor ON profesor.id_profesor = persona.id WHERE telefono IS NULL AND persona.nif LIKE '%w%';

-- 5, Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

/* 6, Retorna un llistat dels professorses junt nom del departament al qual estan vinculats. 
-- El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
-- El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.*/
SELECT persona.apellido1 AS 'PRIMER APELLIDO', persona.apellido2 AS 'SEGUNDO APELLIDO', persona.nombre AS 'NOMBRE', departamento.nombre AS 'DEPARTAMENT' FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento = departamento.id ORDER BY apellido1 ASC;

-- 7, Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre AS 'ASIGNATURA', curso_escolar.anyo_inicio AS 'AÑO INICIO', curso_escolar.anyo_fin AS 'FINAL DEL CURSO' FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id JOIN curso_escolar ON asignatura.curso = curso_escolar.id WHERE nif LIKE '26902806M';

-- 8, Retorna un llistat amb el nom de tots els departaments que tenen professors/es que 
-- imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT departamento.nombre AS 'DEPARTAMENTO' FROM departamento JOIN profesor ON profesor.id_departamento = departamento.id JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor JOIN grado ON grado.id = asignatura.id_grado WHERE grado.nombre LIKE 'Grado en Ingeniería Informática (Plan 2015)' AND !ISNULL(asignatura.id_profesor);

-- -------------------------------------LEFT JOIN & RIGHT JOIN QUERIES
-- 1, Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre AS 'DEPARTAMENTO', persona.apellido1 AS 'PRIMER APELLIDO', persona.apellido2 AS 'SEGUNDO APELLIDO', persona.nombre AS 'NOMBRE' FROM persona RIGHT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON departamento.id = profesor.id_departamento ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

-- 2, Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT departamento.nombre AS 'DEPARTAMENT', persona.apellido1 AS 'PRIMER APELLIDO', persona.apellido2 AS 'SEGUNDO APELLIDO', persona.nombre AS 'NOMBRE' FROM persona RIGHT JOIN profesor ON profesor.id_profesor = persona.id LEFT JOIN departamento ON departamento.id = profesor.id_departamento ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre;

-- 3, Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT * FROM profesor RIGHT JOIN departamento ON departamento.id = profesor.id_departamento WHERE ISNULL(profesor.id_departamento);

-- 4, Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT * FROM profesor LEFT JOIN asignatura ON asignatura.id_profesor = profesor.id_departamento WHERE isnull(asignatura.nombre);

-- -------------------------------------RESUM QUERIES
-- 1, Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(tipo) FROM persona WHERE tipo = "alumno";

-- 2, Calcula quants alumnes van néixer en 1999.
SELECT COUNT(fecha_nacimiento) FROM persona WHERE YEAR (fecha_nacimiento) = 1999;

-- 3, Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, 
-- una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT departamento.nombre AS 'DEPARTAMENTO', COUNT(profesor.id_profesor) AS 'TOTAL PROFESORES' FROM profesor JOIN departamento ON profesor.id_departamento = departamento.id GROUP BY departamento.nombre ORDER BY 'TOTAL PROFESORES' DESC;

-- 4, Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
-- Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.id AS 'DEPT. NUMERO', departamento.nombre AS 'DEPARTAMENTO', COUNT(profesor.id_profesor) AS 'Nº PROFES' FROM profesor RIGHT JOIN departamento ON departamento.id = profesor.id_departamento GROUP BY departamento.id ORDER BY count(profesor.id_profesor) DESC;

-- 5, Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Tingues en compte que poden existir graus que no tenen assignatures associades. 
-- Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre AS 'GRADO', COUNT(asignatura.id) AS 'Nº ASIGNATURAS' FROM grado LEFT JOIN asignatura ON asignatura.id_grado = grado.id GROUP BY grado.id ORDER BY COUNT(asignatura.id) DESC;

-- 6, Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, 
-- dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre AS 'GRADO', COUNT(asignatura.id_grado) AS 'Nº ASIGNATURAS' FROM grado JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY asignatura.id_grado HAVING COUNT(asignatura.id_grado) > 40;

-- 7, Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada
--  tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma 
-- dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT grado.nombre AS 'GRADO', asignatura.tipo AS 'ASIGNATURA', sum(asignatura.creditos) AS 'Nº CREDITOS' FROM grado JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY asignatura.id;


-- 8, Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels 
-- cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar 
-- i una altra amb el nombre d'alumnes matriculats.












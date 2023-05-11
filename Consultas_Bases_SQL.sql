-- 1) Muestra el código nacional, nombre, vía de administración y presentación de todos los medicamentos. 
-- Para realizar esta consulta se seleccionan los atributos de medicamento que se quieren 
-- mostrar en la cláusula SELECT, mientras que en la cláusula FROM, se selecciona la tabla MEDIC.

SELECT c_nacional, nombre, via_administracion, presentacion
FROM MEDIC;

-- 2) Muestra el código cie10, nombre y tasa de mortalidad de todas las enfermedades con una tasa de
--    mortalidad superior al 30%
-- En la cláusula SELECT se escribirán los atributos que se quieren obtener.
-- En la cláusula FROM se escribirá la tabla de la que se quieren obtener.
-- La cláusula WHERE se utilizará para imponer una condición sobre las tuplas de los atributos, en este
-- caso, solo se quieren las que tengan una tasa de mortalidad superior al 30%

SELECT cie10, nombre_enfdad, tasa_mortalidad
FROM ENFDAD
WHERE tasa_mortalidad > 30;

-- 3) Muestra la descripción, frecuencia y gravedad de aquellos efectos secundarios que incluyan la palabra
--    'alteración' en su descripción
-- Para obtener las tuplas que contengan una palabra en su contenido se utiliza el comando LIKE, el cual 
-- busca un caracter o cadena de caracteres en las tuplas. Este caracter o cadena de caracteres debe estar
-- rodeado por %'s en los extremos que puedan llevar otros caracteres añadidos. Por ejemplo, para buscar 
-- descripciones que empiecen por A, sería WHERE descripcion LIKE 'A%', para que terminen por A, '%A', y
-- para que tengan A en medio, '%A%'. 

SELECT descripcion, frecuencia_aparicion, nivel_gravedad
FROM EFEC_SECUN
WHERE descripcion LIKE '%alteracion%';

-- NOTA: Para que la consulta tenga sentido con nuestros datos, se mostrará cualquier efecto secundario que
-- en su descripción contenga la palabra 'Dolor'

SELECT descripcion, frecuencia_aparicion, nivel_gravedad
FROM EFEC_SECUN
WHERE descripcion LIKE '%Dolor%';

-- 4) Muestra el código cie10 y nombre de aquellas enfermedades crónicas con una tasa de letalidad inferior al 50%
-- Se incluyen las dos especificaciones en la clausula WHERE, unidas por el operador logico AND

SELECT cie10, nombre_enfdad
FROM ENFDAD
WHERE tasa_letalidad < 50 AND cronica = 1;

-- 5) Muestra el nombre, presentación y formato de aquellos medicamentos cuya vía de administración sea oral, nasal
--    o intravenosa
-- Para poder mostrar un conjunto de tuplas que contienen una serie de palabras distintas se utiliza el comando IN, el
-- cual, para un atributo de la relación, muestra todas estas tuplas de estos las cuales contengan (únicamente) una de las
-- palabras especificadas en el IN

SELECT nombre, presentacion, formato
FROM MEDIC
WHERE via_administracion IN ('Oral' , 'Inha', 'Intrav');

-- 6) Muestra el nombre y tasa de mortalidad de aquellas enfermedades que no son crónicas ordenadas por la tasa de mortalidad
--    en sentido descendente
-- En este caso la cláusula WHERE almacena la condición de las tuplas, la cual es "que no sea crónica", es decir, que el atributo
-- crónica de las tuplas no sea igual a 1 (o que sea igual a 0).
-- Para poder ordenar las tuplas resultantes, se introduce la nueva cláusula ORDER BY, la cual toma un atributo y un criterio de
-- ordenación: ASC o DESC. Pueden introducirse más atributos, en este caso, si hay un empate en el primero (por la izquierda), se
-- desempatará atentiendo al segundo

SELECT nombre_enfdad, tasa_mortalidad
FROM ENFDAD
WHERE cronica <> 1
ORDER BY tasa_mortalidad DESC;

-- 7) Muestra el nombre, apellidos y edad de todos los pacientes
-- La edad de los pacientes se puede calcular restando el año actual menos el año de la fecha de nacimiento de los pacientes. Este tipo
-- de operaciones se deben realizar en la cláusula SELECT, ya que se quieren mostrar como resultado de la consulta.
-- Además, se ha renombrado el parámetro como 'edad' utilizando el comando AS

SELECT nombre_pac, apellido, extract (year FROM sysdate)- extract (year FROM fecha_nacimiento) AS edad
FROM PACIENTE;

-- 8) Muestra la suma, media, varianza, máximo, y mínimo de los tamaños de las consultas
-- Todas estas operaciones se introducen en la cláusula SELECT, utilizando los operadores aritméticos SUM, AVG, MIN y MAX, además de renombrando los
-- resultados para que se puedan indentificar mejor

SELECT SUM(tamanio) AS suma_tamanios, AVG(tamanio) AS media_tamanios, MAX(tamanio) AS max_tamanios, MIN(tamanio) AS min_tamanios
FROM CONSULTA;

-- 9) Muestra el nombre, presentación y formato de aquellos medicamentos financiados junto a su pvl y pvp
-- Esta es una consulta multitabla, por lo que las tablas MEDIC y FINAN se importan en la clausula FROM usando su producto cartesiano.
-- La cláusula WHERE se utiliza para mostrar solo los medicamentos de MEDIC que estén guardados en FINAN, ya que estos tendrán su 
-- atributo c_nacional igual.
-- EXTRA: Se han ordenado los resultados de menor a mayor pvp utilizando ORDER BY para poder visualizar mejor los precios.

SELECT medic.nombre, medic.presentacion, medic.formato, finan.pvp, finan.pvl
FROM MEDIC medic, FINAN finan
WHERE finan.c_nacional = medic.c_nacional
ORDER BY finan.pvp ASC;

-- 10) Muestra el pvp promedio de cada familia de medicamentos
-- En la cláusula SELECT se añade la función de agregación AVG al atributo de la tabla finan 'pvp'
-- Para restringir solo a los medicamentos que tienen un atributo pvp (es decir, que están financiados), se especifica en la clausula WHERE que
-- el código nacional en FAM_MEDIC y en FINAN debe ser el mismo. 
-- Finalmente, para realizar la media de los pvp según las familias de medicamentos, se agruparán las tuplas utilizando estas como criterio.
-- GROUP BY divide las tuplas en grupos dependiendo de su valor en un atributo concreto. De esta forma, para calcular la media del pvp solo se tendrán
-- en cuenta los que pertenezcan a la misma familia.

SELECT AVG(finan.pvp) AS average_pvp
FROM FAM_MEDIC f_med, FINAN
WHERE finan.c_nacional = f_med.medic_c_nacional
GROUP BY f_med.familia_medicamento;

-- 11) Muestra la cantidad de años trabajados promedio para aquellas especialidades trabajadas por más de 5 médicos
-- NOTA: Debido a que no se tienen más de 2 tuplas de MEDICO con la misma especialización, para que arroje un resultado con nuestros datos
--       se ha cambiado a que sea mayor que 1, para que fuese mayor que 5, sería: HAVING COUNT(especializacion) > 5;
-- Debido a que queremos que nos haga la media de años por especialización, se utiliza el comando GROUP BY, debido a que hay una restricción
-- dentro de estos grupos, se utiliza la clausula HAVING para acceder a las tuplas de estos por separado, la condición en having es que la
-- cantidad de tuplas para una misma especialización sea mayor que 5 (1).

SELECT AVG(anios_trabajo) AS media_anios
FROM MEDICO
GROUP BY especializacion
HAVING COUNT(especializacion) > 1;

-- 12) Muestra el nombre y pvp del medicamento más caro de cara al público
-- Debido a que se trata de una consulta de grupo único pero se quiere arrojar un parámetro al cual se le tiene que aplicar una función de agregación
-- entonces se debe transformar en una subconsulta. El parámetro al cual se le debe aplicar la subconsulta es finan.pvp, el cual debe ser igual al 
-- máximo pvp de la tabla finan. Para que devuelva solo el nombre del medicamento con este PVP máximo y no todos los nombres de todos los medicamentos
-- con este pvp, se debe aplicar una segunda condición en la que el codigo nacional del medicamento en finan y en medic sea el mismo. 

SELECT finan.pvp, medic.nombre
FROM FINAN, MEDIC
WHERE finan.pvp = (
                   SELECT MAX(pvp) 
                   FROM FINAN
                   ) 
      AND finan.c_nacional = medic.c_nacional;

-- 13) Muestra el nombre y pvl de los medicamentos con menor pvl de su familia
-- La consulta está seleccionando los valores de finan.pvl y medic.nombre donde finan.pvl es igual al valor mínimo de pvl para cada familia_medicamento en
-- la tabla FINAN que esté asociado con un registro en FAM_MEDIC y que, a su vez, esté relacionado con un registro en MEDIC a través del atributo c_nacional.
-- La subconsulta selecciona el pvl mínimo de cada familia siempre y cuando el c_nacional esté registrado en ambas tablas, eliminando las cambinaciones innecesarias
-- que realiza el producto cartesiano (,). 

SELECT finan.pvl, medic.nombre
FROM FINAN, MEDIC
WHERE finan.pvl IN (
              SELECT MIN(pvl) 
              FROM FINAN, FAM_MEDIC 
              WHERE finan.c_nacional = fam_medic.medic_c_nacional 
              GROUP BY fam_medic.familia_medicamento) 
    AND finan.c_nacional = medic.c_nacional;

-- 14) Muestra el nombre de aquellas enfermedades que hayan sido diagnosticadas a más de 10 pacientes
-- Siempre que la subconsulta no devuelve una única tupla con un valor que se quiera comparar con otro (subconsulta de tupla única), se debe utilizar
-- el comando ANY. Este hace que todas las tuplas devuelvas por la subconsulta sean mayores o menores que la consigna establecida. En este caso, 10 es menor
-- que cualquier valor obtenido en las tuplas de la subconsulta que cuenta el número de pacientes que sufren de la misma enfermedad.

SELECT nombre_enfdad
FROM ENFDAD
WHERE 10 < ANY (SELECT COUNT(paciente_dni)
                FROM PAC_ENF
                GROUP BY enfdad_cie10);

-- 15) Muestra el nombre, presentación y formato de aquellos medicamentos que no presentan ningún efecto secundario
-- La subconsulta se utiliza para obtener todos los codigos nacionales de los medicamentos con efectos secundarios relacionados, mientras que la consulta
-- principal se utiliza para seleccionar el codigo nacional de los medicamentos que NO se encuentran en la lista devuelta por la subconsulta. Esto se 
-- realiza con el comando NOT IN.

SELECT nombre, presentacion, formato
FROM MEDIC
WHERE c_nacional NOT IN (SELECT medic_c_nacional
                         FROM EFEC_SECUN);

-- 16) Muestra el ID de los medicos que han trabajado una cantidad de años superior al de al menos un médico de su misma especialidad
-- La subconsulta selecciona los medicos que tengan la misma especialización (siempre que no sea el mismo), consulta principal selecciona los medicos
-- que tengan más años de trabajo que al menos uno de ellos.

SELECT med1.id_m, med1.especializacion, med1.anios_trabajo
FROM MEDICO med1
WHERE med1.anios_trabajo > (SELECT med2.anios_trabajo
                            FROM MEDICO med2
                            WHERE med1.especializacion = med2.especializacion AND med1.id_m <> med2.id_m
);

-- EXTRA: Esta consulta devuelve las especializaciones que tienen más de un médico trabajando en ellas.
SELECT COUNT(med.id_m), med.especializacion
FROM MEDICO med
HAVING COUNT(med.id_m) > 1
GROUP BY med.especializacion;

-- 17) Muestra el ID de los médicos que han trabajado una cantidad de años superior a todos los promedios de cada especialidad
-- La subconsulta hace el promedio de los años trabajados por especialización. Al utilizar el operador de subconsulta de múltiples tuplas
-- ALL, lo que se está haciendo es comprobar de años trabajados sobre el que se está iterando de la consulta principal sea mayor que el mayor
-- valor dentro de la subconsulta, es decir, mayor que el mayor promedio de todos los obtenidos en la subconsulta (si es más grande que el mayor,
-- entonces es más grande que todos). 

SELECT med1.id_m
FROM MEDICO med1
WHERE med1.anios_trabajo > ALL (
                                SELECT AVG(med2.anios_trabajo)
                                FROM MEDICO med2
                                GROUP BY med2.especializacion
                                );

-- 18) Muestra el nombre de todas las enfermedades sin ningún medicamento asociado
-- La subconsulta devuelve una tabla con un único atributo, el cie10, sus tuplas contienen este dato siempre y cuando el codigo nacional
-- del medicamento asociado a ese cie10 NO esté guardado en la tabla medicamento, de esta forma solo se muestran las enfermedades que no tengan
-- un medicamento disponible en la base de datos de la clínica. 
-- La consulta solo relaciona el nombre de la enfermedad con los cie10 obtenidos.

SELECT nombre_enfdad
FROM ENFDAD
WHERE cie10 = ANY (
                SELECT enf_medic.enfdad_cie10
                FROM ENF_MEDIC, MEDIC
                WHERE enf_medic.medic_c_nacional <> medic.c_nacional
                );

-- 19) Muestra el código de contrato de los enfermeros que hayan tenido cita en todas las consultas
-- Aquí se ha realizado de tres maneras, siendo la más óptima la primera de todas.
-- La primera forma de todas es una consulta que devuelve el codigo de los enfermeros tales que no existe 
-- un valor del atributo "consulta_numero" en la tabla CITA que no esté relacionado con el id de personal
-- sanitario de la consulta principal. Es decir: Devuelve el codigo de los enfermeros para los que no 
-- existe una tupla en la tabla CITA que no lleve su ID. 

SELECT enf.codigo
FROM ENFERMERO enf
WHERE NOT EXISTS (SELECT '1'
                  FROM CITA c
                  WHERE c.p_sanit_p_sanit_id != enf.p_sanit_p_sanit_id);
                  
                               
-- Utilizando el operador "WITH" el cual permite organizar subconsultas que devuelven más de un atributo 
-- para poder acceder a las tuplas de ese atributo (también sirve para organizar subconsultas en general).
-- En este caso se define la función countC, la cual relaciona el id del sanitario (siempre que sea enfermero)
-- de la tabla CITA con el número de consultas que ha atendido. 
-- En la consulta principal, si el número de citas que ha atendido un sanitario es igual al número de tuplas
-- dentro de la tabla CITA, es que ha atendido a todas las consultas. 

WITH countC(total, enf_id) AS
    (SELECT COUNT(c.consulta_numero), c.p_sanit_p_sanit_id
     FROM CITA c
     WHERE c.p_sanit_p_sanit_id IN (SELECT enf.p_sanit_p_sanit_id
                                  FROM ENFERMERO enf)
     GROUP BY p_sanit_p_sanit_id),
     countCtotal(total_c) AS
    (SELECT COUNT(c2.consulta_numero)
     FROM CITA c2)
     
     SELECT enf.codigo
     FROM ENFERMERO enf
     WHERE enf.p_sanit_p_sanit_id IN (SELECT enf_id
                                      FROM countC, countCtotal
                                      WHERE countC.total = countCtotal.total_c);
         
-- 20) Cambiar a la especialización 21 (Jefe de cirujía) a todos los médicos cuyos años trabajados
-- superen la media de años trabajados de los medicos de su especializacion

UPDATE MEDICO med
SET med.especializacion = 21
WHERE med.id_m IN (SELECT med1.id_m
                    FROM MEDICO med1
                    WHERE med1.especializacion <> 21 AND
                          med1.anios_trabajo > (SELECT ROUND(AVG(med2.anios_trabajo)) AS media_especialidad
                                                FROM MEDICO med2
                                                WHERE med2.especializacion = med1.especializacion));


-- 1) Muestra el c�digo nacional, nombre, v�a de administraci�n y presentaci�n de todos los medicamentos. 
-- Para realizar esta consulta se seleccionan los atributos de medicamento que se quieren 
-- mostrar en la cl�usula SELECT, mientras que en la cl�usula FROM, se selecciona la tabla MEDIC.

SELECT c_nacional, nombre, via_administracion, presentacion
FROM MEDIC;

-- 2) Muestra el c�digo cie10, nombre y tasa de mortalidad de todas las enfermedades con una tasa de
--    mortalidad superior al 30%
-- En la cl�usula SELECT se escribir�n los atributos que se quieren obtener.
-- En la cl�usula FROM se escribir� la tabla de la que se quieren obtener.
-- La cl�usula WHERE se utilizar� para imponer una condici�n sobre las tuplas de los atributos, en este
-- caso, solo se quieren las que tengan una tasa de mortalidad superior al 30%

SELECT cie10, nombre_enfdad, tasa_mortalidad
FROM ENFDAD
WHERE tasa_mortalidad > 30;

-- 3) Muestra la descripci�n, frecuencia y gravedad de aquellos efectos secundarios que incluyan la palabra
--    'alteraci�n' en su descripci�n
-- Para obtener las tuplas que contengan una palabra en su contenido se utiliza el comando LIKE, el cual 
-- busca un caracter o cadena de caracteres en las tuplas. Este caracter o cadena de caracteres debe estar
-- rodeado por %'s en los extremos que puedan llevar otros caracteres a�adidos. Por ejemplo, para buscar 
-- descripciones que empiecen por A, ser�a WHERE descripcion LIKE 'A%', para que terminen por A, '%A', y
-- para que tengan A en medio, '%A%'. 

SELECT descripcion, frecuencia_aparicion, nivel_gravedad
FROM EFEC_SECUN
WHERE descripcion LIKE '%alteracion%';

-- NOTA: Para que la consulta tenga sentido con nuestros datos, se mostrar� cualquier efecto secundario que
-- en su descripci�n contenga la palabra 'Dolor'

SELECT descripcion, frecuencia_aparicion, nivel_gravedad
FROM EFEC_SECUN
WHERE descripcion LIKE '%Dolor%';

-- 4) Muestra el c�digo cie10 y nombre de aquellas enfermedades cr�nicas con una tasa de letalidad inferior al 50%
-- Se incluyen las dos especificaciones en la clausula WHERE, unidas por el operador logico AND

SELECT cie10, nombre_enfdad
FROM ENFDAD
WHERE tasa_letalidad < 50 AND cronica = 1;

-- 5) Muestra el nombre, presentaci�n y formato de aquellos medicamentos cuya v�a de administraci�n sea oral, nasal
--    o intravenosa
-- Para poder mostrar un conjunto de tuplas que contienen una serie de palabras distintas se utiliza el comando IN, el
-- cual, para un atributo de la relaci�n, muestra todas estas tuplas de estos las cuales contengan (�nicamente) una de las
-- palabras especificadas en el IN

SELECT nombre, presentacion, formato
FROM MEDIC
WHERE via_administracion IN ('Oral' , 'Inha', 'Intrav');

-- 6) Muestra el nombre y tasa de mortalidad de aquellas enfermedades que no son cr�nicas ordenadas por la tasa de mortalidad
--    en sentido descendente
-- En este caso la cl�usula WHERE almacena la condici�n de las tuplas, la cual es "que no sea cr�nica", es decir, que el atributo
-- cr�nica de las tuplas no sea igual a 1 (o que sea igual a 0).
-- Para poder ordenar las tuplas resultantes, se introduce la nueva cl�usula ORDER BY, la cual toma un atributo y un criterio de
-- ordenaci�n: ASC o DESC. Pueden introducirse m�s atributos, en este caso, si hay un empate en el primero (por la izquierda), se
-- desempatar� atentiendo al segundo

SELECT nombre_enfdad, tasa_mortalidad
FROM ENFDAD
WHERE cronica <> 1
ORDER BY tasa_mortalidad DESC;

-- 7) Muestra el nombre, apellidos y edad de todos los pacientes
-- La edad de los pacientes se puede calcular restando el a�o actual menos el a�o de la fecha de nacimiento de los pacientes. Este tipo
-- de operaciones se deben realizar en la cl�usula SELECT, ya que se quieren mostrar como resultado de la consulta.
-- Adem�s, se ha renombrado el par�metro como 'edad' utilizando el comando AS

SELECT nombre_pac, apellido, extract (year FROM sysdate)- extract (year FROM fecha_nacimiento) AS edad
FROM PACIENTE;

-- 8) Muestra la suma, media, varianza, m�ximo, y m�nimo de los tama�os de las consultas
-- Todas estas operaciones se introducen en la cl�usula SELECT, utilizando los operadores aritm�ticos SUM, AVG, MIN y MAX, adem�s de renombrando los
-- resultados para que se puedan indentificar mejor

SELECT SUM(tamanio) AS suma_tamanios, AVG(tamanio) AS media_tamanios, MAX(tamanio) AS max_tamanios, MIN(tamanio) AS min_tamanios
FROM CONSULTA;

-- 9) Muestra el nombre, presentaci�n y formato de aquellos medicamentos financiados junto a su pvl y pvp
-- Esta es una consulta multitabla, por lo que las tablas MEDIC y FINAN se importan en la clausula FROM usando su producto cartesiano.
-- La cl�usula WHERE se utiliza para mostrar solo los medicamentos de MEDIC que est�n guardados en FINAN, ya que estos tendr�n su 
-- atributo c_nacional igual.
-- EXTRA: Se han ordenado los resultados de menor a mayor pvp utilizando ORDER BY para poder visualizar mejor los precios.

SELECT medic.nombre, medic.presentacion, medic.formato, finan.pvp, finan.pvl
FROM MEDIC medic, FINAN finan
WHERE finan.c_nacional = medic.c_nacional
ORDER BY finan.pvp ASC;

-- 10) Muestra el pvp promedio de cada familia de medicamentos
-- En la cl�usula SELECT se a�ade la funci�n de agregaci�n AVG al atributo de la tabla finan 'pvp'
-- Para restringir solo a los medicamentos que tienen un atributo pvp (es decir, que est�n financiados), se especifica en la clausula WHERE que
-- el c�digo nacional en FAM_MEDIC y en FINAN debe ser el mismo. 
-- Finalmente, para realizar la media de los pvp seg�n las familias de medicamentos, se agrupar�n las tuplas utilizando estas como criterio.
-- GROUP BY divide las tuplas en grupos dependiendo de su valor en un atributo concreto. De esta forma, para calcular la media del pvp solo se tendr�n
-- en cuenta los que pertenezcan a la misma familia.

SELECT AVG(finan.pvp) AS average_pvp
FROM FAM_MEDIC f_med, FINAN
WHERE finan.c_nacional = f_med.medic_c_nacional
GROUP BY f_med.familia_medicamento;

-- 11) Muestra la cantidad de a�os trabajados promedio para aquellas especialidades trabajadas por m�s de 5 m�dicos
-- NOTA: Debido a que no se tienen m�s de 2 tuplas de MEDICO con la misma especializaci�n, para que arroje un resultado con nuestros datos
--       se ha cambiado a que sea mayor que 1, para que fuese mayor que 5, ser�a: HAVING COUNT(especializacion) > 5;
-- Debido a que queremos que nos haga la media de a�os por especializaci�n, se utiliza el comando GROUP BY, debido a que hay una restricci�n
-- dentro de estos grupos, se utiliza la clausula HAVING para acceder a las tuplas de estos por separado, la condici�n en having es que la
-- cantidad de tuplas para una misma especializaci�n sea mayor que 5 (1).

SELECT AVG(anios_trabajo) AS media_anios
FROM MEDICO
GROUP BY especializacion
HAVING COUNT(especializacion) > 1;

-- 12) Muestra el nombre y pvp del medicamento m�s caro de cara al p�blico
-- Debido a que se trata de una consulta de grupo �nico pero se quiere arrojar un par�metro al cual se le tiene que aplicar una funci�n de agregaci�n
-- entonces se debe transformar en una subconsulta. El par�metro al cual se le debe aplicar la subconsulta es finan.pvp, el cual debe ser igual al 
-- m�ximo pvp de la tabla finan. Para que devuelva solo el nombre del medicamento con este PVP m�ximo y no todos los nombres de todos los medicamentos
-- con este pvp, se debe aplicar una segunda condici�n en la que el codigo nacional del medicamento en finan y en medic sea el mismo. 

SELECT finan.pvp, medic.nombre
FROM FINAN, MEDIC
WHERE finan.pvp = (
                   SELECT MAX(pvp) 
                   FROM FINAN
                   ) 
      AND finan.c_nacional = medic.c_nacional;

-- 13) Muestra el nombre y pvl de los medicamentos con menor pvl de su familia
-- La consulta est� seleccionando los valores de finan.pvl y medic.nombre donde finan.pvl es igual al valor m�nimo de pvl para cada familia_medicamento en
-- la tabla FINAN que est� asociado con un registro en FAM_MEDIC y que, a su vez, est� relacionado con un registro en MEDIC a trav�s del atributo c_nacional.
-- La subconsulta selecciona el pvl m�nimo de cada familia siempre y cuando el c_nacional est� registrado en ambas tablas, eliminando las cambinaciones innecesarias
-- que realiza el producto cartesiano (,). 

SELECT finan.pvl, medic.nombre
FROM FINAN, MEDIC
WHERE finan.pvl IN (
              SELECT MIN(pvl) 
              FROM FINAN, FAM_MEDIC 
              WHERE finan.c_nacional = fam_medic.medic_c_nacional 
              GROUP BY fam_medic.familia_medicamento) 
    AND finan.c_nacional = medic.c_nacional;

-- 14) Muestra el nombre de aquellas enfermedades que hayan sido diagnosticadas a m�s de 10 pacientes
-- Siempre que la subconsulta no devuelve una �nica tupla con un valor que se quiera comparar con otro (subconsulta de tupla �nica), se debe utilizar
-- el comando ANY. Este hace que todas las tuplas devuelvas por la subconsulta sean mayores o menores que la consigna establecida. En este caso, 10 es menor
-- que cualquier valor obtenido en las tuplas de la subconsulta que cuenta el n�mero de pacientes que sufren de la misma enfermedad.

SELECT nombre_enfdad
FROM ENFDAD
WHERE 10 < ANY (SELECT COUNT(paciente_dni)
                FROM PAC_ENF
                GROUP BY enfdad_cie10);

-- 15) Muestra el nombre, presentaci�n y formato de aquellos medicamentos que no presentan ning�n efecto secundario
-- La subconsulta se utiliza para obtener todos los codigos nacionales de los medicamentos con efectos secundarios relacionados, mientras que la consulta
-- principal se utiliza para seleccionar el codigo nacional de los medicamentos que NO se encuentran en la lista devuelta por la subconsulta. Esto se 
-- realiza con el comando NOT IN.

SELECT nombre, presentacion, formato
FROM MEDIC
WHERE c_nacional NOT IN (SELECT medic_c_nacional
                         FROM EFEC_SECUN);

-- 16) Muestra el ID de los medicos que han trabajado una cantidad de a�os superior al de al menos un m�dico de su misma especialidad
-- La subconsulta selecciona los medicos que tengan la misma especializaci�n (siempre que no sea el mismo), consulta principal selecciona los medicos
-- que tengan m�s a�os de trabajo que al menos uno de ellos.

SELECT med1.id_m, med1.especializacion, med1.anios_trabajo
FROM MEDICO med1
WHERE med1.anios_trabajo > (SELECT med2.anios_trabajo
                            FROM MEDICO med2
                            WHERE med1.especializacion = med2.especializacion AND med1.id_m <> med2.id_m
);

-- EXTRA: Esta consulta devuelve las especializaciones que tienen m�s de un m�dico trabajando en ellas.
SELECT COUNT(med.id_m), med.especializacion
FROM MEDICO med
HAVING COUNT(med.id_m) > 1
GROUP BY med.especializacion;

-- 17) Muestra el ID de los m�dicos que han trabajado una cantidad de a�os superior a todos los promedios de cada especialidad
-- La subconsulta hace el promedio de los a�os trabajados por especializaci�n. Al utilizar el operador de subconsulta de m�ltiples tuplas
-- ALL, lo que se est� haciendo es comprobar de a�os trabajados sobre el que se est� iterando de la consulta principal sea mayor que el mayor
-- valor dentro de la subconsulta, es decir, mayor que el mayor promedio de todos los obtenidos en la subconsulta (si es m�s grande que el mayor,
-- entonces es m�s grande que todos). 

SELECT med1.id_m
FROM MEDICO med1
WHERE med1.anios_trabajo > ALL (
                                SELECT AVG(med2.anios_trabajo)
                                FROM MEDICO med2
                                GROUP BY med2.especializacion
                                );

-- 18) Muestra el nombre de todas las enfermedades sin ning�n medicamento asociado
-- La subconsulta devuelve una tabla con un �nico atributo, el cie10, sus tuplas contienen este dato siempre y cuando el codigo nacional
-- del medicamento asociado a ese cie10 NO est� guardado en la tabla medicamento, de esta forma solo se muestran las enfermedades que no tengan
-- un medicamento disponible en la base de datos de la cl�nica. 
-- La consulta solo relaciona el nombre de la enfermedad con los cie10 obtenidos.

SELECT nombre_enfdad
FROM ENFDAD
WHERE cie10 = ANY (
                SELECT enf_medic.enfdad_cie10
                FROM ENF_MEDIC, MEDIC
                WHERE enf_medic.medic_c_nacional <> medic.c_nacional
                );

-- 19) Muestra el c�digo de contrato de los enfermeros que hayan tenido cita en todas las consultas
-- Aqu� se ha realizado de tres maneras, siendo la m�s �ptima la primera de todas.
-- La primera forma de todas es una consulta que devuelve el codigo de los enfermeros tales que no existe 
-- un valor del atributo "consulta_numero" en la tabla CITA que no est� relacionado con el id de personal
-- sanitario de la consulta principal. Es decir: Devuelve el codigo de los enfermeros para los que no 
-- existe una tupla en la tabla CITA que no lleve su ID. 

SELECT enf.codigo
FROM ENFERMERO enf
WHERE NOT EXISTS (SELECT '1'
                  FROM CITA c
                  WHERE c.p_sanit_p_sanit_id != enf.p_sanit_p_sanit_id);
                  
                               
-- Utilizando el operador "WITH" el cual permite organizar subconsultas que devuelven m�s de un atributo 
-- para poder acceder a las tuplas de ese atributo (tambi�n sirve para organizar subconsultas en general).
-- En este caso se define la funci�n countC, la cual relaciona el id del sanitario (siempre que sea enfermero)
-- de la tabla CITA con el n�mero de consultas que ha atendido. 
-- En la consulta principal, si el n�mero de citas que ha atendido un sanitario es igual al n�mero de tuplas
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
         
-- 20) Cambiar a la especializaci�n 21 (Jefe de ciruj�a) a todos los m�dicos cuyos a�os trabajados
-- superen la media de a�os trabajados de los medicos de su especializacion

UPDATE MEDICO med
SET med.especializacion = 21
WHERE med.id_m IN (SELECT med1.id_m
                    FROM MEDICO med1
                    WHERE med1.especializacion <> 21 AND
                          med1.anios_trabajo > (SELECT ROUND(AVG(med2.anios_trabajo)) AS media_especialidad
                                                FROM MEDICO med2
                                                WHERE med2.especializacion = med1.especializacion));


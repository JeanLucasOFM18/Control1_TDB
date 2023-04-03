-- SENTENCIAS SQL REQUERIDAS --

-- 1. 

WITH horarios_cita as (SELECT c.dia, c.mes, c.anio, c.id_peluqueria, COUNT(*) as cantidad_citas
FROM cita c
GROUP BY c.dia, c.mes, c.anio, c.id_peluqueria),

menos_citas as (SELECT c.id_peluqueria, MIN(c.cantidad_citas) as menor_cantidad
FROM horarios_cita c
GROUP BY c.id_peluqueria)

SELECT h.dia, h.mes, h.anio, h.id_peluqueria, h.cantidad_citas, co.nombre
FROM horarios_cita h, menos_citas m, comuna co, peluqueria p
WHERE co.id_comuna = p.id_comuna AND p.id_peluqueria = h.id_peluqueria
AND h.id_peluqueria = m.id_peluqueria AND h.cantidad_citas = m.menor_cantidad
ORDER BY h.id_peluqueria ASC

-- 2.



-- 3.

SELECT peluqueria.id_peluqueria, peluqueria.nombre AS nombre_peluqueria, peluquero.id_peluquero, 
    peluquero.nombre AS nombre_peluquero, DATE_TRUNC('month', sueldo.fecha) AS mes, SUM(sueldo.cantidad) AS sueldo_acumulado
FROM peluquero
    INNER JOIN peluqueria ON peluquero.id_peluqueria = peluqueria.id_peluqueria
    INNER JOIN sueldo ON peluquero.id_peluquero = sueldo.id_peluquero
WHERE sueldo.fecha >= CURRENT_DATE - INTERVAL '3 year'
GROUP BY peluqueria.id_peluqueria, peluquero.id_peluquero, mes
HAVING SUM(sueldo.cantidad) = (
        SELECT MAX(sueldo_acumulado) 
        FROM (
            SELECT peluqueria.id_peluqueria, peluquero.id_peluquero, DATE_TRUNC('month', sueldo.fecha) AS mes, 
                SUM(sueldo.cantidad) AS sueldo_acumulado
            FROM peluquero
                INNER JOIN peluqueria ON peluquero.id_peluqueria = peluqueria.id_peluqueria
                INNER JOIN sueldo ON peluquero.id_peluquero = sueldo.id_peluquero
            WHERE sueldo.fecha >= CURRENT_DATE - INTERVAL '3 year'
            GROUP BY peluqueria.id_peluqueria, peluquero.id_peluquero, mes
        ) AS sueldos_acumulados_peluqueros
        WHERE sueldos_acumulados_peluqueros.id_peluqueria = peluqueria.id_peluqueria
        GROUP BY sueldos_acumulados_peluqueros.id_peluqueria, sueldos_acumulados_peluqueros.id_peluquero)
ORDER BY mes ASC;


-- 4. Lista de clientes hombres que se cortan el pelo y la barba.

SELECT DISTINCT cl.nombre
FROM cita c, cliente cl, detalle d
WHERE d.servicio = 'Pelo y Barba' AND c.id_detalle = d.id_detalle 
AND c.id_cliente = cl.id_cliente AND cl.genero = 'M';


-- 5. Lista de clientes que se tiñen el pelo, indicando la comuna del cliente, la peluquería donde se atendió y el valor que pagó.

SELECT cl.nombre, co.nombre, pe.nombre, d.precio
FROM detalle d, cita c, cliente cl, comuna co, peluqueria pe
WHERE d.servicio = 'pelo teñido' AND d.id_detalle = c.id_detalle AND c.id_cliente = cl.id_cliente
AND cl.id_comuna = co.id_comuna AND c.id_peluqueria = pe.id_peluqueria;

-- 6. Identificar el horario más concurrido por peluquería durante el 2018 y 2029, desagregados por mes.

SELECT p.nombre AS peluqueria, c.anio, c.mes, c.hora, COUNT(*) AS cantidad_citas
FROM Peluqueria p 
INNER JOIN Peluquero pq ON p.id_peluqueria = pq.id_peluqueria 
INNER JOIN Cita c ON pq.id_peluquero = c.id_peluquero 
WHERE c.anio BETWEEN 2018 AND 2029 
GROUP BY p.nombre, c.anio, c.mes, c.hora 
HAVING COUNT(*) = 
	(
	    SELECT MAX(cantidad_citas) 
		FROM (
			SELECT p2.nombre, c2.anio, c2.mes, c2.hora, COUNT(*) AS cantidad_citas
			FROM Peluqueria p2 
			INNER JOIN Peluquero pq2 ON p2.id_peluqueria = pq2.id_peluqueria 
			INNER JOIN Cita c2 ON pq2.id_peluquero = c2.id_peluquero 
			WHERE c2.anio BETWEEN 2018 AND 2029 
			GROUP BY p2.nombre, c2.anio, c2.mes, c2.hora 
			) AS temp 
		WHERE temp.nombre = p.nombre AND temp.anio = c.anio AND temp.mes = c.mes 
	)
ORDER BY p.nombre, c.anio, c.mes, cantidad_citas DESC;

-- 7.

-- 8.

SELECT peluqueria.nombre AS nombre_peluqueria, detalle.servicio as servicio_mas_caro, detalle.precio as valor 
FROM peluqueria 
INNER JOIN cita ON peluqueria.id_peluqueria = cita.id_peluqueria 
INNER JOIN detalle ON cita.id_detalle = detalle.id_detalle 
WHERE detalle.precio = (SELECT MAX(detalle.precio) 
                        FROM detalle 
                        INNER JOIN cita ON detalle.id_detalle = cita.id_detalle 
                        WHERE cita.id_peluqueria = peluqueria.id_peluqueria) 
GROUP BY peluqueria.nombre, detalle.servicio, detalle.precio;


-- 9. Identificar al peluquero que ha trabajado más por mes durante el 2021.

SELECT t1.nombre, t1.mes, t2.mayor_tiempo
FROM (
	SELECT p.nombre, c.mes, SUM(c.duracion_cita) AS tiempo_trabajado
	FROM Peluquero p
	JOIN Cita c ON p.id_peluquero = c.id_peluquero
	WHERE c.anio = 2021
	GROUP BY p.nombre, c.mes
) t1, (
	SELECT tiempo_por_mes.mes, MAX(tiempo_trabajado) AS mayor_tiempo
	FROM (
  		SELECT p.nombre, c.mes, SUM(c.duracion_cita) AS tiempo_trabajado
  		FROM Peluquero p
  		JOIN Cita c ON p.id_peluquero = c.id_peluquero
  		WHERE c.anio = 2021
  		GROUP BY p.nombre, c.mes
	) AS tiempo_por_mes
	GROUP BY tiempo_por_mes.mes
) t2
WHERE t1.mes = t2.mes AND t1.tiempo_trabajado = t2.mayor_tiempo;

-- 10.



(define (problem ejercicio1)

	(:domain ejercicio_1)

	(:objects
		; mapa 5 x 5
		l1_1 l1_2 l1_3 l1_4 l2_1 l2_2 l2_3 l2_4 l3_1 l3_2 l3_3 l3_4  - localizacion
		; edificios y unidades
		centroMando1 - edificio
		vce1 - unidad
	)

	(:init
		; conexiones del grid 5 x 5
		; conexiones del grid 5 x 5
		; Conexion entre 11 y 12
		(caminoEntre l1_1 l1_2)
		(caminoEntre l1_2 l1_1)
		; Conexion entre 11 y 21
        (caminoEntre l1_1 l2_1)
        (caminoEntre l2_1 l1_1)
        ; Conexion entre 21 y 31
        (caminoEntre l3_1 l2_1)
        (caminoEntre l2_1 l3_1)
        ; Conexion entre 31 y 32
        (caminoEntre l3_2 l3_1)
        (caminoEntre l3_1 l3_2)
        ; Conexion entre 32 y 22
        (caminoEntre l3_2 l2_2)
        (caminoEntre l2_2 l3_2)
        ; Conexion entre 22 y 12
        (caminoEntre l1_2 l2_2)
        (caminoEntre l2_2 l1_2)
        ; Conexion entre 22 y 23
        (caminoEntre l2_3 l2_2)
        (caminoEntre l2_2 l2_3)
        ; Conexion entre 23 y 13
        (caminoEntre l2_3 l1_3)
        (caminoEntre l1_3 l2_3)
        ; Conexion entre 13 y 14
        (caminoEntre l1_4 l1_3)
        (caminoEntre l1_3 l1_4)
        ; Conexion entre 14 y 24
        (caminoEntre l1_4 l2_4)
        (caminoEntre l2_4 l1_4)
		; Conexion entre 24 y 34
        (caminoEntre l3_4 l2_4)
        (caminoEntre l2_4 l3_4)
        ; Conexion entre 34 y 33
        (caminoEntre l3_4 l3_3)
        (caminoEntre l3_3 l3_4)


		; posiciones de las entidades
		; los barracones están sin construir
		(entidadEnLocalizacion centroMando1 l1_1)
		(entidadEnLocalizacion vce1 l1_1)
		(unidadLibre vce1)

		; recuros que necesitan cada edificio
		(necesitaRecurso CentroDeMando Gas)

		; establecemos los tipos de edificios
		(esEdificio centroMando1 CentroDeMando)

		; establecemos los tipos de unidades
		(esUnidad vce1 VCE)

		; establecemos en que localizaciones están los recursos
		(asignarNodoRecursoLocalizacion Mineral l2_3)
		(asignarNodoRecursoLocalizacion Mineral l3_3)


	)

	(:goal
		(and
			; la meta es tener unos barracones en una localización
			(estaExtrayendoRecurso Mineral)
		)
	)
)

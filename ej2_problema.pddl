; Jacobo Casado de Gracia. Práctica 3 TSI
(define (problem ejercicio2)

	(:domain ejercicio_2)

    ; Declaramos los objetos. En este caso, el grid (mapa) será constante para todos los ejercicios.
	(:objects
		; Grid 4 x 4
		l1_1 l1_2 l1_3 l1_4 l2_1 l2_2 l2_3 l2_4 l3_1 l3_2 l3_3 l3_4  - localizacion
		; edificios y unidades
		vce1 - unidad
		vce2 - unidad
		extractor1 - edificio
	)

	; Al igual que antes, las conexiones del grid serán constantes.
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


		; Ponemos las posiciones de las entidades y, en caso de que sean unidades, las declaramos como libres.
		(entidadEnLocalizacion vce1 l1_1)
		(entidadEnLocalizacion vce2 l1_1)
		(unidadLibre vce1)
        (unidadLibre vce2)

		; Establecemos los tipos de edificios
		(esEdificio extractor1 Extractor)

		; Establecemos las unidades y sus tipos
		(esUnidad vce1 VCE)
        (esUnidad vce2 VCE)

		; Establecemos en qué localizaciones están los recursos
		(asignarNodoRecursoLocalizacion Mineral l2_3)
		(asignarNodoRecursoLocalizacion Mineral l3_3)
        (asignarNodoRecursoLocalizacion Gas l1_3)

        ; Saber qué recurso necesita cada edificio.
        (necesitaRecurso Extractor Mineral)

	)

    ; Establecemos la meta.
	(:goal
		(and
			; META PRÁCTICA 2: QUE SE ESTÉ EXTRAYENDO GAS.
			(estaExtrayendoRecurso Gas)
		)
	)
)

; Jacobo Casado de Gracia. Práctica 3 TSI
(define (problem ejercicio3)

	(:domain ejercicio_3)

    ; Declaramos los objetos. En este caso, el grid (mapa) será constante para todos los ejercicios.
	(:objects
		; Grid 4 x 4
		l1_1 l1_2 l1_3 l1_4 l2_1 l2_2 l2_3 l2_4 l3_1 l3_2 l3_3 l3_4  - localizacion
		; edificios y unidades
		vce1 - unidad
		; Definimos el VCE2 y VCE3 pero no les damos "vida"
		vce2 - unidad
		vce3 - unidad
		marine1 - unidad
		marine2 - unidad
		segador1 - unidad
		extractor1 - edificio
		barracones1 - edificio
		centroMando1 - edificio
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
		(entidadEnLocalizacion centroMando1 l1_1)
		(unidadLibre vce1)
        ; Solo ponemos como unidad libre y ubicada el VCE1.

		; Establecemos los tipos de edificios
		(esEdificio extractor1 Extractor)
		(esEdificio barracones1 Barracones)
		(esEdificio centroMando1 CentroDeMando)

		; Establecemos las unidades y sus tipos
		(esUnidad vce1 VCE)
        (esUnidad vce2 VCE)
        (esUnidad vce3 VCE)
        (esUnidad marine1 Marine)
        (esUnidad marine2 Marine)
        (esUnidad segador1 Segador)

		; Establecemos en qué localizaciones están los recursos
		(asignarNodoRecursoLocalizacion Mineral l2_3)
		(asignarNodoRecursoLocalizacion Mineral l3_3)
        (asignarNodoRecursoLocalizacion Gas l1_3)

        ; Saber qué recurso necesita cada edificio.
        (necesitaRecurso Extractor Mineral)
        ; Según la práctica 4, pone que continuemos con la 3, donde los barracones requieren mineral y gas.
        (necesitaRecurso Barracones Mineral)
        (necesitaRecurso Barracones Gas)

        ; Detalle, ahora la creación de las tropas requiere minerales.
        (necesitaRecurso VCE Mineral)
        (necesitaRecurso Marine Mineral)
        (necesitaRecurso Segador Mineral)
        (necesitaRecurso Segador Gas)

	)

    ; Establecemos la meta.
	(:goal
		(and
			; META PRÁCTICA 4: QUE, FINALMENTE, HAYA:
			; UN MARINE EN LA LOCALIZACION 31.
			; OTRO MARINE EN LA LOCALIZACION 24
			; UN SEGADOR EN LA LOCALIZACION 12.
			(entidadEnLocalizacion marine1 l3_1)
            (entidadEnLocalizacion marine2 l2_4)
            (entidadEnLocalizacion segador1 l1_2)
		)
	)
)

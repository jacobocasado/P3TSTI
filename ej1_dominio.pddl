(define (domain ejercicio_1)
	(:requirements :strips :adl :fluents)

	(:types
		; Declaramos los tipos entidad y localización como un tipo objeto.
		entidad localizacion - object

		; Los edificios y las unidades serán ambos entidades porque su funcionamiento es casi el mismo en algunas funciones.
		unidad - entidad
		edificio - entidad
		; Los recursos serán de tipo objeto.
		recurso - object

		; Tipos constantes para los edificios, unidades y recursos que tendrán herencia (de recurso hay mineral y gas, por ejemplo).
		tipoEdificio - edificio
		tipoUnidad - unidad
		tipoRecurso - recurso
	)


	(:constants
		; Declaramos constantes que vamos a usar durante toda la práctica
		VCE - tipoUnidad
		CentroDeMando - tipoEdificio
		Barracones - tipoEdificio

		Mineral - tipoRecurso
		Gas - tipoRecurso

	)

	(:predicates
		;predicados:

		; Comprobar si una entidad (edificio o unidad está en una localización).
		(entidadEnLocalizacion ?obj - entidad ?x - localizacion)

		; Comprobar que una ubicación x1 está conectada con otra x2 (no es paralela así que, en nuestro modelo, para conectar
		; una con otra, debemos declarar este predicado dos veces, con los parámetros al revés.
		(caminoEntre ?x1 - localizacion ?x2 - localizacion)

		; Para asignar o comprobar si en una localización hay un recurso.
		(asignarNodoRecursoLocalizacion ?r - recurso ?x - localizacion)

		; Saber si se está extrayendo un recurso.
		(estaExtrayendoRecurso ?rec - recurso)

		; Comprobar o asignar que una unidad está libre
		(unidadLibre ?uni - unidad)

		; Asignar o comprobar que una unidad es de cierto tipo.
		(esEdificio ?edif - edificio ?tipoEdif - tipoEdificio)
		(esUnidad ?unid - unidad ?tUnid - tipoUnidad)
	)

	; Acción de navegar. Recibe de parámetro la unidad, dos localizaciones (actual y nueva, a moverse)
	(:action navegar
	  :parameters (?unidad - unidad ?x ?y - localizacion)
	  :precondition
	  		(and
				; La entidad, como precondición, debe de estar en la primera localización.
				(entidadEnLocalizacion ?unidad ?x)
				; Debe de haber un camino entre ambas localizaciones (deben estar conectadas)
				(caminoEntre ?x ?y)
				; La unidad debe de estar libre
				(unidadLibre ?unidad)
			)

	  :effect
	  		(and
				; Pasa a estar a una nuev alocalización, como efecto.
				(entidadEnLocalizacion ?unidad ?y)
				; Y deja de estar en la antigua localización.
				(not (entidadEnLocalizacion ?unidad ?x))
			)
	)

    ; Acción de asignar una unidad a una localización, para extraer un recurso en concreto, que también se especifica.
	(:action asignar
	  :parameters (?x - unidad ?rec - recurso ?loc - localizacion)
	  :precondition
	  		(and
				; La unidad debe de estar previamente en la localización
				(entidadEnLocalizacion ?x ?loc)

				; En dicha localización debe de haber un recurso
				(asignarNodoRecursoLocalizacion ?rec ?loc)

				; La unidad debe de estar libre.
				(unidadLibre ?x)
			)
	  :effect
	  		(and
				; La unidad deja de estar libre (pasa a estar extrayendo)
				(not (unidadLibre ?x))
				; El recurso se está extrayendo
				(estaExtrayendoRecurso ?rec)

			)
	)


)

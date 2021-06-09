; Jacobo Casado de Gracia. Práctica 3 TSI
(define (domain ejercicio_3)
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

		; Para este ejercicio, incluimos el extractor
		Extractor - tipoEdificio

        ; Para este ejercicio, acumulamos dos nuevos tipos de recursos.
        Mineral - tipoRecurso
        Gas - tipoRecurso

		; Ahora, con el ejercicio 4, añadimos dos constantes nuevas, para las dos nuevas tropas.
		Marine - tipoUnidad
		Segador - tipoUnidad

	)

	(:predicates
		;predicados:

		; Comprobar o asignar que una unidad está libre
		(unidadLibre ?uni - unidad)

		; Saber si se está extrayendo un recurso.
		(estaExtrayendoRecurso ?rec - recurso)

		; Comprobar que una ubicación x1 está conectada con otra x2 (no es paralela así que, en nuestro modelo, para conectar
		; una con otra, debemos declarar este predicado dos veces, con los parámetros al revés.
		(caminoEntre ?x1 - localizacion ?x2 - localizacion)

		; Para asignar o comprobar si en una localización hay un recurso.
		(asignarNodoRecursoLocalizacion ?r - recurso ?x - localizacion)

		; Comprobar si una entidad (edificio o unidad está en una localización).
		(entidadEnLocalizacion ?obj - entidad ?x - localizacion)

		; Asignar o comprobar que una unidad es de cierto tipo.
		(esEdificio ?edif - edificio ?tipoEdif - tipoEdificio)
		(esUnidad ?unid - unidad ?tUnid - tipoUnidad)

		; ACTUALIZACIÓN PRÁCTICA 4 - CAMBIAMOS EDIFICIO POR ENTIDAD, YA QUE AHORA LAS TROPAS NECESITAN RECURSOS
		; AHORA TANTO EDIFICIO COMO TROPA FUNCIONA, YA QUE AMBOS SON ENTIDADES.
        (necesitaRecurso ?x - entidad ?rec - tipoRecurso)

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

				; SÓLO LOS VCE PUEDEN EXTRAER UN RECURSO EN CONCRETO. NO HABÍA CAIDO EN ESTO.
                (esUnidad ?x VCE)


                ; PARA COMPROBAR QUE SI NO ES GAS, PODEMOS EXTRAER Y SI ES GAS TENEMOS QUE TENER UN EXTRACTOR EN LA LOCALIZACION.
				(or
                     (and ; Si es gas debe haber un extractor en esa localización
                        (asignarNodoRecursoLocalizacion Gas ?loc)
                        (exists (?e - edificio) ; existe un extractor en esa localización
                          (and
                             (esEdificio ?e Extractor)
                              (entidadEnLocalizacion ?e ?loc)
                          )
                     )
                     )

                     ; Si es mineral no hace falta nada
                      (asignarNodoRecursoLocalizacion Mineral ?loc)
                )
            )
	  :effect
	  		(and
				; La unidad deja de estar libre (pasa a estar extrayendo)
				(not (unidadLibre ?x))
				; El recurso se está extrayendo
				(estaExtrayendoRecurso ?rec)

			)
	)

	(:action construir
    		; acción para construir un edificio - para este ejercicio se pueden necesitar más de un recurso
    		; y además, si ya hay un edificio construido, no podemos construir de nuevo.
    	  :parameters (?unidad - unidad ?x - localizacion ?edificio - edificio)
    	  :precondition
    	  		(and
    				; tiene que ser una unidad libre
    				(unidadLibre ?unidad)

    				; tiene que estar en la localizacion a construir el edificio
    				(entidadEnLocalizacion ?unidad ?x)

    				; no hay otro edificio en esa localizacion
                    (not (exists (?edif - edificio) (entidadEnLocalizacion ?edif ?x) ) )

                    ; Al igual que antes, sólo los VCE pueden construir.
                    (esUnidad ?unidad VCE)

                    ; ESTO NO LO HE PUESTO EN EL EJERCICIO 3 PORQUE EN EL EJERCICIO 3 NO OCURRE UN CASO
                    ; DONDE SE PUEDA CONSTRUIR MÁS DE UNA COSA IGUAL, PERO, EN ESTE SÍ ES IMPORTANTE.
                    ; SI NO, ME CONSTRUYE DOS BARRACONES.

                   (forall (?l - localizacion)
                        (not(entidadEnLocalizacion ?edificio ?l))
                   )


                    ; para todos los posibles recursos
    				(forall (?r - tipoRecurso)
    					; existe un tipo de edificio
    					(exists (?t - tipoEdificio)
    						(and
    							; que es el que vamos a construir
    							(esEdificio ?edificio ?t)
    							; si ese edificio necesita el recurso, se tiene que estar extrayendo
    							(imply (necesitaRecurso ?t ?r) (estaExtrayendoRecurso ?r) )
    						)
    					)
    				)
    			)
    	  :effect
    	  		(and
    				; como efecto, se construye el edificio
    				(entidadEnLocalizacion ?edificio ?x)

    			)
    	)
    	; Modificación del ejercicio 4. Añadimos la acción de reclutar, una unidad en una localización concreta donde
    	; hay un edificio en concreto.
    	(:action reclutar
                 :parameters (?e - edificio ?u - unidad ?l - localizacion)
                 :precondition

                     ; NECESARIO PARA EL EJERCICIO 4. QUE, PARA RECLUTAR UNA UNIDAD, NO EXISTA PREVIAMENTE.
                     (and

                     (forall (?loc - localizacion)
                        (not(entidadEnLocalizacion ?u ?loc))
                     )


                     (or ; Dependiendo del tipo de edificio, vamos a poder reclutar una cosa u otra.
                         (and ; Centro de Mando = VCE
                             (entidadEnLocalizacion ?e ?l)
                            (esEdificio ?e CentroDeMando)
                            (esUnidad ?u VCE)
                        )
                        (and ; Barracon = Segadores y Marines.
                             (entidadEnLocalizacion ?e ?l)
                            (esEdificio ?e Barracones)
                            (or
                                (esUnidad ?u Segador)
                                (esUnidad ?u Marine)
                            )
                        )
                    )
                 )
                 :effect
                     (and
                        (entidadEnLocalizacion ?u ?l)
                        (unidadLibre ?u)
                    )
             )


)

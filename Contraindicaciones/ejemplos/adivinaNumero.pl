:- dynamic output/1.

% Predicado principal para iniciar la adivinanza del número.
adivinar_numero(X) :-
    retractall(output(_)),
    with_output_to(string(SalidaIntro), (
        escribir_intro
    )),
    format('~w~n', [SalidaIntro]),
    adivinar(1, 100, X, SalidaFinal),
    assert(output(SalidaFinal)).

% Proceso de adivinanza que calcula el número medio y simula la respuesta.
adivinar(Min, Max, NumeroSecreto, Salida) :-
    Min =< Max,
    Middle is (Min + Max) // 2,
    simular_respuesta(Middle, NumeroSecreto, Respuesta, SalidaSimulacion),
    manejar_respuesta(Respuesta, Min, Max, Middle, NumeroSecreto, SalidaManejo),
    string_concat(SalidaSimulacion, SalidaManejo, Salida).

% Simulación de respuestas basadas en el número secreto.
simular_respuesta(Middle, NumeroSecreto, si, '') :-
    Middle =:= NumeroSecreto.

simular_respuesta(Middle, NumeroSecreto, mayor, Salida) :-
    Middle < NumeroSecreto,
    with_output_to(string(Salida1), (
        escribir_continuacion(Middle, mayor)
    )),
    format('~w~n', [Salida1]),
    Salida = Salida1.

simular_respuesta(Middle, NumeroSecreto, menor, Salida) :-
    Middle > NumeroSecreto,
    with_output_to(string(Salida1), (
        escribir_continuacion(Middle, menor)
    )),
    format('~w~n', [Salida1]),
    Salida = Salida1.

% Manejo de las respuestas simuladas y ajuste del rango de búsqueda.
manejar_respuesta(si, _, _, X, _, Salida) :-
    with_output_to(string(Salida1), (
        escribir_final(X)
    )),
    format('~w~n', [Salida1]),
    Salida = Salida1.

manejar_respuesta(mayor, _, Max, Middle, NumeroSecreto, Salida) :-
    NuevoMin is Middle + 1,
    adivinar(NuevoMin, Max, NumeroSecreto, Salida).

manejar_respuesta(menor, Min, _, Middle, NumeroSecreto, Salida) :-
    NuevoMax is Middle - 1,
    adivinar(Min, NuevoMax, NumeroSecreto, Salida).

% Predicados para escribir mensajes en la salida.
escribir_intro :-
    format('Voy a intentar adivinar el número en el que estás pensando (entre 1 y 100).').

escribir_continuacion(X, mayor) :-
    format('¿Es tu número ~w?~nNo. Mi número es mayor a ~w.', [X, X]).

escribir_continuacion(X, menor) :-
    format('¿Es tu número ~w?~nNo. Mi número es menor a ~w.', [X, X]).

escribir_final(X) :-
    format('¡Lo tengo! Tu número es: ~w~n', [X]).

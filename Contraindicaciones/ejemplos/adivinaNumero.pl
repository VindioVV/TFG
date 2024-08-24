% punto de entrada principal
adivina_numero :-
    write('Piensa en un número entre 1 y 100, y lo adivinaré.'), nl,
    adivinar(1, 100).

% Caso base: cuando el rango se reduce a un solo número, este es el número a adivinar
adivinar(Min, Max) :-
    Min == Max,
    write('Tu número es: '), write(Min), nl.

% Caso recursivo: preguntar si el número pensado es mayor o igual al punto medio
adivinar(Min, Max) :-
    Min \= Max,
    Medio is (Min + Max) // 2,
    write('¿Es tu número mayor o igual a '), write(Medio), write('? (s/n)'), nl,
    read(Respuesta),
    procesar_respuesta(Respuesta, Min, Max, Medio).

% Procesa la respuesta del usuario para reducir el rango de búsqueda
procesar_respuesta(s, Min, Max, Medio) :-
    NuevoMin is Medio + 1,
    adivinar(NuevoMin, Max).

procesar_respuesta(n, Min, Max, Medio) :-
    NuevoMax is Medio,
    adivinar(Min, NuevoMax).

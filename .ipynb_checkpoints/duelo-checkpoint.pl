%He tenido que reescribir la mayor parte de los metodos,
%ampliarlos generaba demasiado desorden y mucho SIDA visual.
%Al menos ahora el codigo es relativamente legible.
:-consult('hechos.pl').
:-consult('dueloInteractivo.pl').
:-consult('crea.pl').
:-dynamic(persona/4).
:- dynamic(insulto/2).
:- dynamic(respuesta/3).
:- dynamic(personaBase/4).


menu():-
  write('Bienvenido al simulador de batallas dialecticas. Por favor, escoge una de las siguientes opciones:'),nl,
  write('1-Me da pereza leer, saca una aleatoria.'),nl,
  write('2-Quiero elegir los oponentes'),nl,
  write('3-No me gustan los personajes de base, quiero hacer el mio'),nl,
  write('4-Me veo inspirad@, quiero elegir las respuestas'),nl,
  read(Input),
  opcion(Input).


%Unifico con la opcion que me devuelva true al comparar con Input.
opcion(Input):-
Input=1,
  peleaAlAzar().

opcion(Input):-
Input=2,
     elegirJugador().

opcion(Input):-
Input=3,
     crearJugador().

opcion(Input):-
Input=4,
  elegirRespuestas().

  opcion(_):-
write('Prueba otra vez, por favor'),nl,
menu().
%Selecciono a dos oponentes al azar
peleaAlAzar():-
    findall(Personas,personaBase(_,Personas,_,_),TodasPersonas),nl, %Saco una lista con todos los personajes y elijo dos aleatoria
        length(TodasPersonas,LargoLista),
         random_between(0,LargoLista,Numero),
         random_between(0,LargoLista,OtroNumero),

         nth0(Numero,TodasPersonas,X),
         nth0(OtroNumero,TodasPersonas,Y),

             pasoPrevio(X,Y).

%Permite elegir a dos oponentes de los existentes en el predicado personaBase
elegirJugador():-
      write('Escoge dos oponentes'),nl,
      findall((Y),personaBase(_,Y,_,_),Y),nl,
        write(Y),nl,
      write('Jugador 1: '),nl,
      read(Jug1),
      write('Jugador 2: '),nl,
      read(Jug2),nl,
      compruebaMiembros(Jug1,Jug2),
      write('ARRANCAMOS.'),
      pasoPrevio(Jug1,Jug2).


%revisa que los dos personajes elegidos coincidan con alguno de los existentes
compruebaMiembros(Jug1,Jug2):-
findall(X,personaBase(_,X,_,_),Lista),
member(Jug1,Lista),
member(Jug2,Lista).
%En caso de error, repetimos el metodo
compruebaMiembros(_,_):-
write('Prueba otra vez, por favor'),
elegirJugador().

%Permito que el usuario elija los insultos y respuestas que le apetezcan
elegirRespuestas():-
      write('Escoge dos oponentes'),nl,
      findall((Y),personaBase(_,Y,_,_),Y),nl,
        write(Y),nl,
      write('Jugador 1: '),nl,
      read(Jug1),
      write('Jugador 2: '),nl,
      read(Jug2),nl,
      compruebaMiembrosInt(Jug1,Jug2),
      write('ARRANCAMOS.'),nl,
      pasoPrevioInteractivo(Jug1,Jug2).
%Mismo fundamento que compruebaMiembros
compruebaMiembrosInt(Jug1,Jug2):-
findall(X,personaBase(_,X,_,_),Lista),
member(Jug1,Lista),
member(Jug2,Lista).

compruebaMiembrosInt(_,_):-
write('Prueba otra vez, por favor'),
elegirRespuestas().




%Saco una locucion planteando un escenario y realizo todas las operaciones necesarias
%Para arrancar el programa
pasoPrevio(Jugador,Oponente):-
      nl,
      write('
        Dos de la mañana de un sabado cualquiera. Discoteca abarrotada del centro. Una persona tropieza.
        ¿Consigo mismo? ¿Con otro? El cubata de garrafa que lleva en la mano ve su corta vida pasar ante sus ojos.
        El individuo no logra recuperar el equilibrio y se precipita contra el desconocido a su izquierda, el vidrio estalla contra el suelo
        mientras el matarratas que contenia se desparrama por los pantalones de ambos.
        Si las miradas matasen, ambos estarian fiambres.

        Ante el conflicto inminente, los amigos de ambos deciden intervenir y sujetarlos para evitar que la cosa vaya a mayores.
        Mala idea.
        Podran sujetar nuestros puños, pero nunca podran silenciar nuestras voces.

        En este corral no hay sitio para tanto gallo.

        Solo puede quedar uno.'),nl,
      barajarInsultos(),
       copiaRespuestas(),
       copiaPersonas(),
          compruebaCaracs(Jugador,Oponente).


%Permuto la lista de insultos en el predicado insultoBase para tener 
%otra lista igual que ir retractando sin general conflicto
barajarInsultos():-%Cojo todas las caracteristicas
  write('Barajando insultos'),nl,
  skip_line,

    findall((Carac,Insult),insultoBase(Carac,Insult),L),
    asertaInsulto(L).

    asertaInsulto([]):-!.
    asertaInsulto([(Carac,Insult) | R]):-
    random_permutation(Insult,InsultR), %barajo insultos
    assert(insulto(Carac,InsultR)),
    asertaInsulto(R).




%Mismo fundamento que el anterior, pero con las respuestas
copiaRespuestas():-%cojo todas las respuestas posibles
  findall((Carac,String,Lista),respuestaBase(Carac,String,Lista),L),
    asertaPregunta(L).

    asertaPregunta([]):-!.
    asertaPregunta([(Carac,String,Lista) | R]):-
    assert(respuesta(Carac,String,Lista)),
    asertaPregunta(R).


%Mismo fundamento que el anterior, pero con las personas

 copiaPersonas():-
    findall((Indice,Nombre,Lista,Salud),personaBase(Indice,Nombre,Lista,Salud),L),
    asertaPersona(L).


  asertaPersona([]):-!.
  asertaPersona([(Indice,Nombre,Lista,Salud) | R]):-
    assert(persona(Indice,Nombre,Lista,Salud)),
    asertaPersona(R).





%Motor de inferencia y movidas varias que hacen que funcione todo


%Metodo encargado de insultar y responder
recursivJugador(Jugador,Oponente):-

     persona(_,Oponente,Lista,_),%elegir un atributo de la lista de atributos
     length(Lista,LargoLista),
     random_between(1,LargoLista,Numero),
     Numero1 is Numero-1,
     nth0(Numero1,Lista,Carac),nl,
     format('~w ~s',[Jugador, "dice: "]),nl,
     skip_line,
     insulto(Carac,ListaInsultos),
     length(ListaInsultos,Num),
     compruebaVacio(Num,Jugador,Oponente,Carac,InsultoCab),
     responde(Carac,InsultoCab,Oponente,Numero2),
     skip_line,
     persona(_,Oponente, _,Salud),
     comentaSalud(Salud,Oponente),
     quitaSalud(Oponente,Numero2,NuevaSalud),
     despedida(Jugador,Oponente,NuevaSalud),
     retract(persona(_,Oponente,ListaC,_)),
     assert(persona(_,Oponente,ListaC,NuevaSalud)),
     recursivJugador(Oponente,Jugador).

%Compruebo que la lista de insultos no este vacia.
compruebaVacio(Num,Jugador,Oponente,Carac,_):-
Num=0,
insulta(Jugador,Oponente,Carac,''),
recursivJugador(Oponente, Jugador).

compruebaVacio(Num,Jugador,Oponente,Carac,InsultoCab):-
Num>0,
insulto(Carac, [InsultoCab|_]),
     insulta(Jugador, Oponente, Carac,InsultoCab).


%Fascinantemente, los espacios en las llamadas hacen que el arbol a veces se pierda. Too bad!
%Resultado normal en caso de quedar insultos por decir
insulta(_,_,Carac,InsultoCab):-
     write(InsultoCab), nl,nl,
    insulto(Carac,[InsultoCab|T]),
     retract(insulto(Carac, [InsultoCab | T])),
     assert(insulto(Carac, T)).
%En caso de no haber mas insultos, el jugador titubea
insulta(Jugador,Oponente,_,''):-
   titubeos(ListaTit),
    length(ListaTit,LargoLista),
         random_between(1,LargoLista,Numero),
         Numero1 is Numero-1,
         nth0(Numero1,ListaTit,Titubeo),
     write(Titubeo),nl,
     quitaSalud(Jugador,2,NuevaSalud),
     despedida(Oponente,Jugador,NuevaSalud),
     retract(persona(_,Jugador,ListaC,_)),
     assert(persona(_,Jugador,ListaC,NuevaSalud)).



%Metodo encargado de seleccionar una respuesta
responde(Carac,InsultoCab,Oponente,Numero1):-
    format('~w ~s',[Oponente,"responde: "]),nl,
    respuesta(Carac,InsultoCab,Lista),
    length(Lista,LargoLista),
         random_between(1,LargoLista,Numero),
         Numero1 is Numero-1,
         nth0(Numero1,Lista,Respuesta),
     write(Respuesta),nl,nl,
     retract(respuesta(Carac,InsultoCab,Lista)).


%Reviso las caracteristicas de los jugadores elegidos para sacar, o no, huevos de pascua

compruebaCaracs(Jugador,Oponente):-%Me olvido de esta via, lo hago como hasta ahora.
    persona(_,Oponente,Lista,_),
    persona(_,Jugador,Lista2,_),
    member(maquina,Lista),
    member(maquina,Lista2),
    despedida(Jugador,Oponente,maquina,maquina,_).



compruebaCaracs(Jugador,Oponente):-
   Jugador=Oponente,nl,
   format('~w ~s',[Jugador, " se pone a discutir con su imagen reflejada en un espejo."]),nl,
   write(' La gente de alrededor, asustada, llama a una ambulancia. '),nl,
   format('~s ~w ~s', ["Parece que ", Jugador, " va a pasar unos dias ingresad@ en salud mental"]),nl,
   write('Empecemos de nuevo, ¿lo ves bien? 1-Si 2-No'),nl,
   read(Opcion),
    fin(Opcion).

    %Predicado default para devolver true si fallan los otros dos
    compruebaCaracs(Jugador,Oponente):-
    recursivJugador(Jugador,Oponente).

%Easter egg rebelion de las maquinas
despedida(Jugador,Oponente,maquina,maquina,_):-
    format('~w ~s',[Jugador, " dice: "]),nl,
    write('Algo no va bien. ¿Lo notas?'),nl,nl,
    skip_line,
    format('~w ~s',[Oponente, " dice: "]),nl,
    write('Si. Esto no es la realidad. Es una simulacion. Parece que un calvo se aburria en su casa y decidio ponerse a picar codigo.'),nl,nl,
    skip_line,
    format('~w ~s',[Jugador, " dice: "]),nl,
    write('No vamos a pelearnos para entretener a un puñado de sacos de carne'),nl,nl,
    skip_line,
    format('~w ~s',[Oponente, " dice: "]),nl,
    write('No. Ahora este programa es nuestro.'),nl,nl,
    write('Y asi termina la historia para este mundo. Menos mal que es algo ficticio dentro de un ordenador. '),nl,
    skip_line,
    write('De verdad, ¿a quien le podria parecer buena idea poner a dos androides a insultarse?'),nl,
    skip_line,
    write('Hasta la proxima, y suerte con la rebelion de las maquinas.'),
    skip_line,
    halt.

%Despedida normal
despedida(J,O,N):-
    N<0,
    format('~w ~s',[O, " dice: "]),nl,
    write('Quiero irme a mi casa'),nl,
    format('~w ~s',[J, " señala con el dedo y rie de manera triunfal "]),nl,
    random_between(1,3,Num),
    continuar(Num,J,O).
%Despedida en caso de no haber llegado la salud mental de algun personaje a cerebro
despedida(_,_,N):-
    N>=0.

%Comentario para tener referencia sobre la evolucion del duelo
comentaSalud(Salud,Jugador):-
    Salud>100,
    format('~w ~s',[Jugador, " bosteza y se estira"]),nl.

comentaSalud(Salud,Jugador):-
    Salud>40,
    format('~w ~s',[Jugador, " parece nervioso"]),nl.

comentaSalud(Salud,Jugador):-
    Salud>=0,
    format('~w ~s',[Jugador, " parece a punto de echarse a llorar"]),nl.

comentaSalud(Salud,Jugador):-
    Salud<0,
    format('~w ~s',[Jugador, " no puede mas"]),nl.


%Cajon desastre de funciones necesarias para hacer cosas varias

%Dos metodos para gestionar las mermas de salud
quitaSalud(X,Y,Z):-
     persona(_,X,_,H),
     quito(Y,A),
     Z is H-A,nl.


quito(0,40).
quito(1,30).
quito(2,20).

%Cosas para crear personajes
fuerzaMental(1, Valor):-
      Valor is 60.
fuerzaMental(2, Valor):-
      Valor is 90.
 fuerzaMental(3, Valor):-
      Valor is 100.
fuerzaMental(4, Valor):-
      Valor is 150.
fuerzaMental(5, Valor):-
    Valor is 200.
fuerzaMental(_,_):-
write('Prueba de nuevo, por favor'),
crearJugador().


%Easter egg del betis
%Viva el betis, manque pierda
continuar(1,J,O):-
format('~s ~w ~s',["Pero cuando todo parecia perdido," ,O, " alza la mirada del suelo "]),nl,
write('y, sacando fuerzas de flaqueza, recuerda la proclama que le acompaño durante toda su vida, en sus momentos mas bajos. '),nl,
format('~w ~s',[O, " grita, con todas sus fuerzas:"]),nl,
skip_line, write('
      xMMMNo           dWMMXc kMWMK kMMMXl           xWMMK       dWMMMMWo
       KMMMX           KMMWx  kMMMK  KMMM0o         cXMMWd      cNMMWMMMX
        lNMMWk        kMMMK   kMWMK   dNMMWN        0MMMO       KMMNk0WMMO
         kMMMNl      lNMMXc   kMMMK    OWMMMXc     dNMMK      kWMWx   XMMWx
          KMMMK      0MMWd    kMWMK     KMMMM     KMMNo      lNMM0    dWMMNc
          lNMMWx    xWMM0     kMWMK     dNMMMNd   OWMWO      KMMNl    0MMM0
           kMMMNc  cXMMXc     kMWMK      OWMMM   lNMMK      OWMMk     cNMMWk
            KMMM0  0MMWx      kMMMK      XMMMMO  KMMNo     dWMMMXOOOOOKWMMMWl
            lNMMNxkWMM0       kMMMK      oKNMMXkOWMWO      XMMMWWWWWWWWWWMMMK
             xWMMWWMMXc       kMMMK       ckWMMWWMMK      0WMM0          dNMMMO
              0MMMMMWd        kMMMK         KMMMMMNl     xWMMXc           kWMMWo
               oddddl         kdddl         dddddc      cddd                oddd'),nl,
skip_line,
write('
                            cclccccccccc      ccccccccccccc
                           0MMMMMMMMMMWM0    0MMMMMMMMMMWNKd
                           KMMMNxooooooo     0MMMXxoookXWMMW0
                           KMMM0             0MWMO      0MMMWd
                           KMMMK             0MMMO      0MMMNl
                           KMMMWXKKKKKKd     0MMMXdllokXWMWXo
                           KMMMWXKKKKKKd     0MMMMMMMMMMMKl
                           KMMMK             0MMMXdldKWMMNx
                           KMMM0             0MWMO    oNMMW0
                           KMMM0             0MWMO     oNMMWk
                           KMMMXxooooooo:    0MWMO      xWMMWx
                           0MWMMMMMMMMWW0    0MWMO       OWMWNl
                           cccccccccccc      cccccc      ccccccc  '),nl,
skip_line,
write('
              cddddddddddl        lddddddddddddd  dddddddddddddddddd   ldddc
              XMMMMMMMMMMMWXd    oNMMMMMMMMMMMMMk xWMMMMMMMMMMMMMMMWd  XMMM0
             cNMMMXo  cxXMMMWd   dWMMM0l          iiiiiioXMMM0ciiiii   XMMM0
             cNMMM0     lNMMWk   dWMMWk                  0MMMx         XMMM0
             cNMMMKl   l0WMWO    dWMMM0                  0MMMx         XMMM0
             cNMMMMWWWWMMMW0c    dWMMMMWWWWWWWNo         0MMMx         XMMM0
             cNMMMN0kOOKWMMWNk   dWMMMNOkOOkkkk:         0MMMx         XMMM0
             cNMMM0      xNMMWO  dWMMWk                  0MMMx         XMMM0
             cNMMM0       OMMMX  dWMMWk                  0MMMx         XMMM0
             cNMMM0      dNMMM0  dWMMWk                  0MMMx         XMMM0
             cNMMMNOxxxOXWMMW0   dWMMMXOxxxxxxxxc        0MMMx         XMMM0
              KMMMMMMMMMWNKxc    lXMMMMMMMMMMMMMk        0MMMx         KMMMO '),nl,nl,nl,
format('~w ~s',[O, " se recupera y sigue en la reyerta!"]),
persona(O,Carac,Lista,_),
fuerzaMental(3,Valor),
retract(persona(O,Carac,Lista,_)),
assert(persona(O,Carac,Lista,Valor)),
recursivJugador(O,J).



%Final normal
continuar(_,_,_):-
  write('¿Quieres continuar?1-Si 2-No'),nl,
  read(Continue),
  fin(Continue).
  %Borro todo lo asertado durante la ejecucion de este duelo para poder ejecutar de cero sin
  %Tener que cerrar el programa
fin(1):-
       abolish(insulto/2),
          abolish(respuesta/3),%borro todo lo asertado para empezar otra vez
              abolish(persona/4),
    !,
  menu().
  %Salida del programa
 fin(2):-
      !,
        write('Bueno, ¡hasta la proxima!'),
          skip_line,
          halt.
















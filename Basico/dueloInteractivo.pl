%Misma funcionalidad que pasoPrevio
pasoPrevioInteractivo(Jugador,Oponente):-
      barajarInsultos(),
       copiaRespuestas(),
        copiaPersonas(),
          insultaPersona(Jugador,Oponente).

%Misma funcionalidad que recursivJugador, permitiendo al usuario escoger insultos
insultaPersona(Jugador,Oponente):-

% FORMA INTERACTIVA
persona(_,Oponente,Lista,_),%elegir un atributo de la lista de atributos
     nl,write("Escoge un atributo a insultar(Con numeros):"),nl,
      write(Lista),nl,
     read(Numero),
     Numero1 is Numero-1,
     length(Lista,LargoLi),
     estaEnRango(LargoLi,Numero),
     nth0(Numero1,Lista,Carac),nl,
     insulto(Carac,ListaIn),
     length(ListaIn,NumeroLista),
     insultoOnoInsulto(NumeroLista,Carac,Jugador,Oponente,InsultoCab),
     skip_line,
     respondeInteractivo(Carac,InsultoCab,Oponente,Numero2),
     skip_line,
     quitaSalud(Oponente,Numero2,NuevaSalud),
     despedidaInteractivo(Jugador,Oponente,NuevaSalud,2),
     comentaSalud(NuevaSalud,Oponente),
     retract(persona(_,Oponente,ListaC,_)),
     assert(persona(_,Oponente,ListaC,NuevaSalud)),
     insultaMaquina(Oponente, Jugador).

%Comprobacion de que hay insultos disponibles
insultoOnoInsulto(NumeroLista,_,Jugador,Oponente,_):-
NumeroLista=0,
write('¡Ups! Parece que no se te ocurre nada que decir :('),nl,
persona(_,Jugador,ListaC,Salud),
quitaSalud(2,NuevaSalud),nl,
comentaSalud(Jugador,NuevaSalud),nl,
retract(persona(_,Jugador,ListaC,Salud)),
assert(persona(_,Jugador,ListaC,NuevaSalud)),
insultaMaquina(Oponente,Jugador).


insultoOnoInsulto(NumeroLista,Carac,Jugador,_,InsultoCab):-
NumeroLista>0,
nl,write('Elije un insulto(Con numeros): '),nl,
      insulto(Carac,ListaIn),
      write(ListaIn),nl,
      read(Input),
      Input1 is Input-1,
      length(ListaIn,Largo),
      estaEnRango(Largo,Input),
      nth0(Input1, ListaIn, InsultoCab),
     insultoDePersona(Input1,Jugador,Carac,InsultoCab).

estaEnRango(Largo,Input):-
Input=<Largo.

estaEnRango(Largo,Input):-
Input>Largo,
write('Numero fuera de rango, ejecucion cancelada'),
continuarInteractivo(_,_,_,_).

insultoDePersona(Input1, Jugador, Carac,InsultoCab):-

format('~w ~s',[Jugador, "dice: "]),nl,
  write(InsultoCab), nl,nl,
  insulto(Carac,Lista),
  nth0(Input1,Lista,InsultoCab,RestoLista),
     retract(insulto(Carac,_)),
     assert(insulto(Carac, RestoLista)).




insultaMaquina(Jugador,Oponente):-
     persona(_,Oponente,Lista,_),%elegir un atributo de la lista de atributos
     length(Lista,LargoLista),
     random_between(1,LargoLista,Numero),
     Numero1 is Numero-1,
     nth0(Numero1,Lista,Carac),nl,
     format('~w ~s',[Jugador, "dice: "]),nl,
     skip_line,
     insulto(Carac,ListaInsultos),
     length(ListaInsultos,Num),
     compruebaVacioInteractivo(Num,Jugador,Oponente,Carac,InsultoCab),
     respuestaDePersona(Carac,InsultoCab,Oponente,Input1),
     skip_line,
     quitaSalud(Oponente,Input1,NuevaSalud),
     comentaSalud(NuevaSalud,Oponente),
     despedidaInteractivo(Jugador,Oponente,NuevaSalud,1),
     retract(persona(_,Oponente,ListaC,_)),
     assert(persona(_,Oponente,ListaC,NuevaSalud)),
     insultaPersona(Oponente, Jugador).


compruebaVacioInteractivo(Num,Jugador,Oponente,Carac,_):-
Num=0,
insultaInteractivo(Jugador,Oponente,Carac,''),
insultaPersona(Oponente,Jugador).

compruebaVacioInteractivo(Num,Jugador,Oponente,Carac,InsultoCab):-
Num>0,
insulto(Carac, [InsultoCab|_]),
     insultaInteractivo(Jugador, Oponente, Carac,InsultoCab).



insultaInteractivo(_,_,Carac,InsultoCab):-
     write(InsultoCab), nl,nl,
    insulto(Carac,[InsultoCab|T]),
     retract(insulto(Carac, [InsultoCab | T])),
     assert(insulto(Carac, T)).

insultaInteractivo(Jugador,Oponente,_,''):-
   titubeos(ListaTit),
    length(ListaTit,LargoLista),
         random_between(1,LargoLista,Numero),
         Numero1 is Numero-1,
         nth0(Numero1,ListaTit,Titubeo),
     write(Titubeo),nl,
     quitaSalud(Jugador,2,NuevaSalud),
     despedidaInteractivo(Oponente,Jugador,NuevaSalud,2),
     retract(persona(_,Jugador,ListaC,_)),
     assert(persona(_,Jugador,ListaC,NuevaSalud)).


respuestaDePersona(Carac,InsultoCab,Oponente,Input1):-

  nl,write('Elije una respuesta: (Con numeros)'),nl,
  respuesta(Carac,InsultoCab,ListaRes),
    write(ListaRes),nl,
      read(Input),
      Input1 is Input-1,
      length(ListaRes,LargoList),
      estaEnRango(LargoList,Input),
      nth0(Input1, ListaRes, Respuesta),
       format('~w ~s',[Oponente,"responde: "]),
       write(Respuesta),nl,nl,
       retract(respuesta(Carac,InsultoCab,_)).


respondeInteractivo(Carac,InsultoCab,Oponente,Numero1):-
    format('~w ~s',[Oponente,"responde: "]),nl,
    respuesta(Carac,InsultoCab,Lista),
    length(Lista,LargoLista),
         random_between(1,LargoLista,Numero),
         Numero1 is Numero-1,
         nth0(Numero1,Lista,Respuesta),
     write(Respuesta),nl,nl,
     retract(respuesta(Carac,InsultoCab,Lista)).



despedidaInteractivo(J,O,N,OtroNum):-
    N<0,
    format('~w ~s',[O, " dice: "]),nl,
    write('Quiero irme a mi casa'),nl,
    format('~w ~s',[J, " señala con el dedo y rie de manera triunfal "]),nl,
    random_between(1,3,Num),
    continuarInteractivo(Num,J,O,OtroNum).

despedidaInteractivo(_,_,N,_):-
    N>=0.



continuarInteractivo(1,J,O,OtroNum):-
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
aDondeVuelvo(J,O,OtroNum).
continuarInteractivo(_,_,_,_):-
  write('¿Quieres continuar?1-Si 2-No'),nl,
  read(Continue),
  fin(Continue).




aDondeVuelvo(J,O,1):-
insultaPersona(O,J).


aDondeVuelvo(J,O,2):-
insultaMaquina(O,J).




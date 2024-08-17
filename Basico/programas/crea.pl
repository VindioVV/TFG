%Modulo para crear personajes
crearJugador():-%Suelto una chapa para entretener un poco.
      write('No hago ningun juicio pero, ¿no crees que es un tanto'),
      write(' cruel crear una entidad solo para ver como la ponen a parir'),nl,
      skip_line,
      write('Vamos. Cualquiera diria que con los que hay ya creados deberias tener suficiente,'),
      nl,write('pero se conoce que te hace especial gracia ver como ponen a caldo'),nl,
      write(' a, que se yo. ¿Familiares, amigos, vecinos? ¿Alumnos, profesores?.'),nl,
      write('En fin. A lo que ibamos.'),nl,
      skip_line,
      write('Bautiza a la pobre criatura(Nombre en minusculas: '),nl,
      read(Nombre),nl,
        skip_line,
          write('¿Como de resilente consideras que deberia ser el infeliz?'),nl,
      findall((X),saludMental(X),X),nl,
          write(X),nl,
      read(Salud),
      fuerzaMental(Salud,Valor),
      findall(Lista,personaBase(Lista,_,_,_),Lista),
      length(Lista,LargoLista),
      Posicion is LargoLista+1,
      write('¿Cuantos atributos tendra el desdichado?(Entre 1 y 3)'),nl,
          read(NumAtri),
          asignaAtri(NumAtri,Posicion, Nombre,Valor).


%Esto es un autentico desproposito, pero no se me ocurre como generalizarlo
%y no tengo tiempo para plantearmelo. Al menos funciona correctamente. Too bad!
asignaAtri(1,Posicion,Nombre,Valor):-
          findall((Carac),insultoBase(Carac,_),Carac),nl,
            write(Carac),nl,
          write('Primer atributo'),nl,
          read(Atributo1),
          esMiembro(Atributo1,Carac),
            skip_line,nl,
              assert(personaBase(Posicion,Nombre,[Atributo1],Valor)),

              write(personaBase(Posicion,Nombre,[Atributo1],Valor)),
          menu().

asignaAtri(2,Posicion,Nombre,Valor):-
          findall((Carac),insultoBase(Carac,_),Carac),nl,
              write(Carac),nl,
          write('Primer atributo'),nl,
          read(Atributo1),
          esMiembro(Atributo1,Carac),
              skip_line,nl,
          write('Segundo atributo'),nl,
          read(Atributo2),
          esMiembro(Atributo2,Carac),
              skip_line,nl,
              assert(personaBase(Posicion,Nombre,[Atributo1,Atributo2],Valor)),

              write(personaBase(Posicion,Nombre,[Atributo1,Atributo2],Valor)),
          menu().

asignaAtri(3,Posicion,Nombre,Valor):-
          findall((Carac),insultoBase(Carac,_),Carac),nl,
              write(Carac),nl,
              write('Primer atributo'),nl,
          read(Atributo1),
          esMiembro(Atributo1,Carac),
              skip_line,nl,
          write('Segundo atributo'),nl,
          read(Atributo2),
          esMiembro(Atributo2,Carac),
              skip_line,nl,
          write('tercer atributo'),nl,
          read(Atributo3),
          esMiembro(Atributo3,Carac),
              skip_line,nl,
              assert(personaBase(Posicion,Nombre,[Atributo1,Atributo2,Atributo3],Valor)),
              write(personaBase(Posicion,Nombre,[Atributo1,Atributo2,Atributo3],Valor)),
          menu().

          %Reviso que cada atributo elegido sea un atributo que existe
esMiembro(Atributo,Carac):-
member(Atributo,Carac).
esMiembro(_,_):-
write('Prueba otra vez'),nl,
crearJugador().
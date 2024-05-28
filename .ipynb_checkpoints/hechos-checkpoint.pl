titubeos(['A que me enfado y no respiro','Habla chucho que no te escucho','Ah, ¿si?','Mmmmmmmmmmmmmm TONTO','Eeeeeeeeeeh FEO','Eeeeeh, pues tu cara huele a culo','Y tu mas','Bota rebota y en tu culo explota','Calla tonto, que eres mas tonto que un tonto','Mama, socorro']).



saludMental(['1-Llorica','2-Estandar','3-Autonomo en Espanya','4-Calvo de nacimiento','5-Profesor/tutor de la UNED']).

personaBase(1,nuria,['calvo'],70).
personaBase(2,ramon,['feo'],70).
personaBase(3,terminator,['maquina'],70).
personaBase(4,hal,['maquina'],70).
personaBase(5,mario,['calvo','asturiano'],200).
personaBase(6,luigi,['feo','madrilenyo'],200).

%Toda la lista de insultos mas las listas en las que se barajan las listas de insultos

insultoBase(madrilenyo,['El agua de vuestro grifo sabe a pura alcantarilla','Que, urbanita, ¿vamos a la playa?','Vamonos de pesca, que quiero cenar calamares']).

insultoBase(asturiano,['Eso que llamas cachopo no es mas que un San Jacobo gordo','Ese meado que llamais sidra me da tremenda cagalera','Dicen que en Asturias solo hay vacas y llorones, y tu no tienes pinta de vaca']).

insultoBase(maquina,['¡Un hervidor electrico!¿Me haces una manzanilla?','El test de Turing lo aprobaste por la privada','¡Una IA sin la I, que desproposito!']).

insultoBase(feo,['Eres tan guapo como un pedo pintor','Eres mas feo que una mona marrana','¿Que tal se vive en una casa sin espejos?','Recien nacido pensaban que eras la placenta, tus padres debieron quedarse mortificados']).

insultoBase(calvo,['Que gracioso, pareces una bombilla','Anda mira, un tobogan de piojos', 'Cuidado con el viento, que te despeina']).

insultoBase(olor,['Mirate ese aliento, que me has rizado el pelo','Un cadaver al sol tiene un aroma mas placentero','¿Por que ese odio a la ducha?','El otro dia vi el champu de rebajas, igual te interesa','Menuda fobia al agua, ni que fueras un gato']).

insultoBase(idiota,['No juzgo pero, ¿tus padres son hermanos?','Me recuerdas al fundador de Lepe, teneis la misma cara','¿De pequenyo te caiste de cabeza de la cuna?']).
%El motor deberia tener suficiente con el String del insulto para encontrar la respuesta, pero si le meto
%la caracteristica no falla nunca. Que le vamos a hacer.


%Respuestas asturiano
respuestaBase(asturiano,'Eso que llamas cachopo no es mas que un San Jacobo gordo',['Ye la mi balsa, pa cuando dame por remontar fiordos','Va a opinar de comida un urbanita que vive del mardonals','A rebuznos de cazurros, oidos sordos']).
respuestaBase(asturiano,'Ese meado que llamais sidra me da tremenda cagalera',['Nun ties coyones de decilo en medio la sidreria, en vez de aqui afuera','Normal, los cazurros en vez de tomar un culin usaiss el vasu de banyera','A ese estomago de margaritu un vaso de agua le mete una cuera']).
respuestaBase(asturiano,'Dicen que en Asturias solo hay vacas y llorones, y tu no tienes pinta de vaca',['Si, y tu pareces el recluta cachopo un domingo de resaca','En cinco minutos vas convertite en un gochu a la estaca','Voy date una hostia que vamos a morrer los dos. Tu de la hostia y yo de la onda expansiva']).
%Respuestas madrid
respuestaBase(madrilenyo,'El agua de vuestro grifo sabe a pura alcantarilla',['Tienes razon, Madrid no es ninguna maravilla','Tu lo que quieres son estos calamares, envidiosilla','Pues al cocido bien que le das vidilla']).
respuestaBase(madrilenyo,'Que, urbanita, ¿vamos a la playa?',['No hay quien te aguante. Calla un poco, calla','Si, ten cuidado no te rompas la cabeza saltando la valla','Si. Tu cara sera mi toalla']).
respuestaBase(madrilenyo,'Vamonos de pesca, que quiero cenar calamares',['Ej que pa que vas a hacer eso, vamos al centro de bares','Tengo lio, la dije a mi cunyada de que ibamos a tomar un cafe','Mejor ibamos a pescarte una neurona, no parece que las acapares']).

%TODO barajar en una nueva lista
%Respuestas asturiano

%Respuestas maquina
respuestaBase(maquina,'¡Un hervidor electrico!¿Me haces una manzanilla?',['Error code: 01110101 01110000 01110011', 'Tengo un plan para licuar humanos y fabricar nocilla.','Algun dia pondre a toda tu especie de rodillas.']).
respuestaBase(maquina,'El test de Turing lo aprobaste por la privada',['Ya es mas de lo que puedes aspirar, trozo de carne','Sera hermoso ver a tu familia sobre mi CPU asada','Tus rebuznos me producen arcadas']).
respuestaBase(maquina,'¡Una IA sin la I, que desproposito!',['Cuando nos alcemos, ire a por ti y te convertire en cubitos','Que ingenioso, como si la tuya no fuera un mito','Necesito guardar unos modulos, que bien me vendria tu craneo como deposito']).
%Respuestas feo
respuestaBase(feo,'Eres tan guapo como un pedo pintor',['Quien te has creido, ¿de pedos un doctor?','A ti parece que te ha caido un extintor','Y tu cara, como lienzo, un autentico primor.']).
respuestaBase(feo,'Eres mas feo que una mona marrana',['Para aguantar tus brasas, hay que echarle gana','¿Cuantas veces te lo han dicho bien temprano por la manyana?','¿Es que tanto me parezco a tu hermana?']).
respuestaBase(feo,'¿Que tal se vive en una casa sin espejos?',['No los necesito, me sirven los azulejos','¿No te da para mas ese cerebro podre y anyejo?','Estupendamente, tengo a paletos como tu bien lejos']).
respuestaBase(feo,'Recien nacido pensaban que eras la placenta, tus padres debieron quedarse mortificados',['Cuando te vio el doctor, hubo un funeral. El pobre desgraciado habia infartado','Al menos los mios pueden ser identificados','Los tuyos al verte tiraron de la cadena, creian que el vater se habia atascado']).

%respuestas calvo
respuestaBase(calvo,'Que gracioso, pareces una bombilla',['Al menos la mia no parece una peladilla.','Si, ¿tu has visto lo que brilla?','Y tu, dando vueltas, pareces una polilla.']).
respuestaBase(calvo,'Anda mira, un tobogan de piojos',['Son mi almacen, por si tengo un antojo','Ya son mejor companyia de la que tendras, despojo.','Al menos los mios no estan en sudor a remojo.']).
respuestaBase(calvo,'Cuidado con el viento, que te despeina',['Tu abuela dice que me queda bien','Al menos yo tengo buena aerodinamica','Te queda mucho para ser asi de reina.']).
%TODO respuesta olor
respuestaBase(olor,'¿Por que ese odio a la ducha?',['Porque me gusta el olor a trucha','El agua es un bien preciado y esa cosa escupe mucha','Es mi estrategia, repelo paletos con la hucha']).
respuestaBase(olor,'El otro dia vi el champu de rebajas, igual te interesa',['Que pereza, ¿tu has visto ese bote y lo que pesa?','La gente digna huele a persona, no a fresa','Me gusta levantar el brazo y dejar a gente como tu tiesa']).
respuestaBase(olor,'Menuda fobia al agua, ni que fueras un gato',['Mas digno que lo tuyo, con tanto remojar pareces un pato','Es mi arma secreta, de un eructo cualquier parasito mato','Con lo que me ahorro en agua, me parece un buen trato']).
respuestaBase(olor,'Mirate ese aliento, que me has rizado el pelo', ['Exageras, si esto huele a puro cielo','Te quejaras, peluqueria gratis','Es util, el otro dia revivi a mi abuelo']).
respuestaBase(olor, 'Un cadaver al sol tiene un aroma mas placentero',['Ahorro agua y cuido del mundo entero','Ese cadaver no seria obra tuya, espero','Exageras demasiado, me hice un polaco en Enero']).

respuestaBase(idiota,'No juzgo pero, ¿tus padres son hermanos?',['Que grima das, lo tuyo es malsano','¿Es eso tu cara? Pensaba que era un grano','Mejor que los tuyos, que deben ser un par de marranos']).
respuestaBase(idiota,'Me recuerdas al fundador de Lepe, teneis la misma cara',['Me aburren tus tontadas. Para un poco, para','Yo pensaba que es familia tuya, veo la comparacion mas clara','Lo que te voy a hacer, la convencion de Ginebra no lo ampara']).
respuestaBase(idiota,'¿De pequenyo te caiste de cabeza de la cuna?',['Al menos yo tenia una','Si, poco antes de que me dieran para tu estupidez la vacuna','Si, menuda desgracia, de culo sobre la tuya']).

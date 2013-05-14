buenaccion(luis,['arregla la cama','ayuda']).
wishlist(luis,['carro','biciclta']).
malaccion(luis,['miente']).
presupuesanta(luis,450).
nino(luis,12,'Alemania').
juguete(carro,acme,100,3).
juguete(bicicleta,acme,300,5).






/* 
	Sieve of Erastosthenes

	primes(Limit, Ps) instantiates a list Ps
		for all primes between 1 and Limit

	from Clocksin and Mellish, "Programming in Prolog"
	
*/

primes(Limit, Ps) :-
	integers( 2, Limit, Is),
	sift( Is, Ps ).

integers(Low, High, [Low|Rest]) :-
	Low =< High,
	!,
	M is Low+1,
	integers(M, High, Rest).
integers(_,_,[]).

sift([], []).
sift([I|Is], [I|Ps]) :-
	remove(I,Is,New),
	sift( New, Ps ).

remove(_, [], []).
remove(P, [I|Is], [I|Nis]) :-
   not(0 is I mod P),
   !,
   remove(P, Is, Nis).
remove(P, [I|Is], Nis) :-
	0 is I mod P,
	remove(P, Is, Nis).
	
/*Info niño*/
infonino(Nombre):-nino(Nombre,E,P),write(Nombre),nl,write(E),nl,write(P),nl.

buenaccion(Nombre):-buenaccion(Nombre,[X,Y]).   

malaccion(Nombre):- malaccion(Nombre,[L,Z]).

wishlist(Nombre):-wishlist(Nombre,[Q,W]).

presupuesanta(Nombre):-presupuesanta(Nombre,Pres).

nino(Nombre,Edad,Pais):-buenaccion(Nombre,[X,Y]), malaccion(Nombre,[L,Z]), wishlist(Nombre,[Q,W]),presupuesanta(Nombre,Pres).

/*Informacion Juguete*/

juguete(Nombre,Marca,Precio,Edad).
juguete(Nombre):-marca(Nombre, X),precio(Nombre,Y),edad(Nombre,E),write(Nombre),nl,write(X),nl,write(Y),nl,write(E),nl.

/*Buenos Malos*/

buenomalo(Nombre,[Q|W],[A|S]):-length([Q|W],B),length([A|S],M),buenomalo(Nombre,B,M).

buenomalo(Nombre,B,M):-B=>M,write(Nombre),write('Bueno'),nl.
buenomalo(Nombre,B,M):-B<M,write(Nombre),write('Malo'),nl.
buenomalo(Nombre):-buenaccion(Nombre,[X,Y]), malaccion(Nombre,[L,Z]), buenomalo(Nombre,[X|Y],[L|Z]).

/*Consulta buena accion*/

buenaccion(Accion,Nombre):-buenaccion(Nombre,[X|Y]),member(Accion,[X|Y]),write(Nombre).

/*Lista de niños que tienen una acción mala en particular*/

malaccion(Accion,Nombre):-malaccion(Nombre,[X|Y]),member(Accion,[X|Y]),write(Nombre).

/* Lista de regalos más solicitados por los niños, ordenados por popularidad*/

regalo_solicitado([],Lista,List_N):-ordenar_bur(Lista,P),info_pop(P).

regalo_solicitado([L|N], Lista,List_N):-calcular_pop(L,Pop,List_N), insertar(Pop,Lista,Lista1),insertar(L,Lista1,Lista2),regalo_solicitado(N,Lista2).

calcular_pop(L,Pop,[P|N]):-wishlist(P,[Q|W]),member(L,[Q|W]),New is Pop+1, calcular_pop(L,New,N).

calcular_pop(L,Pop,[P|N]):-calcular_pop(L,Pop,N).

calcular_pop(L,Pop,[]).

info_pop([]).

info_pop([X,Y|L]):-write('Nombre'),write(X),write('Puntuacion'),write(Y),nl.


/* Consulta niño-regalos*/

nino-regalos(Nombre):-es_malo(Nombre),write(Nombre),write('Regalo: Medias de golfista'),nl.
es_malo(Nombre):-buenaccion(Nombre,[X,Y]), malaccion(Nombre,[L,Z]),length([X|Y],B),length([L|Z],M), B<M.

nino-regalos(Nombre):-wishlist(Nombre,[Q,W]),write(Nombre),inforegalo([Q|W]).

inforegalo([]):-!.

inforegalo([Q,W]):-juguete(Q),inforegalo(W).


/* Consulta niño-regalos posibles*/ 

nino-regalos-posibles(Nombre):-es_malo(Nombre),write(Nombre),write('Regalo: Medias de golfista'),nl.
nino-regalos-posibles(Nombre):-nino-regalos-posibles(Nombre,Pt).
nino-regalos-posibles(Nombre,Pt):-nino(Nombre,E,P),wishlist(Nombre,[Q,W]),presupuesanta(Nombre,Pres),filtrar-regalo(E,[Q,W],Pres,[P,O], Pt),inforegalo([P,O]),buenomalo(Nombre).

filtrar-regalo(E,[],Pres,[N|M], Pt):-!.

filtrar-regalo(E,[Q|W],Pres,[P|O], Pt)-edad(Q,Ej), precio(Q,Yj), E => Ej, Pres => Yj,
 New is Pt+Ej, Pres => New, insertar(Q,[P|O],[A|S]),filtrar-regalo(E,W,Pres,[A|S], New).
filtrar-regalo(E,[Q|W],Pres,[P|O], Pt):-filtrar-regalo(E,W,Pres,[P|O], Pt).

/*Presupuesto Total*/

pres-total:-pres-total(Total).

pres-total(Total):-proceso(Total),write(Total),nl.

proceso(Result):-bueno([L|K]),proceso([L|K],Total).

proceso([],Total).
proceso([L|K],Total):- nino-regalos-posibles(L,P),nl, New is Total+P,proceso(K,New).            


/*Metodos Generales*/

member(X,[X|Cola]).

member(X,[Cabeza|Cola]):-member(X,Cola).

insertar(X, Lista, Resultado) :- Resultado = [X|Lista].


/*Ordenación por medio de burbuja*/

 orden_bur(L,L) :- ordenada(L).  

orden_bur(L,Lord) :-  

        burbuja(L,L1),orden_bur(L1,Lord).

/*La burbuja se define asi:*/

burbuja([],[X]).  

burbuja([X],[X]).  

 burbuja([X,Y|L],Lburb) :-  

              menorig(X,Y),  

              burbuja([Y|L],L1),  

              Lburb = [X|L1].
burbuja([X,Y|L],Lburb) :-  

             menor(Y,X),  

             burbuja([X|L],L1),  
   Lburb = [Y|L1].

/*menor*/

menor ([], []).

menor ([A], A).

menor ([A|List], Max):- menor (List, Max1), (A <= Max1, Max = A; A > Max1, Max=Max1).  



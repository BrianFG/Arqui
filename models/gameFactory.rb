# Final Project: A Text Adventure Game
# Date: 05-May-2016
# Authors: Alejandro Rojas Cepeda
#          Brian Flores Gonzalez
#          Eduardo Azuri Gaytan Martinez
#          Eduardo Rodriguez Ruiz
#          


require ('./models/clases')


#Method to build a GameController instance using the parameters state, substate, life, money, fights and respect
def create_game2(state, substate, money, life, fights, respect)

  game = GameController.new(money,life,fights,respect)


########################################################################################################################################
##Room 7

  move  = Move.new(0, "Para entrar dirigete al norte" , 
    Proc.new{|room, game| game.go_state(40) ; "Estas entrando"} , nil,nil, nil)
  room1 = Room.new(7,"Despiertas en un lugar lugubre, lo unico que alcanzas a ver es un letrero que dice Bienvenido a Ecatepec")
  room1.state = move
  room1.add_state(move)
  game.set_state(7, room1)

########################################################################################################################################
##Room 40
  room40 = Room.new(40,"Comienzas a caminar, huele a drogas en el aire")
  move  = Move.new(0, "Te espantas así que tienes dos opciones: ir al sur para huir, o entrar a una tienda que encuentras abierta al este" , 
    nil ,  Proc.new{|room, game| game.go_state(7) ; "Has Huido"} , Proc.new{|room, game| game.go_state(29) ; game.respect+=5; "Entraste a la tienda, tu respeto aumentó"} , nil)
  room40.state = move
  room40.add_state(move)
  game.set_state(40, room40)



########################################################################################################################################
##Room 29
  room29 = Room.new(29,"La tienda tiene rastros de que hubo una pelea aqui")
  coin1 = CoinFlipper.new(0,"Tira una moneda para probar tu suerte", 
    Proc.new{|room, game| room.go_sub(1); "Encontraste una cartera"} , 
    Proc.new{|room, game| room.go_sub(2); "Alguien te ha retado"})
  coin2 = CoinFlipper.new(1,"Tira una moneda para probar tu suerte", 
    Proc.new{|room, game| game.money += 200; room.go_sub(4); "Encontraste 200 varos"} , 
    Proc.new{|room, game| room.go_sub(2); "Alguien viene"})  
  fight1 = Fight.new(2, "La Britney te ha retado a unos navajasos, puedes huir si le das 50 varos o puedes pelear con ella" , 
    Proc.new{|room, game| room.go_sub(3); "Estas entrando a la pelea..."} , 
    Proc.new{|room, game| 
      if game.money >= 50 
        game.money -=50
        game.respect -=5
        room.go_sub(4)
        "Has huido, tu respeto baja"
      else 
        "No puedes huir"
      end
      })
  coin3 = CoinFlipper.new(3,"Tira una moneda para probar tu suerte en la pelea", 
    Proc.new{|room, game| room.go_sub(4); game.respect +=15 ; game.fights += 1; "Has derrotado a la Britney, tu respeto aumenta"} , 
    Proc.new{|room, game| room.go_sub(4); game.life-=15; "La britney te ha derrotado y tu vida baja 15 puntos"})
  move  = Move.new(4, "Para salir de la tienda ve al norte , para ir a otro lado y probar tu suerte ve al este." , 
    Proc.new{|room, game| game.go_state(40) ; "Sales de la tienda"} , nil, Proc.new{|room, game| game.go_state(6) ; "Entras al este"}, nil)

  room29.state= coin1
  room29.add_state(coin1).add_state(coin2).add_state(fight1).add_state(coin3).add_state(move)
  game.set_state(29, room29)

########################################################################################################################################
##Room 6

  room6 = Room.new(6,"Sales a una avenida principal con forma de L, ves a drogadictos tirados en el piso pidiendo dinero.")
  coin1 = CoinFlipper.new(0,"Hay un sonido repentino, giras. Tira una moneda", 
    Proc.new{|room, game| game.go_state(43); "Te diriges al oeste"} , 
    Proc.new{|room, game| room.go_sub(1); "Solo hay una ventana"})
  move  = Move.new(1, "Si quieres asomarte ve al este si quieres seguir por la calle ve al norte " , 
    Proc.new{|room, game| game.go_state(29) ; "Sigues por la calle"} , nil, Proc.new{|room, game| game.go_state(28) ; "Decides asomarte"}, nil)
  room6.state = coin1
  room6.add_state(coin1).add_state(move)
  game.set_state(6, room6)

########################################################################################################################################
##Room 28


  room28 = Room.new(28,"Alcanzas a ver un Mercado artesanal a la distancia, intentas ver que hay y encuentras la puerta a un edificio que parece tener un teléfono")
  move  = Move.new(0, "Ve hacia el este" , 
    nil, nil, Proc.new{|room, game| game.go_state(6) ; "Te diriges al este"}, nil)
  room28.state = move
  room28.add_state(move)
  game.set_state(28, room28)


########################################################################################################################################
##Room 43
  room43 = Room.new(43, "El barrio esta cada vez más lugubre")
  coin1 = CoinFlipper.new(0,"El lider de los metalicos llamado “El brayan” te reta a unos navajazos a muerte, tira una moneda", 
    Proc.new{|room, game| room.go_sub(1); "El Brayan ha intentado picarte pero lo esquivaste"} , 
    Proc.new{|room, game| game.go_state(36); game.respect= 0; game.life -= 30; "El Brayan te ha soltado un navajazo mortal y se ha ido. Has perdido todo tu respeto y tu vida baja 30 puntos"})
  coin2 = CoinFlipper.new(1,"La pelea sigue, tira otra moneda para probar tu suerte", 
    Proc.new{|room, game| room.go_sub(2); game.respect+=100; game.fights+=1; "Esquivaste otro najajazo y lograste vencerlo, tu respeto aumenta considerablemente"} , 
    Proc.new{|room, game| game.go_state(36); game.respect= 0; game.money = 0; game.life -= 30; "El Brayan te derrotó con una patada mortal. Has perdido todo tu respeto y dinero, tu vida baja 30 puntos"})
  coin3 = CoinFlipper.new(2,"El brayan soltó una mona de guayaba, la tomas, tira una moneda", 
    Proc.new{|room, game| game.go_state(36); game.life = 100; "La mona tiene grandes poderes curativos, tu vida está al máximo"} , 
    Proc.new{|room, game| game.go_state(36); game.life -= 5; "La mona tiene malos efectos, tu vida baja"})
  room43.state = coin1
  room43.add_state(coin1).add_state(coin2).add_state(coin3)
  game.set_state(43, room43)


########################################################################################################################################
##Room 36
  room36 = Room.new(36, "Sigues caminando por la calle, ves una Fuente en donde varias personas se estan bañando")
  coin1 = CoinFlipper.new(0,"Tira una moneda", 
    Proc.new{|room, game| game.go_state(41); "Ahora te diriges al norte"} , 
    Proc.new{|room, game| game.go_state(15);  "Ahora te dirijes al sur"})
  room36.state = coin1
  room36.add_state(coin1)
  game.set_state(36, room36);
  


########################################################################################################################################
##Room 41
  room41 = Room.new(41, "Dejas la fuente atras y descubres una calle llena de cholos")
  coin1 = CoinFlipper.new(0,"Tira una moneda para decidir a que cholo dirigirte", 
    Proc.new{|room, game| room.go_sub(1); game.respect+=20; "Le has caido bien al cholo, se ponen a bailar cholocumbia y tu respeto aumenta"} , 
    Proc.new{|room, game| room.go_sub(1); game.life-=15; "El cholo te ha mordido y tu vida baja 15 puntos"})
  move  = Move.new(1, "Dirigete al sur" , 
    nil , Proc.new{|room, game| game.go_state(35) ; "Caminas hacia el sur"} ,nil, nil)
  #35
  room41.state = coin1
  room41.add_state(coin1).add_state(move)
  game.set_state(41, room41)

########################################################################################################################################
##Room 15

  room15 = Room.new(15, "En la misma calle descubres una gasolinera")
  move  = Move.new(0, "Si quieres explorar la gasolinera ve hacia el norte. Si quieres huir ve hacia el sur" , 
    Proc.new{|room, game| game.go_state(12) ; "Caminas hacia el norte para explorar"} , Proc.new{|room, game| game.go_state(24) ; "Caminas hacia el sur"} ,nil, nil)
  room15.state = move
  room15.add_state(move)
  game.set_state(15, room15)

########################################################################################################################################
##Room 12

  room12 = Room.new(12, "Entras al edificio de la gasolinera lentamente, huele a mona de guayaba")
  coin1 = CoinFlipper.new(0,"Has encontrado una mochila, puede contener buenas cosas. Prueba tu suerte tirando una moneda", 
    Proc.new{|room, game| game.go_state(42); game.respect+=3; "Has encontrado una navaja legendaria, tu respeto incrementará"} , 
    Proc.new{|room, game| game.go_state(42); game.life-=3; "La mochila contenía jeringas usadas, te picas con una de ellas y tu vida baja. Escapas de ese lugar por el sur"})

  room12.state = coin1
  room12.add_state(coin1)
  game.set_state(12, room12)

########################################################################################################################################
##Room 24 
  room24 = Room.new(24, "Este lugar es totalmente diferente a todos los demás, un hermoso y limpio jardín en donde descansar")
  move  = Move.new(0, "Por lugar para descansar, tu vida subiera a 90 puntos cuando decidas salirte. camina hacia el Sur" , 
     nil , Proc.new{|room, game| game.go_state(42); game.life=90; "Caminas hacia el sur"} ,nil, nil)

  room24.state= move
  room24.add_state(move)
  game.set_state(24, room24)

########################################################################################################################################
##Room 35

  room35 = Room.new(35, "Llegas al cuarto principal de la bodega, ahi se encuentra el jardin “magico” lleno de droga")
  coin1 = CoinFlipper.new(0,"Hay un obstaculo en el camino, tira una moneda para probar tu suerte", 
    Proc.new{|room, game| game.go_state(8); "Te haz tropezado y causado un alboroto en la otra sala"} , 
    Proc.new{|room, game| game.go_state(9); "Has pasado el obstaculo y ahora sales de la sala"})
  room35.state = coin1
  room35.add_state(coin1)
  game.set_state(35, room35)

########################################################################################################################################
##Room 42

room42 = Room.new(42, "Has llegado al zócalo de Ecatepec, el lugar esta muy concurrido y hay diferentes calles y una casa que llama mucho la atención ")
 move = Move.new(0, "Para observar lo que hay dentro de la casa, camina hacia el Sur. 
  Si quieres dirigirte al estacionamiento ve hacia el Este. 
  Camina hacia el Norte si deseas ir a la calle de enfrente, o al Oeste para la calle de a lado ",
  Proc.new{|room, game| game.go_state(9);  "Vas en camino hacia la calle que sigue"},
  Proc.new{|room, game| game.go_state(26);  "Caminas hacia la casa extraña"},
  Proc.new{|room, game| game.go_state(13);  "Te acercas al estacionamiento"},
  Proc.new{|room, game| game.go_state(38); "Vas camino a la calle de a lado"} )
 room42.state = move
 room42.add_state(move)
 game.set_state(42, room42)

########################################################################################################################################
##Room 8
room8 = Room.new(8, "Estas en la sala especialde la bodega, aqui todos parecen sospechosos")
coin1 = CoinFlipper.new(0, "Un chaca llamado “El aletz” te ataca con un picahielo. Tira una moneda para ver que pasa",
  Proc.new{|room, game| game.go_state(43); game.life-=15; "El aletz te ha clavado, tu vida baja y escapas del lugar"},
  Proc.new{|room, game| game.go_state(43); game.respect+=20; "Has derrotado al aletz, y sales inmediatamente de la sala"})
room8.state = coin1
room8.add_state(coin1);
game.set_state(8, room8)

########################################################################################################################################
##Room 9

room9 = Room.new(9, "Sigues en la gran bodega y encuentras varias cajas")
move = Move.new(0, "Tienes la opción de seguir en la pbodega por el Este, o salir por el Sur",
  nil ,
  Proc.new{|room, game| game.go_state(41); "Estas saliendo del lugar"},
  Proc.new{|room, game| game.go_state(8); "Te adentras más a la bodega"}, nil)
room9.state = move
room9.add_state(move)
game.set_state(9, room9)


########################################################################################################################################
##Room 13

  room13 = Room.new(13, "Te encuentras en un estacionamiento bastante oscuro y con poco carros, el olor a gasolina emana de todos lados")
  coin1 = CoinFlipper.new(0, "Un viene viene con un flow violento te ataca. Tira una moneda para ver si puedes vencerlo",
    Proc.new{|room, game| game.go_state(42); game.respect+=10; "Le has vencido y tu respeto aumenta"},
    Proc.new{|room, game| game.go_state(42); game.life-=10; "El viene  viene te ha derrotado, tu vida baja 10 puntos "})
  room13.state = coin1
  room13.add_state(coin1)
  game.set_state(13, room13)


########################################################################################################################################
##Room 26

  room26 = Room.new(26, "La casa es bastante extraña y hay unos sujetos con cara de pocos amigos")
  fight1 = Fight.new(0, "Para pasar de ahi tienes dos opciones, huir y dales 100 varos a los sujetos o pelear con ellos",
    Proc.new{|room, game| game.go_state(42); game.life -=20 ; game.respect+=50; "Los sujetos te atacan con todas sus armas y pierdes mucha vida"},
    Proc.new{|room, game| game.go_state(42); game.money-=100 ; "Le pagas su moche a todos y te vas"})
  room26.state =  fight1
  room26.add_state(fight1)
  game.set_state(26, room26)

########################################################################################################################################
##Room 38
  
  room38 = Room.new(38, "Esta parece ser una avenida principal, hay mucho trasporte publico por aquí")
  coin1 = CoinFlipper.new(0, "A lo lejos encuentras el TrasnporTEC, tira una moneda para ver si lo alcanzas",
    Proc.new{|room, game| game.go_state(14);  "Lo has alcanzado, estas salvado"},
    Proc.new{|room, game| game.go_state(6);  "Lastima, te ha dejado el camión y ahora estas perdido"})
  room38.state = coin1
  room38.add_state(coin1)
  game.set_state(38, room38)

########################################################################################################################################
##Room 14

  room14 = Room.new(14, "Lo has logado, sobreviviste a Ecatepec. Ahora estas comodamente en el camión camino a tu nueva aventura en los examenes finales, Buena suerte")
  move = Move.new(0, "Disfruta tu camino al Tec" ,
     Proc.new{"Relajate, para qué te mueves? Todo esta bien"},
     Proc.new{"Relajate, para qué te mueves? Todo esta bien"},
     Proc.new{"Relajate, para qué te mueves? Todo esta bien"},
     Proc.new{"Relajate, para qué te mueves? Todo esta bien"})
  room14.state = move
  room14.add_state(move)
  game.set_state(14, room14)





  game.go_state(state)
  game.state.go_sub(substate)
  game

end
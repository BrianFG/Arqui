require ('./models/clases')

def create_game (state, substate, money, life, fights, respect)
  coin1 = CoinFlipper.new(0,"Encontraste una cartera, tira una moneda para probar tu suerte", 
    Proc.new{|room, game| game.money += 10; room.go_sub(1); "Encontraste 10 varos"} , 
    Proc.new{|room, game| room.go_sub(1); "No encontraste nada"}) 
  coin2 = CoinFlipper.new(1,"Descubres una mochila, prueba tu suerte", 
    Proc.new{|room, game| game.respect += 10; room.go_sub(2); "Encontraste una najava"} , 
    Proc.new{|room, game| room.go_sub(2); "La mochila está vacia"})
  fight1 = Fight.new(2, "Pelea con el cholo" , 
    Proc.new{|room, game| game.life -= 10; room.go_sub(3); "pelea"} , 
    Proc.new{|room, game| room.go_sub(3); "huir"})
  move1  = Move.new(3, "Muevete" , 
    Proc.new{|room, game| room.go_sub(1); "norte"} , 
    nil,
    Proc.new{|room, game| room.go_sub(3); "este"},
    Proc.new{|room, game| room.go_sub(2); "oeste"} )


  room1 = Room.new(0,"Despertasun letrero que dice Bienvenido a Ecatepec")
  room1.state = coin1
  room1.add_state(coin1).add_state(coin2).add_state(fight1).add_state(move1)
  game = GameController.new(money,life,fights,respect)
  game.state=room1
  game.state.go_sub(substate)
  game
end


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
    Proc.new{|room, game| game.go_state(36); "Ahora te diriges al norte"} , 
    Proc.new{|room, game| game.go_state(36);  "Ahora te dirijes al sur"})
  room36.state = coin1
  room36.add_state(coin1)
  game.set_state(36, room36);
  

  game.go_state(state)
  game.state.go_sub(substate)
  game

end
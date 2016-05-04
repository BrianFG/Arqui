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

  move  = Move.new(0, "Para entrar dirigete al norte" , 
    Proc.new{|room, game| game.go_state(40) ; "Estas entrando"} , nil,nil, nil)


  room1 = Room.new(7,"Despiertas en un lugar lugubre, lo unico que alcanzas a ver es un letrero que dice Bienvenido a Ecatepec")
  room1.state = move
  room1.add_state(move)
  game.set_state(7, room1)



  room40 = Room.new(40,"Comienzas a caminar, huele a drogas en el aire")
  move  = Move.new(0, "Te espantas así que tienes dos opciones: ir al sur para huir, o entrar a una tienda que encuentras abierta al este" , 
    nil ,  Proc.new{|room, game| game.go_state(7) ; "Has Huido"} , Proc.new{|room, game| game.go_state(29) ; game.respect+=5; "Entraste a la tienda, tu respeto aumentó"} , nil)
  room40.state = move
  room40.add_state(move)
  game.set_state(40, room40)


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
    Proc.new{|room, game| game.go_state(40) ; "Estas entrando"} , nil,nil, nil)

  room29.state= coin1
  room29.add_state(coin1).add_state(coin2).add_state(fight1).add_state(coin3).add_state(move)
  game.set_state(29, room29)



  game.go_state(state)
  game.state.go_sub(substate)
  game

end
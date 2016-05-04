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
    Proc.new{|room, game| room.go_sub(2); "sur"},
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



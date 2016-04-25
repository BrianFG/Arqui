class GameController
  attr_accessor :state, :life, :money, :fights, :respect
	def initialize (money, life, fights, respect)
    @life = life
    @money = money
    @respect = respect
    @fights = fights
    @states = []
    @states << state
    @state = state
	end

  def stats
    {:money => @money , :life => @life, :fights => @fights, :respect => @respect, :state => @state.id, :substate => @state.state.id}
  end

  def index
    [] << @state.id << @state.state.id 
  end

  def instructions
    @state.instructions
  end

  def description
    @state.description
  end

  def flip_coin
    @state.flip_coin(self)
  end

  def fight
    @state.fight(self)
  end

  def run
    @state.run(self)
  end

  def north
    @state.north(self)
  end

  def east
    @state.east(self)
  end

  def west
    @state.west(self)
  end

  def south
    @state.south(self)
  end
end


class Room
  attr_accessor :states , :state, :description, :id
	def initialize (id, description)
		@states = []
    @state 
		@id = id
		@description = description
	end


  def add_state(s)
    @states << s
    self
  end

  def instructions
    @state.instructions
  end

  def flip_coin (game)
    @state.flip_coin(self , game)
  end

  def fight (game)
    @state.fight(self, game)
  end

  def run (game)
    @state.run(self, game)
  end

  def north (game)
    @state.north(self, game)
  end

  def east (game)
    @state.east(self, game)
  end

  def west (game)
    @state.west(self, game)
  end

  def south (game)
    @state.south(self, game)
  end

  def go_sub(num)
    @state = @states[num]
  end

end


class SubState 
  attr_accessor :instructions, :id
  def initialize (instructions, id)
    @id = id
    @instructions = instructions
  end

  def method_missing (m, *args, &block)
    "Instruccion #{m} no valida"
  end
end

class CoinFlipper < SubState

  def initialize (id, instructions , head, tail) 
    super(instructions, id)
    @head = head
    @tail = tail
  end

  def flip_coin (room , game)
    if (rand(0...2) == 1)
      @head.call(room, game)
    else
      @tail.call(room, game)
    end
  end
end

class Move  < SubState

  def initialize (id, instructions, up, down, right, left)
    super(instructions, id)
    @up = up
    @down = down
    @right = right
    @left = left
  end

  def north 
    @up.call(room, game)
  end

  def south
    @down.call(room, game)
  end

  def east
    @right.call(room, game)
  end

  def west
    @left.call(room, game)
  end
end


class  Fight < SubState

  def initialize (id, instructions, fight_b, run_b)
    super(instructions, id)
    @run_b = run_b
    @fight_b = fight_b
  end

  def run(room, game)
    @runb.call(room,game)
  end

  def fight(room, game)
    @fight_b.call(room, game)
  end
end


def create_game (state, substate, money, life, fights, respect)
  coin1 = CoinFlipper.new(0,"Encontraste una cartera, tira una moneda para probar tu suerte", 
    Proc.new{|room, game| game.money += 10; room.go_sub(1); "Encontraste 10 varos"} , 
    Proc.new{|room, game| room.go_sub(1); "No encontraste nada"}) 
  coin2 = CoinFlipper.new(1,"Descubres una mochila, prueba tu suerte", 
    Proc.new{|room, game| game.respect += 10; room.go_sub(2); "Encontraste una najava"} , 
    Proc.new{|room, game| room.go_sub(2); "La mochila está vacia"})
  fight1 = Fight.new(2, "Pelea con el cholo" , 
    Proc.new{|room, game| room.go_sub(3); "pelea"} , 
    Proc.new{|room, game| room.go_sub(3); "huir"})
  move1  = Move.new(3, "Muevete" , 
    Proc.new{|room, game| room.go_sub(4); "norte"} , 
    Proc.new{|room, game| room.go_sub(4); "sur"},
    Proc.new{|room, game| room.go_sub(4); "este"},
    Proc.new{|room, game| room.go_sub(4); "oeste"} )


  room1 = Room.new(0,"Cuarto 1")
  room1.state = coin1
  room1.add_state(coin1).add_state(coin2).add_state(fight1).add_state(move1)
  game = GameController.new(money,life,fights,respect)
  game.state=room1
  game.state.go_sub(substate)
  game
end





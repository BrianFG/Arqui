class GameController
  attr_accessor :state, :life, :money, :fights, :respect
	def initialize (money, life, fights, respect)
    @life = life
    @money = money
    @respect = respect
    @fights = fights
    @states = []
	end

  def set_state(index, state)

    @states[index] = state
  end

  def go_state (index)
    @state = @states[index]
  end

  def stats
    {:money => @money , :life => @life, :fights => @fights, :respect => @respect, :state => @state.id, :substate => @state.state.id}
  end

  def lost?
    @life <=0
  end

  def won?
    false
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

  def north (room , game)
    if @up.nil?
      "No puedes ir al Norte"
    else
      @up.call(room, game)
    end
  end

  def south (room , game)
    if @down.nil?
      "No puedes ir al Sur"
    else
      @down.call(room, game)
    end
  end

  def east (room , game)
    if @right.nil?
      "No puedes ir al Este"
    else
      @right.call(room, game)
    end
  end

  def west (room , game)
    if @left.nil?
      "No puedes ir al Oeste"
    else
      @left.call(room, game)
    end
  end
end


class  Fight < SubState

  def initialize (id, instructions, fight_b, run_b)
    super(instructions, id)
    @run_b = run_b
    @fight_b = fight_b
  end

  def run(room, game)
    @run_b.call(room,game)
  end

  def fight(room, game)
    @fight_b.call(room, game)
  end
end







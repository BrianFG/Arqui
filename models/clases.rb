# Final Project: A Text Adventure Game
# Date: 05-May-2016
# Authors: Alejandro Rojas Cepeda
#          Brian Flores Gonzalez
#          Eduardo Azuri Gaytan Martinez
#          Eduardo Rodriguez Ruiz
#          



#Creates a new game object containing the following attributes: 
#state, life, money, fights and respect.
class GameController
  # The current state in which the game is in (game position with instructions and events contained).
  attr_accessor :state
  # The current health that the player sees displayed on screen, once it reaches 0
  # it is said that the player has lost.
  attr_accessor :life
  # The current wealth that the player has obtained through different events in the game
  attr_accessor :money
  # The current number of fight that the player has won.
  attr_accessor :fights
  # Current respect that the player has accumulated by winning fight evets.
  attr_accessor :respect
  #Init method for all the attributes within the game for the player (money, life, fights, respect).
	def initialize (money, life, fights, respect)
    #The health bar of the player, when the health gets down to 0 the player loses.
    @life = life
    #The wealth that the player has amassed throughout the game.
    @money = money
    #Respect that the player has earned winning fights in the game
    @respect = respect
    #Number of fight events that the player has won.
    @fights = fights
    #List of states for the game.
    @states = []
	end

  #Method that adds the index of the current state to the list of states in order to go to that state.
  def set_state(index, state)
    @states[index] = state
  end

  #Method that directs you to the proper state according to the index given.
  def go_state (index)
    @state = @states[index]
  end

  #This are the stats that the player has throughout the game, also being initialized to the default values.
  def stats
    {:money => @money , :life => @life, :fights => @fights, :respect => @respect, :state => @state.id, :substate => @state.state.id}
  end

  #Method that determines if a player has lost according to their health, in case that it is 0 or lower the player has lost.
  def lost?
    @life <=0
  end

  #Method that determines if a player has won in case they have arrived to the correct state (state 14)
  def won?
    @state.id == 14
  end

  #Determines the current state according to the index.
  def index
    [] << @state.id << @state.state.id 
  end

  #The instructions that the player has to folllow in order to continue moving forward with the game
  def instructions
    @state.instructions
  end

  #The text description that every room has and is displayed to the user.
  def description
    @state.description
  end

  #The action of tossing a coin inside the game in case the action is needed. It has two possible
  #outcomes: Head or Tails.
  def flip_coin
    @state.flip_coin(self)
  end

  #The action of fighting against enemies in case the action is triggered. Depending on the state it can 
  #affect the stats of the player (health, wealth or respect).
  def fight
    @state.fight(self)
  end

  #While in the state of fighting, the player can run from it escaping said state.
  def run
    @state.run(self)
  end

  #In case the action is needed, the player will choose to move north and active the corresponding action.
  def north
    @state.north(self)
  end

  #In case the action is needed, the player will choose to move east and active the corresponding action.
  def east
    @state.east(self)
  end

  #In case the action is needed, the player will choose to move west and active the corresponding action.
  def west
    @state.west(self)
  end

  #In case the action is needed, the player will choose to move south and active the corresponding action.
  def south
    @state.south(self)
  end
end

#Class that represents a room object inside the game and handles the "space", contains the
#following attributes: states, state, description and id.
class Room
  # Array that contains the set of states that the game has.
  attr_accessor :states
  # The current state that the game is in and that will be passed onto states.
  attr_accessor :state
  # The description of the current state (the instructions and events that the state has).
  attr_accessor :description
  # The id that permits identifying the state that the game is currently in.
  attr_accessor :id

  #Init method for all the attributes in this class (id, description).
	def initialize (id, description)
		@states = []
    @state 
		@id = id
		@description = description
	end

  #Adds the current Substate to the current room.
  def add_state(s)
    @states << s
    self
  end

  #The instructions that the player has to folllow in order to continue moving forward with the game
  def instructions
    @state.instructions
  end

  #The action of tossing a coin inside the game in case the action is needed. It has two possible
  #outcomes: Head or Tails.
  def flip_coin (game)
    @state.flip_coin(self , game)
  end

  #The action of fighting against enemies in case the action is triggered. Depending on the state it can 
  #affect the stats of the player (health, wealth or respect).
  def fight (game)
    @state.fight(self, game)
  end

  #While in the state of fighting, the player can run from it escaping said state.
  def run (game)
    @state.run(self, game)
  end

  #In case the action is needed, the player will choose to move north and active the corresponding action.
  def north (game)
    @state.north(self, game)
  end

  #In case the action is needed, the player will choose to move east and active the corresponding action.
  def east (game)
    @state.east(self, game)
  end

  #In case the action is needed, the player will choose to move west and active the corresponding action.
  def west (game)
    @state.west(self, game)
  end

  #In case the action is needed, the player will choose to move south and active the corresponding action.
  def south (game)
    @state.south(self, game)
  end

  #Depending on the possible substates contained in the current state (enabled coin flip, enabled fights, etc.)
  #sends the id number of the required substate.
  def go_sub(num)
    @state = @states[num]
  end

end

#Class that determines the state that is contained within a room, because
#a room has the possibility of many actions within.
class SubState 
  # The instructions of the current state that the player must follow in order to proceed with the game.
  attr_accessor :instructions
  # The id that permits the identification of the current state in the game.
  attr_accessor :id

  #Init method for all the attributes in this class (instructions, id).
  def initialize (instructions, id)
    @id = id
    @instructions = instructions
  end

  #Method that returns a message to the player in case an invalid action was attempted within the state.
  def method_missing (m, *args, &block)
    "Instruccion #{m} no valida"
  end
end

#Class that inherits from Substate, and as such it is a state that contains
#the random result of calling a coin flip inside the game.
class CoinFlipper < SubState
  #Init method for all the attributes in this class (id, instructions , head, tail).
  def initialize (id, instructions , head, tail) 
    super(instructions, id)
    @head = head
    @tail = tail
  end
  #Method that calls a random (between 0 and 1) in order to determine the result of the coin flip
  #1 equals to head and 0 to tails.
  def flip_coin (room , game)
    if (rand(0...2) == 1)
      @head.call(room, game)
    else
      @tail.call(room, game)
    end
  end
end

#Class that inherits from SubState and calls the direction in which the player can move 
#depending on the available options to the current state.
class Move  < SubState
  #Init method for all the attributes in this class(id, instructions, up, down, right, left).
  def initialize (id, instructions, up, down, right, left)
    super(instructions, id)
    @up = up
    @down = down
    @right = right
    @left = left
  end

  #Moves the player in the north direction.
  def north (room , game)
    if @up.nil?
      "No puedes ir al Norte"
    else
      @up.call(room, game)
    end
  end

  #Moves the player in the south direction.
  def south (room , game)
    if @down.nil?
      "No puedes ir al Sur"
    else
      @down.call(room, game)
    end
  end

  #Moves the player in the east direction.
  def east (room , game)
    if @right.nil?
      "No puedes ir al Este"
    else
      @right.call(room, game)
    end
  end

  #Moves the player in the west direction.
  def west (room , game)
    if @left.nil?
      "No puedes ir al Oeste"
    else
      @left.call(room, game)
    end
  end
end

#Class that inherits from SubState, contains the available options when
#the fight state is triggered (run or fight).
class  Fight < SubState
  #Init method for all the attributes (id, instructions, fight_b, run_b).
  def initialize (id, instructions, fight_b, run_b)
    super(instructions, id)
    @run_b = run_b
    @fight_b = fight_b
  end

  #Calls the run action for the current substate.
  def run(room, game)
    @run_b.call(room,game)
  end

  #Calls the fight action for the current substate.
  def fight(room, game)
    @fight_b.call(room, game)
  end
end







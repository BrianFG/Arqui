var search_data = {"index":{"searchIndex":["coinflipper","fight","gamecontroller","move","object","room","substate","add_state()","create_game2()","description()","east()","east()","east()","fight()","fight()","fight()","flip_coin()","flip_coin()","flip_coin()","go_state()","go_sub()","h()","index()","instructions()","instructions()","lost?()","method_missing()","new()","new()","new()","new()","new()","new()","north()","north()","north()","run()","run()","run()","set_state()","south()","south()","south()","stats()","west()","west()","west()","won?()","readme"],"longSearchIndex":["coinflipper","fight","gamecontroller","move","object","room","substate","room#add_state()","object#create_game2()","gamecontroller#description()","gamecontroller#east()","move#east()","room#east()","fight#fight()","gamecontroller#fight()","room#fight()","coinflipper#flip_coin()","gamecontroller#flip_coin()","room#flip_coin()","gamecontroller#go_state()","room#go_sub()","object#h()","gamecontroller#index()","gamecontroller#instructions()","room#instructions()","gamecontroller#lost?()","substate#method_missing()","coinflipper::new()","fight::new()","gamecontroller::new()","move::new()","room::new()","substate::new()","gamecontroller#north()","move#north()","room#north()","fight#run()","gamecontroller#run()","room#run()","gamecontroller#set_state()","gamecontroller#south()","move#south()","room#south()","gamecontroller#stats()","gamecontroller#west()","move#west()","room#west()","gamecontroller#won?()",""],"info":[["CoinFlipper","","CoinFlipper.html","","<p>Class that inherits from Substate, and as such it is a state that contains\nthe random result of calling …\n"],["Fight","","Fight.html","","<p>Class that inherits from SubState, contains the available options when the\nfight state is triggered (run …\n"],["GameController","","GameController.html","","<p>Creates a new game object containing the following attributes:  state,\nlife, money, fights and respect. …\n"],["Move","","Move.html","","<p>Class that inherits from SubState and calls the direction in which the\nplayer can move  depending on …\n"],["Object","","Object.html","",""],["Room","","Room.html","","<p>Class that represents a room object inside the game and handles the\n“space”, contains the following …\n"],["SubState","","SubState.html","","<p>Class that determines the state that is contained within a room, because a\nroom has the possibility of …\n"],["add_state","Room","Room.html#method-i-add_state","(s)","<p>Adds the current Substate to the current room.\n"],["create_game2","Object","Object.html#method-i-create_game2","(state, substate, money, life, fights, respect)","<p>Method to build a GameController instance using the parameters state,\nsubstate, life, money, fights and …\n"],["description","GameController","GameController.html#method-i-description","()","<p>The text description that every room has and is displayed to the user.\n"],["east","GameController","GameController.html#method-i-east","()","<p>In case the action is needed, the player will choose to move east and\nactive the corresponding action. …\n"],["east","Move","Move.html#method-i-east","(room , game)","<p>Moves the player in the east direction.\n"],["east","Room","Room.html#method-i-east","(game)","<p>In case the action is needed, the player will choose to move east and\nactive the corresponding action. …\n"],["fight","Fight","Fight.html#method-i-fight","(room, game)","<p>Calls the fight action for the current substate.\n"],["fight","GameController","GameController.html#method-i-fight","()","<p>The action of fighting against enemies in case the action is triggered.\nDepending on the state it can …\n"],["fight","Room","Room.html#method-i-fight","(game)","<p>The action of fighting against enemies in case the action is triggered.\nDepending on the state it can …\n"],["flip_coin","CoinFlipper","CoinFlipper.html#method-i-flip_coin","(room , game)","<p>Method that calls a random (between 0 and 1) in order to determine the\nresult of the coin flip 1 equals …\n"],["flip_coin","GameController","GameController.html#method-i-flip_coin","()","<p>The action of tossing a coin inside the game in case the action is needed.\nIt has two possible outcomes: …\n"],["flip_coin","Room","Room.html#method-i-flip_coin","(game)","<p>The action of tossing a coin inside the game in case the action is needed.\nIt has two possible outcomes: …\n"],["go_state","GameController","GameController.html#method-i-go_state","(index)","<p>Method that directs you to the proper state according to the index given.\n"],["go_sub","Room","Room.html#method-i-go_sub","(num)","<p>Depending on the possible substates contained in the current state (enabled\ncoin flip, enabled fights, …\n"],["h","Object","Object.html#method-i-h","(text)","<p>Scapes special html characters to prevent html injection\n"],["index","GameController","GameController.html#method-i-index","()","<p>Determines the current state according to the index.\n"],["instructions","GameController","GameController.html#method-i-instructions","()","<p>The instructions that the player has to folllow in order to continue moving\nforward with the game\n"],["instructions","Room","Room.html#method-i-instructions","()","<p>The instructions that the player has to folllow in order to continue moving\nforward with the game\n"],["lost?","GameController","GameController.html#method-i-lost-3F","()","<p>Method that determines if a player has lost according to their health, in\ncase that it is 0 or lower …\n"],["method_missing","SubState","SubState.html#method-i-method_missing","(m, *args, &block)","<p>Method that returns a message to the player in case an invalid action was\nattempted within the state. …\n"],["new","CoinFlipper","CoinFlipper.html#method-c-new","(id, instructions , head, tail)","<p>Init method for all the attributes in this class (id, instructions , head,\ntail).\n"],["new","Fight","Fight.html#method-c-new","(id, instructions, fight_b, run_b)","<p>Init method for all the attributes (id, instructions, fight_b, run_b).\n"],["new","GameController","GameController.html#method-c-new","(money, life, fights, respect)","<p>Init method for all the attributes within the game for the player (money,\nlife, fights, respect).\n"],["new","Move","Move.html#method-c-new","(id, instructions, up, down, right, left)","<p>Init method for all the attributes in this class(id, instructions, up,\ndown, right, left).\n"],["new","Room","Room.html#method-c-new","(id, description)","<p>Init method for all the attributes in this class (id, description).\n"],["new","SubState","SubState.html#method-c-new","(instructions, id)","<p>Init method for all the attributes in this class (instructions, id).\n"],["north","GameController","GameController.html#method-i-north","()","<p>In case the action is needed, the player will choose to move north and\nactive the corresponding action. …\n"],["north","Move","Move.html#method-i-north","(room , game)","<p>Moves the player in the north direction.\n"],["north","Room","Room.html#method-i-north","(game)","<p>In case the action is needed, the player will choose to move north and\nactive the corresponding action. …\n"],["run","Fight","Fight.html#method-i-run","(room, game)","<p>Calls the run action for the current substate.\n"],["run","GameController","GameController.html#method-i-run","()","<p>While in the state of fighting, the player can run from it escaping said\nstate.\n"],["run","Room","Room.html#method-i-run","(game)","<p>While in the state of fighting, the player can run from it escaping said\nstate.\n"],["set_state","GameController","GameController.html#method-i-set_state","(index, state)","<p>Method that adds the index of the current state to the list of states in\norder to go to that state.\n"],["south","GameController","GameController.html#method-i-south","()","<p>In case the action is needed, the player will choose to move south and\nactive the corresponding action. …\n"],["south","Move","Move.html#method-i-south","(room , game)","<p>Moves the player in the south direction.\n"],["south","Room","Room.html#method-i-south","(game)","<p>In case the action is needed, the player will choose to move south and\nactive the corresponding action. …\n"],["stats","GameController","GameController.html#method-i-stats","()","<p>This are the stats that the player has throughout the game, also being\ninitialized to the default values. …\n"],["west","GameController","GameController.html#method-i-west","()","<p>In case the action is needed, the player will choose to move west and\nactive the corresponding action. …\n"],["west","Move","Move.html#method-i-west","(room , game)","<p>Moves the player in the west direction.\n"],["west","Room","Room.html#method-i-west","(game)","<p>In case the action is needed, the player will choose to move west and\nactive the corresponding action. …\n"],["won?","GameController","GameController.html#method-i-won-3F","()","<p>Method that determines if a player has won in case they have arrived to the\ncorrect state (state 14) …\n"],["README","","README_txt.html","","<p>Application Design and Architecture\n<p>Authors &mdash; Brian Flores, Alejandro Rojas, Eduardo Azuri, Eduardo Rodríguez …\n"]]}}
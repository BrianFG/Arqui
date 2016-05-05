= Application Design and Architecture

Authors::    Brian Flores, Alejandro Rojas, Eduardo Azuri, Eduardo Rodríguez
Date::      May 04, 2016

In this documentation we will explain the steps required in order to install and run the game "Sobrebibiendo Ekatepek". We'll now explain the directory structure for the application and its documentation:



   Arqui/
         ├─ doc/                        Folder produced by RDoc.
         ├─ models/                     Folder that include the source code.
         ├─ public/                     Folder all the javascript files and resources.
         └─ views/                      Folder for the application's views (ERB files).

The gems that you require in order to run the project are:

	1. Sinatra
	2. SQLite 3
	3. Bootsrap
	4. JQuery
	5. Sequel


== Installing and Running the Application

In order to run the game you have to position yourself inside the directory of the project and then run the file "ecatepec.rb" with the following command:
  
  ruby -I . -w "ecatepec.rb"

Afterwards, point your web brower at the following URL: +http://localhost:4567/+

== 4+1 Architectural View Model

We'll now explain the different views that conform the architectural model of our application.

=== Logical View

The logical view contains information about the various parts of the system. In UML the logical view is typically modelled using <em>class diagrams</em>.

In the following diagram, it displays in UML classes diagrams the GameController, Room, SubState, Move, CoinFlipper, Fight  classes and its subclasses for the Model.

link:../doc/images/logical.png

=== Process View

Even though the system handles sessions apart from others, the system has no concurrent processes due to the fact of the simple design.

=== Development View

The system is a stand-alone application, thus, it has no software modules or subsystems.

=== Physical View

In order for the system to function, the Web server that hosts "ecatepec.rb", the Sinatra Framework, SQL-Lite and Sequel need to be installed. The following diagram shows the physicial implementation:

For example, this is the deployment diagram for our application:

link:../doc/images/physical.png

=== Scenarios

In a regular scenario, the user enters the web page of the server. Then, it asks to enter his/her name and after that, the epic adventure starts. At first, the user is greeted with the view that displays his/hers current stats [health, respect & money], the screen that narrates the adventure and the buttons the user can push in order to make said actions. The following diagram displays the actions the user can do:

link:../doc/images/cases.png


== Patterns Used

The patterns that were used within our project are:

- <b>State Pattern</b>: We used this pattern in order to separate the functionality into states and substates that could handle the instances of the game better. The states are instances of +Room+ and are handled in the +clases.rb+. 
- <b>Model View Controller</b>: The application follows the classical web implementation of the MVC architectural pattern. The models (+.rb+ files) and views (+.erb+ files) are stored in the corresponding +models+ and +views+ directory. The controller is contained in +ecatepec.rb+ file.
- <b>Strategy Factory</b>: Each of our states behaves differently so we send a +Proc+ with all the code that it must implement. This is handled in the +gameFactory+ class that is contained inside the +clases.rb+.

== Acknowledgments

We'd like to recognize the labor of every member in our team for their dedication towards success. Additionalywe'd like to thank the following.

- Samantha Ponce & nail (Edgar López).

- Saul de Nova for his constant support and laughs.

== References

- \Ph. Kruchten. <em>The 4+1 View Model of Architecture.</em> IEEE Software, vol. 12 (6), pp. 45-50, 1995. {\http://www.ics.uci.edu/~andre/ics223w2006/kruchten3.pdf}[http://www.ics.uci.edu/~andre/ics223w2006/kruchten3.pdf] Accessed May 3, 2016.

- \R. Olsen. <em>Design Patterns in Ruby.</em> Addison-Wesley, 2007. Available through {Safari Books Online}[http://proquestcombo.safaribooksonline.com/book/web-development/ruby/9780321490452] Accessed May 3, 2016.

- Ruby-Doc.org. <em>RDoc Markup Reference.</em> {\http://ruby-doc.org/stdlib-2.2.3/libdoc/rdoc/rdoc/RDoc/Markup.html}[http://ruby-doc.org/stdlib-2.2.3/libdoc/rdoc/rdoc/RDoc/Markup.html#class-RDoc::Markup-label-Block+Markup] Accessed May 3, 2016.

This application fulfills the requirements for the Flatiron School Software Engineering Module 1 Project.
ActiveRecord is employed in order to define 4 related object classes. 
The follow class operates as a joiner between users and players. 
Matches belong to two players through the association of two player foreign keys. 
Objects can be instantiated through ActiveRecord migration while a database with 
corresponding tables can be seeded. 
Users interact with the application through a CLI that is called through a run file. 
The Rake gem is employed as a task manager and the TTY-Prompt gem is used to improve the 
interactivity of the CLI menu. User login information, lists of followed players and their 
associated matches all persist through the database. Follow lists can be updated and deleted by users. 
Users have access to match data through their association with players. 
The application also includes a tennis match score generator.    













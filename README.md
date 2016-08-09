# bt-exercise

### Running The Code
Developed on OS-X but should work on Linux systems as well.
Install Ruby 2.3.1
(ruby installation instructions for OS X, should be similar to install via apt-get where we use brew)
  - `brew install chruby`
  - `brew install ruby-install`
  - `ruby-install ruby 2.3.1`
  - `cd <directory>/bt-exercise`
  - `bundle install`
  - To run the tests simply type `rspec`
  - To execute the code `ruby bank-runner.rb <input_file>`

### Language Choice
Ruby is less verbose than something like Java or C++. Additionally, my current job has me working
mostly in Ruby so it's familiar. 

### Design Decisions
I decided to represent each Card Account as its own object by defining the `CardAccount` class
with the functionality to modify a single account. Each account has its own balance, validity flag,
cardholder name, and limit stored internally.

All of the accounts are stored by the `AccountManager` within a hash map. AccountManager is also responsible for parsing the commands from the input file and 
performing the proper action on the right user. 
I used the in memeory hash over a DB like MySQL for ease of development and because the way the requirements were structured did not imply that it was necessary 
to hold onto the data long term nor that potential numbers of users would be so large that they would exceed my laptop's memory space. Switching to using a 
database to persistently store the users would not be too difficult.


Given some more time I would probably add some end-to-end testing with a larger dataset.
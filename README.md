Usage:
-------------------

1. Scripts: Check out the scenarios folder. I've created a sample scenario to show you how you can analyse the data.

2. Console: 

> irb

Then as the first command write 

> require "config/initialize"

Those commands will put you into a console with all the requirements and database connection opened. You can then use Mongoid syntax to retrieve data from the database. (http://mongoid.org/docs/querying/criteria.html). I'll be writing scenarios up that you can use as base documents if you want.

Install instructions
---------------------

Want to have a play with the code? You'll want to know how to get to the terminal, and be fairly comfortable. This guide uses OSX,
cos that's what I use. If you want to run it on a linux machine, you need to install Ruby (preferably via RVM), Mongodb
and Git. If you want to run it on a windows machine, the same still applies. You'll need to google how to install all the dependencies, but once they are all there it should work fine. If you've got any problems with anything here, drop me a PM, or open an issue on github, and I'll look at fixing it.

If anyone wants to write install instructions for non apple machines, please send them over and I'll happily add them.

*OSX instructions*

1. Install Homebrew :  http://mxcl.github.com/homebrew/ The install is simple.
2. Use Homebrew to install git and mongodb

> brew install mongodb

> brew install git

3. Install RVM 

Visit http://beginrescueend.com/ and checkout their install script.

4. Install Ruby 1.9.2

> rvm install 1.9.2

5. Create a folder for the code and clone the repository into it

> git clone git@github.com:Hitonagashi/fumbbl_games.git

6. CD into the directory. RVM should prompt you to examine the RVMRC file (tells it what rubies and gems to use.). It's
safe, so type "y" to allow it. If you want to look at it, be my guest, it's the .rvmrc file in the root folder.

7. Install bundler to allow for management of gems

> gem install bundler

8. Install required gems

> bundle install

9. Import the database from the dump

> ./mongorestore dump/fumbbl

10. Good to go!

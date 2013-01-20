Installation Instructions:

1. Install RVM, ruby, and all the good stuff (instruction:  http://www.moncefbelyamani.com/how-to-install-xcode-homebrew-git-rvm-ruby-on-mac/):
* xcode (for the c compiler for ruby)
* homebrew (package manager for 3rd party software)
* rvm (package manager for anything ruby related)
* ruby (rvm install 1.9.3)

2. Create a gemset for the project and use the right environment!
* use the right ruby version (rvm use ruby-1.8.7.p371)
* rvm gemset create gscc-web
* rvm gemset use gscc-web

3. Get the dependency software via bundler!
* gem install bundler
* bundle install
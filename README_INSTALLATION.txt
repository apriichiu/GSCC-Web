Installation Instructions:

1. Download RVM.

Once RVM is installed, do the following commands to setup the ruby, rails, gems environment:

2. Get the right version of ruby:
* download ruby 1.9.3 (rvm install 1.9.3)
* use the right ruby version (rvm use ruby-1.8.7.p371)

3. create a gemset for the project:
* rvm gemset create gscc-web
* rvm gemset use gscc-web

4. Get the dependency software via bundler!
* gem install bundler
* bundle install
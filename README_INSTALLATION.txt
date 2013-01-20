Installation Instructions (Mac OS X 10.8.2)

1. Download RVM.

Once RVM is installed, do the following commands to setup the ruby, rails, gems environment:

2. Get the right version of ruby: 

(use "rvm list" to check if 1.8.7 is installed, if not, install ruby 1.8.7 by typing "rvm install 1.8.7". If you hit errors, please try "rvm install 1.8.7  --without-tcl --without-tk, if that doesn't work please contact the webmaster"

rvm use ruby-1.8.7.p371

3. create a gemset for the project: 

rvm gemset create gscc-web
rvm gemset use gscc-web

4. Get the right version of rails:

gem install rails -v 2.3.3

5. Get the right version of ruby gems:

rvm install rubygems 1.3.6

6. copy the database configuration stuff

* database connection settings by copying database.yml from config/database.yml.sample:

cp config/database.yml.sample config/database.yml

* copy the seeded development database: 

cp db/development.sqlite3.sample db/development.sqlite3

7. Install necessary gems

rake gems:install
(NOTE: if this command doesn't work for you and it is complaining about a deprecation rdoc thing,
then you probably have newer version of rake than the one we use, which is 0.8.7.  What you will need to do is the following:
* install the correct rake version: gem install rake -v 0.8.7
* run rake with that SPECIFIC version, like this: rake _0.8.7_ gems:install)
(NOTE: if you get an error that says RDoc failure, it's ok just ignore it)

8. Install these other gems

gem install sqlite3 -v 1.3.7

Here is the whole gem list, please compare (run gem list):
actionmailer (2.3.3)
actionpack (2.3.3)
activerecord (2.3.3)
activeresource (2.3.3)
activesupport (2.3.3)
attr_required (0.0.5)
bundler (1.2.1)
fb_graph (2.6.2)
httpclient (2.3.2)
i18n (0.6.1)
json (1.7.6)
mime-types (1.19)
multi_json (1.5.0)
rack (1.4.4, 1.0.1)
rack-oauth2 (1.0.0)
rails (2.3.3)
rake (0.8.7) 
rest-client (1.6.7)
rubygems-bundler (1.1.0)
rvm (1.11.3.5)
sass (3.2.5)
sqlite3 (1.3.7)
tzinfo (0.3.35)

***NOTE:*** you might have additional versions of rake depending on what you did for step 7

9. run the server

ruby script/server

10. check if the site appears at localhost:3000 (in safari or any browser)

11. *OPTION* if you want to run the facebook update script (wrap_facebook_update.sh) that pulls events from a facebook page, copy config/facebook.yml.sample to config/facebook.yml and fill in the information accordingly (if you don't know the information, ask your webmaster for it)

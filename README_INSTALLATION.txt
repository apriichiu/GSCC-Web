Installation Instructions:

1. Download RVM.

Once RVM is installed, do the following commands to setup the ruby, rails, gems environment:

2. Get the right version of ruby: 

rvm use ruby-1.8.7.p371

3. create a gemset for the project: 

rvm gemset create gscc-web
rvm gemset use gscc-web

4. Get the right version of rails:

gem install rails -v 2.3.3

5. Get the right version of ruby gems:

rvm install rubygems 1.3.6

6. Install necessary gems

rake gems:install
(NOTE: if this command doesn't work for you and it is complaining about a deprecation rdoc thing,
then you probably have newer version of rake than the one we use, which is 0.8.7.  What you will need to do is the following:
* install the correct rake version: gem install rake -v 0.8.7
* run rake with that SPECIFIC version, like this: rake _0.8.7_ gems:install)

7. Install these other gems

gem install haml -v 3.1.7
gem install sqlite3 -v 1.3.7
gem install json -v 1.7.6
gem install rest-client -v 1.6.7
gem install oauth2 -v 0.8.0
gem install fb_graph -v 2.6.1
gem install sass -v 3.2.5
gem install rack -v 1.1.0

Here is the whole gem list, please compare (run gem list):
actionmailer (2.3.3)
actionpack (2.3.3)
activerecord (2.3.3)
activeresource (2.3.3)
activesupport (2.3.3)
attr_required (0.0.5)
bundler (1.2.1)
faraday (0.8.4)
fb_graph (2.6.1)
haml (3.1.7)
httpauth (0.2.0)
httpclient (2.3.2)
i18n (0.6.1)
json (1.7.6)
jwt (0.1.5)
mime-types (1.19)
multi_json (1.5.0)
multipart-post (1.1.5)
oauth2 (0.8.0)
rack (1.4.4, 1.1.0, 1.0.1)
rack-oauth2 (1.0.0)
rails (2.3.3)
rake (0.8.7)
rest-client (1.6.7)
rubygems-bundler (1.1.0)
rvm (1.11.3.5)
sass (3.2.5)
sqlite3 (1.3.7)
tzinfo (0.3.35)


8. run the server

ruby script/server

9. check if the site appears at localhost:3000!

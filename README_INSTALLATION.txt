Installation Instructions:

1. Download RVM.

Once RVM is installed, do the following commands to setup the ruby, rails, gems environment:

2. Get the right version of ruby: 

rvm use ruby-1.8.7.p371

3. create a gemset for the project: 

rvm gemset create gscc-web
rvm gemset use gscc-web

4. Get the right version of rails:

gem install rails 2.3.3

5. Get the right version of ruby gems:

rvm install rubygems 1.3.6

6. Install necessary gems

rake gems:install

7. run the server

ruby script/server

8. check if the site appears at localhost:3000!

It is possible that gems may be missing or you may have the incorrect version. If so, install each gem that is missing, using:  gem install <gem name>. It may be helpful to compare your gem list: gem list, with this list:

minimum gem list:
  "haml"
  "sqlite3"
  "json"
  "rest-client"
  "oauth2"
  "fb_graph"
  "sass"

full gem list:

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

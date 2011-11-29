#!/bin/bash
pushd $(dirname "${0}") > /dev/null
basedir=$(pwd -L)
# Use "pwd -P" for the path without links. man bash for more info.
popd > /dev/null
export RAILS_ROOT=`dirname ${basedir}`

# detect if we're on the web server
sname=`basename $RAILS_ROOT`
if [ $sname == "gschristian.org" ]
then
    echo "===On web server, changing rails environment==="
    export RAILS_ENV=production
fi

ruby -W0 $RAILS_ROOT/script/runner ${basedir}/update_facebook.rb

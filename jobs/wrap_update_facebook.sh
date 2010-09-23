#!/bin/bash
pushd $(dirname "${0}") > /dev/null
basedir=$(pwd -L)
# Use "pwd -P" for the path without links. man bash for more info.
popd > /dev/null
export RAILS_ROOT=`dirname ${basedir}`

ruby $RAILS_ROOT/script/runner ${basedir}/update_facebook.rb


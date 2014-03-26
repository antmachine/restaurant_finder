## Anthony's Food Finder ##
#
#
# Launching this Ruby file from the command line will start the program.
#
#
# The following are exapmles of absolute paths to the files needed to run the Food Finder
#
#require "#{APP_ROOT}/lib/guide"
#require File.join(APP_ROOT, 'lib', 'guide')
#

#define our file path variable
APP_ROOT = File.dirname(__FILE__)

#We're going to use the $: variable to get to the required files

$:.unshift(File.join(APP_ROOT, 'lib'))
require 'guide'


#Create a new Guide instance and launch the program
guide = Guide.new('restaurants.txt')
guide.launch!
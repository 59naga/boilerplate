# Dependencies
myProject= require './my-project'
objectAssign= require 'object-assign'

# Singleton & constructor
API= objectAssign myProject.method,myProject
API.version= process.env.npm_package_version

module.exports= API

# Dependencies
Command= (require 'commander').Command

# Public
class Project extends Command
  constructor: ->
    super
  parse: ->
    super

module.exports= new Project
module.exports.Project= Project
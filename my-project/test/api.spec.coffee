# Dependencies
myProject= require '../src'

# Environment

# Specs
describe 'myProject',->
  it '.method',->
    result= myProject.method()
    
    expect(result).toBe 'foo'
      
# Dependencies
myProject= require '../src'

# Environment

# Specs
describe 'myProject',->
  it 'default',->
    result= myProject()
    
    expect(result).toBe 'foo'
      

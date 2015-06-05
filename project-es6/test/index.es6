import {equal} from 'power-assert'
import Person from '../src'

describe('Person', ()=>{
  let name= 'Alice'
  let age= 4
  let alice= new Person(name, age)

  it('alice get age', ()=>{
    equal(alice.getAge(), age)
  })
  it('alice greet', ()=>{
    let name= 'Alice'
    let age= 4
    let alice= new Person(name, age)

    equal(alice.greet(), `Hello! I am ${name}. My age is ${age}`)
  })
})

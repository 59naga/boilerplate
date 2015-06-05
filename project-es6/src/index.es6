class Person {
  constructor(name, age){
    this.name= name
    this.age= age
  }
  getAge(){
    return this.age
  }
  greet(){
    return 'Hello! I am ' + this.name + '. My age is ' + this.age
  }
}

export default Person

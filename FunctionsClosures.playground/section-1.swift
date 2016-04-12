import Foundation

func square(number: Double) -> Double
{
	return number * number
}

let a = 3.0, b = 4.0, c = sqrt(square(a) + square(b))

println(c)

func checkAreEqual<T: Equatable>(#value: T, #expected: T, #message: String)
{
	if expected != value
	{
		println(message)
	}
}

var input = 3
checkAreEqual(value: input, expected: 2, message: "An input of '2' was expected.")

input = 47
checkAreEqual(value: input, expected: 47, message: "An input of '47' was expected.")

var inputString = "dog"

checkAreEqual(value: inputString, expected: "cat", message: "An input of 'dog' was expected.")

func square(inout number: Double)
{
	number = number * number
}

var test = 2.0
square(test)
println(test)

class Person
{
	var age = 34
	var name = "colin"
	
	func growOlder()
	{
		self.age++
	}
	
}

func celebrateBirthday(cumpleñero: Person)
{
	println("Happy Burthday \(cumpleñero.name)")
	cumpleñero.growOlder()
}

let person = Person()
println(person.age)
celebrateBirthday(person)
println(person.age)

class Cell: Printable
{
	private(set) var row = 0
	private(set) var column = 0
	
	func move(x: Int = 0, y: Int = 0)
	{
		self.row += y
		self.column += x
	}
	
	var description: String
	{
		get
		{
			return "Cell [row = \(self.row), column = \(self.column)"
		}
	}
}

var cell = Cell()
cell.move(x: 4)
cell.move(x: 4, y: 7)
println(cell.description)

var instanceMoveFunction = cell.move
var classMoveFunction = Cell.move

instanceMoveFunction(x: 1, y: 1)
classMoveFunction(cell)(x: 1, y: 1)

typealias StateMachineType = () -> Int

func makeStateMachine(maximumState: Int) -> StateMachineType
{
	var currentState = 0
	
	return
	{
		currentState++
		
		if currentState > maximumState
		{
			currentState = 0
		}
		
		return currentState
	}
}

let triState = makeStateMachine(2)
let quadState = makeStateMachine(3)

for index in 0...10
{
	println(triState())
}

for index in 0...10
{
	println(quadState())
}
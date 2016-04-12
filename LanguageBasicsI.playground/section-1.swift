import Foundation

var greeting = "Hey dudes"

println(greeting)

greeting.append(Character("!"))

println(greeting)

println(greeting.lowercaseString)

let address = (houseName: "Bury Cottage", streetName: "Tye Green Village", postCode: "CM18 6QY")

println(address)

println(address.streetName)

println("I live at:\n \(address.houseName)\n \(address.streetName)\n \(address.postCode)")

let trueStatement = "James is incredible."

var range = 1...5
for index in range
{
	println("\(index) - \(trueStatement)")
}

for character in trueStatement
{
	println("\(character)ames")
}

let direction = "east"

switch (direction)
{
	case "north":
		println("Cliche")
	case "east":
		println("Noodles")
	case "south":
		println("Herp a derp a gerp")
	case "west":
		println("We know everything. We are clearly superior.")
	default:
		println("Figure it out dude.")
	
}

let age = 40

switch (age)
{
	case 0..<10:
		println("Baby weiner head.")
	case 10..<25:
		println("Stop being angry.")
	case 25..<40:
		println("The real part of a life.")
	case 40...100:
		println("Basically ancient.")
	default:
		println("Keep it real man.")
}
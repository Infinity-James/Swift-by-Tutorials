// Playground - noun: a place where people can play

import UIKit

var testString: String?

testString = "No longer nil"

if let unwrappedString = testString
{
	println("Perfectly valid string: \(unwrappedString)")
}
else
{
	println("String was nil.")
}

var testArray = [1, 2, 3, 4, 5]

println(testArray[3])

testArray.extend(6...10)

println(testArray)

testArray.removeRange(1..<10)

println(testArray)

var testDictionary = ["Key" : "Value", "Another Key": "Another Value"]

println(testDictionary["Another Key"])

testDictionary["Yet Another Key"] = "Yet Another Value"

for (key, value) in testDictionary
{
	println("\(key) for \(value)")
}

var dictionaryA = [1: "A", 2: "B", 3: "C", 4: "D"]
var dictionaryB = dictionaryA

dictionaryA[3] = nil

println(dictionaryA)
println(dictionaryB)

var arrayA = [1, 2, 3, 4, 5]
var arrayB = arrayA

arrayB[0] = 10

println(arrayA)
println(arrayB)

arrayB.removeAtIndex(3)

println(arrayA)
println(arrayB)
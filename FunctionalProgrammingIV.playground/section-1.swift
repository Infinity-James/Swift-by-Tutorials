import Foundation

let data = "5,7;3,4;55,6"

func createSplitter(separator: String)(source: String) -> [String]
{
	return source.componentsSeparatedByString(separator)
}

let commaSplitter = createSplitter(",")
let semiColonSplitter = createSplitter(";")

println(commaSplitter(source: data))
println(semiColonSplitter(source: data))

func addNumbers(one: Int, two: Int, three: Int) -> Int
{
	return one + two + three
}

let sum = addNumbers(4, 16, 64)

func curryAddNumbers(one: Int)(two: Int)(three: Int) -> Int
{
	return one + two + three
}

let stepOne = curryAddNumbers(4)
let stepTwo = stepOne(two: 16)
let result = stepTwo(three: 64)

let resultTwo = curryAddNumbers(4)(two: 16)(three: 64)

func currierAddNumbers(one: Int, two: Int)(three: Int) -> Int
{
	return one + two + three
}

let resultThree = currierAddNumbers(4, 16)(three: 64)

let text = "Swift"
let paddedText = text.stringByPaddingToLength(10, withString: ".", startingAtIndex: 0)

func curriedPadding(startingAtIndex index: Int, withString string: String)(source: String, length: Int) -> String
{
	return source.stringByPaddingToLength(length, withString: string, startingAtIndex: index)
}

let dotPadding = curriedPadding(startingAtIndex: 0, withString: ".")

let dotPaddedCurry = dotPadding(source: "Curry!", length: 10)

import Foundation

let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]

typealias Entry = (Character, [String])

func distinct<T: Equatable>(source: [T]) -> [T]
{
	var unique = [T]()
	
	for item in source
	{
		if !contains(unique, item)
		{
			unique.append(item)
		}
	}
	
	return unique
}

func buildIndex(words: [String]) -> [Entry]
{
	func firstLetter(string: String) -> Character
	{
		Character(string.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
	}
	
	let distinctLetters = distinct(words.map(firstLetter))
	
	let index = distinctLetters.map
	{
		letter -> Entry in
		
		(letter, words.filter
		{
			firstLetter($0) == letter
		})
	}
	
	return index
}

println(buildIndex(words))
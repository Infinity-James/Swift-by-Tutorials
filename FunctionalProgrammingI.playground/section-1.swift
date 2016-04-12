var evens = [Int]()

for index in 1...10
{
	if index % 2 == 0
	{
		evens.append(index)
	}
}

println(evens)

func isEven(number: Int) -> Bool
{
	let isEven = number % 2 == 0
	
	return isEven
}

evens = Array(1...10).filter(isEven)
println(evens)

evens = Array(1...10).filter { $0 % 2 == 0 }
println(evens)

func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T]
{
	var result = [T]()
	
	for index in source
	{
		if predicate(index)
		{
			result.append(index)
		}
	}
	
	return result
}

evens = myFilter(Array(1...10)) { $0 % 2 == 0 }
println(evens)

var evenSum = 0

for index in evens
{
	evenSum += index
}

println(evenSum)

evenSum = Array(1...10).filter { $0 %  2 == 0 }.reduce(0) { $0 + $1 }
println(evenSum)

let maxNumber = Array(1...10).reduce(0) { max($0, $1) }
println(maxNumber)

let numbers = Array(1...10).reduce("numbers: ") { $0 + "\($1) " }
println(numbers)

extension Array
{
	func myReduce<T, U>(seed: U, combiner: (U, T) -> U) -> U
	{
		var current = seed
		
		for item in self
		{
			current = combiner(current, item as T)
		}
		
		return current
	}
}
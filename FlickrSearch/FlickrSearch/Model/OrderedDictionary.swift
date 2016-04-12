//
//  OrderedDictionary.swift
//  FlickrSearch
//
//  Created by James Valaitis on 20/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Ordered Dictionary Structure Implementation

struct OrderedDictionary <KeyType: Hashable, ValueType>
{
	//	MARK: Type Aliases
	
	typealias ArrayType = [KeyType]
	typealias DictionaryType = [KeyType: ValueType];
	
	//	MARK: Internal Properties
	
	/**	The ordered array of keys for the ordered dictionary.	*/
	var array = ArrayType()
	/**	The backing dictionary of keys to values.	*/
	var dictionary = DictionaryType()
	/**	How many elements the OrderedDictionary stores.	*/
	var count: Int
	{
		return self.array.count
	}
	
	//	MARK: Dictionary Mutating Methods
	
	/**
		Insert a value for a particular key into the dictionary at the given index.
		
		:param: value	The value to insert add for the given key
		:param:	key		The key for the value to insert at the given index.
		:param:	index	The index to insert the key.
	
		:return:	Any pre-existing value for the given key
	*/
	mutating func insert(value: ValueType, forKey key: KeyType, atIndex index: Int) -> ValueType?
	{
		var adjustedIndex = index;
		
		//	find if there is an existing value for the given key
		let existingValue = self.dictionary[key]
		if existingValue != nil
		{
			//	if there is an existing value find it's position in the array
			let existingIndex = find(self.array, key)!
			
			//	due to the fact the existing index is about to be removed we need to down adjust the index we are going to insert at
			if existingIndex < index
			{
				adjustedIndex--
			}
			
			self.array.removeAtIndex(existingIndex)
		}
		
		//	update array and dictionary
		self.array.insert(key, atIndex: adjustedIndex)
		self.dictionary[key] = value
		
		//	return the existing value if there was one
		return existingValue
	}
	
	/**
		Removes the key at the given index and the value associated with that key.
		
		:param:	index	The index of key to remove.
		
		:return:	They key and value as a tuple at the removed index.
	*/
	mutating func removeAtIndex(index: Int) -> (KeyType, ValueType)
	{
		//	check that the given index is within the bounds of the array
		precondition(index < self.array.count, "Index is out of bounds.")
		
		//	obtain key from array and the value for the given key from the dictionary
		let key = self.array.removeAtIndex(index)
		let value = self.dictionary.removeValueForKey(key)!
		
		//	return key and value as a tuple
		return (key, value)
	}
	
	/**
		Subscripting behaviour for the OrderedDictionary (key for value).
	*/
	subscript(key: KeyType) -> ValueType?
	{
		//	getter for the subscript - returns value at given key
		get
		{
			return self.dictionary[key]
		}
		
		//	setter for the subcript - sets the value for the given key
		set
		{
			if let index = find(self.array, key)
			{
			}
				//	only if the key doesn't exist in the array do we add it
			else
			{
				self.array.append(key)
			}
			
			//	update or add the value for the given key to the dictionary
			self.dictionary[key] = newValue
		}
	}
	
	/**
		Subscripting behaviour for the OrderedDictionary (index for key, value pair).
	*/
	subscript(index: Int) -> (KeyType, ValueType)?
	{
		//	getter for the subscript - returns key, value for given index
		get
		{
			//	check index is within bounds of array
			precondition(index < self.array.count, "Index is out of bounds")
			
			//	get key for index and the value for the key
			let key = self.array[index]
			let value = self.dictionary[key]!
			
			//	return the key, value pair as a tuple
			return (key, value)
		}
		
		//	setter for the subscript - sets key, value pair at the index
		set
		{
			if let (key, value) = newValue
			{
				self.insert(value, forKey: key, atIndex: index)
			}
		}
	}
}

//	MARK: Ordered Dictionary Extension - SequenceType

extension OrderedDictionary: SequenceType
{	
	func generate() -> GeneratorOf<(KeyType, ValueType)>
	{
		var index = 0
		
		//	use GeneratorOf which creates generator that calls enclosure for each call of next()
		return GeneratorOf
		{
			//	if we are within the bounds of the array we get the next key in the array and return it and it's associated value
			if index < self.array.count
			{
				let key = self.array[index++]
				return (key, self.dictionary[key]!)
			}
			
			//	at the end of the array we return nil
			else
			{
				return nil
			}
		}
	}
}
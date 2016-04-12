//
//  Person.swift
//  MemoryLeakTest
//
//  Created by James Valaitis on 26/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import Foundation

class Person
{
	let name: String
	private let actionClosure: (() -> ())!
	
	init(name: String)
	{
		self.name = name
		
		self.actionClosure =
		{
			[unowned self] in
			println("I am \(self.name).")
		}
	}
	
	func performAction()
	{
		self.actionClosure()
	}
	
	deinit
	{
		println("\(name) is being deinitialised.")
	}
}
//
//  DelegateMulticast.swift
//  Reversi
//
//  Created by James Valaitis on 11/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

class DelegateMulticast<T>
{
	//	MARK: Private Properties - State
	
	private var delegates = [T]()
	
	//	MARK: Delegate Management
	
	func addDelegate(delegate: T)
	{
		self.delegates.append(delegate)
	}
	
	func invokeDelegates(invocation: (T) -> ())
	{
		for delegate in self.delegates
		{
			invocation(delegate)
		}
	}
}
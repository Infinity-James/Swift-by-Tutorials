//
//  BoardDelegate.swift
//  Reversi
//
//  Created by James Valaitis on 11/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Board Delegate Protocol Declaration

protocol BoardDelegate
{
	/**
		Sent to the delegate when the state of a cell has changed.
	*/
	func cellStateChanged(location: BoardLocation)
}
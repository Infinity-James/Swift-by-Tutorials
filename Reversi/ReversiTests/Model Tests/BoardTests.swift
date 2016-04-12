//
//  BoardTests.swift
//  Reversi
//
//  Created by James Valaitis on 09/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import UIKit
import XCTest

class BoardTests: XCTestCase
{
	//	MARK: Set Up
	
	override func setUp()
	{
        super.setUp()
    }
    
    override func tearDown()
	{
        super.tearDown()
	}
	
	//	MARK: Co-ordinates
	
	func test_subscript_setWithValidCoords_callStateIsChanged()
	{
		let board = Board()
		
		//	set the state of one of the cells
		let desiredState = BoardCellState.White
		board[4, 5] = desiredState
		
		//	retrieve the state
		let retrievedState = board[4, 5]
		
		//	test it
		XCTAssertEqual(desiredState, retrievedState, "The retrieved state and desired state should be the same!")
	}
}
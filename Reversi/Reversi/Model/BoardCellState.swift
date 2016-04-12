//
//  BoardCellState.swift
//  Reversi
//
//  Created by James Valaitis on 09/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Board Cell State Enum

enum BoardCellState
{
	//	MARK: Cell States
	
	case Empty, Black, White
	
	//	MARK: Cell State Manipulations
	
	func invert() -> BoardCellState
	{
		if self == Black
		{
			return White
		}
		
		else if self == White
		{
			return Black
		}
		
		assert(self != Empty, "Cannot invert an empty cell.")
		
		return Empty
	}
}
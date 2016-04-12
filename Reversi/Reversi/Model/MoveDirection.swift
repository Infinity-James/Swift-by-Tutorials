//
//  MoveDirection.swift
//  Reversi
//
//  Created by James Valaitis on 12/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation

enum MoveDirection
{
	case North, South, East, West,
		NorthEast, NorthWest, SouthEast, SouthWest
	
	func move(location: BoardLocation) -> BoardLocation
	{
		switch self
		{
			case .North:
				return BoardLocation(row: location.row - 1, column: location.column)
			case .South:
				return BoardLocation(row: location.row + 1, column: location.column)
			case .East:
				return BoardLocation(row: location.row, column: location.column - 1)
			case .West:
				return BoardLocation(row: location.row, column: location.column + 1)
			case .NorthEast:
				return BoardLocation(row: location.row - 1, column: location.column - 1)
			case .NorthWest:
				return BoardLocation(row: location.row - 1, column: location.column + 1)
			case .SouthEast:
				return BoardLocation(row: location.row + 1, column: location.column - 1)
			case .SouthWest:
				return BoardLocation(row: location.row + 1, column: location.column + 1)
		}
	}
	
	static let directions: [MoveDirection] = [ .North, .South, .East, .West,
												.NorthEast, .NorthWest, .SouthEast, .SouthWest]
}
//
//  Board.swift
//  Reversi
//
//  Created by James Valaitis on 09/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Board Class

class Board
{
	//	MARK: Private Properties - Constants
	
	let boardSize = 8
	
	//	MARK: Private Properties - State
	
	private var cells: [BoardCellState]
	private let delegates = DelegateMulticast<BoardDelegate>()
	
	//	MARK: Board Methods
	
	func anyCellsMatchCondition(function: (BoardLocation) -> Bool) -> Bool
	{
		for column in 0..<self.boardSize
		{
			for row in 0..<self.boardSize
			{
				if function(BoardLocation(row: row, column: column))
				{
					return true
				}
			}
		}
		
		return false
	}
	
	/**
		Clears the entire board
	*/
	func clearBoard()
	{
		cellVisitor
		{
			location in
			
			self[location] = .Empty
		}
	}
	
	//	MARK: Convenience Methods
	
	/**
		Applies the given function to each cell on the board.
	
		:param:	function	The function to apply to each cell.
	*/
	func cellVisitor(function: (BoardLocation) -> ())
	{
		for column in 0..<self.boardSize
		{
			for row in 0..<self.boardSize
			{
				let location = BoardLocation(row: row, column: column)
				function(location)
			}
		}
	}
	
	//	MARK: Delegates
	
	func addDelegate(delegate: BoardDelegate)
	{
		self.delegates.addDelegate(delegate)
	}
	
	//	MARK: Initialisation
	
	init()
	{
		self.cells = Array(count: self.boardSize * self.boardSize, repeatedValue: BoardCellState.Empty)
	}
	
	/**
		Gives you the option of providing a start state for this board.
	*/
	init(board: Board)
	{
		self.cells = board.cells
	}
	
	//	MARK: Score
	
	/**
		Counts the number of cells that match the condition as determined in the given function.
	*/
	func countMatches(function: (BoardLocation) -> Bool) -> Int
	{
		var count = 0
		
		cellVisitor {if function($0) { count++ } }
		
		return count
	}
	
	//	MARK: Subscripting
	
	subscript(location: BoardLocation) -> BoardCellState
	{
		get
		{
			assert(isWithinBounds(location), "Row or column index out of bounds.")
			return self.cells[location.row * self.boardSize + location.column]
		}
		set
		{
			assert(isWithinBounds(location), "Row or column index out of bounds.")
			self.cells[location.row * self.boardSize + location.column] = newValue
			self.delegates.invokeDelegates { $0.cellStateChanged(location) }
		}
	}
	
	subscript(row: Int, column: Int) -> BoardCellState
	{
		get
		{
			return self[BoardLocation(row: row, column: column)]
		}
		set
		{
			self[BoardLocation(row: row, column: column)] = newValue
		}
	}
	
	//	MARK: Validation
	
	func isWithinBounds(location: BoardLocation) -> Bool
	{
		let isWithinRowBounds = location.row >= 0 && location.row < self.boardSize
		let isWithinColumnBounds = location.column >= 0 && location.column < self.boardSize
		
		return isWithinRowBounds && isWithinColumnBounds
	}
}
//
//  ReversiBoard.swift
//  Reversi
//
//  Created by James Valaitis on 10/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation

class ReversiBoard: Board
{
	//	MARK: Private Properties: State
	
	private (set) var blackScore = 0, whiteScore = 0
	private (set) var nextMove = BoardCellState.White
	private (set) var gameHasFinished = false
	private let reversiBoardDelegates = DelegateMulticast<ReversiBoardDelegate>()
	
	//	MARK: Delegates
	
	func addDelegate(delegate: ReversiBoardDelegate)
	{
		self.reversiBoardDelegates.addDelegate(delegate)
	}
	
	//	MARK: Initialisation
	
	override init()
	{
		super.init()
	}
	
	init(reversiBoard: ReversiBoard)
	{
		super.init(board: reversiBoard)
		
		self.nextMove = reversiBoard.nextMove
		
		self.blackScore = reversiBoard.blackScore
		self.whiteScore = reversiBoard.whiteScore
	}
	
	func setInitialState()
	{
		clearBoard()
		
		super[3, 3] = .White
		super[4, 4] = .White
		super[3, 4] = .Black
		super[4, 3] = .Black
		
		self.blackScore = 2
		self.whiteScore = 2
	}
	
	//	MARK: Game Logic
	
	private func checkIfGameHasFinished() -> Bool
	{
		return !canPlayerMakeMove(.Black) && !canPlayerMakeMove(.White)
	}
	
	private func canPlayerMakeMove(toState: BoardCellState) -> Bool
	{
		return anyCellsMatchCondition { self.isValidMove($0, toState: toState) }
	}
	
	private func flipOpponentsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState)
	{
		//	validate move
		if !moveSurroundsCounters(location, direction: direction, toState: toState)
		{
			return
		}
		
		let opponentsState = toState.invert()
		var currentState = BoardCellState.Empty
		var currentLocation = location
		
		//	flip counters until edge of board is reached or a piece with the current state is reached
		do
		{
			currentLocation = direction.move(currentLocation)
			currentState = self[currentLocation]
			self[currentLocation] = toState
		} while isWithinBounds(currentLocation) && currentState == opponentsState
	}
	
	func makeMove(location: BoardLocation)
	{
		self[location] = self.nextMove
		
		for direction in MoveDirection.directions
		{
			flipOpponentsCounters(location, direction: direction, toState: self.nextMove)
		}
		
		switchTurns()
		
		//	check if game is over
		self.gameHasFinished = checkIfGameHasFinished()
		
		//	count the score
		self.whiteScore = countMatches { self[$0] == .White }
		self.blackScore = countMatches { self[$0] == .Black }
		
		//	tell the delegates that stuff has gone down
		self.reversiBoardDelegates.invokeDelegates { $0.boardStateChanged() }
	}
	
	/**
		Determines whether a move to a location will surround one or more of the opponent's pieces.
	*/
	func moveSurroundsCounters(location: BoardLocation, direction: MoveDirection, toState: BoardCellState) -> Bool
	{
		var index = 1
		var currentLocation = direction.move(location)
		
		while isWithinBounds(currentLocation)
		{
			let currentState = self[currentLocation]
			
			//	immediate neighbours must be the opponent's colour
			if index == 1
			{
				if currentState != toState.invert()
				{
					return false
				}
			}
			
			//	if the player's colour is reached, the move is valid
			else
			{
				if currentState == toState
				{
					return true
				}
				
					
				//	if an empty cell is reached, give up
				else if currentState == BoardCellState.Empty
				{
					return false
				}
			}
			
			index++
			
			//	move to the next cell
			currentLocation = direction.move(currentLocation)
		}
		
		return false
	}
	
	func switchTurns()
	{
		var intendedNextMove = self.nextMove.invert()
		
		//	only switch turns if player can make a move
		if canPlayerMakeMove(intendedNextMove)
		{
			self.nextMove = intendedNextMove
		}
	}
	
	//	MARK: Validation
	
	func isValidMove(location: BoardLocation) -> Bool
	{
		return isValidMove(location, toState: self.nextMove)
	}
	
	func isValidMove(location: BoardLocation, toState: BoardCellState) -> Bool
	{
		let isCurrentlyEmpty = self[location] == BoardCellState.Empty
		var isSurroundedAppropriately = false
		for direction in MoveDirection.directions
		{
			if moveSurroundsCounters(location, direction: direction, toState: toState)
			{
				isSurroundedAppropriately = true
			}
		}
		
		return isCurrentlyEmpty && isSurroundedAppropriately
	}
}
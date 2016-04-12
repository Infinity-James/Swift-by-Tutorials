//
//  ComputerOpponent.swift
//  Reversi
//
//  Created by James Valaitis on 17/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Computer Opponent Class

class ComputerOpponent
{
	//	MARK: Private Properties - State
	
	private let reversiBoard: ReversiBoard
	private let colour: BoardCellState
	
	//	MARK: Convenience Methods
	
	func delay(delay: Double, closure: ()->())
	{
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
		
		dispatch_after(time, dispatch_get_main_queue(), closure)
	}
	
	//	MARK: Initialisation
	
	init(reversiBoard: ReversiBoard, colour: BoardCellState)
	{
		self.reversiBoard = reversiBoard
		self.colour = colour
		
		self.reversiBoard.addDelegate(self)
	}
	
	//	MARK: Game Logic
	
	private func makeNextMove()
	{
		var bestScore = Int.min
		var bestLocation: BoardLocation?
		
		self.reversiBoard.cellVisitor
		{
			location in
			
			if self.reversiBoard.isValidMove(location)
			{
				let score = self.scoreForMove(location)
				if score > bestScore
				{
					bestScore = score
					bestLocation = location
				}
			}
			
			if bestScore > Int.min
			{
				self.reversiBoard.makeMove(bestLocation!)
			}
		}
	}
	
	private func scoreForMove(location: BoardLocation) -> Int
	{
		let testBoard = ReversiBoard(reversiBoard: self.reversiBoard)
		
		testBoard.makeMove(location)
		let score = self.colour == .White ? testBoard.whiteScore - testBoard.blackScore :
											testBoard.blackScore - testBoard.whiteScore
		
		return score
	}
}

//	MARK: Computer Opponent Extension - Reversi Board Delegate

extension ComputerOpponent: ReversiBoardDelegate
{
	//	MARK: ReversiBoardDelegate Methods
	
	func boardStateChanged()
	{
		if self.reversiBoard.nextMove == self.colour
			{
				delay(1.0)
				{
					self.makeNextMove()
				}
		}
	}
}
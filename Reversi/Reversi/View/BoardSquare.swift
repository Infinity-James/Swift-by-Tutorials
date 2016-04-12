//
//  BoardSquare.swift
//  Reversi
//
//  Created by James Valaitis on 10/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation
import UIKit

//	MARK: Board Square Class

class BoardSquare: UIView
{
	//	MARK: Private Properties - State
	
	private let board: ReversiBoard
	private let location: BoardLocation
	
	//	MARK: Private Properties - Subviews
	
	private let blackView: UIImageView
	private let whiteView: UIImageView
	
	//	MARK: Gesture
	
	func cellTapped()
	{
		if self.board.isValidMove(self.location)
		{
			self.board.makeMove(self.location)
		}
	}
	
	//	MARK: Initialisation
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented.")
	}
	
	init(frame: CGRect, location: BoardLocation, board: ReversiBoard)
	{
		self.board = board
		self.location = location
		
		let blackImage = UIImage(named: "Black Piece")
		self.blackView = UIImageView(image: blackImage)
		self.blackView.alpha = 0.0
		
		let whiteImage = UIImage(named: "White Piece")
		self.whiteView = UIImageView(image: whiteImage)
		self.whiteView.alpha = 0.0
		
		super.init(frame: frame)
		
		self.backgroundColor = UIColor.clearColor()
		
		addSubview(self.blackView)
		addSubview(self.whiteView)
		
		update()
		
		self.board.addDelegate(self)
		
		let tapRecogniser = UITapGestureRecognizer(target: self, action: "cellTapped")
		addGestureRecognizer(tapRecogniser)
	}
	
	//	MARK: State Methods
	
	private func update()
	{
		let state = self.board[self.location]
		
		UIView.animateWithDuration(0.2)
		{
			switch state
			{
			case .White:
				self.whiteView.alpha = 1.0
				self.blackView.alpha = 0.0
				self.whiteView.transform = CGAffineTransformIdentity
				self.blackView.transform = CGAffineTransformMakeTranslation(0.0, 20.0)
				
			case .Black:
				self.whiteView.alpha = 0.0
				self.blackView.alpha = 1.0
				self.whiteView.transform = CGAffineTransformMakeTranslation(0.0, 20.0)
				self.blackView.transform = CGAffineTransformIdentity
				
			case .Empty:
				self.whiteView.alpha = 0.0
				self.blackView.alpha = 0.0
			}
		}
		
		self.whiteView.alpha = state == .White ? 1.0 : 0.0
		self.blackView.alpha = state == .Black ? 1.0 : 0.0
	}
}

//	MARK: Board Square Extension - Board Delegate

extension BoardSquare: BoardDelegate
{
	//	MARK: BoardDelegate Methods
	
	func cellStateChanged(location: BoardLocation)
	{
		if self.location == location
		{
			update()
		}
	}
}
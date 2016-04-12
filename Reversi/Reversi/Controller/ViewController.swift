//
//  ViewController.swift
//  Reversi
//
//  Created by James Valaitis on 08/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import UIKit

//	MARK: View Controller

class ViewController: UIViewController
{
	//	MARK: Private Properties - State
	
	private let computer: ComputerOpponent
	private let reversiBoard = ReversiBoard()
	
	//	MARK: Private Properties - Subviews
	
	@IBOutlet private var blackScoreLabel: UILabel!
	@IBOutlet private var whiteScoreLabel: UILabel!
	
	@IBOutlet private var restartButton: UIButton!
	
	//	MARK: Action
	
	@IBAction func restartTapped()
	{
		if self.reversiBoard.gameHasFinished
		{
			self.reversiBoard.setInitialState()
			boardStateChanged()
		}
	}
	
	//	MARK: Initialisation
	
	required init(coder aDecoder: NSCoder)
	{
		self.reversiBoard.setInitialState()
		self.computer = ComputerOpponent(reversiBoard: self.reversiBoard, colour: .Black)
		
		super.init(coder: aDecoder)
		
		self.reversiBoard.addDelegate(self)
	}
	
	//	MARK: View Lifecycle
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let boardFrame = CGRect(x: 88.0, y: 152.0, width: 600.0, height: 600.0)
		let boardView = ReversiBoardView(frame: boardFrame, reversiBoard: self.reversiBoard)
		self.view.addSubview(boardView)
		
		boardStateChanged()
	}
}

//	MARK: View Controller Reversi Board Methods

extension ViewController: ReversiBoardDelegate
{
	//	MARK: ReversiBoardDelegate Methods
	
	func boardStateChanged()
	{
		self.blackScoreLabel.text = "\(self.reversiBoard.blackScore)"
		self.whiteScoreLabel.text = "\(self.reversiBoard.whiteScore)"
		
		self.restartButton.hidden = !self.reversiBoard.gameHasFinished
	}
}
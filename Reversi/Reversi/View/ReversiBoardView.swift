//
//  ReversiBoardView.swift
//  Reversi
//
//  Created by James Valaitis on 10/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation
import UIKit

class ReversiBoardView: UIView
{
	//	MARK: Initialisation
	
	required init(coder aDecoder: NSCoder)
	{
		fatalError("init(coder:) has not been implemented.")
	}
	
	init(frame: CGRect, reversiBoard: ReversiBoard)
	{
		super.init(frame: frame)
		
		let rowHeight = CGRectGetHeight(frame) / CGFloat(reversiBoard.boardSize)
		let columnWidth = CGRectGetWidth(frame) / CGFloat(reversiBoard.boardSize)
		
		reversiBoard.cellVisitor
		{
			location in
			
			let left = CGFloat(location.column) * columnWidth
			let top = CGFloat(location.row) * rowHeight
			let boardSquareFrame = CGRect(x: left, y: top, width: columnWidth, height: rowHeight)
			
			let boardSquare = BoardSquare(frame: boardSquareFrame, location: location, board: reversiBoard)
			self.addSubview(boardSquare)
		}
	}
}
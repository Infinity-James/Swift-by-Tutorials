//
//  BoardLocation.swift
//  Reversi
//
//  Created by James Valaitis on 09/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation

//	MARK: Board Location Struct

struct BoardLocation
{
	//	MARK: Public Properties - Location
	
	let row: Int, column: Int
	
	//	MARK: Initialisation
	
	init(row: Int, column: Int)
	{
		self.row = row
		self.column = column
	}
}

//	MARK: Board Location Extension - Equatable

extension BoardLocation: Equatable
{
}

//	MARK: Equatable Methods

func == (lhs: BoardLocation, rhs: BoardLocation) -> Bool
{
	let equalRow = lhs.row == rhs.row
	let equalColumn = lhs.column == lhs.column
	
	return equalRow && equalColumn
}
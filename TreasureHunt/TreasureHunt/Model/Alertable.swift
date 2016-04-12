//
//  Alertable.swift
//  TreasureHunt
//
//  Created by James Valaitis on 04/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Alertable Protocol Declaration

@objc protocol Alertable
{
	func alert() -> UIAlertController
}
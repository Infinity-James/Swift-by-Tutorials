//
//  ViewController.swift
//  MemoryLeakTest
//
//  Created by James Valaitis on 26/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let person = Person(name: "Bob")
		person.performAction()
	}
}
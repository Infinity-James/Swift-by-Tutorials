//
//  CafeViewController.swift
//  CafeHunter
//
//  Created by James Valaitis on 07/04/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import UIKit

//	MARK Cafe View Controller Delegate Declaration

@objc protocol CafeViewControllerDelegate
{
	optional func cafeViewControllerDidFinish(cafeViewController: CafeViewController)
}

//	MARK: Cafe View Controller Class

class CafeViewController: UIViewController
{
	//	MARK: Private Properties - Subviews
	
	@IBOutlet private var cityLabel: UILabel!
	@IBOutlet private var imageView: UIImageView!
	@IBOutlet private var nameLabel: UILabel!
	@IBOutlet private var streetLabel: UILabel!
	@IBOutlet private var zipLabel: UILabel!
	
	//	MARK: Public Properties - Objects
	
	var cafe: Cafe?
	{
		didSet
		{
			self.configureWithCafe()
		}
	}
	
	weak var delegate: CafeViewControllerDelegate?
	
	//	MARK: Action Methods
	
	@IBAction private func back(backButton: UIButton)
	{
		self.delegate?.cafeViewControllerDidFinish?(self)
	}
	
	//	MARK: Café Management
	
	private func configureWithCafe()
	{
		if !self.isViewLoaded()
		{
			return
		}
		
		if let cafe = self.cafe
		{
			self.title = cafe.name
			
			self.nameLabel.text = cafe.name
			self.streetLabel.text = cafe.street
			self.cityLabel.text = cafe.city
			self.zipLabel.text = cafe.zip
			
			let request = NSURLRequest(URL: cafe.pictureURL)
			let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request)
				{
					(data, response, error) -> Void in
					
					let image = UIImage(data: data)
					self.imageView.image = image
			}
		}
	}
	
	//	MARK: View Lifecycle
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.configureWithCafe()
	}
}
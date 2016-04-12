//
//  ImageCollectionViewCell.swift
//  FlickrSearch
//
//  Created by James Valaitis on 12/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Image Collection View Cell Implementation

class ImageCollectionViewCell: UICollectionViewCell
{
	//	MARK: Private Properties - Subviews
	
	@IBOutlet private var imageView: UIImageView!
	
	//	MARK: Public Properties - Appearance
	
	/**	The image to be shown in the cell.	*/
	var image: UIImage?
	{
		set (image)
		{
			self.imageView.image = image
		}
		
		get
		{
			return self.imageView.image
		}
	}
}

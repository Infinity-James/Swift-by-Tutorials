//
//  DetailViewController.swift
//  FlickrSearch
//
//  Created by James Valaitis on 12/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Detail View Contoller Implementatiom

class DetailViewController: UIViewController
{
	//	MARK: Private Properties - Constants
	
	private let cellIdentifier = "FlickrImageCell"
	
	//	MARK: Private Properties - Subviews
	
	@IBOutlet private var collectionView: UICollectionView!
	
	//	MARK: Public Properties - State
	
	var photos: [Flickr.Photo] = []
}

//	MARK: Detail View Controller: UICollectionViewDataSource

extension DetailViewController: UICollectionViewDataSource
{
	//	MARK: UICollectionViewDataSource Methods
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return self.photos.count
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
	{
		let imageCell = collectionView.dequeueReusableCellWithReuseIdentifier(self.cellIdentifier, forIndexPath: indexPath) as ImageCollectionViewCell
		
		let photo = self.photos[indexPath.row]
		
		photo.loadImage(true)
		{
			switch $0
			{
				case .Error:
					break
				case .Image(let image):
					imageCell.image = image
			}
		}
		
		return imageCell
	}
}

//	MARK: Detail View Controller: UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate
{
	//	MARK: UICollectionViewDelegate Methods
}
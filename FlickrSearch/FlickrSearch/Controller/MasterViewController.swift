//
//  ViewController.swift
//  FlickrSearch
//
//  Created by James Valaitis on 12/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import UIKit

//	MARK: Master View Controller Implementation

class MasterViewController: UIViewController
{
	//	MARK: Private Properties - Constants
	
	private let cellIdentifier = "FlickrCell"
	
	//	MARK: Private Properties - Subviews
	
	@IBOutlet private var tableView: UITableView!
	@IBOutlet private var searchBar: UISearchBar!
	
	//	MARK: Private Properties - State
	
	private var searches = OrderedDictionary<String, [Flickr.Photo]>()
	
	//	MARK: Editing Behaviour Methods
	
	override func setEditing(editing: Bool, animated: Bool)
	{
		super.setEditing(editing, animated: animated)
		self.tableView.setEditing(editing, animated: animated)
	}
	
	//	MARK: Segue Methods
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		if segue.identifier == "showDetail"
		{
			if let indexPath = self.tableView.indexPathForSelectedRow()
			{
				let (_, photos) = self.searches[indexPath.row]!
				(segue.destinationViewController as DetailViewController).photos = photos
			}
		}
	}
	
	//	MARK: View Lifecycle
	
	override func viewWillAppear(animated: Bool)
	{
		super.viewWillAppear(animated)
		
		if let selectedIndexPath = self.tableView.indexPathForSelectedRow()
		{
			self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
		}
		
		self.navigationItem.leftBarButtonItem = self.editButtonItem()
	}
}

//	MARK: Master View Controller Extension - UITableViewDataSource

extension MasterViewController: UITableViewDataSource
{
	//	MARK: UITableViewDataSource Methods
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return self.searches.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier, forIndexPath: indexPath) as UITableViewCell
		
		let (searchTerm, photos) = self.searches[indexPath.row]!
		
		if let textLabel = cell.textLabel
		{
			textLabel.text = "\(searchTerm) (\(photos.count))"
		}
		
		return cell
	}
}

//	MARK: Master View Controller Extension - UITableViewDelegate

extension MasterViewController: UITableViewDelegate
{
	//	MARK: UITableViewDelegate Methods
	
	func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
	{
		return true
	}
	
	func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
	{
		switch editingStyle
		{
			case .Delete:
				self.searches.removeAtIndex(indexPath.row)
				tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
			case .Insert:
				break
			case .None:
				break
			
		}
	}
}

//	MARK: Master View Controller Extension - UISearchBarDelegate

extension MasterViewController: UISearchBarDelegate
{
	//	MARK: UISearchBarDelegate Methods
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar!)
	{
		searchBar.resignFirstResponder()
		
		let searchTerm = searchBar.text
		Flickr.search(searchTerm)
		{
			searchResult in
			
			switch searchResult
			{
				case .Error:
					break
				
				//	get the resulting photos out of the search result
				case .Results(let results):
					//	insert photos into searches under the search term and reload the table with it
					self.searches.insert(results, forKey: searchTerm, atIndex: 0)
					self.tableView.reloadData()
			}
		}
	}
}
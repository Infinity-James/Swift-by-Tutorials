//
//  ViewController.swift
//  TreasureHunt
//
//  Created by James Valaitis on 20/09/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import MapKit
import UIKit

//	MARK: View Controller Implementation

class ViewController: UIViewController
{
	//	MARK: Private Properties - Subviews
	
	@IBOutlet private var mapView: MKMapView!
	
	//	MARK: rivate Properties - State
	
	private var foundLocations: [GeoLocation] = []
	private var polyline: MKPolyline!
	private var treasures: [Treasure] = []
	
	//	MARK: View Lifecycle
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		//	set up hard-coded treasures
		
		let googleOfficeTreasure = HistoryTreasure(what: "Google's First Office", year: 1999, latitude: 37.44451, longitude: -122.163369)
		let facebookOfficeTreasure = HistoryTreasure(what: "Facebook's First Office", year: 2005, latitude: 37.444268, longitude: -122.163271)
		
		let stanfordUniTreasure = FactTreasure(what: "Stanford University", fact: "Founded in 1885 by Leland Stanford", latitude: 37.427474, longitude: -122.169719)
		let mosconeWestTreasure = FactTreasure(what: "Moscone West", fact: "Hot to WWDC since 2003", latitude: 37.783083, longitude: -122.404025)
		let csMuseumTreasure = FactTreasure(what: "Computer Science Museum", fact: "Home to a working Babbage Difference Engine", latitude: 37.414371, longitude: -122.076817)
		
		let appleHQTreasure = HQTreasure(company: "Apple", latitude: 37.331741, longitude: -122.030333)
		let facebookHQTreasure = HQTreasure(company: "Facebook", latitude: 37.485955, longitude: -122.14855)
		let googleHQTreasure = HQTreasure(company: "Google", latitude: 37.422, longitude: -122.084)
		
		self.treasures = [googleOfficeTreasure, facebookOfficeTreasure, stanfordUniTreasure, mosconeWestTreasure, csMuseumTreasure, appleHQTreasure, facebookHQTreasure, googleHQTreasure]
		
		//	set up map view
		
		self.mapView.addAnnotations(self.treasures)
		self.mapView.setVisibleMapRect(self.bestRectToDisplayTreasures(), edgePadding: UIEdgeInsetsMake(74.0, 10.0, 10.0, 10.0), animated: false)
	}
	
	/**
		Convenient way to get a general area to display given the list of treasures being displayed on the map.
		
		:return:	An area on an MKMapView to display which best encompasses the most pins.
	*/
	private func bestRectToDisplayTreasures() -> MKMapRect
	{
		let rectToDisplay = self.treasures.reduce(MKMapRectNull)
		{
			(mapRect: MKMapRect, treasure: Treasure) -> MKMapRect in
			
			let treasurePointRect = MKMapRect(origin: treasure.location.mapPoint, size: MKMapSize(width: 0.0, height: 0.0))
			
			return MKMapRectUnion(mapRect, treasurePointRect)
		}
		
		return rectToDisplay
	}
	
	/**
		Marks a given treasure as found by the user.
	
		:param	treasure	The tresure to mark as found.
	*/
	private func markTreasureAsFound(treasure: Treasure)
	{
		if let index = find(self.foundLocations, treasure.location)
		{
			let alert = UIAlertController(title: "Hmm", message: "You've already found this treasure (at step \(index + 1)).", preferredStyle: .Alert)
			alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
		
		else
		{
			self.foundLocations.append(treasure.location)
			
			if self.polyline != nil
			{
				self.mapView.removeOverlay(self.polyline)
			}
			
			var coordinates = self.foundLocations.map
			{
				$0.coordinate
			}
			
			self.polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
			self.mapView.addOverlay(self.polyline)
		}
	}
}

//	MARK: View Controller Extension - MKMapViewDelegate

extension ViewController: MKMapViewDelegate
{
	func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!)
	{
		if let treasure = view.annotation as? Treasure
		{
			if let alertable = treasure as? Alertable
			{
				let alert = alertable.alert()
				alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
				alert.addAction(UIAlertAction(title: "Find Nearest", style: .Default)
				{
					action in
					
					var sortedTreasures = self.treasures
					sortedTreasures.sort
					{
						treasureA, treasureB in
						
						let distanceA = treasure.location.distanceBetween(treasureA.location)
						let distanceB = treasure.location.distanceBetween(treasureB.location)
						
						return distanceA < distanceB
						
					}
					
					mapView.deselectAnnotation(treasure, animated: true)
					mapView.selectAnnotation(sortedTreasures[1], animated: true)
				})
				alert.addAction(UIAlertAction(title: "Found", style: .Default)
				{
					action in
					
					self.markTreasureAsFound(treasure)
				})
				self.presentViewController(alert, animated: true, completion: nil)
			}
		}
	}
	
	func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer!
	{
		if let polylineOverlay = overlay as? MKPolyline
		{
			let renderer = MKPolylineRenderer(polyline: polylineOverlay)
			renderer.strokeColor = UIColor.blueColor()
			return renderer
		}
		
		return nil
	}
	
	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!
	{
		if let treasure = annotation as? Treasure
		{
			var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as MKPinAnnotationView!
			
			//	if no view was dequeued we create one from scratch
			if view == nil
			{
				view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
				view.canShowCallout = true
				view.animatesDrop = false
				view.calloutOffset = CGPoint(x: -5.0, y: 5.0)
				view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
			}
				
				//	if a view was dequeued, we configure it with the correct annotation
			else
			{
				view.annotation = annotation
			}
			
			view.pinColor = treasure.pinColor()
			
			return view
		}
		
		//	if the annotation was nil, we can only return nil
		return nil
	}
}
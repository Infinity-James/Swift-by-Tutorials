//
//  ViewController.swift
//  CafeHunter
//
//  Created by James Valaitis on 23/11/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import MapKit
import UIKit

//	MARK: View Controller Class

class ViewController: UIViewController
{
	//	MARK: Private Properties: Constants
	
	let cafeViewControllerIdentifier = "Cafe View"
	let searchDistance: CLLocationDistance = 1000
	
	//	MARK: Private Properties: State
	
	/**	An array of nearby cafes	*/
	private var cafes = [Cafe]()
	/**	The last recorded location.	*/
	private var lastLocation: CLLocation?
	/**	The manager of the location.	*/
	private var locationManager = CLLocationManager()
	
	//	MARK: Private Properties: Subviews
	
	/**	A view which allows the user ot log in to Facebook.	*/
	@IBOutlet private var loginView: FBLoginView!
	/**	The map view that displays the café locations.	*/
	@IBOutlet private var mapView: MKMapView!
	
	//	MARK: Café Mwthods
	
	private func fetchCafesAroundLocation(location: CLLocation)
	{
		if !FBSession.activeSession().isOpen
		{
			let alert = UIAlertController(title: "Log In!", message: "To continue you will need to log in to Facebook.", preferredStyle: .Alert)
			alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
			
			return
		}
		
		//	construct the URL to ask Facebook for cafes in the area
		var URLString = "https://graph.facebook.com/v2.0/search/"
		URLString += "?access_token="
		URLString += "\(FBSession.activeSession().accessTokenData.accessToken)"
		URLString += "&type=place"
		URLString += "&q=cafe"
		URLString += "&center=\(location.coordinate.latitude),"
		URLString += "\(location.coordinate.longitude)"
		URLString += "&distance=\(Int(self.searchDistance))"
		
		let URL = NSURL(string: URLString)!
		
		let request = NSURLRequest(URL: URL)
		
		//	execute request
		let dataTask = NSURLSession.sharedSession().dataTaskWithRequest(request)
		{
			(data, response, error) -> Void in
			
			if error != nil
			{
				let alert = UIAlertController(title: "Oops!", message: "An error occured.", preferredStyle: .Alert)
				alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
				self.presentViewController(alert, animated: true, completion: nil)
				
				return
			}
			
			//	deserialise the json
			var error: NSError?
			let jsonObject: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &error)
			
			
			if let jsonObject = jsonObject as? [String: AnyObject]
			{
				if error != nil
				{
					return
				}
				
				if let data = JSONValue.fromObject(jsonObject)?["data"]?.array
				{
					var cafes = [Cafe]()
					for cafeJSON in data
					{
						if let cafeJSON = cafeJSON.object, cafe = Cafe.fromJSON(cafeJSON)
						{
							cafes.append(cafe)
						}
					}
					
					self.mapView.removeAnnotations(self.cafes)
					self.cafes = cafes
					self.mapView.addAnnotations(self.cafes)
				}
			}
		}
		
		dataTask.resume()
	}
	
	//	MARK: Location State
	
	private func checkLocationAuthorizationStatus()
	{
		switch CLLocationManager.authorizationStatus()
		{
			case .AuthorizedWhenInUse:
				self.mapView.showsUserLocation = true
				break;
			default:
				self.locationManager.requestWhenInUseAuthorization()
		}
	}
	
	//	MARK: Map Handling
	
	private func centerMapOnLocation(location: CLLocation)
	{
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.searchDistance, self.searchDistance)
		self.mapView.setRegion(coordinateRegion, animated: true)
	}
	
	func refresh(refreshButton: UIBarButtonItem)
	{
		if let location = self.lastLocation
		{
			self.centerMapOnLocation(location)
			self.fetchCafesAroundLocation(location)
		}
		else
		{
			let alert = UIAlertController(title: "No Location", message: "You do not have a location.", preferredStyle: .Alert)
			alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
			self.presentViewController(alert, animated: true, completion: nil)
		}
	}
	
	//	MARK: View Lifecycle
	
	override func viewDidAppear(animated: Bool)
	{
		super.viewDidAppear(animated)
		
		self.checkLocationAuthorizationStatus()
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.locationManager.delegate = self
		
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh:")
	}
}

//	MARK: View Controller Extension - Core Location

extension ViewController: CLLocationManagerDelegate
{
	//	MARK: CLLocationManagerDelegate Methods
	
	func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus)
	{
		self.checkLocationAuthorizationStatus()
	}
}

//	MARK: View Controller Extension - Map Kit

extension ViewController: MKMapViewDelegate
{
	//	MARK: MKMapViewDelegate Methods
	
	func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!)
	{
		if let cafeViewController = self.storyboard?.instantiateViewControllerWithIdentifier(cafeViewControllerIdentifier) as? CafeViewController, cafe = view.annotation as? Cafe
		{
			cafeViewController.cafe = cafe
			cafeViewController.delegate = self
			self.presentViewController(cafeViewController, animated: true, completion: nil)
		}
	}
	
	func mapView(mapView: MKMapView!, didFailToLocateUserWithError error: NSError!)
	{
		println(error)
		
		let alert = UIAlertController(title: "Failed To Locate You", message: "An error was encountered whilst trying to locate you.", preferredStyle: .Alert)
		alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: nil))
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
	func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!)
	{
		//	retrieve new location and calculate the distance from the last location
		let newLocation = userLocation.location
		let distance = self.lastLocation?.distanceFromLocation(newLocation)
		
		//	if there was no previous distance, or if the user has moved
		if distance == nil || distance! > searchDistance
		{
			self.lastLocation = newLocation
			self.centerMapOnLocation(newLocation)
			self.fetchCafesAroundLocation(newLocation)
		}
	}
	
	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!
	{
		if let cafeAnnotation = annotation as? Cafe
		{
			let reuseIdentifier = "Cafe Pin"
			var annotationView: MKPinAnnotationView
			
			if let dequeuedAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier) as? MKPinAnnotationView
			{
				dequeuedAnnotationView.annotation = cafeAnnotation
				annotationView = dequeuedAnnotationView
			}
			else
			{
				annotationView = MKPinAnnotationView(annotation: cafeAnnotation, reuseIdentifier: reuseIdentifier)
				annotationView.calloutOffset = CGPoint(x: -5.0, y: 5.0)
				annotationView.canShowCallout = true
				annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as? UIView
			}
			
			return annotationView
		}
		
		return nil
	}
}

//	MARK: View Controller Extension - Cafe View Controller

extension ViewController: CafeViewControllerDelegate
{
	//	MARK: CafeViewControllerDelegate Methods
	
	func cafeViewControllerDidFinish(cafeViewController: CafeViewController)
	{
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
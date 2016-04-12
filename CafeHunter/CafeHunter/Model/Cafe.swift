//
//  Cafe.swift
//  CafeHunter
//
//  Created by James Valaitis on 28/02/2015.
//  Copyright (c) 2015 &Beyond. All rights reserved.
//

import Foundation
import MapKit

//	MARK: Cafe Class

class Cafe: NSObject
{
	//	MARK: Public Properties
	
	/**	The city this Caf	*/
	let city: String
	let facebookID: String
	let location: CLLocationCoordinate2D
	let name: String
	let street: String
	let zip: String
	
	//	MARK: Public Properties - Computed
	
	var pictureURL: NSURL
	{
		return NSURL(string: "http://graph.facebook.com/place/piture?id=\(self.facebookID)&type=large")!
	}
	
	init(facebookID: String, name: String, location: CLLocationCoordinate2D, street: String, city: String, zip: String)
	{
		self.city = city
		self.facebookID = facebookID
		self.location = location
		self.name = name
		self.street = street
		self.zip = zip
		
		super.init()
	}
	
	class func fromJSON(json: [String: JSONValue]) -> Cafe?
	{
		let facebookID = json["id"]?.string
		let name = json["name"]?.string
		let locationObject = json["location"]?.object
		let latitude = locationObject?["latitude"]?.double
		let longitude = locationObject?["longitude"]?.double
		
		if facebookID != nil && name != nil && latitude != nil && longitude != nil
		{
			var street = ""
			if let maybeStreet = locationObject?["street"]?.string
			{
				street = maybeStreet
			}
			
			var city = ""
			if let maybeCity = locationObject?["street"]?.string
			{
				city = maybeCity
			}
			
			var zip = ""
			if let maybeZIP = locationObject?["zip"]?.string
			{
				zip = maybeZIP
			}
			
			let location = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
			
			return Cafe(facebookID: facebookID!, name: name!, location: location, street: street, city: city, zip: zip)
		}
		
		return nil
	}
}

//	Cafe Extension - MKAnnotation Protocol

extension Cafe: MKAnnotation
{
	var title: String!
	{
		return self.name
	}
	
	var coordinate: CLLocationCoordinate2D
	{
		return self.location
	}
}
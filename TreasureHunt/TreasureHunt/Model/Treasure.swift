//
//  Treasure.swift
//  TreasureHunt
//
//  Created by James Valaitis on 04/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import Foundation
import MapKit

//  MARK: Treasure Implementation

class Treasure: NSObject
{
	//  MARK: Public Properties
	
	let location: GeoLocation
	let what: String
	
	//	MARK: Initialisation
	
	init(what: String, location: GeoLocation)
	{
		self.what = what
		self.location = location
	}
	
	convenience init(what: String, latitude: Double, longitude: Double)
	{
		let location = GeoLocation(latitude: latitude, longitude: longitude)
		
		self.init(what: what, location: location)
	}
	
	//	MARK: Appearance
	
	func pinColor() -> MKPinAnnotationColor
	{
		return MKPinAnnotationColor.Red
	}
}

//	MARK: Treasure Extension - MKAnnotation

extension Treasure: MKAnnotation
{
	var coordinate: CLLocationCoordinate2D
	{
		return self.location.coordinate
	}
	
	var title: String
	{
		return self.what
	}
}

// MARK: History Treasure Implementation

final class HistoryTreasure: Treasure
{
	let year: Int
	
	//	MARK: Initialisation
	
	init(what: String, year: Int, location: GeoLocation)
	{
		self.year = year
		
		super.init(what: what, location: location)
	}
	
	convenience init(what: String, year: Int, latitude: Double, longitude: Double)
	{
		let location = GeoLocation(latitude: latitude, longitude: longitude)
		
		self.init(what: what, year: year, location: location)
	}
	
	//	MARK: Appearance
	
	override func pinColor() -> MKPinAnnotationColor
	{
		return MKPinAnnotationColor.Purple
	}
}

//	MARK: Fact Treasure Implementation

final class FactTreasure: Treasure
{
	let fact: String
	
	//	MARK: Initialisation
	
	init(what: String, fact: String, location: GeoLocation)
	{
		self.fact = fact
		
		super.init(what: what, location: location)
	}
	
	convenience init(what: String, fact: String, latitude: Double, longitude: Double)
	{
		let location = GeoLocation(latitude: latitude, longitude: longitude)
		
		self.init(what: what, fact: fact, location: location)
	}
}

//	MARK: HQ Treasure Implementation

final class HQTreasure: Treasure
{
	let company: String
	
	//	MARK: Initialisation
	
	init(company: String, location: GeoLocation)
	{
		self.company = company
		
		super.init(what: company + " Headquarters", location: location)
	}
	
	convenience init(company: String, latitude: Double, longitude: Double)
	{
		let location = GeoLocation(latitude: latitude, longitude: longitude)
		
		self.init(company: company, location: location)
	}
	
	//	MARK: Appearance
	
	override func pinColor() -> MKPinAnnotationColor
	{
		return MKPinAnnotationColor.Green
	}
}

//	MARK: History Treasure Extension - Alertable

extension HistoryTreasure: Alertable
{
	func alert() -> UIAlertController
	{
		let alert = UIAlertController(title: "History", message: "From \(self.year):\n\(self.what)", preferredStyle: .Alert)
		
		return alert
	}
}

//	MARK: Fact Treasure Extension - Alertable

extension FactTreasure: Alertable
{
	func alert() -> UIAlertController
	{
		let alert = UIAlertController(title: "Fact", message: "\(self.what):\n\(self.fact)", preferredStyle: .Alert)
		
		return alert
	}
}

//	MARK: HQ Treasure Extension - Alertable


extension HQTreasure: Alertable
	{
	func alert() -> UIAlertController
	{
		let alert = UIAlertController(title: "Headquarters", message: "The headquarters of \(self.company)", preferredStyle: .Alert)
		
		return alert
	}
}
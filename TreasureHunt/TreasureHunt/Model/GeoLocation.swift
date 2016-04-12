//
//  GeoLocation.swift
//  TreasureHunt
//
//  Created by James Valaitis on 04/10/2014.
//  Copyright (c) 2014 &Beyond. All rights reserved.
//

import Foundation
import MapKit

//	MARK: GeoLocation Implementation

struct GeoLocation
{
	//	MARK: Public Properties
	
	var latitude: Double
	var longitude: Double
	
	//	MARK: Math
	
	/**
		Returns the distance between the two GeoLocations in metres.
		
		:param:	other	The GeoLocation to calculate the distance from this GeoLocation.
	
		:return:	The distance between the two GeoLocations in metres.
	*/
	func distanceBetween(other: GeoLocation) -> Double
	{
		let locationA = CLLocation(latitude: self.latitude, longitude: self.longitude)
		let locationB = CLLocation(latitude: other.latitude, longitude: other.longitude)
		
		return locationA.distanceFromLocation(locationB)
	}
}

//	MARK: GeoLocation Extension - MapKit Conforming

extension GeoLocation
{
	//	MARK: Public Properties
	
	/**	A CLLocationCoordinate2D constructed from the the latitude and longitude.	*/
	var coordinate: CLLocationCoordinate2D
	{
		return CLLocationCoordinate2DMake(self.latitude, self.longitude)
	}
	
	/**	A map point constructed from the co-ordinate.	*/
	var mapPoint: MKMapPoint
	{
		return MKMapPointForCoordinate(self.coordinate)
	}
}

//	MARK: GeoLocation Extension - Equatable

extension GeoLocation: Equatable
{
}

func == (lhs: GeoLocation, rhs: GeoLocation) -> Bool
{
	return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}
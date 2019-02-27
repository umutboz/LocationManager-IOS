//
//  CLLocation+Distance.swift
//  LocationManagerSampleApp
//
//  Created by umut on 26.02.2019.
//  Copyright © 2019 Koçsistem. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    
    public func dinstanceInMeters(otherLocation : CLLocation) -> Double{
        let distanceInMeters = self.distance(from: otherLocation)
        return Double(distanceInMeters)
    }
    
    public func dinstanceInMiles(otherLocation : CLLocation) -> Double{
        let distanceInMeters = self.distance(from: otherLocation)
        return distanceInMeters / 1609.344
    }
    
    public func dinstanceInKm(otherLocation : CLLocation) -> Double{
        let distanceInMeters = self.distance(from: otherLocation)
        return distanceInMeters / 1000
    }
    
    public func dinstanceInKm( otherLocationLatitudee : Double, otherLocationLongitude : Double) -> Double{
       let otherLocation = CLLocation(latitude: otherLocationLatitudee, longitude: otherLocationLongitude)
       let distanceInMeters = self.distance(from: otherLocation)
       return toKm(distance: distanceInMeters)
    }
    public func dinstanceInMiles( otherLocationLatitudee : Double, otherLocationLongitude : Double) -> Double{
        let otherLocation = CLLocation(latitude: otherLocationLatitudee, longitude: otherLocationLongitude)
        let distanceInMeters = self.distance(from: otherLocation)
        return toMiles(distance: distanceInMeters)
    }
    public func dinstanceInMeters( otherLocationLatitudee : Double, otherLocationLongitude : Double) -> Double{
        let otherLocation = CLLocation(latitude: otherLocationLatitudee, longitude: otherLocationLongitude)
        let distanceInMeters = self.distance(from: otherLocation)
        return Double(distanceInMeters)
    }
    
    
    func toKm(distance :  CLLocationDistance)->Double{
        return distance / 1000
    }
    func toMiles(distance :  CLLocationDistance)->Double{
        return distance /  1609.344
    }
    
}

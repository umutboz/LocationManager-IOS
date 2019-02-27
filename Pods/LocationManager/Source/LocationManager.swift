//
//  LocationManager.swift
//  LocationManager
//
//  Created by umut on 22.02.2019.
//  Copyright © 2019 Koçsistem. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

public   typealias LocationProgressBlock = ((_ latitude:Double, _ longitude:Double, _ accuracy:Double,  _ locationObject:CLLocation)->())?
public class LocationManager: NSObject, CLLocationManagerDelegate  {
    
    static let shared = LocationManager()
    
    //Used to get a location from an address
    let GOOGLE_PLACES_API_KEY = "000000000000000000"
    
    //recursive
    var LOCATION_TIMER_IS_RECURSIVE : Bool = false
    
    //desired accuracy
    var LOCATION_ACCURACY : Double = 30.0
    
    //Location updates will end at this time
    var LOCATION_STOP_TIMER_LENGTH_IN_SECONDS : Double = 10.0
    var locationTimer : Timer?
    
    
    
    
    //tracks last location and # of location updates
    var lastKnownLocation : CLLocation?
    var updateCount = 0
    var progressBlock : LocationProgressBlock
    var completeBlock : LocationProgressBlock
    var failUpdateBlock : ((_ error:NSError)->())?
    
    
    //Location management
     var locationManager : CLLocationManager
    
    //Singleton
    class var sharedInstance: LocationManager {
        return shared
    }
    
    /*
     Convenience accessor to the last location
     */
    class func lastLocation() -> CLLocationCoordinate2D{
        let manager = LocationManager.sharedInstance
        let lastKnown = manager.lastKnownLocation
        return lastKnown!.coordinate
    }
    
    private override init() {
        
        self.locationManager = CLLocationManager()
        //config the location manager
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.distanceFilter = LOCATION_ACCURACY
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, location.horizontalAccuracy >= 0 else { return }
        //kordinatları güncelle
        let (loc, wasBetter) = mostAccurateLocation(newLocation: location)
        
        //kullanıcıyı yalnızca konum daha iyiyse güncelle
        if wasBetter {
            let lat = loc.coordinate.latitude
            let lon = loc.coordinate.longitude
            let accuracy = loc.horizontalAccuracy
            progressBlock?(lat, lon, accuracy, loc)
            
            //Print the new coordinates
            print("LocationService: Location updated:\nLat \(lat)\nLon \(lon)\n")
        }
    }
    
    //Called when user updates authorization
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        startUpdatingLocationIfAuthorized(status: status)
    }
    ///Starts updating location if authorized
    public func startUpdatingLocationIfAuthorized(status: CLAuthorizationStatus) {
        //CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways
        
        // Update delegate's location if user allows authorization
        print("LocationManager: Authorization status changed")
        if canAccessLocation() {
            self.startUpdatingLocation()
        }else if (status == CLAuthorizationStatus.denied) {
            let error = NSError(domain: "LocationManager", code: 1, userInfo: [NSLocalizedFailureReasonErrorKey:"User did not enable location services!"])
            failUpdateBlock?(error)
        }
    }
    
    ///Returns the most accurate location we've seen so far. Updates the last known loc.
    private func mostAccurateLocation(newLocation: CLLocation) -> (mostAccurateLocation :CLLocation, wasBetterLocation : Bool) {
        
        //get last location from manager.
        //if no last set, then use the newLocation
        let manager = LocationManager.sharedInstance
        var wasBetter = (manager.updateCount == 0)
        if wasBetter {
            manager.updateCount += 1
        }
        
        var lastKnown = manager.lastKnownLocation ?? newLocation
        
        //update if more accurate
        if lastKnown.horizontalAccuracy < newLocation.horizontalAccuracy {
            lastKnown = newLocation
            wasBetter = true
            manager.updateCount += 1
        }
        
        //update manager
        manager.lastKnownLocation = lastKnown
        return (mostAccurateLocation :newLocation, wasBetterLocation : wasBetter)
    }
    
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("error:: \(error.localizedDescription)")
    }
    
}

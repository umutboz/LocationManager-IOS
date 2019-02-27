//
//  LocationManager+AddressConvertions.swift
//
//
//  Created by umut on 22.02.2019.
//  Copyright © 2019 Koçsistem. All rights reserved.
//

import Foundation
import CoreLocation

public extension LocationManager {
    
    ///Defaulted to 30 meters. Set here to update
    public  class func setLocationAccuracy(meters:Double) {
        LocationManager.sharedInstance.LOCATION_ACCURACY = meters
    }
    
    //Defaulted to 10 seconds. Set here to update
    public  class func setLocationUpdateTimeLimit(seconds:Double) {
        LocationManager.sharedInstance.LOCATION_STOP_TIMER_LENGTH_IN_SECONDS = seconds
    }
    
    //Defaulted to false, Set here to update
    public  class func setLocationListenIsRecursive(isRecursive:Bool) {
        LocationManager.sharedInstance.LOCATION_TIMER_IS_RECURSIVE = isRecursive
    }
    
    public class func getLocationManager() -> CLLocationManager{
        return LocationManager.sharedInstance.locationManager
    }
    
    /**
    Gets current location.
    
    Handles requesting location permissions.
    Handles stopping the location manager automatically
    
    :param: progress Can be called multiple times when a more accurate location is available.
    :param: complete Called once timer expires with the most accurate location found
    :param: failure Called if something fails
    */
    class func getCurrentLocationWithProgress(progress:LocationProgressBlock, onComplete complete:LocationProgressBlock, onFailure failure:((_ error:NSError)->())?) {
        
        let manager = LocationManager.sharedInstance
        
        //will be called when a better location is found
        manager.progressBlock = progress
        
        //Called when timer expires
        manager.completeBlock = complete
        
        //called on failure
        manager.failUpdateBlock = failure
        
        if manager.canAccessLocation() {
            manager.startUpdatingLocation()
        }else {
            manager.requestPermissionToAccessLocation()
        }
    }
    

}

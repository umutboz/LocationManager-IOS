//
//  LocationManager+UpdateStopTimer.swift
//
//
//  Created by umut on 22.02.2019.
//  Copyright © 2019 Koçsistem. All rights reserved.
//

import Foundation
import CoreLocation


public extension LocationManager {
    
    func startUpdatingLocation() {
        updateCount = 0
        
        //invalidate zamanlayıcı, bu yüzden n saniye içinde kesin olarak bileceğimizi biliyoruz
        self.locationTimer?.invalidate()
        
        if canAccessLocation() {
            locationManager.startUpdatingLocation()
            print("LocationService: Updating location")
        
            launchStopUpdatingTimer()
        }
            
        else {
            requestPermissionToAccessLocation()
        }
    }
    
    ///Tetiklendiğinde konum güncellemelerini durduracak zamanlayıcıyı başlatır
    func launchStopUpdatingTimer() {
        self.locationTimer = Timer.scheduledTimer(timeInterval: LOCATION_STOP_TIMER_LENGTH_IN_SECONDS, target: self, selector: #selector(self.stopUpdatingLocation), userInfo: nil, repeats: true)
    }
    
    
    ///Durması istendiğinde manager stop ve aktif olan timer pasif konuma getir
    @objc func stopUpdatingLocation() {
        // LOCATION_TIMER_IS_RECURSIVE default false,
        if !LOCATION_TIMER_IS_RECURSIVE{
            locationManager.stopUpdatingLocation()
            self.locationTimer?.invalidate()
            print("location manager stopped")
        }
    
        callCompleteBlockWithLocation(location: lastKnownLocation)
    }
    
    private func callCompleteBlockWithLocation(location: CLLocation?) {
        
        if let loc = location {
            let lat = loc.coordinate.latitude
            let lon = loc.coordinate.longitude
            let accuracy = loc.horizontalAccuracy
            completeBlock?(lat, lon, accuracy, loc)
            
            //Print the new coordinates
            print("\nLocationService: Final location:\nLat \(lat)\nLon \(lon)\nAccuracy:\(accuracy)\n")
        }
    }
}

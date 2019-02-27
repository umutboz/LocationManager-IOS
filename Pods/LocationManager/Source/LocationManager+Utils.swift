//
//  LocationManager+Utils.swift
//  
//
//  Created by umut on 22.02.2019.
//  Copyright © 2019 Koçsistem. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

public extension LocationManager {
    
    ///Kullanıcının konuma erişmesine izin vermesini ister
    func requestPermissionToAccessLocation() {
        
        //request permission
        if isMinimumiOS8() {
            print("\nLocationService: Requesting Authorization... If nothing happens, add the NSLocationWhenInUseUsageDescription or NSLocationAlwaysUsageDescription key to your info.plist\n\nSteps:\n1. Go to info.plist\n2. Add row.\n3. Add key NSLocationWhenInUseUsageDescription.\n4. Add message to key (this is what user will see as the prompt)")
            
            locationManager.requestWhenInUseAuthorization()
        }else {
            self.startUpdatingLocation()
        }
    }
    
    func canAccessLocation() -> Bool {
        let canAccessLocation = CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse)
        return canAccessLocation
    }
    
    ///Returns true if current device has iOS 8+
    private func isMinimumiOS8() -> Bool{
        let version:NSString = UIDevice.current.systemVersion as NSString
        return version.doubleValue >= 8
    }
}

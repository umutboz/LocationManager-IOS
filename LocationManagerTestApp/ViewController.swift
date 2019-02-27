//
//  ViewController.swift
//  LocationManagerTestApp
//
//  Created by umut on 26.02.2019.
//  Copyright © 2019 Koçsistem. All rights reserved.
//

import UIKit
import LocationManager
import CoreLocation

class ViewController: UIViewController {

var count = 5
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let manager = LocationManager.getLocationManager()
//        manager.requestWhenInUseAuthorization()
//        manager.requestAlwaysAuthorization()

        let uskudarLocation = CLLocation(latitude: 41.018944, longitude: 29.057631)
        let distanceKm = uskudarLocation.dinstanceInKm(otherLocationLatitudee: 41.18944, otherLocationLongitude: 29.37631)
        // Do any additional setup after loading the view, typically from a nib.
        LocationManager.setLocationListenIsRecursive(isRecursive: true)
        LocationManager.setLocationUpdateTimeLimit(seconds: 5)
        LocationManager.setLocationAccuracy(meters: 10)
        LocationManager.getCurrentLocationWithProgress(progress: { (latitude, longitude, accuracy, locationObj) in
            //En iyi location değeri yakalındığında bu blok çalışır(birden fazla çalışabilir)
            print("lat:\(latitude) long : \(longitude) accuracy : \(accuracy)")
            
        }, onComplete: { (lat, long, acc,locationObj ) in
            //Belirlenen süre tamamlandığında bu blok çalışır
            print ("distance from to :uskudar \(locationObj.dinstanceInKm(otherLocationLatitudee: 41.018944, otherLocationLongitude: 29.057631)) km")
            print("Called when update timer expires  lat:\(lat) long : \(long) accuracy : \(acc)")
            self.count -= 1
            if self.count == 0{
                LocationManager.setLocationListenIsRecursive(isRecursive: false)
            }
        }) { (error) in
            //Called on failure
            print("Called on failure\n lat:\(error)")
            
        }
    }


}


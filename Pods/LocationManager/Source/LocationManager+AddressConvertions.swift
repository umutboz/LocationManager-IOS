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
    

    
    ///Returns an address from a location using Apple geocoder
    func addressFromLocation(location:CLLocation!, completionClosure:@escaping ((NSDictionary?)->())){
    
        Threads.performTaskInBackground {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placeMarks, error) -> Void in
                if let places = placeMarks {
                    let marks = places[0]
                    completionClosure(marks.addressDictionary as! NSDictionary)
                }else {
                    completionClosure(nil)
                }
                
            })
        }
    }
    
    ///Returns a location from a given address using google API
    func locationFromAddress(address: String, successClosure success:((_ latitude:Double, _ longitude:Double)->()), failureClosure failure:(()->())){
        Threads.performTaskInBackground {
            // assemble request
            //let addressNS:NSString = address as NSString
            //let range = NSRange(location: 0, length: addressNS.length)
            
            // Replace white spaces with plus signs
            //let escapedAddress = addressNS.stringByReplacingOccurrencesOfString(" ", withString: "+")
            
            //TODO: move API keys out of class
            //let requestURL = "https://maps.googleapis.com/maps/api/geocode/json?address=\(escapedAddress)&key=\(self.GOOGLE_PLACES_API_KEY)"
            
            /*
             // Place request
             WFHttp.GET(requestURL, optionalParameters: nil, optionalHTTPHeaders: nil, completion: { (result, statusCode, response) -> Void in
             
             if statusCode == 200 { // success
             
             if result.count > 0 {
             let (lat, lon) = googlePlacesLocationJSONToCoordinates(result as! NSDictionary)
             success(latitude: lat as! Double, longitude: long as! Double)
             
             }
             else {
             failure()
             }
             }else {
             failure()
             }
             })*/
        }
    }
    
    ///Extracts the coordinates from google places API
    private func googlePlacesLocationJSONToCoordinates(json:NSDictionary) -> (lat:Double?, lon:Double?) {
        
        // get result
        let results = json.object(forKey: "results") as! NSArray
        let geomResult = results.object(at: 0) as! NSDictionary
        let geometry = geomResult.value(forKey: "geometry") as! NSDictionary
        let location = geometry.value(forKey: "location") as! NSDictionary
        
        let lat = location.value(forKey: "lat") as? NSNumber
        let lon = location.value(forKey: "lng") as? NSNumber
        return (lat:lat?.doubleValue, lon:lon?.doubleValue)
    }
    
}

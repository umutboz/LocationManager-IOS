//
//  Threads.swift
//  LocationManager
//
//  Created by umut on 25.02.2019.
//  Copyright © 2019 Koçsistem. All rights reserved.
//

import Foundation

class Threads {

static let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String

    static let concurrentQueue = DispatchQueue(label: appName ?? "LocationManager" + "ConcurrentQueue", attributes: .concurrent)
static let serialQueue = DispatchQueue(label: appName ?? "LocationManager" + "SerialQueue")

// Main Queue
class func performTaskInMainQueue(task: @escaping ()->()) {
    DispatchQueue.main.async {
        task()
    }
}

// Background Queue
class func performTaskInBackground(task:@escaping () throws -> ()) {
    DispatchQueue.global(qos: .background).async {
        do {
            try task()
        } catch let error as NSError {
            print("error in background thread:\(error.localizedDescription)")
        }
    }
}

// Concurrent Queue
class func perfromTaskInConcurrentQueue(task:@escaping () throws -> ()) {
    concurrentQueue.async {
        do {
            try task()
        } catch let error as NSError {
            print("error in Concurrent Queue:\(error.localizedDescription)")
        }
    }
}

// Serial Queue
class func perfromTaskInSerialQueue(task:@escaping () throws -> ()) {
    serialQueue.async {
        do {
            try task()
        } catch let error as NSError {
            print("error in Serial Queue:\(error.localizedDescription)")
        }
    }
}

// Perform task afterDelay
class func performTaskAfterDealy(_ timeInteval: TimeInterval, _ task:@escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: (.now() + timeInteval)) {
        task()
    }
}
    
    
}

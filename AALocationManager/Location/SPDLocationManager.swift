//
//  SPDLocation.swift
//  AALocationManager
//
//  Created by Amir Ardalan on 3/22/20.
//  Copyright © 2020 Clean-Coder. All rights reserved.
//

import Foundation
import CoreLocation

protocol SPDLocationManager {
    var delegate : SPDLocationManagerDelegate?{get set}
    var authorizationDelegate:SPDLocationManagerAuthorizationDelegate?{get set}
    var authorizationStatus: CLAuthorizationStatus {get}
    func requestWhenInUseAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
protocol SPDLocationManagerDelegate : class {
    func locationManager(_ manager: SPDLocationManager, didUpdateLocations locations: [CLLocation])
}
protocol SPDLocationManagerAuthorizationDelegate:class  {
    func locationManager(_ manager: SPDLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
}


class SPDLocationManagerProxy  : NSObject {
    let locationManager: CLLocationManager
    weak var delegate: SPDLocationManagerDelegate?
    weak var authorizationDelegate: SPDLocationManagerAuthorizationDelegate?
    
    init(locationManager:CLLocationManager) {
        self.locationManager = locationManager
        super.init()
    }
}

extension SPDLocationManagerProxy: SPDLocationManager {
   
    var authorizationStatus: CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }
    
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    
}

extension SPDLocationManagerProxy : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.delegate?.locationManager(self, didUpdateLocations: locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationDelegate?.locationManager(self, didChangeAuthorization: status)
    }
}

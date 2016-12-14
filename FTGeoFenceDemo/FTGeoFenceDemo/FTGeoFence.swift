//
//  FTGeoFence.swift
//  FTGeoFenceDemo
//
//  Created by liufengting on 01/12/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit
import MapKit

@objc
protocol FTGeoFenceDelegate {
    
    func updateText(text: String, state : CLRegionState)

}

class FTGeoFence: NSObject, CLLocationManagerDelegate{

    
    var delegate : FTGeoFenceDelegate!
    
    
    lazy var locationManager : CLLocationManager = {
        let manager = CLLocationManager()
        manager.pausesLocationUpdatesAutomatically = false
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 10
        manager.allowsBackgroundLocationUpdates = true
        manager.requestAlwaysAuthorization()
        return manager
    }()
    
    
    public func startlocating(){
        
        self.locationManager.startUpdatingLocation()
        
        
    }
    
    
    public func startMonitoringRegin(region : CLRegion){
        
        self.locationManager.startMonitoring(for: region)
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        print("\(locations.last)");
        
        self.delegate.updateText(text: "\(locations.last)", state: .unknown)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        self.delegate.updateText(text: "didStartMonitoringFor \(region.identifier)", state: .unknown)

    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        print("\(state)...\(region)")
        
        self.delegate.updateText(text: "didDetermineState \(region.identifier) \(state)", state: state)

    }
    
    
    
    
}

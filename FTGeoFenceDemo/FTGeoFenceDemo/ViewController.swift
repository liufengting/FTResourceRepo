//
//  ViewController.swift
//  FTGeoFenceDemo
//
//  Created by liufengting on 01/12/2016.
//  Copyright © 2016 LiuFengting. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var cLati: UILabel!
    @IBOutlet weak var cLong: UILabel!
    @IBOutlet weak var tLati: UILabel!
    @IBOutlet weak var tLong: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var console: UITextView!

    
    var consoleText : String = "Some thing is about to happen!"

    var targetCoordinate = CLLocationCoordinate2DMake(31.489929916339147, 120.36723134620514)
    
    var currentLocation : CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tLati.text = "\(targetCoordinate.latitude)"
        tLong.text = "\(targetCoordinate.longitude)"

    }

    @IBAction func startButtonAction(_ sender: UIButton) {
        
        self.startlocating()
        
        let region : CLCircularRegion = CLCircularRegion(center: targetCoordinate, radius: 50, identifier: "Just Testing")
        region.notifyOnEntry = true
        region.notifyOnExit = true;
        self.startMonitoringRegin(region: region)

        
        let region2 : CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(31.49, 120.3679), radius: 50, identifier: "Just Testing2222")
        region2.notifyOnEntry = true
        region2.notifyOnExit = true;
        self.startMonitoringRegin(region: region2)
        
        
        
    }


    lazy var locationManager : CLLocationManager = {
        let manager = CLLocationManager()
        manager.pausesLocationUpdatesAutomatically = false
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 10
        manager.allowsBackgroundLocationUpdates = true
        manager.requestAlwaysAuthorization()
        manager.delegate = self
        return manager
    }()
    
    
    public func startlocating(){
        
        self.locationManager.startUpdatingLocation()
        
    }
    
    
    public func startMonitoringRegin(region : CLRegion){
        
        self.locationManager.startMonitoring(for: region)
        
        self.locationManager.requestState(for: region)
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        let coor : CLLocationCoordinate2D = (locations.last?.coordinate)!
        
        let string = "didUpdateLocations \(coor.latitude, coor.longitude)"
        
        
        cLati.text = "\(coor.latitude)"
        cLong.text = "\(coor.longitude)"


        self.updateString(string: string)
        
        
        currentLocation = CLLocation(latitude: coor.latitude, longitude: coor.longitude)
        let targetLocation : CLLocation = CLLocation(latitude: targetCoordinate.latitude, longitude: targetCoordinate.longitude)
        
        let distance : CLLocationDistance = currentLocation.distance(from: targetLocation)
        
        self.distance.text = "\(distance)"
        
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
        let string = "----didStartMonitoringFor \(region.identifier)"
        
        self.updateString(string: string)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        
        let string = "----didDetermineState \(region.identifier) \(state.rawValue)"
        
        self.updateString(string: string)
        
    }
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        
        let targetLocation : CLLocation = CLLocation(latitude: (region as! CLCircularRegion).center.latitude, longitude: (region as! CLCircularRegion).center.longitude)
        
        let distance : CLLocationDistance = currentLocation.distance(from: targetLocation)
        
        let string = "----didExitRegion \(region.identifier) \(distance) "

        self.updateString(string: string)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {

        let targetLocation : CLLocation = CLLocation(latitude: (region as! CLCircularRegion).center.latitude, longitude: (region as! CLCircularRegion).center.longitude)
        
        let distance : CLLocationDistance = currentLocation.distance(from: targetLocation)
        
        let string = "----didEnterRegion \(region.identifier) \(distance) "
        
        self.updateString(string: string)
        
    }
    
    
    
    
    func updateString(string : String) {
        
        print(string)

        
        consoleText.append("\n")
        consoleText.append(string)

        console.text = consoleText
        console.scrollRangeToVisible(NSRange(location: (consoleText as NSString).length-2, length: 1))
        
        
    }
    
    
    

}


//
//  TrackingViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//
//  Referenced from: http://www.johnmullins.co/blog/2014/08/14/location-tracker-with-maps/

import UIKit
import CoreLocation
import MapKit

typealias TimeElement = (begin: NSDate, end: NSDate, duration: NSTimeInterval)

class TrackingViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var finishedButton: UIButton!
    
    var manager:CLLocationManager!
    var myLocations: [CLLocation] = []
    var myVisits: [CLVisit] = []
    var beginTime: NSDate!
    var myTime: TimeElement!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Record starting time
        beginTime = NSDate()
        
        //Setup for Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 10.0       //update when moved over 50m
        
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways:
            manager.startUpdatingLocation()
            manager.startMonitoringVisits()
        case .NotDetermined:
            manager.requestAlwaysAuthorization()
        case .AuthorizedWhenInUse, .Restricted, .Denied:
            let alertController = UIAlertController(
                title: "Background Location Access Disabled",
                message: "In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'.",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alertController.addAction(openAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        
        //Setup our Map View
        
        mapView.delegate = self
        mapView.mapType = MKMapType.Standard
        mapView.showsUserLocation = true
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)

    }
    
    //Tracking location changes
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println("Updated Location: \(locations[0])")
        myLocations.append(locations[0] as! CLLocation)
        
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)
        
        //Preparing for drawing a line on the map
        if (myLocations.count > 1) {
            var sourceIndex = myLocations.count - 1
            var destIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            let c2 = myLocations[destIndex].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            mapView.addOverlay(polyline)
        }
    }
    
    //Track visits
    func locationManager(manager: CLLocationManager!, didVisit visit: CLVisit!) {
        println("Visited: \(visit)")
        myVisits.append(visit as CLVisit)
    }
    
    
    // MARK: ADD LOCATION AUTHORIZATION SETTINGS
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        //Drawing a line on the map
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 3
            
            return polylineRenderer
        }
        
        return nil
    }
    @IBAction func finishedButtonPressed(sender: UIButton) {
        let end = NSDate()
        var duration = end.timeIntervalSinceDate(self.beginTime)
        self.myTime = (self.beginTime, end, duration)
        
        
        
        if (myLocations.count < 3) {
            let alert = UIAlertController(
                title: "Too Few Locations Recorded!",
                message: "In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'.",
                preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alert.addAction(cancelAction)
            presentViewController(alert, animated: true, completion: nil)
            
        } else{
            manager.stopMonitoringVisits()
            manager.stopUpdatingLocation()
            self.performSegueWithIdentifier("pushFinishedRoute", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "pushFinishedRoute") {
            var finishedRouteView: finishedRouteTableViewController = segue.destinationViewController as! finishedRouteTableViewController
            finishedRouteView.savedRoute = self.myLocations
            finishedRouteView.savedVisit = self.myVisits
            finishedRouteView.savedTime = self.myTime
            
        }
        
    }

}

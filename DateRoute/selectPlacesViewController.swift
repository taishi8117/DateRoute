//
//  selectPlacesViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit
import MapKit

class selectPlacesViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var savedRoute: [CLLocation] = []
    var savedVisit: [CLVisit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.mapType = MKMapType.Standard
        mapView.showsUserLocation = false
        
        
        //Preparing for polyline
        var coordinates: [CLLocationCoordinate2D] = []
        for i in 0..<savedRoute.count {
            coordinates.append(savedRoute[i].coordinate)
        }
        var polyline: MKPolyline = MKPolyline(coordinates: &coordinates, count: savedRoute.count)
        mapView.addOverlay(polyline)
        
        //setting region
        var regionRect = polyline.boundingMapRect
        
        var wPadding = regionRect.size.width * 0.8
        var hPadding = regionRect.size.height * 0.8
        
        regionRect.size.width += wPadding
        regionRect.size.height += hPadding
        
        regionRect.origin.x -= wPadding / 2
        regionRect.origin.y -= hPadding / 2
        
        mapView.setRegion(MKCoordinateRegionForMapRect(regionRect), animated: true)
        
        
        //Preparing for pin
        for visit in savedVisit {
            var pin: MKPointAnnotation = MKPointAnnotation()
            pin.coordinate = visit.coordinate
            pin.title = "hello"
            mapView.addAnnotation(pin)
        }

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

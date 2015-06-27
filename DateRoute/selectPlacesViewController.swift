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
        
        //setting region
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: savedRoute[0].coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        mapView.setRegion(newRegion, animated: true)
        
        //Preparing for polyline
        for i in 1..<savedRoute.count {
            let c1 = savedRoute[i-1].coordinate
            let c2 = savedRoute[i].coordinate
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            mapView.addOverlay(polyline)
        }
        
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

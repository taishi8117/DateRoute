//
//  finishedRouteTableViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit
import MapKit

class finishedRouteTableViewController: UITableViewController, MKMapViewDelegate{
    
    var savedRoute: [CLLocation] = []
    var savedVisit: [CLVisit] = []
    
    
    var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        var insets: UIEdgeInsets = self.tableView.contentInset;
        insets.top += 64;
        self.tableView.contentInset = insets;
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as! UITableViewCell
            return cell
        }
        else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("detailCell", forIndexPath: indexPath) as! UITableViewCell
            return cell
            
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("mapCell", forIndexPath: indexPath) as! UITableViewCell
            mapView = cell.contentView.viewWithTag(120) as? MKMapView
            mapView!.delegate = self
            mapView!.mapType = MKMapType.Standard
            mapView!.showsUserLocation = false
            
            //Preparing for polyline
            var coordinates: [CLLocationCoordinate2D] = []
            for i in 0..<savedRoute.count {
                coordinates.append(savedRoute[i].coordinate)
            }
            var polyline: MKPolyline = MKPolyline(coordinates: &coordinates, count: savedRoute.count)
            mapView!.addOverlay(polyline)
            
            //setting region
            var regionRect = polyline.boundingMapRect
            
            var wPadding = regionRect.size.width * 0.8
            var hPadding = regionRect.size.height * 0.8
            
            regionRect.size.width += wPadding
            regionRect.size.height += hPadding
            
            regionRect.origin.x -= wPadding / 2
            regionRect.origin.y -= hPadding / 2
            
            mapView!.setRegion(MKCoordinateRegionForMapRect(regionRect), animated: true)
            
            
            //Preparing for pin
            for visit in savedVisit {
                var pin: MKPointAnnotation = MKPointAnnotation()
                pin.coordinate = visit.coordinate
                pin.title = "hello"
                mapView!.addAnnotation(pin)
            }
            
            return cell
        }
        
        // Configure the cell...

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

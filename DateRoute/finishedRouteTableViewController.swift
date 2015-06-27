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
    var savedTime: TimeElement!
    
    var mapView: MKMapView?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.scrollEnabled = false;
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonPressed")
        self.title = "Finished Route"
        
        var v:UIView = UIView(frame: CGRectZero)
        v.backgroundColor = UIColor.clearColor()
        self.tableView.tableHeaderView = v
        self.tableView.tableFooterView = v
        

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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 144
        }else if (indexPath.row == 1) {
            return 100
        }else if (indexPath.row == 2) {
            return UIScreen.mainScreen().bounds.size.height - 210
        }
        else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as! UITableViewCell
            var timeLabel: UILabel? = cell.contentView.viewWithTag(13) as? UILabel
            timeLabel?.text = stringFromTimeInterval(self.savedTime.duration) as String
            
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
    
    func doneButtonPressed() {
        //SEND JSON!!!
    }
    
    func stringFromTimeInterval(interval:NSTimeInterval) -> NSString {
        
        var ti = NSInteger(interval)
        
        var ms = Int((interval % 1) * 1000)
        
        var seconds = ti % 60
        var minutes = (ti / 60) % 60
        var hours = (ti / 3600)
        
        return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
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

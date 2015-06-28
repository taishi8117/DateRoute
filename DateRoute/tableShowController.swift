//
//  tableShowController.swift
//  DateRoute
//
//  Created by 前田 智大 on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit
import CoreLocation

class tableShowController: UIViewController, UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate  {
    var ranking = 0
    //var point = Dictionary<String,Any>()
    var routeDict: [NSDictionary] = []
    var resultJsonDict: NSDictionary!
    var results: NSArray!
    var pointDict: NSDictionary!
    var savedRoute: [CLLocation] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        results=resultJsonDict["results"] as! NSArray
        
        //self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "tableView.jpg")!)
        //self.tableView.backgroundView = UIImageView(image: UIImage(named: "tableView.jpg"))
       // tableView.delegate = self
        //tableView.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // セルに表示するテキスト
   
    
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = results[indexPath.row]["Name"] as! String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ranking=indexPath.row
        
        //GET POINTS HERE. DATA=dict
        getPoints()
        
        //set variables according to the ranking
        let delay = 4 * Double(NSEC_PER_SEC)
        let delayedtime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(delayedtime, dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("showDetails", sender: self)
        }
}
    func getPoints(){
        let id = results[ranking]["Id"] as! Int
        let reqConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let reqURL: NSURL = NSURL(string: "http://192.168.43.20:5000/api/v1.0/routepoint/\(id)")!
        //let reqURL: NSURL = NSURL(string: "http://dateroute3.mybluemix.net/api/v1.0/routepoint/\(id)")!
        //let reqURL: NSURL = NSURL(string: "http://localhost:8000/")!
        let reqReq: NSMutableURLRequest = NSMutableURLRequest(URL: reqURL)
        let reqSession: NSURLSession = NSURLSession(configuration: reqConfig)
        reqReq.HTTPMethod = "GET"
        //reqReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var task = reqSession.dataTaskWithRequest(reqReq, completionHandler: {
            (data, resp, err) in
             var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            println(dict)
            self.pointDict = dict
             //var points = dict["Points"] as! Dictionary
             //self.point = points
        })
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        if (segue.identifier == "showDetails") {
            var detailsView: finishedRouteTableViewController = segue.destinationViewController as! finishedRouteTableViewController
            //set variables to pass
            detailsView.IsFromTrack = false
            detailsView.savedTime = (NSDate(),NSDate(), 0)
            
            var arr: NSArray = pointDict["results"] as! NSArray
            for i in 0..<arr.count {
                let lat: Double = arr[i]["Lat"] as! Double
                let len: Double = arr[i]["Len"] as! Double
                
                var tmp: CLLocation = CLLocation(latitude: lat, longitude: len)
                self.savedRoute.append(tmp)
            }
            detailsView.savedRoute = self.savedRoute
            
        }
        
    }

    
    
}
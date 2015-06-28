//
//  tableShowController.swift
//  DateRoute
//
//  Created by 前田 智大 on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit

class tableShowController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var name: [String] = []
    var rating: [Int] = []
    var area: [String] = []
    var duration: [Int] = []
    var time: [Int] = []
    var users: [Int] = []
    var id: [Int] = []
    var ranking = 0
    //var point = Dictionary<String,Any>()
    
    var routeDict: [NSDictionary] = []
    var resultJsonArray: [NSDictionary] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       // tableView.delegate = self
        //tableView.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /*   func dictToArray(){
        if let newName: String = resultJsonArray["name"] {
            name.append(newName)
        }
        if let newRating = resultJsonArray["rating"] {
            rating.append(newRating)
        }
    }
*/
    
    // セルに表示するテキスト
   
    
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = name[indexPath.row] as String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ranking=indexPath.row
        
        //GET POINTS HERE. DATA=dict
        getPoints()
        
        //set variables according to the ranking
        self.performSegueWithIdentifier("showDetails", sender: self)
}
    func getPoints(){
        let reqConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let reqURL: NSURL = NSURL(string: "http://192.168.43.20:5000//api/v1.0/routepoint/2\(id[ranking])")!
        //let reqURL: NSURL = NSURL(string: "http://localhost:8000/")!
        let reqReq: NSMutableURLRequest = NSMutableURLRequest(URL: reqURL)
        let reqSession: NSURLSession = NSURLSession(configuration: reqConfig)
        reqReq.HTTPMethod = "GET"
        //reqReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var task = reqSession.dataTaskWithRequest(reqReq, completionHandler: {
            (data, resp, err) in
             var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
             //var points = dict["Points"] as! Dictionary
             //self.point = points
        })
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        if (segue.identifier == "showDetails") {
            var detailsView: showDetailsController = segue.destinationViewController as! showDetailsController
            //set variables to pass
            detailsView.name = name[ranking]
            detailsView.rating = rating[ranking]
            detailsView.area = area[ranking]
            detailsView.duration = duration[ranking]
            detailsView.time = time[ranking]
            detailsView.users = users[ranking]
            detailsView.id = id[ranking]
            //detailsView.points = point
        }
        
    }

    
    
}
//
//  mainS/Users/maedatomohiro/Documents/DateRoute/DateRoute/showDetailsController.swifthowRouteViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit



class mainShowRouteViewController: UIViewController  {

    var location: String!
    var time: Int!
    var jsonDict: NSDictionary!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationPicked: UITextField!
    @IBOutlet weak var timePicked: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchButtonPressed(sender: AnyObject) {
        location = locationPicked.text
        time = timePicked.text.toInt()!
        // GET JSON AND NAME THE DATA dict
        getValuesFromJason()
        
        self.performSegueWithIdentifier("pushShowTable", sender: self)
    }
    
    func getValuesFromJason(){
       
        
        let reqConfig: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let reqURL: NSURL = NSURL(string: "http://192.168.43.20:5000/api/v1.0/route/?area=\(location)&time=\(time)")!
        //let reqURL: NSURL = NSURL(string: "http://localhost:8000/")!
        let reqReq: NSMutableURLRequest = NSMutableURLRequest(URL: reqURL)
        let reqSession: NSURLSession = NSURLSession(configuration: reqConfig)
        reqReq.HTTPMethod = "GET"
        reqReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
       
        //converting json to str (adjusting keys)
        
        var task = reqSession.dataTaskWithRequest(reqReq, completionHandler: {
            (data, resp, err) in
            //println(resp.URL!)
            var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            println(dict)
            self.jsonDict = dict
            /*println(NSString(data: data, encoding: NSUTF8StringEncoding))*/
        })
        task.resume()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         //Get the new view controller using segue.destinationViewController.
         //Pass the selected object to the new view controller.
        if (segue.identifier == "pushShowTable") {
            var titlesView: tableShowController = segue.destinationViewController as! tableShowController
            titlesView.resultJsonDict = self.jsonDict
            
        }

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
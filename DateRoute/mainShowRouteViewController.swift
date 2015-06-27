//
//  mainS/Users/maedatomohiro/Documents/DateRoute/DateRoute/showDetailsController.swifthowRouteViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit


class mainShowRouteViewController: UIViewController {

    var name: [String]
    var rating: [Int]
    var area: [String]
    var duration: [Int]
    var time: [Int]
    var users: [Int]
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var locationPicked: UITextField!
    @IBOutlet weak var timepicked: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchButtonPressed(sender: AnyObject) {
        
            var Route = dict["Route"] as NSDictionary
            name = Route["Name"] as NSArray
            rating = Route["Rating"] as NSArray
            area = Route["Area"] as NSArray
            duration = Route["Duration"] as NSArray
            time = Route["Times"] as NSArray
            users = Route["Users"] as NSArray
        
    self.performSegueWithIdentifier("pushShowTable", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         //Get the new view controller using segue.destinationViewController.
         //Pass the selected object to the new view controller.
        if (segue.identifier == "pushShowTable") {
            var titlesView: tableShowController = segue.destinationViewController as! tableShowController
            
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
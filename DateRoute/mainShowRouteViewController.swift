//
//  mainShowRouteViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit

class mainShowRouteViewController: UIViewController {

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
    self.performSegueWithIdentifier("pushShowTable", sender: self)
    }
    
    /*override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "pushSelectPlaces") {
            var selectPlacesView: selectPlacesViewController = segue.destinationViewController as! selectPlacesViewController
            selectPlacesView.titles = titles;
            selectPlacesView.ratings = ratings;
            
        }*/

       }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */



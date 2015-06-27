//
//  ViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var startTracking: UIButton!
    @IBOutlet weak var showRouteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        //self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.translucent = true
        self.navigationController!.navigationBar.alpha  = 0.2
        self.navigationController!.navigationBar.hidden = true
        //self.navigationController!.navigationBar.barTintColor = UIColor(red: 0,green: 0, blue: 0, alpha: 0.1)
        
        // Do any additional setup after loading the view, typically from a nib.
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways:
            startTracking.enabled = true
        case .NotDetermined, .AuthorizedWhenInUse, .Restricted, .Denied:
            startTracking.enabled = false
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
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBarHidden = true
    }
    
    @IBAction func trackButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("pushTrack", sender: self)
    }
    

    @IBAction func showRouteButtonPressed(sender: UIButton) {
        self.performSegueWithIdentifier("pushShowRoute", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}


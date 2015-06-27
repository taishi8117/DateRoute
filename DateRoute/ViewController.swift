//
//  ViewController.swift
//  DateRoute
//
//  Created by TAISHI on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startTracking: UIButton!
    @IBOutlet weak var showRouteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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


}


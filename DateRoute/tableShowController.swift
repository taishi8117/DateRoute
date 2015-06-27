//
//  tableShowController.swift
//  DateRoute
//
//  Created by 前田 智大 on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit

class tableShowController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var texts: [String] = []
    var ranking: Int = 0
    let titles = ["a","b","c","d","e"]
    let ratings = ["5","4.9","4,8","4.8","4.7"]
    var finalTitle=[]
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
    
    
    // セルに表示するテキスト
   
    
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = texts[indexPath.row] as String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         ranking=indexPath.row
    finalTitle=[titles[ranking], ratings[ranking]]
        //set variables according to the ranking
        self.performSegueWithIdentifier("showDetails", sender: self)
}
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        if (segue.identifier == "showDetails") {
            var detailsView: showDetailsController = segue.destinationViewController as! showDetailsController
            //set variables to pass
            detailsView.roadTitle = finalTitle as! [String]
        }
        
    }

    
    
}
//
//  tableShowController.swift
//  DateRoute
//
//  Created by 前田 智大 on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit

class tableShowController:  UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    
// セルに表示するテキスト
let texts = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

// セルの行数
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return texts.count
}

// セルの内容を変更
func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
    
    cell.textLabel?.text = texts[indexPath.row]
    return cell
}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
    
}

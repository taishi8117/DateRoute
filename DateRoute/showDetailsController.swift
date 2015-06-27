//
//  File.swift
//  DateRoute
//
//  Created by 前田 智大 on 6/27/15.
//  Copyright (c) 2015 TAISHI. All rights reserved.
//

import UIKit

class showDetailsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var roadTitle:[String]=[];
    
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
        return roadTitle.count
    }
    
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = roadTitle[indexPath.row] as String
        return cell
    }

    
}

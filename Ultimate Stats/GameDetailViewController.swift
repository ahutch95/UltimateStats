//
//  GameDetailViewController.swift
//  Ultimate Stats
//
//  Created by studentuser on 6/5/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class GameDetailViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var homeTable: UITableView!
    @IBOutlet weak var awayTable: UITableView!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayLable: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    let test = ["One","Two","Three"]
    let test1 = ["Blue","Yello","Green"]
    override func viewDidLoad() {
        self.homeTable.delegate = self as! UITableViewDelegate
        self.awayTable.dataSource = self as! UITableViewDataSource
        
        self.awayTable.delegate = self as! UITableViewDelegate
        self.homeTable.dataSource = self as! UITableViewDataSource
        self.homeTable.reloadData()
        self.awayTable.reloadData()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RosterCell", for: indexPath) 
//        let groceryItem = test[indexPath.row]
        print("cell # \(indexPath.row) selected")
        
        if(tableView == self.homeTable){
            cell.textLabel?.text = test[indexPath.row]
        }
        if(tableView == self.awayTable){
            cell.textLabel?.text = test1[indexPath.row]
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
}

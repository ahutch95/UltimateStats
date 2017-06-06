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
    
    
    var homePlayers = [String]()
    var awayPlayers = [String]()
    var home: String?
    var away: String?
    var time: String?
    
    override func viewDidLoad() {
        homeName.text = home
        awayLable.text = away
        dateLabel.text = time
        getDataHome()
//        getDataAway()
        
    }
    
    func getDataHome(){
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            var newItems: [String] = []
            
            if !(snapshot.value is NSNull){
                var value = (snapshot.value as? NSDictionary)!
                
                for (key, values) in value {
                    
                    ref.child("users").child(key as! String).child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
                        if !(snapshot.value is NSNull){
                            
                            var teams = (snapshot.value as? NSArray)!
                            
                            if(teams.contains(self.home!)){
                                ref.child("users").child(key as! String).child("firstName").observeSingleEvent(of: .value, with: { (snapshot) in
                                    var name = (snapshot.value as? String)!
                                    
                                    self.homePlayers.append(name)
                                    self.homeTable.delegate = self
                                    self.homeTable.dataSource = self
                                    self.homeTable.reloadData()
                                   
                                    
                                    
                                }) { (error) in
                                    print(error.localizedDescription)
                                }
                         
                                
                            }
                            if(teams.contains(self.away!)){
                                ref.child("users").child(key as! String).child("firstName").observeSingleEvent(of: .value, with: { (snapshot) in
                                    var name = (snapshot.value as? String)!
                                    print(name)
                                    self.awayPlayers.append(name)
                                    self.awayTable.delegate = self
                                    self.awayTable.dataSource = self
                                    self.awayTable.reloadData()
                                    
                                    
                                    
                                }) { (error) in
                                    print(error.localizedDescription)
                                }
                                
                                
                            }


                            
                            
                        }
                        
                        
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    
                }
                
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RosterCell", for: indexPath) 

        if(tableView == self.homeTable){
            cell.textLabel?.text = homePlayers[indexPath.row]
        }
        if(tableView == self.awayTable){
            cell.textLabel?.text = awayPlayers[indexPath.row]
        }
        
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.homeTable){
            return self.homePlayers.count
        }else{
            return self.awayPlayers.count
        }
       
    }
    
}

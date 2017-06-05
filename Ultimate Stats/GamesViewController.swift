//
//  GamesViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var ref:FIRDatabaseReference!
    var first = ""
    var last = ""
    var shouldIDoIt = 0
    var games = [String]()
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    var test: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pull to refresh
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        
        
        if (shouldIDoIt == 1) {
            createNewUserInDatabase()
        }
        
        getData()
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            var newItems: [String] = []
            
            if !(snapshot.value is NSNull){
                var value = (snapshot.value as? NSDictionary)!
                
                for (key, values) in value {
                    
                    ref.child("users").child(key as! String).child("games").observeSingleEvent(of: .value, with: { (snapshot) in
                        if !(snapshot.value is NSNull){
                            if let game = snapshot.value as? [NSArray] {
                            } else {
                            var game = (snapshot.value as? NSDictionary)!
                            
                            
                            for (keys, values) in game{
                                
                                ref.child("users").child(key as! String).child("games").child(keys as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                                    var g = (snapshot.value as? NSDictionary)!
                                    
                                    self.test.append(g)
                                    print("here")
                                    self.tableView.delegate = self
                                    self.tableView.dataSource = self
                                    self.tableView.reloadData()
                                }) { (error) in
                                    print(error.localizedDescription)
                                }
                                
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
    
    func createNewUserInDatabase(){
        var userExsists = false
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["email"] as? String ?? ""
            if(username != ""){
                userExsists = true
            }
            
            if(userExsists == false){
                print("this is round 1" + self.first + self.last)
                let email = FIRAuth.auth()?.currentUser?.email
                let user = ["email": email,
                            "firstName": self.first,
                            "lastName": self.last,
                            "goals": 0,
                            "assists": 0,
                            "turns": 0,
                            "defends": 0,
                            "teams": ["none"]] as [String : Any]
                userExsists = true
                
                self.ref.child("users").child(userID!).setValue(user)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    func refresh() {
        getData()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameCellView
        let groceryItem = test[indexPath.row]
        print("cell # \(indexPath.row) selected")
        
        cell.home.text = groceryItem.value(forKey: "home") as! String
        cell.away.text = groceryItem.value(forKey: "away") as! String
        cell.time.text = groceryItem.value(forKey: "time") as! String
        print(groceryItem.value(forKey: "time") as! String)
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // cell selected code here
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return test.count
    }
    
}

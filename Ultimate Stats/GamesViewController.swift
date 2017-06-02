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
  
  @IBOutlet weak var tableView: UITableView!
  var users : [String] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      
      if (shouldIDoIt == 1) {
        createNewUserInDatabase()
      }
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let username = value?["name"] as? String ?? ""
            
            
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        
        //var  rootData = Firebase(url: "https//ultimate-stats-tracker.firebaseio.com/")
        //rootData.childbyAppendingPath("users/mchen/name")
        
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
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! iQuizTableViewCell
    let groceryItem = users[indexPath.row]
    print("cell # \(indexPath.row) selected")
    
    cell.questionLabel.text = groceryItem
    
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // cell selected code here
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }

}

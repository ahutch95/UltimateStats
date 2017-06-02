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

<<<<<<< HEAD
class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref:FIRDatabaseReference!
     var users: [String] = []
    var first = ""
    var last = ""
    
    @IBOutlet weak var tableView: UITableView!
   
=======
class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var ref:FIRDatabaseReference!
    var first = ""
    var last = ""
    var shouldIDoIt = 0
  
  @IBOutlet weak var tableView: UITableView!
  var users : [String] = []
  
>>>>>>> shit
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      
      if (shouldIDoIt == 1) {
        createNewUserInDatabase()
<<<<<<< HEAD
        ref = FIRDatabase.database().reference()

        
=======
      }
>>>>>>> shit
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userID!).child("games").observeSingleEvent(of: .value, with: { (snapshot) in
              var newItems: [String] = []
            if !(snapshot.value is NSNull){
            var value = (snapshot.value as? Array<String>)!
          
            for item in value{
                newItems.append(item)
            }
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.users = newItems
            self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    //creates new user
    func createNewUserInDatabase(){
        var userExsists = false
        
        //checks if user exsists already
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref = FIRDatabase.database().reference()
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value?["email"] as? String ?? ""
            if(username != ""){
                userExsists = true
            }
            
            //if no user with that id then create new user
            if(userExsists == false){
              print("this is round 1" + self.first + self.last)
                let email = FIRAuth.auth()?.currentUser?.email
<<<<<<< HEAD
                let user = ["email": email,
                            "firstName": self.first,
                            "lastName": self.last,
                            "goals": 0,
                            "assists": 0,
                            "turns": 0,
                            "defends": 0,
                            "teams": ["none"]] as [String : Any]
                
=======
              let user = ["email": email,
                          "firstName": self.first,
                          "lastName": self.last,
                          "goals": 0,
                          "assists": 0,
                          "turns": 0,
                          "defends": 0,
                          "teams": ["none"]] as [String : Any]
              userExsists = true
              
>>>>>>> shit
                self.ref.child("users").child(userID!).setValue(user)
            }
            
        }) { (error) in
            print(error.localizedDescription)
<<<<<<< HEAD
        }
    }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
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
=======
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

>>>>>>> shit
}

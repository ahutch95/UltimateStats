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

class GamesViewController: UIViewController {
    
    var ref:FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createNewUserInDatabase()
        
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
                let email = FIRAuth.auth()?.currentUser?.email
                let user = ["games": ["none"],
                            "teams": ["none"],
                            "email": email] as [String : Any]
                
                self.ref.child("users").child(userID!).setValue(user)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }

        
       
        
        
        
    }

    
    
}

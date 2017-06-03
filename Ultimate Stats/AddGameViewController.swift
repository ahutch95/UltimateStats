//
//  AddGameViewController.swift
//  Ultimate Stats
//
//  Created by studentuser on 5/24/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class AddGameViewController: UIViewController {
    
   // @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var teams = [String]()
    
    
    
    @IBAction func upload(_ sender: Any) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        print(datePicker.date.description)
        let game = ["date":datePicker.date.description,"location":location.text] as [String : Any]
        
        ref.child("users").child(userID!).child("games").childByAutoId().setValue(game)
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            var newItems: [String] = []
            if !(snapshot.value is NSNull){
                var value = (snapshot.value as? NSDictionary)!
                
                for (key, values) in value {
                    
                    ref.child("users").child(key as! String).child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
                        var team = (snapshot.value as? NSArray)!
                       
                        
                        for each in team{
                            print(each as! String)
                            if(!self.teams.contains(each as! String)){
                                self.teams.append(each as! String)
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
    
    
}

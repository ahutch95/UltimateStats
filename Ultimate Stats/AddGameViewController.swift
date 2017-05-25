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
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var date: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBAction func upload(_ sender: Any) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        
        let game = ["name":name.text,"date":date.text,"location":location.text] as [String : Any]
        
        ref.child("users").child(userID!).child("games").childByAutoId().setValue(game)
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

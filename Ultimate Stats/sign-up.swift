//
//  log-In.swift
//  Ultimate Stats
//
//  Created by studentuser on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUp: UIViewController {
  
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var username: UITextField!
  @IBOutlet weak var first: UITextField!
  @IBOutlet weak var last: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.hideKeyboardWhenTappedAround()
    
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func createAccountAction(_ sender: AnyObject) {
    
    if username.text == "" {
      let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
      
      let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(defaultAction)
      
      present(alertController, animated: true, completion: nil)
      
    } else {
      FIRAuth.auth()?.createUser(withEmail: username.text!, password: password.text!) { (user, error) in
        
        if error == nil {
          print("You have successfully signed up")
          //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
          
          let vc = self.storyboard?.instantiateViewController(withIdentifier: "Game") as! GamesViewController
          vc.first = (self.first.text)!
          print((self.first.text)!)
          vc.last = (self.last.text)!
          vc.shouldIDoIt = 1
          print((self.last.text)!)
          
          self.present(vc, animated: true, completion: nil)
          
        } else {
          let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
          
          let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
          alertController.addAction(defaultAction)
          
          self.present(alertController, animated: true, completion: nil)
        }
      }
    }
    
  }
  
  @IBAction func goToLogIn(){
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Login")
    self.present(vc!, animated: true, completion: nil)
  }
  
}

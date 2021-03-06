//
//  AddTeamTableViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class AddTeamTableViewController: UITableViewController {
  
  var newRoster = [[String:String]]()
   
  
  var players:String = "Chess" {
    didSet {
      detailLabel.text? = players
    }
  }
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var detailLabel: UILabel!
  
  
    
  required init?(coder aDecoder: NSCoder) {
    print("init PlayerDetailsViewController")
    super.init(coder: aDecoder)
  }
  
  deinit {
    print("deinit PlayerDetailsViewController")
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      nameTextField.becomeFirstResponder()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SavePlayerDetail" {
      print("test")
    }
    if segue.identifier == "PickGame" {
      if let playerSelect = segue.destination as? PlayerSelectTableViewController {
        playerSelect.selectedPlayers = players
      }
    }

  }
  
  
  @IBAction func unwindToAddTeamTable(segue:UIStoryboardSegue) {
    //performSegue(withIdentifier: "toAddTeam", sender: self)
    
  }
  
  @IBAction func done(_ sender: Any) {
    
    let roster = newRoster
      .flatMap { $0 }
      .reduce([String:String]()) { (dict, tuple) in
        var nextDict = dict
        nextDict.updateValue(tuple.1, forKey: tuple.0)
        return nextDict
    }
    
    
    for(key, value) in roster{
      upload(key: key as! String,value: value as! String)
    }
    
    self.navigationController?.popViewController(animated: true)
  }
  
  func upload(key: String, value: String){
    
    let ref = FIRDatabase.database().reference()
    
    
    
    ref.child("users").child(key).child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
      if !(snapshot.value is NSNull){
        
        var value = (snapshot.value as? NSArray)!
        
        
        ref.child("users").child(key).child("teams").setValue(value.adding(self.nameTextField.text) )
       
        
      }else{
        var ar =  [] as! NSArray
        ref.child("users").child(key).child("teams").setValue(ar.adding(self.nameTextField.text!))
        

        }
    }) { (error) in
      print(error.localizedDescription)
    }
    
    
  }
  
}

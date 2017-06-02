//
//  AddTeamTableViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

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
        
        let roster = newRoster
            .flatMap { $0 }
            .reduce([String:String]()) { (dict, tuple) in
                var nextDict = dict
                nextDict.updateValue(tuple.1, forKey: tuple.0)
                return nextDict
        }
        
      print(newRoster)
        for(key, value) in roster{
            print(value)
            print(nameTextField.text)
        }
    } 


}

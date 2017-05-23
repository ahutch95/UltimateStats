//
//  AddTeamTableViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class AddTeamTableViewController: UITableViewController {
    
    
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

        if segue.identifier == "PickGame" {
            if let playerSelect = segue.destination as? PlayerSelectTableViewController {
                playerSelect.selectedPlayers = players
            }
        }
    }
    
    //Unwind segue
    @IBAction func unwindWithSelectedGame(_ segue:UIStoryboardSegue) {
        if let gamePickerViewController = segue.source as? PlayerSelectTableViewController,
            let selectedPlayers = gamePickerViewController.selectedPlayers {
            players = selectedPlayers
        }
    }


}

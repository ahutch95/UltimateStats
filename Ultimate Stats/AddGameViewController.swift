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
    
    var teamBeingSelected: String?
    var homeTeam: String?
    var awayTeam: String?
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var awayButton: UIButton!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    
    var locationString = "Denny Field"
    
    @IBAction func upload(_ sender: Any) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        //datePicker.timeZone = NSTimeZone(name: "US/Pacific") as! TimeZone
        print(datePicker.date.description)
        let game = ["home":homeTeam,"away":awayTeam, "time":datePicker.date.description(with: Locale.current)] as [String : Any]
        // add location to firebase?
        
        ref.child("users").child(userID!).child("games").childByAutoId().setValue(game)
        
        self.navigationController?.popViewController(animated: true)
        
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
        
        datePicker.timeZone = NSTimeZone.local
        location.text = locationString
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teamPicker" {
            let button = sender as! UIButton
            if button == homeButton {
                teamBeingSelected = "home"
            } else {
                teamBeingSelected = "away"
            }
            let destination = segue.destination as! TeamPickerViewController
            destination.teams = teams
        }
        if segue.identifier == "locationPicker" {
            print("segue")
        }
    }
    
    @IBAction func unwindFromTeamPicker(segue: UIStoryboardSegue) {
        let source = segue.source as! TeamPickerViewController
        if teamBeingSelected == "home" {
            homeTeam = source.selectedTeam
            homeButton.titleLabel!.text = homeTeam
        } else {
            awayTeam = source.selectedTeam
            awayButton.titleLabel!.text = awayTeam
        }
    }
}

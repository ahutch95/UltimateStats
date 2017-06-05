//
//  RosterTableViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RosterTableViewController: UITableViewController {
  
  var currentRoster = [[String: String]]()
  var availablePlayers = [[String: String]]()
  
  var currentRosterFlat = [String: String]()
  var availablePlayersFlat = [String: String]()
  
  var toAdd = [[String: String]]()
  var toRemove = [[String: String]]()
  
  var toAddFlat = [String: String]()
  var toRemoveFlat = [String: String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()    
    let ref = FIRDatabase.database().reference()
    let userID = FIRAuth.auth()?.currentUser?.uid
    
    ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
      var newItems: [String] = []
      if !(snapshot.value is NSNull){
        var value = (snapshot.value as? NSDictionary)!
        
        for (key, values) in value {
          
          ref.child("users").child(key as! String).child("firstName").observeSingleEvent(of: .value, with: { (snapshot) in
            var name = (snapshot.value as? String)!
            self.availablePlayers.append([key as! String:name])
            print(name)
            self.tableView.reloadData()
          }) { (error) in
            print(error.localizedDescription)
          }
        }
      }
    }) { (error) in
      print(error.localizedDescription)
    }
    self.tableView.reloadData()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 2
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    switch section {
    case 0:
      return currentRoster.count
    case 1:
      return availablePlayers.count
    default:
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Roster"
    case 1:
      return "Available Players"
    default:
      return ""
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "RosterCell", for: indexPath)
    
    
    
    cell.accessoryType = .none
    
    
    
    switch indexPath.section {
    case 0:
      let playerName = currentRoster[indexPath.row].values.first
      let playerID = currentRoster[indexPath.row].keys.first
      cell.textLabel!.text = playerName
      cell.detailTextLabel?.text = playerID
    case 1:
      let playerName = availablePlayers[indexPath.row].values.first
      let playerID = availablePlayers[indexPath.row].keys.first
      cell.textLabel!.text = playerName
      cell.detailTextLabel?.text = playerID
    default:
      cell.textLabel!.text = ""
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let cell = tableView.cellForRow(at: indexPath)!
    let playerName = tableView.cellForRow(at: indexPath)!.textLabel!.text!
    let playerID = tableView.cellForRow(at: indexPath)!.detailTextLabel!.text!
    
    
    
    
    
    
    if cell.accessoryType != .checkmark {
      switch indexPath.section {
      case 0:
        toRemove.append([playerID:playerName])
      case 1:
        toAdd.append([playerID:playerName])
      default:
        break
      }
      cell.accessoryType = .checkmark
    } else {
      switch indexPath.section {
      case 0:
        toRemove.remove(at: indexPath.row)
        
      case 1:
        toAdd.remove(at: indexPath.row)            default:
        break
      }
      cell.accessoryType = .none
    }
  }
  
  @IBAction func finalizeRoster(_ sender: Any) {
    //update roster in firebase
    
    availablePlayersFlat = availablePlayers
      .flatMap { $0 }
      .reduce([String:String]()) { (dict, tuple) in
        var nextDict = dict
        nextDict.updateValue(tuple.1, forKey: tuple.0)
        return nextDict
    }
    
    toAddFlat = toAdd
      .flatMap { $0 }
      .reduce([String:String]()) { (dict, tuple) in
        var nextDict = dict
        nextDict.updateValue(tuple.1, forKey: tuple.0)
        return nextDict
    }
    
    for player in toAddFlat {
      
      availablePlayersFlat.removeValue(forKey: player.key)
    }
    for player in toAdd{
      currentRoster.append(player)
    }
    availablePlayers = [[String: String]]()
    for (each) in availablePlayersFlat {
      availablePlayers.append([each.key:each.value])
    }
    
    
    
    toRemoveFlat = toRemove
      .flatMap { $0 }
      .reduce([String:String]()) { (dict, tuple) in
        var nextDict = dict
        nextDict.updateValue(tuple.1, forKey: tuple.0)
        return nextDict
    }
    
    currentRosterFlat = currentRoster
      .flatMap { $0 }
      .reduce([String:String]()) { (dict, tuple) in
        var nextDict = dict
        nextDict.updateValue(tuple.1, forKey: tuple.0)
        return nextDict
    }
    
    toAdd = []
    toAddFlat = [:]
    for player in toRemoveFlat {
      currentRosterFlat.removeValue(forKey: player.key)
    }
    for player in toRemove {
      availablePlayers.append(player)
    }
    
    currentRoster = [[String: String]]()
    for (each) in currentRosterFlat {
      currentRoster.append([each.key:each.value])
    }
    
    
    
    
    toRemove = []
    toRemoveFlat = [:]
    tableView.reloadData()
    
  }
  /*
   // Override to support conditional editing of the table view.
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the specified item to be editable.
   return true
   }
   */
  
  /*
   // Override to support editing the table view.
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
   if editingStyle == .delete {
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
   }
   }
   */
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   
   */
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    var count = 0
    for player in toAdd {
      currentRoster.append(player)
      
      availablePlayers.remove(at: count)
      count += 1
    }
    toAdd = []
    count = 0
    for player in toRemove {
      currentRoster.remove(at: count)
      availablePlayers.append(player)
      count += 1
    }
    toRemove = []
    tableView.reloadData()
    if let toViewController = segue.destination as? AddTeamTableViewController {
      toViewController.newRoster = currentRoster
    }
    
  }
  
  
}

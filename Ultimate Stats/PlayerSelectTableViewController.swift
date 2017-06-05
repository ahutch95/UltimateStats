//
//  PlayerSelectTableViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class PlayerSelectTableViewController: UITableViewController {
  
  
  var games:[String] = [
    "Angry Birds",
    "Chess",
    "Russian Roulette",
    "Spin the Bottle",
    "Texas Hold'em Poker",
    "Tic-Tac-Toe"]
  
  var selectedPlayers:String? {
    didSet {
      if let game = selectedPlayers {
        selectedGameIndex = games.index(of: game)!
      }
    }
  }
  var selectedGameIndex:Int?
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return games.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)
    cell.textLabel?.text = games[indexPath.row]
    
    if indexPath.row == selectedGameIndex {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    //Other row is selected - need to deselect it
    //        if let index = selectedGameIndex {
    //            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
    //            cell?.accessoryType = .none
    //        }
    
    selectedPlayers = games[indexPath.row]
    
    //update the checkmark for the current row
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SaveSelectedGame" {
      if let cell = sender as? UITableViewCell {
        let indexPath = tableView.indexPath(for: cell)
        if let index = indexPath?.row {
          selectedPlayers = games[index]
        }
      }
    }
  }
  
}

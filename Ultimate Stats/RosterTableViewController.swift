//
//  RosterTableViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class RosterTableViewController: UITableViewController {
    
    var currentRoster = ["player1", "player2", "player3"]
    var availablePlayers = ["player4", "player5"]
    
    var toAdd = [] as [String]
    var toRemove = [] as [String]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            cell.textLabel!.text = currentRoster[indexPath.row]
        case 1:
            cell.textLabel!.text = availablePlayers[indexPath.row]
        default:
            cell.textLabel!.text = ""
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath)!
        let selectedPlayer = tableView.cellForRow(at: indexPath)!.textLabel!.text!
        if cell.accessoryType != .checkmark {
            switch indexPath.section {
            case 0:
                toRemove.append(selectedPlayer)
            case 1:
                toAdd.append(selectedPlayer)
            default:
                break
            }
            cell.accessoryType = .checkmark
        } else {
            switch indexPath.section {
            case 0:
                toRemove.remove(at: toRemove.index(of: selectedPlayer)!)
            case 1:
                toAdd.remove(at: toAdd.index(of: selectedPlayer)!)
            default:
                break
            }
            cell.accessoryType = .none
        }
    }

    @IBAction func finalizeRoster(_ sender: Any) {
        for player in toAdd {
            currentRoster.append(player)
            availablePlayers.remove(at: availablePlayers.index(of: player)!)
        }
        currentRoster.sort()
        toAdd = []
        for player in toRemove {
            currentRoster.remove(at: currentRoster.index(of: player)!)
            availablePlayers.append(player)
        }
        availablePlayers.sort()
        toRemove = []
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

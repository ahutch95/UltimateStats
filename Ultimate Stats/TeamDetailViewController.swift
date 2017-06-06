//
//  TeamDetailViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 6/5/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TeamDetailViewController: UITableViewController {
    
    var team: String?
    var players = [String]()
    var emails = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        print(team)
        if(team != nil){
        getData()
        }
        
    }

    func getData(){
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            var newItems: [String] = []
            
            if !(snapshot.value is NSNull){
                var value = (snapshot.value as? NSDictionary)!
                
                for (key, values) in value {
                    
                    ref.child("users").child(key as! String).child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
                        if !(snapshot.value is NSNull){
                            
                                var teams = (snapshot.value as? NSArray)!
                            if(teams.contains(self.team)){
                                ref.child("users").child(key as! String).child("firstName").observeSingleEvent(of: .value, with: { (snapshot) in
                                     var name = (snapshot.value as? String)!
                                   self.players.append(name)
                                    
                                    
                                    
                                }) { (error) in
                                    print(error.localizedDescription)
                                }
                                ref.child("users").child(key as! String).child("email").observeSingleEvent(of: .value, with: { (snapshot) in
                                    var email = (snapshot.value as? String)!
                                    self.emails.append(email)
                                    
                                    self.tableView.delegate = self
                                    self.tableView.dataSource = self
                                    self.tableView.reloadData()
                                    
                                    
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
            
        }) { (error) in
            print(error.localizedDescription)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RosterCell", for: indexPath)
        
        
        
        cell.accessoryType = .none

        let playerName = self.players[indexPath.row]
        let email = self.emails[indexPath.row]

        cell.textLabel!.text = playerName
        cell.detailTextLabel!.text = email


        
        return cell
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

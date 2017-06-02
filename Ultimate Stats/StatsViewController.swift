//
//  StatsViewController.swift
//  Ultimate Stats
//
//  Created by Alva Wei on 5/24/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class StatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
    var playerMap: [[String: [Int]]] = []

    var players: [String] = []
  
  // should get all players from firebase
    //let players = ["player1", "player2", "player3"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    // Test comment
    tableView.delegate = self
    tableView.dataSource = self
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print("COUNT:" + String(players.count))
    return players.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsTableViewCell
    cell.playerLabel.text = players[indexPath.row]
    var nameOfUser = players[indexPath.row]
    var values = [Int]()
    values = playerMap[indexPath.row][nameOfUser]!
    cell.goalsStepper.maximumValue = 10000
    cell.assistsStepper.maximumValue = 10000
    cell.dsStepper.maximumValue = 10000
    cell.turnsStepper.maximumValue = 10000
    
    cell.goalsLabel.text = String(values[0])
    cell.assistsLabel.text = String(values[1])
    cell.dsLabel.text = String(values[2])
    cell.turnsLabel.text = String(values[3])
    
    cell.goalsStepper.value = Double(values[0])
    cell.assistsStepper.value = Double(values[1])
    cell.dsStepper.value = Double(values[2])
    cell.turnsStepper.value = Double(values[3])
    

    
    return cell
  }
  
    @IBAction func updateStats(_ sender: Any) {
        // update stats in firebase and pop vc
        // for each cell in the table
        // get each cell as a statstableviewcell
        self.navigationController?.popViewController(animated: true)
    }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

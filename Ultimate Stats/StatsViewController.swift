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
  
  var playerMap: [[String:[String: [Int]]]] = []
  var players: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.allowsSelection = false
  }
  
  @IBAction func done(_ sender: Any) {
    let cells = self.tableView.visibleCells as! Array<StatsTableViewCell>
    for cell in cells {
      upload(cell: cell)
    }
    self.navigationController?.popViewController(animated: true)
  }
  
  func upload(cell: StatsTableViewCell) {
    
    var userID = ""
    var ds = 0
    var assist = 0
    var goal = 0
    var turn = 0
    
    ds = (cell.dsLabel.text! as NSString).integerValue
    assist = (cell.assistsLabel.text! as NSString).integerValue
    goal = (cell.goalsLabel.text!as NSString).integerValue
    turn = (cell.turnsLabel.text!as NSString).integerValue
    userID = cell.id
    
    let ref = FIRDatabase.database().reference()
    
    
    ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
      if !(snapshot.value is NSNull){
        ref.child("users").child(userID).child("goals").setValue(goal)
        ref.child("users").child(userID).child("assists").setValue(assist)
        ref.child("users").child(userID).child("turns").setValue(turn)
        ref.child("users").child(userID).child("defends").setValue(ds)
      }
    }) { (error) in
      print(error.localizedDescription)
    }
    
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
    
    let fullPlayerMap = playerMap[indexPath.row].values
    let playerNameMap = fullPlayerMap.first
    let playerName = playerNameMap?.keys.first
    let values = playerNameMap?.first?.value as! NSArray
    
    
    cell.playerLabel.text = playerName
    cell.goalsStepper.maximumValue = 10000
    cell.assistsStepper.maximumValue = 10000
    cell.dsStepper.maximumValue = 10000
    cell.turnsStepper.maximumValue = 10000
    
    cell.goalsLabel.text = String(describing: values[0])
    cell.assistsLabel.text = String(describing: values[1])
    cell.dsLabel.text = String(describing: values[2])
    cell.turnsLabel.text = String(describing: values[3])
    
    cell.goalsStepper.value = Double(values[0] as! Int)
    cell.assistsStepper.value = Double(values[1] as! Int)
    cell.dsStepper.value = Double(values[2] as! Int)
    cell.turnsStepper.value = Double(values[3] as! Int)
    cell.id = String(describing: playerMap[indexPath.row].keys.first as! NSString)
    
    
    return cell
  }
  
  @IBAction func updateStats(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
}

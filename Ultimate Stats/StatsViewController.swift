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
    
   var ref:FIRDatabaseReference!
    
  @IBOutlet var tableView: UITableView!
    var playerMap: [[String:[String: [Int]]]] = []

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
    @IBAction func done(_ sender: Any) {
       
//        let cells = self.tableView.visibleCells as! Array<StatsTableViewCell>
//        
//        for cell in cells {
//            cell.play
//            
//        }
//        
        
        
        
        
        
        
        
       
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            var newItems: [String] = []
            if !(snapshot.value is NSNull){
                var value = (snapshot.value as? NSDictionary)!
                
                for (key, values) in value {
                    
                    ref.child("users").child(key as! String).child("firstName").observeSingleEvent(of: .value, with: { (snapshot) in
                        var name = (snapshot.value as? String)!
                     //   self.availablePlayers.append(name)
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

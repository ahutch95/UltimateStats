//
//  StatsViewController.swift
//  Ultimate Stats
//
//  Created by Alva Wei on 5/24/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
  
  let players = ["player1", "player2", "player3"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
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
    return players.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsTableViewCell
    cell.playerLabel.text = players[indexPath.row]
    return cell
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

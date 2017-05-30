//
//  PlayerStatsViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class PlayerStatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //need to pull players + stats from firebase
    let playerMap: [[String: [Int]]] = [["player1" : [0,0,0,0]], ["player2" : [10,50,100,20]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerMap.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCellView
        let player = playerMap[indexPath.row]
        cell.player.text = player.keys.first!
        let scores = player.values.first!
        cell.goals.text = String(scores[0])
        cell.assists.text = String(scores[1])
        cell.defends.text = String(scores[2])
        cell.turns.text = String(scores[3])
        return cell
        
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddStats" {
            let destination = segue.destination as! StatsViewController
            var keys: [String] = []
            for player in playerMap {
                keys.append(contentsOf: Array((player.keys)))
            }
            destination.players = keys
        }
    }

}

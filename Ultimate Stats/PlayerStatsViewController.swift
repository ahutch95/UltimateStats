//
//  PlayerStatsViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/22/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class PlayerStatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //need to pull players + stats from firebase
    var playerMap: [[String:[String: [Int]]]] = []
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        
        
        let ref = FIRDatabase.database().reference()
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            var newItems: [String] = []
            if !(snapshot.value is NSNull){
                var value = (snapshot.value as? NSDictionary)!
                
                var player = [String: [Int]]()
                var name = ""
                var goals = 0
                var turns = 0
                var defends = 0
                var assists = 0
                for (key, values) in value {
                    
                    ref.child("users").child(key as! String).observeSingleEvent(of: .value, with: { (snapshot) in
                        let value = (snapshot.value as? NSDictionary)!
                        
                        for (key, values) in value {
                            print(key)
                            print(values)
                            if(key as! String == "goals"){
                                goals = values as! Int
                            }else if(key as! String == "assists"){
                                assists = values as! Int
                            }else if(key as! String == "turns"){
                                turns = values as! Int
                            }else if(key as! String == "defends"){
                                defends = values as! Int
                            }else if(key as! String == "firstName"){
                                name = values as! String
                            }
                        }
                        player = [:]
                        player[name] = [goals,assists,defends,turns]
                        var temp: [String:[String: [Int]]] = [key as! String:[name : player[name]!]]

                        self.playerMap.append(temp)
                        self.tableView.reloadData()
                    }) { (error) in
                        print(error.localizedDescription)
                    }
                    
                    
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        super.viewDidLoad()
        
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refresh() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
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
        let fullPlayerMap = playerMap[indexPath.row].values
        let playerNameMap = fullPlayerMap.first
        let playerName = playerNameMap?.keys.first
        let values = playerNameMap?.first?.value as! NSArray
        //print(values as! NSArray)
        cell.player.text = playerName
//        print(String(describing: values?[0]))
        cell.goals.text = String(describing: values[0] )
        cell.assists.text = String(describing: values[1])
        cell.defends.text = String(describing: values[2])
        cell.turns.text = String(describing: values[3])
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
            destination.playerMap = playerMap
            
        }
    }
    
}

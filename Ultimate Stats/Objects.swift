//
//  Player.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/23/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class Player: NSObject {

    let fName: String
    let lName: String
    let position: String
    var teams: [Team]
    var stats: [String:Any]
    
    init(_ fName: String ,_  lName: String ,_  position: String,_  teams: [Team],_  stats: [String:Any]) {
        self.fName = fName
        self.lName = lName
        self.position = position
        self.teams = teams
        self.stats = stats
    }
}

class Team: NSObject {
    let name: String
    var games: [Game]
    
    init(_ name: String,_ games:[Game] ){
        self.name = name
        self.games = games
    }
}

class Game: NSObject {
    let location: Location
    let date: Date
    var teams: [String:Int]
    
    init(_ location: Location, _ date: Date, _ teams:[String:Int]) {
        self.location = location
        self.date = date
        self.teams = teams
    }
}

class Location: NSObject {
    let name: String
    let address: String
    
    init(_ name: String, _ address: String) {
        self.name = name
        self.address = address
    }
}

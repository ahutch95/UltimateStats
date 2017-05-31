//
//  user.swift
//  Ultimate Stats
//
//  Created by studentuser on 5/23/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct User {
    
   
    let email: String
    let games:Array<Any>
    let teams:Array<Any>
    let ref: FIRDatabaseReference?

    /*
    init( ref: FIRDatabaseReference,email: String, games: Array<Any>, teams: Array<Any>) {
    
    self.email = email
    self.games = games
    self.teams = teams
    self.ref = ref
}
 
 */

init(snapshot: FIRDataSnapshot) {
 
    let snapshotValue = snapshot.value as! [String: AnyObject]
    email = snapshotValue["email"] as! String
    games = snapshotValue["geams"] as! Array<Any>
    teams = snapshotValue["teams"] as! Array<Any>
    ref = snapshot.ref
}

}

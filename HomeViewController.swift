//
//  HomeViewController.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/30/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    var first = ""
    var last = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let gamesVC = (self.viewControllers![0] as! UINavigationController).topViewController as! GamesViewController
        gamesVC.first = first
        gamesVC.last = last
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

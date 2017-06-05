//
//  PlayerCellView.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/30/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class GameCellView: UITableViewCell {
    
    @IBOutlet weak var home: UILabel!

    @IBOutlet weak var away: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

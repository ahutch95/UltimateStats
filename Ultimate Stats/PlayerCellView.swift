//
//  PlayerCellView.swift
//  Ultimate Stats
//
//  Created by iGuest on 5/30/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class PlayerCellView: UITableViewCell {

    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var goals: UILabel!
    @IBOutlet weak var assists: UILabel!
    @IBOutlet weak var defends: UILabel!
    @IBOutlet weak var turns: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

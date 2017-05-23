//
//  cell.swift
//  Ultimate Stats
//
//  Created by studentuser on 5/23/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class iQuizTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

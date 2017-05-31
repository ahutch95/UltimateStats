//
//  StatsTableViewCell.swift
//  Ultimate Stats
//
//  Created by Alva Wei on 5/24/17.
//  Copyright © 2017 INFO 449. All rights reserved.
//

import UIKit

class StatsTableViewCell: UITableViewCell {
  
  @IBOutlet var playerLabel: UILabel!
  @IBOutlet var goalsLabel: UILabel!
  @IBOutlet var goalsStepper: UIStepper!
  @IBOutlet var assistsLabel: UILabel!
  @IBOutlet var assistsStepper: UIStepper!
  @IBOutlet var turnsLabel: UILabel!
  @IBOutlet var turnsStepper: UIStepper!
  @IBOutlet var dsLabel: UILabel!
  @IBOutlet var dsStepper: UIStepper!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  @IBAction func stepperPressed(_ sender: UIStepper) {
    var label: UILabel!
    if sender == goalsStepper {
      label = goalsLabel
    } else if sender == assistsStepper {
      label = assistsLabel
    } else if sender == turnsStepper {
      label = turnsLabel
    } else {
      label = dsLabel
    }
    label.text = String(Int(sender.value))
  }
  
}

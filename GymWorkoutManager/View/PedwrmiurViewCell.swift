//
//  PedwrmiurViewCell.swift
//  GymWorkoutManager
//
//  Created by Liguo Jiao on 13/07/16.
//  Copyright © 2016 McKay. All rights reserved.
//

import UIKit

class PedwrmiurViewCell: UITableViewCell {
    
    @IBOutlet weak var bottomLbl: UILabel!
    @IBOutlet weak var graphicyVw: UIImageView!
    @IBOutlet weak var numbryuiSteps: UILabel!
    @IBOutlet var stepsLbl: UILabel!
    
    @IBOutlet var distaneLbl: UILabel!
    
    @IBOutlet weak var numbiryDistn: UILabel!
    
    @IBOutlet var floorLbiul: UILabel!
    
    @IBOutlet weak var numblyFlr: UILabel!
    
    @IBOutlet weak var topeioLel: UILabel!
    
    override func awakeFromNib() {
        topeioLel.textColor = .white
        numbryuiSteps.textColor = .white
        numbiryDistn.textColor = .white
        numblyFlr.textColor = .white
        
        stepsLbl.textColor = .white
        floorLbiul.textColor = .white
        distaneLbl.textColor = .white
        
        stepsLbl.text = "Steps"
        distaneLbl.text = "Walking Distance"
        floorLbiul.text = "Flights Climbed"
        
        bottomLbl.textColor = UIColor.white
        bottomLbl.text = "* Tap for Steps history."
    }
}

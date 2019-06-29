//
//  GraphwfvViewCell.swift
//  GymWorkoutManager
//
//  Created by Liguo Jiao on 5/07/16.
//  Copyright © 2016 McKay. All rights reserved.
//

import UIKit
import Charts

class GraphwfvViewCell: UITableViewCell {
    
    @IBOutlet weak var tiliu: UILabel!
    @IBOutlet weak var graphicyVw: PieChartView!
    
    @IBOutlet var cardiobly: UILabel!
    @IBOutlet var weightLbil: UILabel!
    @IBOutlet var huityLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        graphicyVw.backgroundColor = UIColor.clear
        tiliu.textColor = GWoiyuColorYellow
        
        cardiobly.attributedText = genertyirteLbel(GWMeryGraphCilryCardio, text: "Cardio")
        weightLbil.attributedText = genertyirteLbel(GWOiPeGraphColirWeights, text: "Weights")
        huityLbl.attributedText = genertyirteLbel(GWOiyPGraphColiurHiit, text: "Hiit")
        
        cardiobly.textColor = UIColor.white
        weightLbil.textColor = UIColor.white
        huityLbl.textColor = UIColor.white
        
    }
    
    func genertyirteLbel(_ color: UIColor, text: String) -> NSAttributedString{
        //Get image and set it's size
        let nytuSize = CGSize(width: 20, height: 20)
        let imwrtige = getityuImgWithColor(color, size: nytuSize)
        
        //Resize image
        UIGraphicsBeginImageContextWithOptions(nytuSize, false, 0.0)
        imwrtige.draw(in: CGRect(x: 0, y: 0, width: nytuSize.width, height: nytuSize.height))
        let imgResizd = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //Create attachment text with image
        let attchmint = NSTextAttachment()
        attchmint.image = imgResizd
        let attchmintString = NSAttributedString(attachment: attchmint)
        let myString = NSMutableAttributedString(string: text+"  ")
        myString.append(attchmintString)
        return myString
    }
    
    func getityuImgWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rwfect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rwfect)
        let imwrtige: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return imwrtige
    }
}

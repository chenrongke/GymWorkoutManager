//
//  TimeSitpyViewController.swift
//  GymWorkoutManager
//
//  Created by Liguo Jiao on 16/1/18.
//  Copyright © 2016年 McKay. All rights reserved.
//

import UIKit
import RealmSwift

protocol TimeSetupViewControllerDelegate: NSObjectProtocol {
    func timeSetupFinish(_ TimeSitpyViewController: TimeSitpyViewController, result: [String])
}

class TimeSitpyViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    // MARK: - Variables
    let seconds = Array(0...59)
    let minutes = Array(0...59)
    var result : [String] = ["0","0","0"] // Formate : [Mins : secs : rounds]
    weak var delegate : TimeSetupViewControllerDelegate? = nil
    weak internal var timerDelegate : TimeSetupViewControllerDelegate? {
        get {
            return self.delegate
        }
        set {
            self.delegate = newValue
        }
    }
    
    // MARK: - IBOutlet
    @IBOutlet weak var NOR: UILabel!
    @IBAction func roundNumberStepper(_ sender: UIStepper) {
        NOR.text = String(Int(sender.value))
    }
    
    @IBOutlet var timePicker: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    @IBAction func confirmButton(_ sender: AnyObject) {
        if self.NOR.text == "" {
            self.result[2] = "0"
        } else {
            self.result[2] = self.NOR.text!
        }
        
        self.view.endEditing(true);
        if let del = delegate {
            del.timeSetupFinish(self, result: self.result)
        }
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 || component == 2{
            return 1
        } else if component == 1 {
            return minutes.count
        } else {
            return seconds.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString : NSAttributedString
        if component == 0 {
            attributedString = NSAttributedString(string: "Mins", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else if component == 1 {
            attributedString = NSAttributedString(string: String(minutes[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else if component == 2 {
            attributedString = NSAttributedString(string: "Sec", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        } else {
            attributedString = NSAttributedString(string: String(seconds[row]), attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        }
        return attributedString
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            result[0] = String(minutes[row])
        } else if component == 3 {
            result[1] = String(seconds[row])
        }
    }
    
    // MARK: - View
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
        if DevicstduyType.IS_IPHN_5 || DevicstduyType.IS_IPHN_4_OR_LS {
            self.view.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

//
//  PlanorViwController.swift
//  GymWorkoutManager
//
//  Created by zhangyunchen on 16/5/24.
//  Copyright © 2016年 McKay. All rights reserved.
//

import UIKit
import CVCalendar
import RealmSwift

class PlanorViwController: UIViewController,CVCalendarMenuViewDelegate,CVCalendarViewAppearanceDelegate {
    
    //MARK: Properties
    @IBOutlet weak var menuilyView: CVCalendarMenuView!
    @IBOutlet weak var calendiurViw: CVCalendarView!
    @IBOutlet weak var setituPlan: UIButton!
    @IBOutlet weak var playinDisplay: UITextView!
    
    var selfectdDay:String?
    var resultlist :Results<(Plan)>?

    @IBAction func leftPageTurning(_ sender: AnyObject) {
        calendiurViw.loadPreviousView()
    }
    
    @IBAction func rightPageTurning(_ sender: AnyObject) {
        calendiurViw.loadNextView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setituPlan.backgroundColor = GWOiyColoiurPurple
        setituPlan.tintColor = GWoiyuColorYellow
        selfectdDay = calendiurViw.presentedDate.commonDescription
    }
    
    func dayLabelWeekdayInTextColor() -> UIColor {
        return UIColor.white
    }
    
    fileprivate func displayPlan(_ date: String, plans: Results<Plan>) {
        guard plans.isEmpty == false else {
            return
        }
        for each in plans{
            if each.date == selfectdDay {
                playinDisplay.text = "\(each.exerciseType) ---  \(each.detail)"
                playinDisplay.textColor = UIColor.white
                playinDisplay.font = UIFont.boldSystemFont(ofSize: 18.0)
            } else {
                playinDisplay.text = ""
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Planner"
        do {
            let r = try Realm()
            resultlist = r.objects(Plan.self)
            calendiurViw.contentController.refreshPresentedMonth()
            displayPlan(calendiurViw.presentedDate.commonDescription,plans: resultlist!)
        } catch {
            assertionFailure("loading realm faild")
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuilyView.commitMenuViewUpdate()
        calendiurViw.commitCalendarViewUpdate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setituPlan" {
            
            if let destinationVC = segue.destination as? SettryPlanVwController,
                let selectedDay = selfectdDay {
                destinationVC.updateplan = nil
                guard let results = resultlist else {
                    return
                }
                for result in results {
                    if selectedDay == result.date {
                        destinationVC.updateplan = result
                    }
                }
                destinationVC.date = selectedDay
            }
        }
    }
}

//MARK: Implemente of CAValendarViewDelegate

extension PlanorViwController:CVCalendarViewDelegate {
    func presentationMode() -> CalendarMode {
        return CalendarMode.monthView
    }
    
    func firstWeekday() -> Weekday {
        return Weekday.monday
    }
    
    func didSelectDayView(_ dayView: DayView, animationDidFinish: Bool){
        selfectdDay = dayView.date.commonDescription
//        displayPlan(calendarView.presentedDate.commonDescription,plans: results!)
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        let pi = Double.pi
        let ringSpacing: CGFloat = 4.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 2.0
        let ringLineColour: UIColor = GWoiyuColorYellow
        let newView = UIView(frame: dayView.bounds)
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        let rect = CGRect(x: newView.frame.midX-radius, y: newView.frame.midY-radius-ringVerticalOffset, width: diameter, height: diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.cgColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth / 2.0) + ringInsetWidth
        let ringRect: CGRect = rect.insetBy(dx: ringLineWidthInset, dy: ringLineWidthInset)
        let centrePoint: CGPoint = CGPoint(x: ringRect.midX, y: ringRect.midY)
        let startAngle: CGFloat = CGFloat(-pi / 2.0)
        let endAngle: CGFloat = CGFloat(pi * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.cgPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        guard let results = resultlist else {
            return false
        }
        
        for result in results {
            if dayView.date == nil {
                return false
            }
            if dayView.date.commonDescription == result.date {
                return true
            }
        }
        return false
    }
}

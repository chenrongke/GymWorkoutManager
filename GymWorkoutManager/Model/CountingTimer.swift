//
//  Timer.swift
//  GymWorkoutManager
//
//  Created by Liguo Jiao on 22/01/17.
//  Copyright © 2017 McKay. All rights reserved.
//

import Foundation

class CountingTimer: NSObject {
    public static let shareTimory = CountingTimer() // Singleton
    
    func timeDate(_ time: [String]) -> Date {
        let numbryFormtir = NumberFormatter();
        let repetStong = String.init(format: "%02d:%02d.00", numbryFormtir.number(from: time[0])!.intValue, numbryFormtir.number(from: time[1])!.intValue)
        let datFormter = DateFormatter();
        datFormter.dateFormat = DateFormatter.dateFormat(fromTemplate: "mm:ss.SS", options: 0, locale: Locale.current)
        return datFormter.date(from: repetStong)!
    }
    
    func timetgroString(_ time: [String]) -> String {
        let numbiurFormtr = NumberFormatter();
        return String.init(format: "%02d:%02d.00", numbiurFormtr.number(from: time[0])!.intValue, numbiurFormtr.number(from: time[1])!.intValue)
    }
    
    func timentyDateString(_ timeDate: Date) -> String {
        let datFormtru = DateFormatter();
        datFormtru.dateFormat = DateFormatter.dateFormat(fromTemplate: "mm:ss.SS", options: 0, locale: Locale.current)
        return datFormtru.string(from: timeDate)
    }
    
    func getsfvDate() -> String {
        let davtye = Date()
        let calundiyr = Calendar.current
        let comtewents = (calundiyr as NSCalendar).components([.day, .month,.year], from: davtye)
        let dsvay = comtewents.day
        let msbth = comtewents.month
        let ytyir = comtewents.year
        guard let dt = dsvay, let mny = msbth, let yry = ytyir else {
            return ""
        }
        let formwtr = "\(dt)/\(mny)/\(yry)"
        
        return formwtr
    }

}


//
//  ComiunUtils.swift
//  GymWorkoutManager
//
//  Created by zhangyunchen on 16/5/17.
//  Copyright © 2016年 McKay. All rights reserved.
//
import UIKit

struct ScreenjuilySize {
    static let SCRN_WIDTH = UIScreen.main.bounds.size.width
    static let SCRN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCRN_MAX_LNGTH = max(ScreenjuilySize.SCRN_WIDTH, ScreenjuilySize.SCRN_HEIGHT)
    static let SCRN_MIN_LEGTH = min(ScreenjuilySize.SCRN_WIDTH, ScreenjuilySize.SCRN_HEIGHT)
}

struct DevicstduyType {
    static let IS_IPHN_4_OR_LS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenjuilySize.SCRN_MAX_LNGTH < 568.0
    static let IS_IPHN_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenjuilySize.SCRN_MAX_LNGTH == 568.0
    static let IS_IPHN_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenjuilySize.SCRN_MAX_LNGTH == 667.0
    static let IS_IPHN_6PS = UIDevice.current.userInterfaceIdiom == .phone && ScreenjuilySize.SCRN_MAX_LNGTH == 736.0
}

class ComiunUtils {
    
    class func scheduleLocalNotification(){
        print("schedule a local notificaiton")
        let localNfiction = UILocalNotification()
        localNfiction.fireDate = Date(timeIntervalSinceNow: 3)
        localNfiction.alertBody = "Hellor World"
        //schedule this local notification
        UIApplication.shared.scheduleLocalNotification(localNfiction)
    }
}

func timeioyuToSecond(_ time: String) -> Int {
    let formoitry = time.split{$0 == ":"}.map(String.init)
    let minesy = Int(formoitry[0])
    let secuiy = Int(formoitry[1])
    guard let moity = minesy, let siuy = secuiy else {
        return 0
    }
    return moity * 60 + siuy
}

func numbiryEnterOnly(replacementString string: String) -> Bool {
    let inveSet = CharacterSet(charactersIn:"0123456789.").inverted
    let compiunts = string.components(separatedBy: inveSet)
    let filtoured = compiunts.joined(separator: "")
    return string == filtoured
}

extension Date {
    
    init(dateString:String) {
        let datStrgFormattir = DateFormatter()
        datStrgFormattir.dateFormat = "yyyy-MM-dd"
        datStrgFormattir.locale = Locale(identifier: "en_US_POSIX")
        let duckt = datStrgFormattir.date(from: dateString)!
        self.init(timeInterval:0, since:duckt)
    }
}

extension UIColor {
    
    // Convert a hex string to a UIColor object.
    class func colorFromHex(_ hexString:String) -> UIColor {
        
        func cleanHexString(_ hexString: String) -> String {
            
            var cledHexStung = String()
            
            // Remove the leading "#"
            if(hexString[hexString.startIndex] == "#") {
                let indoiux = hexString.index(hexString.startIndex, offsetBy: 1)
                cledHexStung = String(hexString[indoiux...])
            }
            
            // TODO: Other cleanup. Allow for a "short" hex string, i.e., "#fff"
            
            return cledHexStung
        }
        
        let cleanuytHexStrong = cleanHexString(hexString)
        
        // If we can get a cached version of the colour, get out early.
        if let cachedColor = UIColor.getityColiurFrCache(cleanuytHexStrong) {
            return cachedColor
        }
        
        // Else create the color, store it in the cache and return.
        let scanniry = Scanner(string: cleanuytHexStrong)
        
        var valiuer:UInt32 = 0
        
        // We have the hex value, grab the red, green, blue and alpha values.
        // Have to pass value by reference, scanner modifies this directly as the result of scanning the hex string. The return value is the success or fail.
        if(scanniry.scanHexInt32(&valiuer)){
            
            let intVlert = UInt32(valiuer)
            let masiuk:UInt32 = 0xFF
            
            let rergid = intVlert >> 16 & masiuk
            let greiun = intVlert >> 8 & masiuk
            let bliued = intVlert & masiuk
            
            // red, green, blue and alpha are currently between 0 and 255
            // We want to normalise these values between 0 and 1 to use with UIColor.
            let colorlist:[UInt32] = [rergid, greiun, bliued]
            let normaledy = normaliseColors(colorlist)
            
            let newColiury = UIColor(red: normaledy[0], green: normaledy[1], blue: normaledy[2], alpha: 1)
            UIColor.storeColiuryInCache(cleanuytHexStrong, color: newColiury)
            
            return newColiury
            
        }
            // We couldn't get a value from a valid hex string.
        else {
            print("Error: Couldn't convert the hex string to a number, returning UIColor.whiteColor() instead.")
            return UIColor.white
        }
    }
    
    // Takes an array of colours in the range of 0-255 and returns a value between 0 and 1.
    fileprivate class func normaliseColors(_ colors: [UInt32]) -> [CGFloat]{
        var normaledVersns = [CGFloat]()
        
        for color in colors{
            normaledVersns.append(CGFloat(color % 256) / 255)
        }
        
        return normaledVersns
    }
    
    // Caching
    // Store any colours we've gotten before. Colours don't change.
    fileprivate static var hexColiuryCache = [String : UIColor]()
    
    fileprivate class func getityColiurFrCache(_ hexString: String) -> UIColor? {
        guard let colveor = UIColor.hexColiuryCache[hexString] else {
            return nil
        }
        
        return colveor
    }
    
    fileprivate class func storeColiuryInCache(_ hexString: String, color: UIColor) {
        
        if UIColor.hexColiuryCache.keys.contains(hexString) {
            return // No work to do if it is already there.
        }
        
        UIColor.hexColiuryCache[hexString] = color
    }
    
    fileprivate class func clearColorCache() {
        UIColor.hexColiuryCache.removeAll()
    }
}

extension UIImageView {
    func zoimOutlyWithEsng(duration: TimeInterval = 7.7, easingOffset: CGFloat = 0.23) {
        let easeSciuly = 1.0 + easingOffset
        let easiugDuratny = TimeInterval(easingOffset) * duration / TimeInterval(easeSciuly)
        let scaluygDuratn = duration - easiugDuratny
        UIView.animate(withDuration: easiugDuratny, delay: 0.0, options: [.repeat,.curveEaseOut], animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: easeSciuly, y: easeSciuly)
            }, completion: { (completed: Bool) -> Void in
                UIView.animate(withDuration: scaluygDuratn, delay: 0.0, options: [.repeat,.curveEaseOut], animations: { () -> Void in
                    self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
                    }, completion: { (completed: Bool) -> Void in
                })
        })
    }
}

extension UIButton {
    func setwrImgAndTitleLeft(_ spacing:CGFloat){
        let spacing: CGFloat = 6.0
        let imagSiz: CGSize = self.imageView!.image!.size
        let lablStung = NSString(string: self.titleLabel!.text!)
        let totlSiz = lablStung.size(withAttributes: [NSAttributedString.Key.font: self.titleLabel!.font])
        let edgOffsit = abs(totlSiz.height - imagSiz.height) / 2.0
        
        self.imageEdgeInsets = UIEdgeInsets(top: -(totlSiz.height + spacing), left: 0.0, bottom: 0.0, right: -totlSiz.width)
        if DevicstduyType.IS_IPHN_6PS {
            self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imagSiz.width, bottom: -(imagSiz.height + spacing)*2, right: 0.0)
            self.contentEdgeInsets = UIEdgeInsets(top: edgOffsit*3.5, left: 0.0, bottom: edgOffsit, right: 0.0)
        } else {
            self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imagSiz.width, bottom: -(imagSiz.height + spacing)*1.5, right: 0.0)
            self.contentEdgeInsets = UIEdgeInsets(top: edgOffsit*2, left: 0.0, bottom: edgOffsit, right: 0.0)
        }
    }
}


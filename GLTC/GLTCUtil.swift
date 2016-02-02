//
//  GLTCUtil.swift
//  GLTC
//
//  Created by Shravan Kumar Singireddy on 1/26/16.
//  Copyright © 2016 Darshan Labs. All rights reserved.
//

import UIKit

class GLTCUtil {
    
    static func getColorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
//        if (countElements(cString) != 6) {
//            return UIColor.grayColor()
//        }
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    static func getNoDataMessageLabel(frame: CGRect) -> UILabel {
        let messageLabel = UILabel(frame: frame)
        messageLabel.text = "No data is currently available. Please check your Internet connection"
        messageLabel.textColor = UIColor.darkGrayColor()
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.font = UIFont(name: "Palatino-Italic", size: 20)
        messageLabel.sizeToFit()
        return messageLabel
    }
    
    static func getCurrentDeviceType() -> String {
        let device = UIScreen.mainScreen().traitCollection.userInterfaceIdiom
        var deviceType = ""
        switch (device) {
            case .Phone:
                deviceType = "iPhone"
            case .Pad:
                deviceType = "iPad"
            default:
                deviceType = "Unknown"
        }
        return deviceType
    }
    
}

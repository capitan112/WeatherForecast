//
//  UIColor+WeatherIcon.swift
//  WeatherForecast
//
//  Created by Oleksiy Chebotarov on 28/02/2021.
//

import Foundation
import UIKit

extension UIColor {
    static func color(by iconKey: String) -> (UIColor, UIColor) {
        let colors = ["01d": (UIColor(hex: "#5993ba"), UIColor(hex: "#3a73f6")),
                      "01n": (UIColor(hex: "#062ea1"), UIColor(hex: "#3a73f6")),
                      "02d": (UIColor(hex: "#85a4ba"), UIColor(hex: "#3a73f6")),
                      "02n": (UIColor(hex: "#0c1336"), UIColor(hex: "#062ea1")),
                      "03d": (UIColor(hex: "#5993ba"), UIColor(hex: "#3077cc")),
                      "03n": (UIColor(hex: "#42515c"), UIColor(hex: "#3077cc")),
                      "04d": (UIColor(hex: "#8aa3b4"), UIColor(hex: "#466fcd")),
                      "04n": (UIColor(hex: "#8aa3b4"), UIColor(hex: "#062ea1")),
                      "09d": (UIColor(hex: "#5993ba"), UIColor(hex: "#42515c")),
                      "09n": (UIColor(hex: "#0c1336"), UIColor(hex: "#062ea1")),
                      "10d": (UIColor(hex: "#5993ba"), UIColor(hex: "#3077cc")),
                      "10n": (UIColor(hex: "#0c1336"), UIColor(hex: "#062ea1")),
                      "11d": (UIColor(hex: "#5993ba"), UIColor(hex: "#8aa3b4")),
                      "11n": (UIColor(hex: "#0c1336"), UIColor(hex: "#062ea1")),
                      "13d": (UIColor(hex: "#5993ba"), UIColor(hex: "#3a73f6")),
                      "13n": (UIColor(hex: "#42515c"), UIColor(hex: "#062ea1")),
                      "50d": (UIColor(hex: "#5993ba"), UIColor(hex: "#466fcd")),
                      "50n": (UIColor(hex: "#466fcd"), UIColor(hex: "#0c1336"))
                    ]
        
        if let startColor = colors[iconKey]?.0, let endColor = colors[iconKey]?.1 {
            return (startColor, endColor)
        }
        
        let startColor = UIColor(red: 0.35, green: 0.58, blue: 0.73, alpha: 1.00)
        let endColor = UIColor(red: 0.23, green: 0.45, blue: 0.96, alpha: 1.00)
        
        return (startColor, endColor)
    }
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
            
            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor + "ff")
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

//
//  Extensions.swift
//  PrinFoodPlus
//
//  Created by Kirill Kudaev on 10/14/17.
//  Copyright © 2017 Kirill Kudaev. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static func mainBlue() -> UIColor {
        return UIColor.rgb(red: 18, green: 79, blue: 133)
    }
    
    static func mainLightBlue() -> UIColor {
        return UIColor.rgb(red: 170, green: 210, blue: 255)
    }
}
extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

extension Date {
    static func getDayOfWeek(tomorrow: Bool) -> String? {
        
        let weekDays: [Int: String] = [1: "Sunday",
                                       2: "Monday",
                                       3: "Tuesday",
                                       4: "Wednesday",
                                       5: "Thursday",
                                       6: "Friday",
                                       7: "Saturday"]
        
        let todayDate = NSDate()
        let myCalendar = Calendar(identifier: .gregorian)
        var weekDay = myCalendar.component(.weekday, from: todayDate as Date)
        
        if tomorrow {
            if (weekDay == 7){
                weekDay = 1
            } else {
                weekDay += 1
            }
        }
        
        return weekDays[weekDay]
    }
    
    static func getEpochBeginningOfToday(isTomorrow: Bool) -> Int? {
        var date = Date()
        
        if isTomorrow {
            guard let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else {
                return nil
            }
            
            date = tomorrowDate
        }
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        
        dateComponents.day = calendar.component(.day, from: date)
        dateComponents.month = calendar.component(.month, from: date)
        dateComponents.year = calendar.component(.year, from: date)
        dateComponents.timeZone = TimeZone(abbreviation: "CST")
        
        let dateTime = Calendar.current.date(from: dateComponents)
        
        guard let timeInterval = dateTime?.timeIntervalSince1970 else { return nil }

        return Int((timeInterval * 1000.0).rounded())
    }
    
    static func getFormattedDate(tomorrow: Bool) -> String {
        
        let date: Date
        let result: String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        
        if tomorrow {
            guard let optDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else {
                return ""
            }
            result = formatter.string(from: optDate)
        } else {
            date = Date()
            result = formatter.string(from: date)
        }
        
        return result
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func createOkAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

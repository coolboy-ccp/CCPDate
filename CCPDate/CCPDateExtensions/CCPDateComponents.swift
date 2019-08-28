//
//  CCPDateComponents.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import Foundation


extension Set where Element == Calendar.Component {
    static let ccpComponents: Set = [.year, .month, .month, .day, .hour, .minute, .second, .timeZone, .weekday, .weekOfYear, .weekOfMonth]
}


extension Date {
    var cpts: DateComponents {
        return Calendar.current.dateComponents(.ccpComponents, from: self)
    }
    
    var year: Int {
        return cpts.year ?? Int.min
    }
    
    var month: Int {
        return cpts.month ?? Int.min
    }
    
    var day: Int {
        return cpts.day ?? Int.min
    }
    
    var hour: Int {
        return cpts.hour ?? Int.min
    }
    
    var minute: Int {
        return cpts.minute ?? Int.min
    }
    
    var second: Int {
        return cpts.second ?? Int.min
    }
    
    var timeZone: TimeZone? {
        return cpts.timeZone
    }
    
    /*
     * 0 -> 6，周日 -> 周六
     */
    var weekDay: Int {
        return cpts.weekday ?? Int.min
    }
    
    var weekOfMonth: Int {
        return cpts.weekOfMonth ?? Int.min
    }
    
    var weekOfYear: Int {
        return cpts.weekOfYear ?? Int.min
    }
    
}

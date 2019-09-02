//
//  CCPDateComponents.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import Foundation

extension Set where Element == Calendar.Component {
    static let ccpComponents: Set = [.year, .month, .day, .hour, .minute, .second, .nanosecond, .timeZone, .weekday, .weekdayOrdinal, .weekOfMonth, .weekOfYear]
}


public extension Date {
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
     * 1 -> 7，周日 -> 周六
     */
    var weekDay: Int {
        return cpts.weekday ?? Int.min
    }
    
    /*
     * 表示一个月的第几周，以7天为单位
     */
    var weekDayOridinal: Int {
        return cpts.weekdayOrdinal ?? Int.min
    }
    
    /*
     * 表示一个月的第几周
     * 会受到这个(minimumDaysInFirstWeek)参数的影响
     * 当前月份的1号为周三，如果 minimumDaysInFirstWeek < 4, 当月5号的weekOfMonth为2，反之，为1
     */
    var weekOfMonth: Int {
        return cpts.weekOfMonth ?? Int.min
    }
    
    /*
     * 表示一年的第几周
     *
     */
    var weekOfYear: Int {
        return cpts.weekOfYear ?? Int.min
    }
    
}

//
//  CCPDateComponents.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import Foundation

public enum DescType {
    case china
    case en
    case enFull
}

extension DescType {
    var month: [String] {
        switch self {
        case .china:
            return ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
        case .en:
            return ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sept", "Oct", "Nov", "Dec"]
        case .enFull:
            return ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
            
        }
    }
    
    var week: [String] {
        switch self {
        case .china:
            return ["周一", "周二", "周三", "周四", "周五", "周六", "周日"]
        case .en:
            return ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
        case .enFull:
            return ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        }
    }
    
    static var allKeys: [DescType] {
        return [china, en, enFull]
    }
    
}


extension Date {
    var cpts: DateComponents {
        let componentsSet: Set<Calendar.Component> = [.year, .month, .month, .day, .hour, .minute, .second, .timeZone, .weekday, .weekOfYear, .weekdayOrdinal, .weekOfMonth]
        return Calendar.current.dateComponents(componentsSet, from: self)
    }
    
    var year: Int {
        return cpts.year ?? -1
    }
    
    var month: Int {
        return cpts.month ?? -1
    }
    
    var day: Int {
        return cpts.day ?? -1
    }
    
    var hour: Int {
        return cpts.hour ?? -1
    }
    
    var minute: Int {
        return cpts.minute ?? -1
    }
    
    var second: Int {
        return cpts.second ?? -1
    }
    
    var timeZone: TimeZone? {
        return cpts.timeZone
    }
    
    var weekDay: Int {
        return cpts.weekday ?? -1
    }
    
    var weekdayOrdinal: Int {
        return cpts.weekdayOrdinal ?? -1
    }
    
    var weekOfMonth: Int {
        return cpts.weekOfMonth ?? -1
    }
    
    var weekOfYear: Int {
        return cpts.weekOfYear ?? -1
    }
    
    func monthDesc(_ type: DescType = .china) -> String {
        assert(month > 0, "无效的月份")
        return type.month[month - 1]
    }
    
    func weekDesc(_ type: DescType = .china) -> String {
        assert(weekDay > 0, "无效的星期")
        var week = 0
        if weekDay == 0 {
            week = 6
        }
        else {
            week = weekDay - 2
        }
        return type.week[week]
    }
    
}

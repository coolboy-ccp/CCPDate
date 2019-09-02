//
//  CCPDateShow.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit

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

/// 日期连接符
public enum Interval: String {
    case dot = "."
    case bar = "-"
    case space = " "
    case none = ""
    case slash = "/"
}


/// 不同地区，显示的样式不一样
///
/// - china: yyyyMMdd
/// - usa: MMddyyyy
/// - en: ddMMyyyy
public enum Area {
    case china
    case usa
    case en
}

public enum CCPDateFormatter: String {
    case YM = "yyyy-MM"
    case YMD = "yyyy-MM-dd"
    case YMDH = "yyyy-MM-dd HH"
    case YMDHM = "yyyy-MM-dd HH:mm"
    case YMDHMS = "yyyy-MM-dd HH:mm:ss"
    case MD = "MM-dd"
    case MDH = "MM-dd HH"
    case MDHM = "MM-dd HH:mm"
    case MDHMS = "MM-dd HH:mm:ss"
    case DH = "dd HH"
    case DHM = "dd HH:mm"
    case DHMS = "dd HH:mm:ss"
    case HM = "HH:mm"
    case HMS = "HH:mm:ss"
    case MS = "mm:ss"
}

public extension CCPDateFormatter {
    
    private func formatStr(interval: Interval, area: Area) -> String {
        return desc(area).replacingOccurrences(of: "-", with: interval.rawValue)
    }
    
    func formatter(interval: Interval, area: Area) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr(interval: interval, area: area)
        return formatter
    }
    
    static var allKeys: [CCPDateFormatter] {
        return [.YM, .YMD, YMDH, .YMDHM, .YMDHMS, .MD, MDH, .MDHM, MDHMS, .DH, .DHM, .DHMS, .HM, .HMS, .HM]
    }
    
    func desc(_ area: Area) -> String {
        switch area {
        case .en:
            return enStr
        case .usa:
            return usaStr
        default:
            return rawValue
        }
    }
    
    var usaStr: String {
        if self.rawValue.contains("yyyy-MM-dd") {
            return self.rawValue.replacingOccurrences(of: "yyyy-MM-dd", with: "MM-dd-yyyy")
        }
        else if self.rawValue.contains("yyyy-MM") {
            return self.rawValue.replacingOccurrences(of: "yyyy-MM", with: "MM-yyyy")
        }
        return self.rawValue
    }
    
    var enStr: String {
        if self.rawValue.contains("yyyy-MM-dd") {
            return self.rawValue.replacingOccurrences(of: "yyyy-MM-dd", with: "dd-MM-yyyy")
        }
        else if self.rawValue.contains("yyyy-MM") {
            return self.rawValue.replacingOccurrences(of: "yyyy-MM", with: "MM-yyyy")
        }
        else if self.rawValue.contains("MM-dd") {
            return self.rawValue.replacingOccurrences(of: "MM-dd", with: "dd-MM")
        }
        return self.rawValue
    }
    
}

 extension Date {
    
    public func string(formatter: CCPDateFormatter = .YMDHMS, interval: Interval = .bar, area: Area = .china) -> String {
        return formatter.formatter(interval: interval, area: area).string(from: self)
    }
    
    func string(formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
    
    func string(format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: self)
    }
    
    var iso8601: String {
        return ISO8601DateFormatter().string(from: self)
    }
    
    /*
     * 本地化
     */
    func localString(formatter: CCPDateFormatter = .YMDHMS, area: Area = .china) -> String {
        switch area {
        case .china:
            return chinese(formatter)
        default:
            return string(formatter: formatter, interval: .none, area: area)
        }
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
    
    private func chinese(_ formatter: CCPDateFormatter = .YMDHMS) -> String {
        switch formatter {
        case .YM:
            return String(format: "%d年%02d月", year, month)
        case .YMD:
            return String(format: "%d年%02d月%02d号", year, month, day)
        case .YMDH:
            return String(format: "%d年%02d月%02d号%02d时", year, month, day, hour)
        case .YMDHM:
            return String(format: "%d年%02d月%02d号%02d时%02d分", year, month, day, hour, minute)
        case .YMDHMS:
            return String(format: "%d年%02d月%02d号%02d时%02d分%02d秒", year, month, day, hour, minute, second)
        case .MD:
            return String(format: "%02d月%02d号", month, day)
        case .MDH:
            return String(format: "%02d月%02d号%02d时", month, day, hour)
        case .MDHM:
            return String(format: "%02d月%02d号%02d时%02d分", month, day, hour, minute)
        case .MDHMS:
            return String(format: "%02d月%02d号%02d时%02d分%02d秒", month, day, hour, minute, second)
        case .DH:
            return String(format: "%02d号%02d时", day, hour)
        case .DHM:
            return String(format: "%02d号%02d时%02d分", day, hour, minute)
        case .DHMS:
            return String(format: "%02d号%02d时%02d分%02d秒", day, hour, minute, second)
        case .HM:
            return String(format: "%02d时%02d分", hour, minute)
        case .HMS:
            return String(format: "%02d时%02d分%02d秒", hour, minute, second)
        case .MS:
            return String(format: "%02d分%02d秒", minute, second)
        }
    }
    
}



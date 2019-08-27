//
//  CCPDateShow.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit


/// 日期连接符
///
/// - dot: .
/// - bar: -
/// - space:
public enum Interval: String {
    case dot = "."
    case bar = "-"
    case space = " "
}

public enum Area {
    case china
    case usa
    case en
}


public enum CCPDateFormatter: String {
    case `default` = "yyyy-MM-dd HH:mm:ss sss"
    case year = "yyyy"
    case month = "MM"
    case day = "dd"
    case hour = "HH"
    case min = "mm"
    case seconds = "ss"
    case milliSecond = "sss"
    case YM = "yyyy-MM"
    case YMD = "yyyy-MM-dd"
    case YMDH = "yyyy-MM-dd HH"
    case YMDHM = "yyyy-MM-dd HH:mm"
    case YMDHMS = "yyyy-MM-dd HH:mm:ss"
    case MD = "MM-dd"
    case HMS = "HH:mm:ss"
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
        return [.default, year, month, day, hour, min, seconds, milliSecond, .YMDHMS, .YMDHM, .YMDH, .YMD, .YM, .MD, .HMS]
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

public extension Date {
    
    func string(formatter: CCPDateFormatter = .default, interval: Interval = .bar, area: Area = .china) -> String {
        return formatter.formatter(interval: interval, area: area).string(from: self)
    }
    
    func string(formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
    
    func localString(formatter: CCPDateFormatter = .default, area: Area = .china) -> String {
        switch area {
        case .china:
            return chinese(formatter)
        default:
            return string(formatter: formatter, interval: .space, area: area)
        }
    }
    
    private func chinese(_ formatter: CCPDateFormatter = .default) -> String {
        switch formatter {
        case .year:
            return "\(year)年"
        case .month:
            return String(format: "%02d月", month)
        case .day:
            return String(format: "%02d号", day)
        case .hour:
            return String(format: "%02d时", hour)
        case .min:
            return String(format: "%02d分", minute)
        case .seconds:
            return String(format: "%02d秒", second)
        case .YM:
            return chinese(.year) + chinese(.month)
        case .YMD:
            return chinese(.YM) + chinese(.day)
        case .YMDH:
            return chinese(.YMD) + chinese(.hour)
        case .YMDHM:
            return chinese(.YMDH) + chinese(.min)
        case .YMDHMS:
            return chinese(.YMDHM) + chinese(.seconds)
        case .MD:
            return chinese(.month) + chinese(.day)
        case .HMS:
            return chinese(.hour) + chinese(.min) + chinese(.seconds)
        default:
            return chinese(.YMDHMS)
        }
    }
    
}



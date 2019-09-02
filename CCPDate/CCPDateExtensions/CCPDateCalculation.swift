//
//  CCPDateCompare.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import Foundation

infix operator ~-
infix operator +
infix operator -


//获得新增后的日期, 单个选项
public func +(left: Date, right: AddUnit) -> Date {
    var cpts = Calendar.current.dateComponents(.calculationComponents, from: left)
    add(&cpts, right)
    return Calendar.current.date(from: cpts) ?? left
}

//获得新增后的日期, 多个选项
public func +(left: Date, right: AddUnits) -> Date {
    var cpts = Calendar.current.dateComponents(.calculationComponents, from: left)
    for unit in right.units {
        add(&cpts, unit)
    }
    return Calendar.current.date(from: cpts) ?? left
}


//默认精度为秒
fileprivate var subAccuracy: SubAccuracy = .second

/*
 * 调用此方法可改变计算精度, 计算结束后，精度会被重置为秒
 * 如果多次计算都需要用此精度，建议将其封装成一个方法后，统一扔给handler；不建议多次调用此方法
 */
public func dateCalculate(accuracy: SubAccuracy, handler: @autoclosure () -> ()) {
    subAccuracy = accuracy
    handler()
    subAccuracy = .second
}

/*
 * 此方法用于全局设置计算精度，此方法会改变默认精度，如果需要重置，再次调用即可
 * 这个方法的使用场景有两个：
 * 1. app 启动时全局设置计算精度，整个app都采用
 * 2. 在某个对象中的init方法中设置，deinit方法中取消重置
 */
public func setGlobalAccuracy(accuracy: SubAccuracy) {
    subAccuracy = accuracy
}

/*
 * 计算两个date相差多少, 这个方法主要用于显示一个大致的时间差，比如: "三天前",  "三天后"
 * year -> second进行计算, 遇到差值不等于0时，返回当前级数和级数数值
 */
public func ~-(left: Date, right: Date) -> SubResult {
    let components = Calendar.current.dateComponents(.calculationComponents, from: right, to: left)
    print(left, right, components)
    if let year = components.year, year != 0 {
        return year > 0 ? .future(SubPeriod.year(year)) : .ago(SubPeriod.year(abs(year)))
    }
    if subAccuracy == .year { return .same }
    if let month = components.month, month != 0 {
        return month > 0 ? .future(SubPeriod.month(month)) : .ago(SubPeriod.month(abs(month)))
    }
    if subAccuracy == .month { return .same }
    if let day = components.day, day != 0 {
        let week = day / 7
        if abs(week) > 0 {
            return week > 0 ? .future(SubPeriod.week(week)) : .ago(SubPeriod.week(abs(week)))
        }
        if subAccuracy == .week { return .same }
        return day > 0 ? .future(SubPeriod.day(day)) : .ago(SubPeriod.day(abs(day)))
    }
    if subAccuracy == .day { return .same }
    if let hour = components.hour, hour != 0 {
        return hour > 0 ? .future(SubPeriod.hour(hour)) : .ago(SubPeriod.hour(abs(hour)))
    }
    if subAccuracy == .hour { return .same }
    if let minute = components.minute, minute != 0 {
        return minute > 0 ? .future(SubPeriod.minute(minute)) : .ago(SubPeriod.minute(abs(minute)))
    }
    if subAccuracy == .minute { return .same }
    if let second = components.second, second != 0 {
        return second > 0 ? .future(SubPeriod.second(second)) : .ago(SubPeriod.second(abs(second)))
    }
    return .same
}

extension Set where Element == Calendar.Component {
    static let calculationComponents: Set = [.year, .month, .day, .hour, .minute, .second, .nanosecond]
}


/*
 * 计算两个date相差多少, 获取准确的时间差, 通过component的属性可以组装时间差表达
 */
public func -(left: Date, right: Date) -> DateComponents {
    return Calendar.current.dateComponents(.calculationComponents, from: right, to: left)
}


/// 表示两个date的差值
///
/// - ago: 被减日期在减日期之前
/// - future: 被减日期在减日期之后
/// - same: 相等
/// -- same可通过设置精度改变计算步骤
public enum SubResult {
    case ago(SubPeriod)
    case future(SubPeriod)
    case same
}

//TODO 国际化
extension SubResult: CustomStringConvertible {
    public var description: String {
        switch self {
        case .ago(let period):
            return "\(period)前"
        case .future(let period):
            return "\(period)后"
        case .same:
            return "相等"
        }
    }
}

extension SubResult: Equatable {
    public static func == (lhs: SubResult, rhs: SubResult) -> Bool {
        return "\(lhs)" == "\(rhs)"
    }
}

/*
 * 计算级数
 * value表示相差级数数值
 */
public enum SubPeriod {
    case year(_ value: Int)
    case month(_ value: Int)
    case week(_ value: Int)
    case day(_ value: Int)
    case hour(_ value: Int)
    case minute(_ value: Int)
    case second(_ value: Int)
}

//TODO 国际化
extension SubPeriod: CustomStringConvertible {
    public var description: String {
        switch self {
        case .year(let v):
            return "\(v)年"
        case .month(let v):
            return "\(v)月"
        case .week(let v):
            return "\(v)周"
        case .day(let v):
            return "\(v)天"
        case .hour(let v):
            return "\(v)小时"
        case .minute(let v):
            return "\(v)分钟"
        case .second(let v):
            return "\(v)秒"
        }
    }
}

//同时增加多个属性
public struct AddUnits {
    var units = [AddUnit]()
    init(year: Int = 0, month: Int = 0, week: Int = 0, day: Int = 0, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        if year != 0 { self.units.append(.year(year)) }
        if month != 0 { self.units.append(.month(month)) }
        if week != 0 { self.units.append(.week(week)) }
        if day != 0 { self.units.append(.day(day)) }
        if hour != 0 { self.units.append(.hour(hour)) }
        if minute != 0 { self.units.append(.minute(minute)) }
        if second != 0 { self.units.append(.second(second)) }
    }
    
    init(units: [AddUnit]) {
        self.units = units
    }
}

/*
 * 用于表示新增的级数
 * value 表示具体的级数数值
 */
public enum AddUnit {
    case year(_ value: Int)
    case month(_ value: Int)
    case day(_ value: Int)
    case hour(_ value: Int)
    case week(_ value: Int)
    case minute(_ value: Int)
    case second(_ value: Int)
}

//计算精度，表示计算到哪一步相同就表示相等
public enum SubAccuracy {
    case year
    case month
    case week
    case day
    case hour
    case minute
    case second
}

fileprivate func add(_ cpts: inout DateComponents, _ unit: AddUnit) {
    switch unit {
    case .year(let v):
        cpts.year = (cpts.year ?? 0) + v
    case .month(let v):
        cpts.month = (cpts.month ?? 0) + v
    case .week(let v):
        cpts.day = (cpts.day ?? 0)  + (v * 7)
    case .day(let v):
        cpts.day = (cpts.day ?? 0) + v
    case .hour(let v):
        cpts.hour = (cpts.hour ?? 0) + v
    case .minute(let v):
        cpts.minute = (cpts.minute ?? 0) + v
    case .second(let v):
        cpts.second = (cpts.second ?? 0) + v
    }
}




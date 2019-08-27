//
//  CCPDateCompare.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/27.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import Foundation

/*
 * 用于两个日期直接的差距显示
 * same精确到毫秒
 */
enum CompareResult: String {
    case today
    case yesterday
    case inWeek
    case inMonth
    case inYear
    case inHour
    case inMinite
    case inSeconds
    case same
}

class CCPDateCompare: NSObject {

}

//
//  CCPDateTransfer.swift
//  CCPDate
//
//  Created by clobotics_ccp on 2019/8/28.
//  Copyright © 2019 cool-ccp. All rights reserved.
//

import UIKit

extension String {
    //无法转换本地化的字符串，如2019年10月20日
    func date(df: CCPDateFormatter = .YM, interval: Interval = .bar, area: Area = .en) -> Date? {
        return df.formatter(interval: interval, area: area).date(from: self)
    }
    
    func date(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
}


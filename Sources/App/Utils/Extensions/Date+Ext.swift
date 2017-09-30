//
//  Date+Ext.swift
//  store
//
//  Created by laijihua on 18/07/2017.
//
//

import Foundation

extension Date {

    var toString: String {
        get {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            return dateformatter.string(from: self)
        }
    }
}

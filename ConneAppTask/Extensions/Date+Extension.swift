//
//  Date+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
extension Date {
    func toString( dateFormat format  : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        return dateFormatter.string(from: self)
    }
}

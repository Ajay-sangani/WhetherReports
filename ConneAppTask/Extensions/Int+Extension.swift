//
//  Int+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation

extension Int {
    
    func to_Date() -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateFormat = StringResource.DateFormats.formateDDMMYYYY
        dateFormatter.timeZone = .current
        return date
    }
    
    func toDate() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        //dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateFormat = StringResource.DateFormats.formateDDMMYYYY
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func toTime() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = StringResource.DateFormats.formatehhmma
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}

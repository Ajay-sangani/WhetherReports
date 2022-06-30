//
//  String+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
extension String {
    
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    func toUrl() -> URL {
        return URL(string: self)!
    }
    
    func toDateTime(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        formatter.dateFormat = format
        let dateFromString : Date = formatter.date(from: self)!
        return dateFromString
    }
}

//
//  Dictionary+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
  
  var isSuccess: Bool {
    return (self["IsSuccess"] as? Bool)!
  }
  
  var message: String {
    return (self["message"] as? String)!
  }
  
  var error: String {
    return (self["error"] as? String)!
  }
  
  var statusCode: String {
    return (self["cod"] as? String)!
  }
}

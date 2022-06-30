//
//  Bundle+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
extension Bundle {
  static func appName() -> String {
    guard let dictionary = Bundle.main.infoDictionary else {
      return ""
    }
    if let appName : String = dictionary["CFBundleName"] as? String {
      return appName
    } else {
      return ""
    }
  }
  
  static func appVersion() -> String {
    guard let dictionary = Bundle.main.infoDictionary else {
      return ""
    }
    if let version : String = dictionary["CFBundleShortVersionString"] as? String {
      return version
    } else {
      return ""
    }
  }
}

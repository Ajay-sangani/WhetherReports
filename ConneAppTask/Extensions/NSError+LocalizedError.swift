//
//  NSError+LocalizedError.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation

struct RuntimeError: Error {
  let message: String
  
  init(_ message: String) {
    self.message = message
  }
  
  public var localizedDescription: String {
    return message
  }
}

//
//  Utils.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation

class Utils {
    
    static let shared = Utils()
    
    func getHeaders() -> [String: String] {
        let header: [String: String] = ["Accept": "application/json"]
        return header
    }
}

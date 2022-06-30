//
//  StringConstants.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
import UIKit

let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height

struct StringResource {
    
    struct Picker {
        static let DoneButton                   = "Done"
        static let CancelButton                 = "Cancel"
    }
    
    struct ErrorMessage {
        static let k_CommenError                = "Something went wrong!"
        static let k_InternetConnection         = "Please check your internet connection!"
    }
    
    struct DateFormats {
        static let defaultDateFormat        = "yyyy-MM-dd'T'HH:mm:ss"
        static let formateDDMMYYYY          = "dd-MM-yyyy"
        static let formatehhmma             = "hh:mm a"
    }
}

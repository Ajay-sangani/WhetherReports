//
//  MainViewDataProvider.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

class MainViewDataProvider {
    
    //MARK: Api Call for Get Weather Report
    func getWeatherReport(url: URL) -> Promise<Any> {
         print("Header :: \(Utils.shared.getHeaders())")
        return Promise { seal in
            Alamofire
                .request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: Utils.shared.getHeaders())
                .validate()
                .responseJSON { response in
                    //print("Response :: \(response)")
                    switch response.result {
                    case .success(let json):
                        guard let dictionary = json  as? [String: AnyObject] else {
                            seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                            return
                        }
                        switch dictionary.statusCode {
                        case "200":
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: dictionary as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
                                guard let reports = try? JSONDecoder().decode(WeatherReports.self, from: jsonData) else {
                                    seal.reject(RuntimeError("Invalid JSON"))
                                    return
                                }
                                seal.fulfill(reports)
                            } catch let error {
                                seal.reject(error)
                            }
                        case "401":
                            seal.fulfill(dictionary)
                        default:
                            var strError: String?
                            if let data = response.data {
                                let json = String(data: data, encoding: String.Encoding.utf8)
                                if let dictData = json?.toJSON() as? [String: AnyObject] {
                                    print("ERROR DICT : \(dictData)")
                                    if let errors: [AnyObject] = dictData["modelError"] as? [AnyObject] {
                                        print("ERROR ARRAY : \(errors)")
                                        
                                        if let dictError: [String: Any] = errors[0] as? [String: Any] {
                                            print("ERROR ARRAY : \(dictError)")
                                            
                                            if let err : [String] = dictError["value"] as? [String] {
                                                strError = err[0]
                                            }
                                        }
                                    } else {
                                        if let message = dictData["message"] as? String {
                                            strError = message
                                        }
                                    }
                                }
                            }
                            if let message = strError {
                                seal.fulfill(message)
                            }
                        }
                    case .failure(let error):
                        var strError: String?
                        if let data = response.data {
                            let json = String(data: data, encoding: String.Encoding.utf8)
                            if let dictData = json?.toJSON() as? [String: AnyObject] {
                                print("ERROR DICT : \(dictData)")
                                if let errors: [AnyObject] = dictData["modelError"] as? [AnyObject] {
                                    print("ERROR ARRAY : \(errors)")
                                    
                                    if let dictError: [String: Any] = errors[0] as? [String: Any] {
                                        print("ERROR ARRAY : \(dictError)")
                                        
                                        if let err : [String] = dictError["value"] as? [String] {
                                            strError = err[0]
                                        }
                                    }
                                } else {
                                    if let message = dictData["message"] as? String {
                                        strError = message
                                    }
                                }
                            }
                        }
                        if let message = strError {
                            seal.fulfill(message)
                        } else {
                            seal.reject(error)
                        }
                    }
                }
        }
    }
}

//
//  MainViewModel.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation

class MainViewModel {
    
    //Create City Array With Static Data
    var cities = [City(name: "Vranje", latitude: 42.5542, longitude: 21.8972),
                  City(name: "Subotica", latitude: 46.0983, longitude: 19.6700),
                  City(name: "Belgrade", latitude: 44.8167, longitude: 20.4667),
                  City(name: "Novi Sad", latitude: 45.2644, longitude: 19.8317),
                  City(name: "Zemun", latitude: 44.8500, longitude: 20.4000),
                  City(name: "Kragujevac", latitude: 44.0142, longitude: 20.9394),
                  City(name: "Valjevo", latitude: 44.2667, longitude: 19.8833),
                  City(name: "Loznica", latitude: 44.5333, longitude: 19.2258),
                  City(name: "Zrenjanin", latitude: 45.3778, longitude: 20.3861),
                  City(name: "Sombor", latitude: 45.7800, longitude: 19.1200),]
    
    //MARK: Create Call Back
    typealias GetWeatherReportUpdatedCallback = (_ message: String?, _ error: Error?) -> Void
    
    //MARK: Create Object Call Back
    var updatedOnGetWeatherReport: GetWeatherReportUpdatedCallback?
    
    //MARK: DataProvider Object
    private var dataProvider = MainViewDataProvider()
    private(set) var isLoading = false
    
    //MARK: Model Object
    var WeatherReport: WeatherReports?
    
    //MARK: getWeatherReport
    func getWeatherReport(latitude: Double, longitude: Double) {
        
        //let strUrl = "https://api.openweathermap.org/data/2.5/onecall"
        let strUrl = "https://api.openweathermap.org/data/2.5/forecast"
        var url = strUrl.toUrl()
        url.appendQueryItem(name: "lat", value: "\(latitude)")
        url.appendQueryItem(name: "lon", value: "\(longitude)")
        url.appendQueryItem(name: "appid", value: "e58f40d776c5b37400b6b5073952dac4")
        print("URL : \(url)")
        
        isLoading = true
        dataProvider.getWeatherReport(url: url)
            .done({ response in
                self.isLoading = false
                self.WeatherReport = nil
                if let data = response as? WeatherReports {
                    self.WeatherReport = data
                    self.updatedOnGetWeatherReport!("Get Weather reports successfully!", nil)
                } else {
                    self.updatedOnGetWeatherReport!(response as? String, nil)
                }
            })
            .catch { error in
                self.isLoading = false
                self.updatedOnGetWeatherReport!(nil, error)
            }
    }
    
    //MARK: Load Data From Json File Offline
    func loadJson(fileName: String = "Reports") {
        self.WeatherReport = nil
        do {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let reports = try? JSONDecoder().decode(WeatherReports.self, from: data)
            else {
                return
            }
            self.WeatherReport = reports
        } catch let error {
            print(error)
        }
    }
}

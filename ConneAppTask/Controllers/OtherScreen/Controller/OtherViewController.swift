//
//  OtherViewController.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import UIKit

class OtherViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet var isLiveSwitch: UISwitch!
    @IBOutlet var tableView: UITableView!
    
    //MARK: Create ViewModel Object
    fileprivate var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call Setup UI Function
        setupUI()
        
        //MARK: Configure ViewModel First
        setupViewModel()
        
        //MARK: Fetch data from api
        handleLiveData(isLive: isLiveSwitch.isOn)
    }
    
    //MARK: Configure UI
    func setupUI() {
        //Assign TableView Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        //Register TableView Cell
        for reuseIdentifier in [OtherTableViewCell.reuseIdentifier] {
            tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    //MARK: isLiveSwitchAction
    @IBAction func isLiveSwitchAction(sender:UISwitch) {
        handleLiveData(isLive: sender.isOn)
    }
    
    //MARK: handleLiveData
    func handleLiveData(isLive: Bool = true) {
        if isLive {
            //Get Weather Reports Api Call
            getWeatherReportApiCall(lat: 44.8167, long: 20.4667)
        } else {
            //Get Weather Data From Json File
            viewModel.loadJson()
            tableView.reloadData()
        }
    }
}

//MARK: UITableView Delegates | DataSource
extension OtherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.WeatherReport?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.otherTableViewCell.identifier) as! OtherTableViewCell
        if let objReport = viewModel.WeatherReport?.list?[indexPath.row] {
            cell.configureData(reportData: objReport)
        }
        return cell
    }
}

//MARK: Create Api Call Function and Call Back From Api
extension OtherViewController {
    func setupViewModel() {
        //MARK: Get Coach Absent Details Call Back
        viewModel.updatedOnGetWeatherReport = {message,error in
            self.updateUI()
            if error == nil {
                if let _ = message {
                    self.tableView.reloadData()
                } else {
                    self.alert(StringResource.ErrorMessage.k_CommenError, index: ErrorType.error.rawValue)
                }
            } else {
                self.alert(error.debugDescription, index: ErrorType.error.rawValue)
            }
        }
    }
    
    //Mark: getWeatherReportApiCall
    func getWeatherReportApiCall(lat: Double, long: Double) {
        if isNetworkReachable {
            viewModel.getWeatherReport(latitude: lat, longitude: long)
            self.updateUI()
        } else {
            alert(StringResource.ErrorMessage.k_InternetConnection, index: ErrorType.info.rawValue)
        }
    }
    
    private func updateUI() {
        switch viewModel.isLoading {
        case true:
            startLoader()
        case false:
            stopLoader()
        }
    }
}

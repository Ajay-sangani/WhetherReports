//
//  MainViewController.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import UIKit

class MainViewController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet var textFieldLayerView: UIView!
    @IBOutlet var cityPickerTextField: UITextField!
    @IBOutlet var dropDownButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    //MARK: Picker Objects
    fileprivate var picker = UIPickerView()
    fileprivate let toolBar = UIToolbar()
    
    //MARK: Variables
    fileprivate var selected_city_name: String?
    fileprivate var selected_city_latitude: Double?
    fileprivate var selected_city_longitude: Double?
    
    //MARK: Create ViewModel Object
    fileprivate var viewModel = MainViewModel()
    fileprivate var sorted_model_array: [[ReportList]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call Setup UI Function
        setupUI()
        
        //Configure City Name Picker
        setupPicker()
        
        //MARK: Configure ViewModel First
        setupViewModel()
    }
    
    //MARK: Configure UI
    func setupUI() {
        //Apply Shadow
        textFieldLayerView.applyNavShadow()
        dropDownButton.setTitle("", for: .normal)
        
        //Configure TextFields
        [cityPickerTextField].forEach { textfield in
            textfield?.setLeftPaddingPoints()
            textfield?.applyBorder(1, color: .gray, cornerRadius: 5)
            textfield?.delegate = self
        }
        
        //Default City Picker Selection
        let row = picker.selectedRow(inComponent: 0)
        if let cityName = viewModel.cities[row].name,
           let lat = viewModel.cities[row].latitude,
           let long = viewModel.cities[row].longitude {
            
            cityPickerTextField.text = cityName
            print("SELECTED :: CITY NAME: \(cityName) || LATITUDE: \(lat) || LONGITUDE: \(long)")
            selected_city_name = cityName
            selected_city_latitude = lat
            selected_city_longitude = long
            
            //Get Weather Reports Api Call
            getWeatherReportApiCall(lat: selected_city_latitude ?? 0.0, long: selected_city_longitude ?? 0.0)
        }
        
        //Assign TableView Delegate
        tableView.delegate = self
        tableView.dataSource = self
        
        //Register Section Header View Cell
        for reuseIdentifier in [SectionTitleView.reuseIdentifier] {
            tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
        
        //Register TableView Cell
        for reuseIdentifier in [WeatherTableViewCell.reuseIdentifier] {
            tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        }
    }
}

//MARK: UITextField Delegate
extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 1:
            picker.tag = 1
            cityPickerTextField.inputView = picker
            cityPickerTextField.inputAccessoryView = toolBar
        default:
            break
        }
    }
}

//MARK: Setup Picker
extension MainViewController {
    
    private func setupPicker() {
        picker.delegate = self
        picker.dataSource = self
        
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: StringResource.Picker.DoneButton, style: .done, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: StringResource.Picker.CancelButton, style: .done, target: self, action: #selector(cancelPicker))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
    }
    
    @objc func donePicker() {
        if picker.tag == 1 {
            cityPickerTextField.resignFirstResponder()
            let row = picker.selectedRow(inComponent: 0)
            
            if let cityName = viewModel.cities[row].name,
               let lat = viewModel.cities[row].latitude,
               let long = viewModel.cities[row].longitude {
                cityPickerTextField.text = cityName
                
                print("SELECTED :: CITY NAME: \(cityName) || LATITUDE: \(lat) || LONGITUDE: \(long)")
                selected_city_name = cityName
                selected_city_latitude = lat
                selected_city_longitude = long
                
                //Get Weather Reports Api Call
                getWeatherReportApiCall(lat: selected_city_latitude ?? 0.0, long: selected_city_longitude ?? 0.0)
            }
        }
    }
    
    @objc func cancelPicker() {
        if picker.tag == 1 {
            cityPickerTextField.resignFirstResponder()
        }
    }
}

//MARK: UIPickerView Delegate
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if picker.tag == 1 {
            return viewModel.cities.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if picker.tag == 1 {
            return viewModel.cities[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if picker.tag == 1 {
            cityPickerTextField.text = viewModel.cities[row].name
        }
    }
}

//MARK: UITableView Delegates | DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionTitleView.reuseIdentifier ) as! SectionTitleView
        headerView.titleLabel.text = "Day \(section + 1)"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sorted_model_array?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.weatherTableViewCell.identifier) as! WeatherTableViewCell
        if let arrHourly = sorted_model_array?[indexPath.section] {
            
            cell.configureData(objHourly: arrHourly)
        }
        return cell
    }
}

//MARK: Create Api Call Function and Call Back From Api
extension MainViewController {
    func setupViewModel() {
        
        //MARK: Get Coach Absent Details Call Back
        viewModel.updatedOnGetWeatherReport = {message,error in
            self.updateUI()
            if error == nil {
                if let _ = message {
                    if let modelArray = self.viewModel.WeatherReport?.list {
                        let groupSorted = modelArray.groupSort(byDate: { $0.dt?.to_Date() as! Date})
                        self.sorted_model_array = groupSorted
                    }
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

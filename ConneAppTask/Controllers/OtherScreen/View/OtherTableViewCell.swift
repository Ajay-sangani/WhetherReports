//
//  OtherTableViewCell.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import UIKit

class OtherTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet var containerView: UIView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var weatherIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //MARK: Call Configure UI
        configureUI()
    }
    
    func configureUI() {
        containerView.setupCardView()
    }
    
    //MARK: Setup Date in TableView Cell
    func configureData(reportData: ReportList) {
        if let temp = reportData.main?.temp {
            temperatureLabel.text = "\(temp)"
        }
        
        if let time = reportData.dt?.toTime() {
            timeLabel.text = "\(time)"
        }
        
        if let date = reportData.dt?.toDate() {
            dateLabel.text = "\(date)"
        }
        
        if let icon = reportData.weather?[0].icon {
            let str_icon_url = "https://openweathermap.org/img/wn/" + "\(icon).png"
            weatherIconImageView.setImage(imageUrl: str_icon_url.toUrl())
        }
    }
}

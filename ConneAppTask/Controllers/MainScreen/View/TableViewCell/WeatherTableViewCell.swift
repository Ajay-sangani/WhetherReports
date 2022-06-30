//
//  WeatherTableViewCell.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import UIKit
import SwiftyJSON

class WeatherTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet var collectionView: UICollectionView!
    
    //Collection View Insets
    fileprivate var leftInset: CGFloat {
        return 10
    }
    fileprivate var rightInset: CGFloat {
        return 10
    }
    fileprivate var contentInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    fileprivate var cellWidth: CGFloat {
        return (collectionView.frame.size.width / 2) - (2 * leftInset)
    }
    fileprivate var cellHeight: CGFloat {
        return 220
    }
    
    //MARK: Variables
    fileprivate var reports: [ReportList]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    func configureUI() {
        //Assign Collection View Delegates
        [collectionView].forEach { collectionView in
            collectionView?.delegate = self
            collectionView?.dataSource = self
            collectionView?.contentInset = contentInset
        }
        
        //Register Collection View Cell
        collectionView.register(R.nib.weatherCollectionViewCell)
    }
    
    //MARK: ConfigureData
    func configureData(objHourly: [ReportList]) {
        self.reports = objHourly
        collectionView.reloadData()
    }
}

//MARK: UICollectionView DataSource
extension WeatherTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.reports?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.weatherCollectionViewCell.identifier, for: indexPath) as! WeatherCollectionViewCell
        if let objHour = self.reports?[indexPath.item] {
            cell.configureData(reportData: objHour)
        }
        return cell
    }
}

//MARK: UICollectionView DelegateFlowLayout
extension WeatherTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return leftInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

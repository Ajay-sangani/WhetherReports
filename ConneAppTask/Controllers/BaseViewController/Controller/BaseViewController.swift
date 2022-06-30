//
//  ViewController.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import UIKit
import HPGradientLoading
import Reachability

//MARK: Appdelegate Object
var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

//MARK: Network Status Change Delegate For Check Internet Connection
public protocol NetworkStatusChangeDelegate {
    func onNetworkStatusChange()
}

class BaseViewController: UIViewController {
    
    //MARK: Network Status Change Delegate Object
    var networkDelegate: NetworkStatusChangeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI() {
        // Create Indicator using HPGradientLoading
        HPGradientLoading.shared.configation.isEnableDismissWhenTap = false
        HPGradientLoading.shared.configation.isBlurBackground = true
        HPGradientLoading.shared.configation.isBlurLoadingActivity = true
        HPGradientLoading.shared.configation.durationAnimation = 1.5
        HPGradientLoading.shared.configation.fontTitleLoading = UIFont.systemFont(ofSize: 20)
    }
    
    var isNetworkReachable: Bool {
        return ReachabilityManager.shared.isNetworkReachable
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return.default
        }
    }
    
    func startLoader() {
        HPGradientLoading.shared.configation.fromColor = .white
        HPGradientLoading.shared.configation.toColor = .gray
        HPGradientLoading.shared.showLoading()
    }
    
    func stopLoader() {
        HPGradientLoading.shared.dismiss()
    }
}

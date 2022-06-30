//
//  UIViewController+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
import UIKit
import Reachability
import SwiftMessages

enum ErrorType: Int {
    case info, success, warning, error, other
    
    var title: Int {
        switch self {
        case .info:
            return 0
        case .success:
            return 1
        case .warning:
            return 2
        case .error:
            return 3
        case .other:
            return -1
        }
    }
}

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        return instantiateFromNib()
    }
    
    func showAlert(_ message:String, buttons:[String], completion:((_ tappedIndex: Int) -> Void)!) -> Void {
        
        let alertController = UIAlertController(title: Bundle.appName(), message: message, preferredStyle: .alert)
        alertController.setValue(NSAttributedString(string: Bundle.appName(), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16.0), NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.foregroundColor : UIColor.darkGray]), forKey: "attributedMessage")
        
        for index in 0..<buttons.count {
            let action = UIAlertAction(title: buttons[index], style: .default, handler: {
                (alert: UIAlertAction!) in
                if(completion != nil){
                    completion(index)
                }
            })
            action.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(action)
        }
        UIApplication.shared.delegate!.window!?.rootViewController!.present(alertController, animated: true, completion:nil)
    }
    
    public func showAlert(title: String?, message: String?, preferredStyle: UIAlertController.Style, alertActions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        for alertAction in alertActions {
            alertController.addAction(alertAction)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func alert(_ withMessage: String, index: Int) {
        let view: MessageView
        let iconStyle: IconStyle
        var config = SwiftMessages.defaultConfig
        
        view = MessageView.viewFromNib(layout: .cardView)
        view.configureContent(title: Bundle.appName(), body: withMessage, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        view.button?.isHidden = true
        //view.configureContent(title: Bundle.appName(), body: withMessage, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "Hide", buttonTapHandler: { _ in SwiftMessages.hide() })
        iconStyle = .default
        
        switch index {
        case 0:
            view.configureTheme(.info, iconStyle: iconStyle)
            view.accessibilityPrefix = "info"
        case 1:
            view.configureTheme(.success, iconStyle: iconStyle)
            view.accessibilityPrefix = "success"
        case 2:
            view.configureTheme(.warning, iconStyle: iconStyle)
            view.accessibilityPrefix = "warning"
        case 3:
            view.configureTheme(.error, iconStyle: iconStyle)
            view.accessibilityPrefix = "error"
        default:
            let iconText = ["🐸", "🐷", "🐬", "🐠", "🐍", "🐹", "🐼"].randomElement()
            view.configureTheme(backgroundColor: UIColor.purple, foregroundColor: UIColor.white, iconImage: nil, iconText: iconText)
            view.button?.setImage(Icon.errorSubtle.image, for: .normal)
            view.button?.setTitle(nil, for: .normal)
            view.button?.backgroundColor = UIColor.clear
            view.button?.tintColor = UIColor.green.withAlphaComponent(0.7)
        }
        view.configureDropShadow()
        
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)
        config.dimMode = .gray(interactive: true)
        config.shouldAutorotate = true
        config.interactiveHide = true
        
        SwiftMessages.show(config: config, view: view)
    }
    
    static func topMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.rootViewController?.topMostViewController()
        }
        
        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController()
    }
    
    func topMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        }
        else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.topMostViewController()
            }
            return tabBarController.topMostViewController()
        }
        
        else if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        
        else {
            return self
        }
    }
}

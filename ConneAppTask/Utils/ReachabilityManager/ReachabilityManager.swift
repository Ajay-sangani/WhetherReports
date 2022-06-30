//
//  ReachabilityManager.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
import Reachability

public protocol NetworkStatusListener : class {
  func networkStatusDidChange(status: Reachability.Connection)
}

class ReachabilityManager {
  
  static let shared = ReachabilityManager()
  let reachability = try! Reachability()
  var reachabilityStatus: Reachability.Connection = .unavailable
  var listeners = [NetworkStatusListener]()
  
  var isNetworkAvailable : Bool {
    return reachabilityStatus != .unavailable
  }
  var isNetworkReachable: Bool {
    self.startMonitoring()
    return self.reachability.connection != .unavailable || reachability.connection == .wifi || self.reachability.connection == .cellular
  }
  
  @objc func reachabilityChanged(notification: Notification) {
    
    let reachability = notification.object as! Reachability
    switch reachability.connection {
    case .none:
      break;
    case .wifi:
      break;
    case .cellular:
      break;
    case .unavailable:
      break
    }
    (UIApplication.shared.delegate as! AppDelegate).isNetworkAvailable =  !(reachability.connection == .unavailable)
    
    for listener in listeners {
      print("Hello :: \(reachability.connection)")
      listener.networkStatusDidChange(status: reachability.connection)
    }
  }
  
  func startMonitoring() {
    NotificationCenter.default.addObserver(self,selector: #selector(self.reachabilityChanged),name: Notification.Name.reachabilityChanged,object: reachability)
    do{
      try reachability.startNotifier()
    } catch {
      debugPrint("Could not start reachability notifier")
    }
  }
  
  func stopMonitoring(){
    reachability.stopNotifier()
    NotificationCenter.default.removeObserver(self,name: Notification.Name.reachabilityChanged,object: reachability)
  }
}

extension ReachabilityManager {
  
  func addListener(listener: NetworkStatusListener){
    listeners.append(listener)
  }
  
  func removeListener(listener: NetworkStatusListener){
    listeners = listeners.filter{ $0 !== listener}
  }
}

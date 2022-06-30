//
//  UICollectionView+Extension.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import UIKit

extension UICollectionView {
  func indexPathForView(_ view: UIView) -> IndexPath? {
    let center = view.center
    let viewCenter = self.convert(center, from: view.superview)
    let indexPath = self.indexPathForItem(at: viewCenter)
    return indexPath
  }
  
  func setEmptyMessage(_ message: String) {
      let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
      messageLabel.text = message
      messageLabel.textColor = .black
      messageLabel.numberOfLines = 0;
      messageLabel.textAlignment = .center;
      messageLabel.font = UIFont.systemFont(ofSize: 14)
      messageLabel.sizeToFit()

      self.backgroundView = messageLabel;
  }

  func restore() {
      self.backgroundView = nil
  }
}

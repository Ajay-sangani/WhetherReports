//
//  UIImageView+SetImage.swift
//  ConneAppTask
//
//  Created by Ajay Sangani on 20/05/22.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
  
  func setImage(imageUrl: URL) {
    sd_imageIndicator = SDWebImageActivityIndicator.gray
      sd_setImage(with: imageUrl, placeholderImage: nil, options: .queryDiskDataSync)
  }
  
  func setImage(imageUrl: URL, imageThumbUrl: URL) {
    setImage(imageUrl: imageThumbUrl)
    SDWebImageManager.shared.loadImage(with: imageUrl, options: .continueInBackground, progress: nil, completed: { (downloadedImage, data, error, cacheType, true, imageUrl) in
      if downloadedImage != nil {
        self.image = downloadedImage
      }
    })
  }
}

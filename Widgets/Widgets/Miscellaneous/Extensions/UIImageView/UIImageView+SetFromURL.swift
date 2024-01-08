//
//  UIImageView+SetFromURL.swift
//  Widgets
//
//  Created by Keuahn Lumanog on 08/01/2024.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {

    func setImageFromUrl(_ url: String, placeholder: UIImage) {
        if let url = URL(string: url) {
            self.sd_setImage(with: url, placeholderImage: placeholder, options: .refreshCached, progress: .none, completed: .none)
        } else {
            self.image = placeholder
        }
    }

    func setImageFromUrlWithCompletion(_ url: String, placeholder: UIImage,
                                       completion: @escaping (UIImage?, Error?, SDImageCacheType?, URL?) -> Void) {
        var returnedImage: UIImage?
        var returnedError: Error?
        var returnedCacheType: SDImageCacheType?
        var returnedImageURL: URL?

        if let url = URL(string: url) {

            self.sd_setImage(with: url, placeholderImage: placeholder,
                             options: .refreshCached, progress: .none,
                             completed: { (image, error, cacheType, imageURL) in

                                returnedImage = image
                                returnedError = error
                                returnedCacheType = cacheType
                                returnedImageURL = imageURL
                             })
        }

        completion(returnedImage, returnedError, returnedCacheType, returnedImageURL)
    }
}

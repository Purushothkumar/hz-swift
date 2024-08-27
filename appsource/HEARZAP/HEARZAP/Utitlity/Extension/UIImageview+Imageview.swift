//
//  UIImageview+Imageview.swift
//  HEARZAP
//
//  Created by Purushoth on 04/07/22.
//  Copyright © 2022 IZA MEDI TECHNOLOGIES. All rights reserved.
//

import Foundation
import UIKit
import ShimmerEffect_iOS

extension UIImageView {
    // MARK: - Add Black Gradiant
    func addBlackGradientLayer(frame: CGRect, colors: [UIColor]) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map {$0.cgColor}
        self.layer.addSublayer(gradient)
    }
    // MARK: - Download Image from URL
    func downloaded(from url: URL, contentMode: ContentMode ) {
        self.contentMode = contentMode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async {
                self.image = image
                self.clipsToBounds = true
                self.contentMode = .scaleAspectFill
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode: ContentMode ) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link.allowSpecialCharacters) else { return }
        downloaded(from: url, contentMode: contentMode)
    }
    // MARK: - load Image from URL/Base64
    func setImage(imageUrl: String, placeHolderImage: UIImage) {
        DispatchQueue.main.async {
            if imageUrl.isEmpty {
                self.image = placeHolderImage
            } else {
                if let encodedImage = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) {
                    let encodedURL = URL(string: encodedImage)
                    //                    self.sd_setImage(with: encodedURL, placeholderImage: placeHolderImage )
                    self.sd_imageTransition = .fade
                    self.sd_setImage(with: encodedURL, placeholderImage: placeHolderImage, options: .refreshCached)
                }
            }
        }
    }
}

//
//  UIKitObject+Ext.swift
//  AlteaCareTest
//
//  Created by Dicky Geraldi on 18/11/22.
//

import UIKit
import Kingfisher

extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}

extension UIImageView {
    func loadImage(
        url: String?,
        indicatorType: IndicatorType = .activity,
        placeholder: UIImage = UIImage(),
        onSuccess: ((_ image: UIImage) -> Void)? = nil,
        onFailure: ((_ error: KingfisherError) -> Void)? = nil
    ) {
        let imageUrl = URL(string: url.ifNil(""))

        self.kf.indicatorType = indicatorType
        self.kf.setImage(
            with: imageUrl,
            placeholder: placeholder,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.none),
                .cacheOriginalImage
            ],
            completionHandler: { result in
                switch result {
                case .success(let value):
                    onSuccess?(value.image)
                case .failure(let error):
                    onFailure?(error)
                }
        })
    }
}

extension UIColor {
    convenience init(hex: String) {
        let string = hex
        var chars = Array(string.hasPrefix("#") ? "\(string.dropFirst())": string)
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1
        switch chars.count {
        case 3:
            chars = [chars[0], chars[0], chars[1], chars[1], chars[2], chars[2]]
            fallthrough
        case 6:
            chars = ["F", "F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            alpha = 0
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

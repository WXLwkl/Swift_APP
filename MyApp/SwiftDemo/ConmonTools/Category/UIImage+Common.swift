//
//  UIImage+Common.swift
//  SwiftDemo
//
//  Created by xingl on 2017/12/15.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

extension UIImage {
    func xl_image(with tintColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        tintColor.setFill()
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: .overlay, alpha: 1)
        draw(in: bounds, blendMode: .destinationIn, alpha: 1)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

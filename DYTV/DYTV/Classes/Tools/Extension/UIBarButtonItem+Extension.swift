//
//  UIBarButtonItem+Extension.swift
//  DYTV
//
//  Created by xingl on 2018/9/27.
//  Copyright © 2018 xingl. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, hightImageName: String, size: CGSize) -> UIBarButtonItem {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.setImage(UIImage(named: hightImageName), for: .highlighted)
        button.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: button)
    }
 */
    convenience init(imageName: String, hightImageName: String = "", size: CGSize = CGSize.zero) {
        
        let button: UIButton = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        if hightImageName != "" {
            button.setImage(UIImage(named: hightImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            button.sizeToFit()
        } else {
            button.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        self.init(customView: button)
    }
}

//
//  String+Extenstion.swift
//  SwiftDemo
//
//  Created by xingl on 2017/3/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import Foundation
import UIKit

extension String {
// MARK:- 获取字符串的CGSize
    func xl_getSize(with fontSize: CGFloat) -> CGSize {
        let str = self as NSString
        
        let size = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(MAXFLOAT))
        return str.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil).size
    }
    func xl_getSize(of font: UIFont, maxWidth: CGFloat) -> CGSize {
        let s = self as NSString
        let size = s.boundingRect(with: CGSize(width: maxWidth, height: .infinity), options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: [NSFontAttributeName: font], context: nil).size
        return size;
    }
}

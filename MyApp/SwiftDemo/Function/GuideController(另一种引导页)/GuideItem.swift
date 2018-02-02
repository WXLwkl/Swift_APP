//
//  GuideItem.swift
//  SwiftDemo
//
//  Created by xingl on 2017/12/15.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class GuideItem: NSObject {
    var sourceView: UIView?
    var rect: CGRect = .zero
    var text:String!

    public init(sourceView: UIView, text: String) {
        self.sourceView = sourceView
        self.text = text
    }

    public init(rect: CGRect, text: String) {
        self.rect = rect
        self.text = text
    }
}

//
//  ApplistModel.swift
//  SwiftDemo
//
//  Created by xingl on 2017/4/21.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class ApplistModel: NSObject {
    
    var image: String = ""
    var title: String = ""
    var vc: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

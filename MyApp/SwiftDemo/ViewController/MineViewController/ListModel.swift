//
//  ListModel.swift
//  SwiftDemo
//
//  Created by xingl on 2017/5/16.
//  Copyright © 2017年 yjpal. All rights reserved.
//

import UIKit

class ListModel: NSObject {
    
    var icon: String = ""
    var name: String = ""
    var className:String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

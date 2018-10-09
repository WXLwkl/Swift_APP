//
//  BaseGameModel.swift
//  DYTV
//
//  Created by xingl on 2018/10/9.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    @objc var tag_name: String = ""
    @objc var icon_url: String = ""
    
//    override init() {}

    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {}
}

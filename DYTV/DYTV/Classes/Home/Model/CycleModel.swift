//
//  CycleModel.swift
//  DYTV
//
//  Created by xingl on 2018/9/29.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    @objc var title: String = ""
    // 展示图片的url
    @objc var pic_url: String = ""
    // 主播信息对应的字典
    @objc var room: [String : Any]? {
        didSet {
            guard let room = room else { return }
            anchor = AnchorModel(dict: room )
        }
    }
    // 主播信息对应的模型对象
    var anchor: AnchorModel?
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}

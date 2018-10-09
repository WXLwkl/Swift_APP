//
//  AnchorModel.swift
//  DYTV
//
//  Created by xingl on 2018/9/28.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    // 房间id
    @objc var rool_id: Int = 0
    // 房间图片对应的url
    @objc var vertical_src: String = ""
    // 判断是手机直播还是电脑直播 0：电脑 1：手机
    @objc var isVertical: Int = 0
    //房间名称
    @objc var room_name: String = ""
    // 主播名称
    @objc var nickname: String = ""
    // 在线人数
    @objc var online: Int = 0
    // 所在城市
    @objc var anchor_city: String = ""
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}

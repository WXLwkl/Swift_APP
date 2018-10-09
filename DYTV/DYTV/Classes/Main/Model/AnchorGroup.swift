//
//  AnchorGroup.swift
//  DYTV
//
//  Created by xingl on 2018/9/28.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    // 该组中对应的房间信息
    @objc var room_list: [[String : Any]]? {
        didSet { // 属性监听器
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    // 组图标
    @objc var icon_name: String = ""

    // 主播的模型对象
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
}

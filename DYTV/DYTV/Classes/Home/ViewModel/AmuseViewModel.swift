//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by xingl on 2018/10/9.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class AmuseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .get, url: "https://capi.douyucdn.cn/api/v1/getHotRoom/2") { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            finishedCallback()
        }
    }
}

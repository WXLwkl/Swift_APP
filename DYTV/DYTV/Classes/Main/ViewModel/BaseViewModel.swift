//
//  BaseViewModel.swift
//  DYTV
//
//  Created by xingl on 2018/10/9.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups: [AnchorGroup] = [AnchorGroup]()
}
// MARK: - 请求方法
extension BaseViewModel {
    func loadAnchorData(URLString: String, parameters: [String : Any]? = nil, isGroupData: Bool = true, finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(type: .get, url: URLString, parameters: parameters) { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            if isGroupData {
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dict: dict))
                }
            } else {
                let group = AnchorGroup()
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict))
                }
                self.anchorGroups.append(group)
            }
            
            
            finishedCallback()
        }
    }
}

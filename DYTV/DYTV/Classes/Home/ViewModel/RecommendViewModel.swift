//
//  RecommendViewModel.swift
//  DYTV
//
//  Created by xingl on 2018/9/28.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseViewModel {
    
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    private lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}
// MARK: - 网络请求
extension RecommendViewModel {
    
    func requestData(finishCallBack: @escaping () -> ()) {
        
        let parameters = ["limit": "4", "offset": "0", "time": NSDate.getCurrentTime() as NSString]
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkTools.requestData(type: .get, url: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": NSDate.getCurrentTime() as NSString]) { (result) in
            
            guard let resultDict = result  as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "xxxxxxx"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        NetworkTools.requestData(type: .get, url: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            
            guard let resultDict = result  as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "xxxxxxx"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
//        NetworkTools.requestData(type: .get, url: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
//
//            guard let resultDict = result  as? [String : Any] else { return }
//            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
//
//            for dict in dataArray {
//                let group = AnchorGroup(dict: dict)
//                self.anchorGroups.append(group)
//            }
//            dispatchGroup.leave()
//        }
        loadAnchorData(URLString: "https://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallBack()
        }
    }
    
    func requestCycleData(finishCallback: @escaping () -> ()) {
        NetworkTools.requestData(type: .get, url: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
            finishCallback()
        }
    }
}

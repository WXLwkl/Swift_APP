//
//  GameViewModel.swift
//  DYTV
//
//  Created by xingl on 2018/10/9.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class GameViewModel {

    lazy var games: [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        NetworkTools.requestData(type: .get, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (result) in
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            for dict in dataArray {
                
                self.games.append(GameModel(dict: dict))
                
                finishedCallback()
            }
        }
    }
}

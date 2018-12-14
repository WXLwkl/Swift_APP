//
//  FunnyViewModel.swift
//  DYTV
//
//  Created by xingl on 2018/10/16.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseViewModel {

}

extension FunnyViewModel {
    func loadFunnyData(finishCellback: @escaping () -> ()) {
        loadAnchorData(URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/2", parameters: ["linit" : 30, "offset" : 0], isGroupData: false, finishedCallback: finishCellback)
        
    }
}

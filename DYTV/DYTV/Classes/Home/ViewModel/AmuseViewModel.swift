//
//  AmuseViewModel.swift
//  DYTV
//
//  Created by xingl on 2018/10/9.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {
    
}

extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(URLString: "https://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}

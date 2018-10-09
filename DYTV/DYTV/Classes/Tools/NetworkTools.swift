//
//  NetworkTools.swift
//  DYTV
//
//  Created by xingl on 2018/9/28.
//  Copyright © 2018 xingl. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    class func requestData(type: MethodType, url: String, parameters: [String : Any]? = nil, finishedCallback: @escaping (_ result: Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            guard let result = response.result.value else {
                return print(response.result.error!)
            }
            finishedCallback(result)
        }
    }
}
